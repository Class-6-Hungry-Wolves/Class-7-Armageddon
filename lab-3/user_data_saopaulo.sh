#!/bin/bash
set -e

# Update and install dependencies
yum update -y
yum install -y python3 python3-pip

# Install Python packages
pip3 install flask pymysql boto3

# Create app directory
mkdir -p /opt/rdsapp

# Create the Flask application - connects to Tokyo RDS via TGW
cat > /opt/rdsapp/app.py << 'APPEOF'
from flask import Flask, request
import pymysql
import boto3
import json
import os
from datetime import datetime

app = Flask(__name__)

# Configuration - São Paulo region, but connects to Tokyo RDS
LOCAL_REGION = os.environ.get('AWS_REGION', 'sa-east-1')
TOKYO_REGION = 'ap-northeast-1'
SECRET_ID = os.environ.get('SECRET_ID', 'chewbacca/rds/mysql')
METRIC_NAMESPACE = 'Chewbacca/RDSApp'

# AWS Clients - local region for metrics, Tokyo for secrets (cross-region)
cloudwatch_client = boto3.client('cloudwatch', region_name=LOCAL_REGION)

# For secrets, we need to connect to Tokyo where the secret is stored
secrets_client = boto3.client('secretsmanager', region_name=TOKYO_REGION)

def emit_metric(metric_name, value, unit='Count'):
    """Emit a custom metric to CloudWatch."""
    try:
        cloudwatch_client.put_metric_data(
            Namespace=METRIC_NAMESPACE,
            MetricData=[
                {
                    'MetricName': metric_name,
                    'Value': value,
                    'Unit': unit,
                    'Timestamp': datetime.utcnow(),
                    'Dimensions': [
                        {'Name': 'Region', 'Value': 'SaoPaulo'}
                    ]
                }
            ]
        )
        print(f"Emitted metric: {metric_name}={value}")
    except Exception as e:
        print(f"Failed to emit metric: {e}")

def get_db_credentials():
    """Retrieve database credentials from Secrets Manager in Tokyo."""
    try:
        response = secrets_client.get_secret_value(SecretId=SECRET_ID)
        return json.loads(response['SecretString'])
    except Exception as e:
        print(f"Error retrieving secret from Tokyo: {e}")
        emit_metric('DBConnectionErrors', 1)
        raise

def get_db_connection():
    """Create a database connection to Tokyo RDS via TGW."""
    try:
        creds = get_db_credentials()
        # Connect to Tokyo RDS via Transit Gateway peering
        connection = pymysql.connect(
            host=creds['host'],  # Tokyo RDS endpoint
            user=creds['username'],
            password=creds['password'],
            database=creds.get('dbname', 'labmysql'),
            port=int(creds.get('port', 3306)),
            connect_timeout=30  # Higher timeout for cross-region
        )
        emit_metric('DBConnectionSuccess', 1)
        return connection
    except pymysql.Error as e:
        print(f"Database connection error (Tokyo RDS via TGW): {e}")
        emit_metric('DBConnectionErrors', 1)
        raise
    except Exception as e:
        print(f"Unexpected error: {e}")
        emit_metric('DBConnectionErrors', 1)
        raise

@app.route('/')
def home():
    return '''
    <h2>Chewbacca Notes App - Sao Paulo Region</h2>
    <p>APPI-Compliant: Stateless compute, data stored in Tokyo</p>
    <hr>
    <p>GET /init - Initialize database (Tokyo RDS)</p>
    <p>POST /add?note=hello - Add a note (stored in Tokyo)</p>
    <p>GET /list - List all notes (from Tokyo)</p>
    <p>GET /health - Health check</p>
    '''

@app.route('/health')
def health():
    """Health check endpoint."""
    return {'status': 'healthy', 'region': 'saopaulo', 'data_region': 'tokyo'}, 200

@app.route('/init')
def init_db():
    """Initialize the database and create tables in Tokyo RDS."""
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute('''
            CREATE TABLE IF NOT EXISTS notes (
                id INT AUTO_INCREMENT PRIMARY KEY,
                content TEXT NOT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                source_region VARCHAR(50) DEFAULT 'saopaulo'
            )
        ''')
        conn.commit()
        cursor.close()
        conn.close()

        emit_metric('DBInitSuccess', 1)
        return {'status': 'Database initialized successfully', 'compute_region': 'saopaulo', 'data_region': 'tokyo'}, 200

    except Exception as e:
        emit_metric('DBConnectionErrors', 1)
        return {'status': 'error', 'message': str(e)}, 500

@app.route('/add')
def add_note():
    """Add a note to the Tokyo RDS database."""
    note = request.args.get('note', '')
    if not note:
        return {'status': 'error', 'message': 'No note provided. Use ?note=your_text'}, 400

    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute('INSERT INTO notes (content, source_region) VALUES (%s, %s)', (note, 'saopaulo'))
        conn.commit()
        cursor.close()
        conn.close()

        emit_metric('NotesAdded', 1)
        return {'status': 'success', 'message': f'Note added: {note}', 'compute_region': 'saopaulo', 'data_stored_in': 'tokyo'}, 200

    except Exception as e:
        emit_metric('DBConnectionErrors', 1)
        return {'status': 'error', 'message': str(e)}, 500

@app.route('/list')
def list_notes():
    """List all notes from the Tokyo RDS database."""
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute('SELECT id, content, created_at, source_region FROM notes ORDER BY created_at DESC')
        notes = cursor.fetchall()
        cursor.close()
        conn.close()

        emit_metric('DBQuerySuccess', 1)

        if not notes:
            return '<h2>Notes (Sao Paulo -> Tokyo)</h2><p>No notes yet. Add one with /add?note=hello</p>'

        html = '<h2>Notes (Sao Paulo Compute -> Tokyo Data)</h2><ul>'
        for note in notes:
            html += f'<li>[{note[0]}] {note[1]} - {note[2]} (from: {note[3]})</li>'
        html += '</ul>'
        return html

    except Exception as e:
        emit_metric('DBConnectionErrors', 1)
        return {'status': 'error', 'message': str(e)}, 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
APPEOF

# Create systemd service
cat > /etc/systemd/system/rdsapp.service << 'SVCEOF'
[Unit]
Description=Chewbacca RDS Notes Flask App - Sao Paulo (connects to Tokyo RDS)
After=network.target

[Service]
Type=simple
User=root
Environment=AWS_REGION=sa-east-1
Environment=SECRET_ID=chewbacca/rds/mysql
WorkingDirectory=/opt/rdsapp
ExecStart=/usr/bin/python3 /opt/rdsapp/app.py
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
SVCEOF

# Enable and start the service
systemctl daemon-reload
systemctl enable rdsapp
systemctl start rdsapp

echo "Chewbacca App (Sao Paulo - stateless) deployment complete!"
