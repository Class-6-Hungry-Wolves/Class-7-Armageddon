#!/bin/bash
dnf update -y
dnf install -y python3-pip
sudo dnf install -y amazon-cloudwatch-agent
#sudo dnf install -y amazon-ssm-agent
pip3 install flask pymysql boto3

mkdir -p /opt/rdsapp
cat >/opt/rdsapp/app.py <<'PY'
import json
import os
import boto3
import pymysql
import logging
import requests
from flask import Flask, request

REGION = os.environ.get("AWS_REGION", "sa-east-1")
SECRET_ID = os.environ.get("SECRET_ID", "peterock/rds/mysql")

secrets = boto3.client("secretsmanager", region_name=REGION)
cloudwatch = boto3.client("cloudwatch", region_name=REGION)

def get_instance_id():
    # 1. Get the Session Token (IMDSv2 requirement)
    token_url = "http://169.254.169.254/latest/api/token"
    token_headers = {"X-aws-ec2-metadata-token-ttl-seconds": "21600"}
    token_response = requests.put(token_url, headers=token_headers, timeout=2)
    token = token_response.text

    # 2. Get the Instance ID using the token
    id_url = "http://169.254.169.254/latest/meta-data/instance-id"
    id_headers = {"X-aws-ec2-metadata-token": token}
    instance_id = requests.get(id_url, headers=id_headers, timeout=2).text
    return instance_id

def emit_db_connection_error(error_msg):
    """
    Emit a DBConnectionError metric to CloudWatch.
    This metric is used to track database connection failures.
    """
    try:
        ec2_id = get_instance_id()

        cloudwatch.put_metric_data(
            Namespace="Lab/RDSApp",
            MetricData=[
                {
                    "MetricName": "DBConnectionErrors",
                    "Dimensions": [
                        {"Name": "InstanceID", "Value": "{ec2_id}"},
                        {"Name": "DBType", "Value": "MySQL"}
                    ],
                    "Value": "1.0",
                    "Unit": "Count",
                },
            ]
        )
        print(f"Error emitted to CloudWatch:{error_msg}")
    except Exception as e:
        # Don't let metric emission failures break the app
        print(f"Failed to emit CloudWatch metric: {e}")

def get_db_creds():
    resp = secrets.get_secret_value(SecretId=SECRET_ID)
    s = json.loads(resp["SecretString"])
    # When you use "Credentials for RDS database", AWS usually stores:
    # username, password, host, port, dbname (sometimes)
    return s

def get_conn():
    try:
        c = get_db_creds()
        host = c["host"]
        user = c["username"]
        password = c["password"]
        port = int(c.get("port", 3306))
        db = c.get("dbname", "labdb")  # we'll create this if it doesn't exist
        return pymysql.connect(host=host, user=user, password=password, port=port, database=db, autocommit=True)
    except Exception as e:
        # Notify CloudWatch of DB connection error by EC2 instance
        emit_db_connection_error(str(e))

app = Flask(__name__)

@app.route("/")
def home():
    return """
    <h2>EC2 → RDS Notes App</h2>
    <p>POST /add?note=hello</p>
    <p>GET /list</p>
    """

@app.route("/init")
def init_db():
    try:
        c = get_db_creds()
        host = c["host"]
        user = c["username"]
        password = c["password"]
        port = int(c.get("port", 3306))

        # connect without specifying a DB first
        conn = pymysql.connect(host=host, user=user, password=password, port=port, autocommit=True)
        cur = conn.cursor()
        cur.execute("CREATE DATABASE IF NOT EXISTS labdb;")
        cur.execute("USE labdb;")
        cur.execute("""
            CREATE TABLE IF NOT EXISTS notes (
                id INT AUTO_INCREMENT PRIMARY KEY,
                note VARCHAR(255) NOT NULL
            );
        """)
        cur.close()
        conn.close()
        return "Initialized labdb + notes table."
    except Exception as e:
        # Notify CloudWatch of DB connection error by EC2 instance
        emit_db_connection_error(str(e))


@app.route("/add", methods=["POST", "GET"])
def add_note():
    try:
        note = request.args.get("note", "").strip()
        if not note:
            return "Missing note param. Try: /add?note=hello", 400
        conn = get_conn()
        cur = conn.cursor()
        cur.execute("INSERT INTO notes(note) VALUES(%s);", (note,))
        cur.close()
        conn.close()
        return f"Inserted note: {note}"
    except Exception as e:
        # Notify CloudWatch of DB connection error by EC2 instance
        emit_db_connection_error(str(e))

@app.route("/list")
def list_notes():
    try:
        conn = get_conn()
        cur = conn.cursor()
        cur.execute("SELECT id, note FROM notes ORDER BY id DESC;")
        rows = cur.fetchall()
        cur.close()
        conn.close()
        out = "<h3>Notes</h3><ul>"
        for r in rows:
            out += f"<li>{r[0]}: {r[1]}</li>"
        out += "</ul>"
        return out
    except Exception as e:
        # Notify CloudWatch of DB connection error by EC2 instance
        emit_db_connection_error(str(e))

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)
PY

cat >/etc/systemd/system/rdsapp.service <<'SERVICE'
[Unit]
Description=EC2 to RDS Notes App
After=network.target

[Service]
WorkingDirectory=/opt/rdsapp
Environment=SECRET_ID=peterock/rds/mysql
ExecStart=/usr/bin/python3 /opt/rdsapp/app.py
Restart=always

[Install]
WantedBy=multi-user.target
SERVICE

# Explanation: Create Log file CloudWatch Agent will use to store failed connection logs
touch /tmp/rdsapp-errors.log
chmod 666 /tmp/rdsapp-errors.log

# Explanation: CloudWatch Agent Configuration JOSN for RDS Monitoring
cat >/tmp/CWAgentConfig.json <<'JSON'
{
    "agent": {
        "metrics_collection_interval": 60
    },
    "metrics": {
        "metrics_collected": {
            "mem": {
                "measurement": [
                    "used_percent"
                ]
            },
            "cpu": {
                "measurement": [
                    "usage_active"
                ]
            },
            "netstat": {
                "measurement": [
                    "tcp_established",
                    "tcp_close_wait",
                    "tcp_time_wait"
                ]
            }
        }
    },
    "logs": {
        "logs_collected": {
            "files": {
                "collect_list": [
                    {
                        "file_path": "/tmp/rdsapp-errors.log",
                        "log_group_name": "/aws/ec2/peterock-rds-app",
                        "log_stream_name": "{instance_id}-app-stream"
                    }
                ]
            }
        }
    }
}
JSON

systemctl daemon-reload
systemctl enable rdsapp
systemctl start rdsapp
#systemctl enable amazon-ssm-agent
#systemctl start amazon-ssm-agent

# Start CloudWatch agent with proper fetch-config command
chmod +x /tmp/CWAgentConfig.json
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
    -a fetch-config \
    -m ec2 \
    -s \
    -c file:/tmp/CWAgentConfig.json


# Explanation: Provision ec2-key-pair cert file for SSH access from Private EC2 instance (as Bastian host)
touch /tmp/ec2-key-pair
cat >/tmp/ec2-key-pair <<'KEY'
-----BEGIN OPENSSH PRIVATE KEY-----
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
-----END OPENSSH PRIVATE KEY-----
KEY

chmod 400 /tmp/ec2-key-pair
