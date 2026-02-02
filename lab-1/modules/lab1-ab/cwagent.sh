#!/bin/bash

# 1. Install the SSM & CloudWatch Agents
#echo "--- Installing Services Manager Agent ---"
#sudo dnf install -y amazon-ssm-agent 
echo "--- Installing CloudWatch Agent ---\n"
sudo dnf install -y amazon-cloudwatch-agent

# 2. Create a directory for your DB connection logs
# Your app should be configured to write connection errors here
echo "--- Creating Log folder & Log file with proper permissions ---\n"
sudo mkdir -p /var/log/cwagentapp
sudo touch /var/log/cwagentapp/rds-errors.log
sudo chmod 666 /var/log/cwagentapp/rds-errors.log

# 3. Create the Configuration JSON for RDS Monitoring
echo "--- Create the CloudWatch Agent JSON File for RDS Monitoring ---\n"
cat <<EOF > /tmp/cwagent-config.json
{
    "agent": {
        "metrics_collection_interval": 60,
        "run_as_user": "root"
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
                        "file_path": "/var/log/cwagentapp/rds-errors.log",
                        "log_group_name": "RDS-Connection-Failures",
                        "log_stream_name": "{instance_id}",
                        "timestamp_format": "%Y-%m-%d %H:%M:%S"
                    }
                ]
            }
        }
    }
}
EOF

# echo "--- Enabling & Starting SSM Agent ---"
# sudo systemctl enable amazon-ssm-agent
# sudo systemctl start amazon-ssm-agent

# 4. Start the agent
echo "--- Starting CloudWatch Agent ---"
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
    -a fetch-config -m ec2 -s -c file:/tmp/cwagent-config.json
