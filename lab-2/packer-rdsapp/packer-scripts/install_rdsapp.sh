#!/bin/bash
set -euo pipefail

########################################
# 1. Base OS packages
########################################
dnf update -y
dnf install -y \
  python3-pip \
  amazon-cloudwatch-agent

########################################
# 2. Python dependencies (system-wide)
########################################
pip3 install --no-cache-dir flask pymysql boto3

########################################
# 3. Application files
########################################
mkdir -p /opt/rdsapp

cat >/opt/rdsapp/app.py <<'PY'
import errno
import json
import logging
import os
import socket
import time

import boto3
import pymysql
from botocore.exceptions import ClientError
from flask import Flask, request

# -----------------------------
# Logging Setup
# -----------------------------
logger = logging.getLogger("rdsapp")
logger.setLevel(logging.INFO)


def log_event(level: str, event: str, **fields):
    """
    Emit structured JSON log events.
    CloudWatch agent will ship these to CloudWatch Logs.
    """
    payload = {
        "ts": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
        "event": event,
        **fields,
    }
    msg = json.dumps(payload, default=str)
    if level == "error":
        logger.error(msg)
    elif level == "warning":
        logger.warning(msg)
    else:
        logger.info(msg)


# -----------------------------
# Config
# -----------------------------
REGION = os.environ.get("AWS_REGION", "us-east-1")

# Secret holds credentials (username/password) and may also include host/port/dbname
SECRET_ID = os.environ.get("SECRET_ID", "armageddon/rds/mysql")

# Parameter Store holds non-secret DB config (recommended by your lab)
DB_HOST_PARAM = os.environ.get("DB_HOST_PARAM", "/armageddon/rds/mysql/host")
DB_PORT_PARAM = os.environ.get("DB_PORT_PARAM", "/armageddon/rds/mysql/port")
DB_NAME_PARAM = os.environ.get("DB_NAME_PARAM", "/armageddon/rds/mysql/dbname")

# Cache settings (reduce API calls)
SSM_CACHE_TTL_SECONDS = int(os.environ.get("SSM_CACHE_TTL_SECONDS", "30"))
SECRET_CACHE_TTL_SECONDS = int(os.environ.get("SECRET_CACHE_TTL_SECONDS", "10"))

# DB retry settings
DB_CONNECT_RETRIES = int(os.environ.get("DB_CONNECT_RETRIES", "2"))
DB_CONNECT_SLEEP_SECONDS = float(os.environ.get("DB_CONNECT_SLEEP_SECONDS", "0.4"))

# -----------------------------
# AWS Clients
# -----------------------------
secrets = boto3.client("secretsmanager", region_name=REGION)
ssm = boto3.client("ssm", region_name=REGION)
cloudwatch = boto3.client("cloudwatch", region_name=REGION)

# -----------------------------
# Small caches (avoid calling AWS every request)
# -----------------------------
_secret_cache = {"ts": 0.0, "vals": None}
_ssm_cache = {"ts": 0.0, "vals": None}


def emit_db_metric(metric_name: str, value: float = 1.0, category: str = "Unknown"):
    """
    Emit CloudWatch custom metric:
      1) Dimensionless metric for alarms
      2) Dimensioned metric for diagnostics
    """
    try:
        cloudwatch.put_metric_data(
            Namespace="Lab/RDSApp",
            MetricData=[
                # A) Alarm metric (NO dimensions)
                {
                    "MetricName": metric_name,
                    "Value": value,
                    "Unit": "Count",
                },
                # B) Diagnostic metric (WITH Category dimension)
                {
                    "MetricName": metric_name,
                    "Dimensions": [{"Name": "Category", "Value": category}],
                    "Value": value,
                    "Unit": "Count",
                },
            ],
        )
    except Exception as e:
        log_event("warning", "metric_emit_failed", metric_name=metric_name, category=category, err=str(e))



