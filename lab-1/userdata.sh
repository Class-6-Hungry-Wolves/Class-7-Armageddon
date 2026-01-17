#!/bin/bash
dnf update -y
dnf install -y python3-pip
pip3 install flask pymysql boto3

mkdir -p /opt/rdsapp
cat >/opt/rdsapp/app.py <<'PY'
import json
import os
import time

import boto3
import pymysql
from flask import Flask, request

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

# -----------------------------
# Small caches (avoid calling AWS every request)
# -----------------------------
_secret_cache = {"ts": 0.0, "vals": None}
_ssm_cache = {"ts": 0.0, "vals": None}


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
        WithDecryption=False,
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

        except pymysql.err.OperationalError as e:
            last_exc = e

            # If we fail once, clear caches so we re-pull fresh values next attempt
            # (useful if rotation just occurred or a stale value was cached)
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

cat >/etc/systemd/system/rdsapp.service <<'SERVICE'
[Unit]
Description=EC2 to RDS Notes App
After=network.target

[Service]
StandardOutput=append:/var/log/rdsapp.log
StandardError=append:/var/log/rdsapp.err
WorkingDirectory=/opt/rdsapp
Environment=SECRET_ID=armageddon/rds/mysql
Environment=DB_HOST_PARAM=/armageddon/rds/mysql/host
Environment=DB_PORT_PARAM=/armageddon/rds/mysql/port
Environment=DB_NAME_PARAM=/armageddon/rds/mysql/dbname
ExecStart=/usr/bin/python3 /opt/rdsapp/app.py
Restart=always

[Install]
WantedBy=multi-user.target
SERVICE

systemctl daemon-reload
systemctl enable rdsapp
systemctl start rdsapp

# ---- log to files so CW Agent can ship them ----
StandardOutput=append:/var/log/rdsapp.log
StandardError=append:/var/log/rdsapp.err

[Install]
WantedBy=multi-user.target
SERVICE

systemctl daemon-reload
systemctl enable rdsapp
systemctl start rdsapp

# -------------------------------
# CloudWatch Agent: log shipping
# -------------------------------
cat >/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json <<'JSON'
{
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
          },
          {
            "file_path": "/var/log/cloud-init-output.log",
            "log_group_name": "/aws/ec2/armageddon-rds-app",
            "log_stream_name": "{instance_id}/cloud-init",
            "timezone": "UTC"
          }
        ]
      }
    }
  }
}
JSON

cat >/opt/aws/amazon-cloudwatch-agent/etc/env-config.json <<'JSON'
{
  "config": {
    "agent": { "mode": "ec2" },
    "source": "file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json"
  }
}
JSON

systemctl enable amazon-cloudwatch-agent
systemctl restart amazon-cloudwatch-agent
