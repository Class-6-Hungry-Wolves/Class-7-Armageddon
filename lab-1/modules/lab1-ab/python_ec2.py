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
                        {"Name": "InstanceID", "Value": "{ec2_id}"}
                        {"Name": "DBType", "Value": "MySQL"}
                    ]
                    "Value": 1.0,
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
        emit_db_connection_error()


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
        emit_db_connection_error()


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)