def classify_db_error(exc: Exception) -> dict:
    """
    Classify database connection errors into actionable categories.
    Returns a dict with: category, reason, hint
    """

    # 1) DNS / name resolution
    if isinstance(exc, socket.gaierror):
        return {
            "category": "DNSFailure",
            "reason": "socket.gaierror (name resolution failed)",
            "hint": "Check SSM /host value, VPC DNS, resolver, private hosted zone, and outbound DNS (if custom).",
        }

    # 2) PyMySQL OperationalError commonly wraps network/auth failures
    if isinstance(exc, pymysql.err.OperationalError):
        # exc.args often looks like (code, message)
        code = exc.args[0] if exc.args else None
        msg = str(exc)

        # Auth errors (rotation/creds/user)
        # 1045 = Access denied
        if code == 1045 or "Access denied" in msg:
            return {
                "category": "AuthFailure",
                "reason": f"MySQL auth failure (code={code})",
                "hint": "Likely secret rotation/creds mismatch, user permissions, or wrong username/password.",
            }

        # Connection / network-ish errors
        # 2003 can't connect to MySQL server (often SG/NACL/route/DNS)
        # 2013 lost connection
        # 2005 unknown MySQL server host (DNS-ish)
        if code in (2003, 2013):
            return {
                "category": "ConnectivityFailure",
                "reason": f"MySQL connectivity failure (code={code})",
                "hint": "Likely SG ingress/egress, NACL, route tables, DB stopped/unavailable, or wrong endpoint/port.",
            }
        if code == 2005 or "Unknown MySQL server host" in msg:
            return {
                "category": "DNSFailure",
                "reason": f"MySQL host lookup failure (code={code})",
                "hint": "Check endpoint string, SSM /host parameter, VPC DNS settings.",
            }

        # Timeout hints in message
        if "timed out" in msg.lower():
            return {
                "category": "Timeout",
                "reason": "Connection timed out",
                "hint": "Likely SG/NACL/route/DB down. Verify RDS SG allows from EC2 SG on 3306 and routing is correct.",
            }

        return {
            "category": "DBOperationalError",
            "reason": f"pymysql OperationalError (code={code})",
            "hint": "Inspect error code/message; could be connectivity or auth depending on details.",
        }

    # 3) Programming/schema errors (table missing, db missing)
    if isinstance(exc, pymysql.err.ProgrammingError):
        msg = str(exc)
        # 1146 table doesn't exist
        if "1146" in msg or "doesn't exist" in msg:
            return {
                "category": "SchemaMissing",
                "reason": "Table/schema missing",
                "hint": "Run /init or ensure migrations/DDL ran against the correct dbname.",
            }
        return {
            "category": "DBProgrammingError",
            "reason": "SQL/schema error",
            "hint": "Likely a query/schema mismatch.",
        }

    # 4) Generic OSError can catch no route, connection refused, etc.
    if isinstance(exc, OSError):
        # errno values helpful for inference
        if exc.errno in (errno.ECONNREFUSED,):
            return {
                "category": "ConnectionRefused",
                "reason": "ECONNREFUSED",
                "hint": "Port reachable but refused: wrong host/port, DB not listening, or SG to wrong target.",
            }
        if exc.errno in (errno.ENETUNREACH, errno.EHOSTUNREACH):
            return {
                "category": "NetworkUnreachable",
                "reason": f"Network unreachable (errno={exc.errno})",
                "hint": "Likely routing/NACL issues or DB subnet routing problems.",
            }
        return {
            "category": "OSError",
            "reason": f"OSError (errno={exc.errno})",
            "hint": "Could be routing, socket, or OS-level connectivity issue.",
        }

    # 5) AWS client errors (SSM/Secrets failures can cascade into DB failures)
    if isinstance(exc, ClientError):
        code = exc.response.get("Error", {}).get("Code", "ClientError")
        return {
            "category": "AWSClientError",
            "reason": f"AWS client error: {code}",
            "hint": "Check IAM permissions, region, secret/parameter existence, and KMS decrypt permissions if SecureString.",
        }

    return {
        "category": "Unknown",
        "reason": exc.__class__.__name__,
        "hint": "Unclassified exception; inspect stack trace.",
    }


def get_db_creds():
    """
    Pull DB credentials from Secrets Manager.
    Expected JSON keys: username, password
    (AWS "Credentials for RDS database" often also includes host, port, dbname)
    """
    now = time.time()
    if _secret_cache["vals"] and (now - _secret_cache["ts"] < SECRET_CACHE_TTL_SECONDS):
        return _secret_cache["vals"]

    resp = secrets.get_secret_value(SecretId=SECRET_ID)
    s = json.loads(resp["SecretString"])

    # Minimal validation for sanity
    if "username" not in s or "password" not in s:
        raise KeyError("Secret is missing required keys: username/password")

    _secret_cache["ts"] = now
    _secret_cache["vals"] = s
    return s


def get_db_config_from_ssm():
    """
    Pull non-secret DB config from SSM Parameter Store:
      - host
      - port
      - dbname
    Uses a small TTL cache to reduce API calls.
    """
    now = time.time()
    if _ssm_cache["vals"] and (now - _ssm_cache["ts"] < SSM_CACHE_TTL_SECONDS):
        return _ssm_cache["vals"]

    resp = ssm.get_parameters(
        Names=[DB_HOST_PARAM, DB_PORT_PARAM, DB_NAME_PARAM],
        WithDecryption=True,
    )

    params = {p["Name"]: p["Value"] for p in resp.get("Parameters", [])}

    # Fail fast if the required host parameter is missing
    if DB_HOST_PARAM not in params:
        missing = [DB_HOST_PARAM, DB_PORT_PARAM, DB_NAME_PARAM]
        raise KeyError(f"Missing required SSM parameter(s). Expected at least: {missing}")

    cfg = {
        "host": params[DB_HOST_PARAM],
        "port": int(params.get(DB_PORT_PARAM, "3306")),
        "dbname": params.get(DB_NAME_PARAM, "rds01"),
    }

    _ssm_cache["ts"] = now
    _ssm_cache["vals"] = cfg
    return cfg


def get_conn():
    """
    Create a DB connection with a tiny retry.
    - Credentials come from Secrets Manager (rotated)
    - Connection details come from Parameter Store (stable config)
    - Logs structured events and emits categorized metrics on failure
    """
    last_exc = None

    for attempt in range(DB_CONNECT_RETRIES):
        try:
            creds = get_db_creds()
            cfg = get_db_config_from_ssm()

            return pymysql.connect(
                host=cfg["host"],
                user=creds["username"],
                password=creds["password"],
                port=cfg["port"],
                database=cfg["dbname"],
                autocommit=True,
                connect_timeout=5,
                read_timeout=10,
                write_timeout=10,
            )

        except (pymysql.err.OperationalError, pymysql.err.ProgrammingError, socket.gaierror, OSError, Exception) as e:
            last_exc = e

            info = classify_db_error(e)

            # Emit metric (this is what will drive your alarm)
            emit_db_metric("DBConnectionErrors", 1.0, category=info["category"])

            # Log a structured event (safe: no secrets)
            try:
                # Attempt to include host/port/dbname without leaking creds
                cfg_safe = _ssm_cache["vals"] if _ssm_cache.get("vals") else {}
                host_safe = cfg_safe.get("host", "unknown")
                port_safe = cfg_safe.get("port", "unknown")
                db_safe = cfg_safe.get("dbname", "unknown")
            except Exception:
                host_safe, port_safe, db_safe = "unknown", "unknown", "unknown"

            log_event(
                "error",
                "db_connect_failed",
                category=info["category"],
                reason=info["reason"],
                hint=info["hint"],
                attempt=attempt + 1,
                max_attempts=DB_CONNECT_RETRIES,
                host=host_safe,
                port=port_safe,
                dbname=db_safe,
            )

            # Clear caches to force refetch (rotation / param fix)
            _secret_cache["vals"] = None
            _ssm_cache["vals"] = None

            if attempt < DB_CONNECT_RETRIES - 1:
                time.sleep(DB_CONNECT_SLEEP_SECONDS)
                continue

            raise

    raise last_exc


app = Flask(__name__)


@app.route("/")
def home():
    return """
    <h2>EC2 → RDS Notes App</h2>
    <p>GET /init</p>
    <p>POST /add?note=hello</p>
    <p>GET /list</p>
    """


@app.route("/init")
def init_db():
    """
    Initializes database + table.
    Uses SSM for host/port/dbname, Secrets for credentials.
    """
    creds = get_db_creds()
    cfg = get_db_config_from_ssm()

    # connect without specifying a DB first (so we can create it)
    conn = pymysql.connect(
        host=cfg["host"],
        user=creds["username"],
        password=creds["password"],
        port=cfg["port"],
        autocommit=True,
        connect_timeout=5,
        read_timeout=10,
        write_timeout=10,
    )

    try:
        with conn.cursor() as cur:
            cur.execute(f"CREATE DATABASE IF NOT EXISTS `{cfg['dbname']}`;")
            cur.execute(f"USE `{cfg['dbname']}`;")
            cur.execute(
                """
                CREATE TABLE IF NOT EXISTS notes (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    note VARCHAR(255) NOT NULL
                );
                """
            )
    finally:
        conn.close()

    return f"Initialized {cfg['dbname']} + notes table."


@app.route("/add", methods=["POST", "GET"])
def add_note():
    note = request.args.get("note", "").strip()
    if not note:
        return "Missing note param. Try: /add?note=hello", 400

    conn = get_conn()
    try:
        with conn.cursor() as cur:
            cur.execute("INSERT INTO notes(note) VALUES(%s);", (note,))
    finally:
        conn.close()

    return f"Inserted note: {note}"


@app.route("/list")
def list_notes():
    conn = get_conn()
    try:
        with conn.cursor() as cur:
            cur.execute("SELECT id, note FROM notes ORDER BY id DESC;")
            rows = cur.fetchall()
    finally:
        conn.close()

    out = "<h3>Notes</h3><ul>"
    for r in rows:
        out += f"<li>{r[0]}: {r[1]}</li>"
    out += "</ul>"
    return out


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)
PY

chmod 755 /opt/rdsapp/app.py

########################################
# 4. systemd service
########################################
cat >/etc/systemd/system/rdsapp.service <<'SERVICE'
[Unit]
Description=EC2 → RDS Notes App
After=network.target

[Service]
Type=simple
WorkingDirectory=/opt/rdsapp

# Runtime configuration (resolved at runtime, not bake time)
Environment=SECRET_ID=armageddon/rds/mysql
Environment=DB_HOST_PARAM=/armageddon/rds/mysql/host
Environment=DB_PORT_PARAM=/armageddon/rds/mysql/port
Environment=DB_NAME_PARAM=/armageddon/rds/mysql/dbname

ExecStart=/usr/bin/python3 /opt/rdsapp/app.py
Restart=always
RestartSec=3

StandardOutput=append:/var/log/rdsapp.log
StandardError=append:/var/log/rdsapp.err

[Install]
WantedBy=multi-user.target
SERVICE

systemctl daemon-reexec
systemctl daemon-reload
systemctl enable rdsapp

########################################
# 5. CloudWatch Agent configuration
########################################
mkdir -p /opt/aws/amazon-cloudwatch-agent/etc

cat >/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json <<'JSON'
{
  "agent": {
    "region": "us-east-1"
  },
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/var/log/rdsapp.log",
            "log_group_name": "/aws/ec2/armageddon-rds-app",
            "log_stream_name": "{instance_id}/rdsapp",
            "timezone": "UTC"
          },
          {
            "file_path": "/var/log/rdsapp.err",
            "log_group_name": "/aws/ec2/armageddon-rds-app",
            "log_stream_name": "{instance_id}/rdsapp-err",
            "timezone": "UTC"
          }
        ]
      }
    }
  }
}
JSON

########################################
# 6. Enable CloudWatch Agent
########################################
systemctl enable amazon-cloudwatch-agent

########################################
# 7. IMPORTANT: do NOT start services
########################################
# We intentionally do NOT run:
#   systemctl start rdsapp
#   systemctl start amazon-cloudwatch-agent
#
# Reason:
# - During bake, IAM role may differ
# - Secrets/SSM may not be reachable
# - systemd will start them on first real boot
########################################

echo "AMI bake complete: rdsapp installed and enabled"
