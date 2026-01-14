module.lab1-ab.data.aws_caller_identity.chewbacca_self01: Reading...0m
module.lab1-ab.data.aws_region.chewbacca_region01: Reading...0m
module.lab1-ab.data.aws_region.chewbacca_region01: Read complete after 0s [id=sa-east-1][0m
module.lab1-ab.data.aws_caller_identity.chewbacca_self01: Read complete after 0s [id=630400242534][0m

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_iam_policy.chewbacca_leastpriv_cwlogs01[0m will be created
  + resource "aws_iam_policy" "chewbacca_leastpriv_cwlogs01" {
      + arn              = (known after apply)
      + attachment_count = (known after apply)
      + description      = "Least-privilege CloudWatch Logs write for the app log group"
      + id               = (known after apply)
      + name             = "peterock-lp-cwlogs01"
      + name_prefix      = (known after apply)
      + path             = "/"
      + policy           = (known after apply)
      + policy_id        = (known after apply)
      + tags_all         = (known after apply)
    }

  # aws_iam_policy.chewbacca_leastpriv_read_params01 will be created
  + resource "aws_iam_policy" "chewbacca_leastpriv_read_params01" {
      + arn              = (known after apply)
      + attachment_count = (known after apply)
      + description      = "Least-privilege read for SSM Parameter Store under /lab/db/*"
      + id               = (known after apply)
      + name             = "peterock-lp-ssm-read01"
      + name_prefix      = (known after apply)
      + path             = "/"
      + policy           = jsonencode(
            {
              + Statement = [
                  + {
                      + Action   = [
                          + "ssm:GetParameter",
                          + "ssm:GetParameters",
                          + "ssm:GetParametersByPath",
                        ]
                      + Effect   = "Allow"
                      + Resource = [
                          + "arn:aws:ssm:sa-east-1:630400242534:parameter/lab/db/*",
                        ]
                      + Sid      = "ReadLabDbParams"
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + policy_id        = (known after apply)
      + tags_all         = (known after apply)
    }

  # aws_iam_policy.chewbacca_leastpriv_read_secret01 will be created
  + resource "aws_iam_policy" "chewbacca_leastpriv_read_secret01" {
      + arn              = (known after apply)
      + attachment_count = (known after apply)
      + description      = "Least-privilege read for the lab DB secret"
      + id               = (known after apply)
      + name             = "peterock-lp-secrets-read01"
      + name_prefix      = (known after apply)
      + path             = "/"
      + policy           = jsonencode(
            {
              + Statement = [
                  + {
                      + Action   = [
                          + "secretsmanager:GetSecretValue",
                          + "secretsmanager:DescribeSecret",
                        ]
                      + Effect   = "Allow"
                      + Resource = "arn:aws:secretsmanager:sa-east-1:630400242534:secret:peterock/rds/mysql*"
                      + Sid      = "ReadOnlyLabSecret"
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + policy_id        = (known after apply)
      + tags_all         = (known after apply)
    }

  # aws_iam_role_policy_attachment.chewbacca_attach_lp_cwlogs01 will be created
  + resource "aws_iam_role_policy_attachment" "chewbacca_attach_lp_cwlogs01" {
      + id         = (known after apply)
      + policy_arn = (known after apply)
      + role       = "peterock-ec2-role01"
    }

  # aws_iam_role_policy_attachment.chewbacca_attach_lp_params01 will be created
  + resource "aws_iam_role_policy_attachment" "chewbacca_attach_lp_params01" {
      + id         = (known after apply)
      + policy_arn = (known after apply)
      + role       = "peterock-ec2-role01"
    }

  # aws_iam_role_policy_attachment.chewbacca_attach_lp_secret01 will be created
  + resource "aws_iam_role_policy_attachment" "chewbacca_attach_lp_secret01" {
      + id         = (known after apply)
      + policy_arn = (known after apply)
      + role       = "peterock-ec2-role01"
    }

  # aws_instance.chewbacca_ec201_private_bonus will be created
  + resource "aws_instance" "chewbacca_ec201_private_bonus" {
      + ami                                  = "ami-0b11764ef057ab4b7"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + enable_primary_ipv6                  = (known after apply)
      + force_destroy                        = false
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t3.micro"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = (known after apply)
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_group_id                   = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + region                               = "sa-east-1"
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = (known after apply)
      + tags                                 = {
          + "Name" = "peterock-ec201-private"
        }
      + tags_all                             = {
          + "Name" = "peterock-ec201-private"
        }
      + tenancy                              = (known after apply)
      + user_data                            = <<-EOT
            #!/bin/bash
            # Use this for your user data (script from top to bottom)
            # install httpd (Linux 2 version)
            yum update -y
            yum install -y httpd
            systemctl start httpd
            systemctl enable httpd
            
            # Get the IMDSv2 token
            TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
            
            # Background the curl requests
            curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/local-ipv4 &> /tmp/local_ipv4 &
            curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/placement/availability-zone &> /tmp/az &
            curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/ &> /tmp/macid &
            wait
            
            macid=$(cat /tmp/macid)
            local_ipv4=$(cat /tmp/local_ipv4)
            az=$(cat /tmp/az)
            vpc=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/${macid}/vpc-id)
            
            echo "
            <!doctype html>
            <html lang=\"en\" class=\"h-100\">
            <head>
            <title>Details for Private EC2 Instance</title>
            </head>
            <body>
            <div>
            <h1>Armageddon LAB1c Private Instance Details</h1>
            
            <br>
            <h1>Peter C's EC2 for Homework #1</h1>
            
            <br>
            <img src="https://www.w3schools.com/images/w3schools_green.jpg" alt="W3Schools.com">
            <br>
            
            <p><b>Instance Name:</b> $(hostname -f) </p>
            <p><b>Instance Private Ip Address: </b> ${local_ipv4}</p>
            <p><b>Availability Zone: </b> ${az}</p>
            <p><b>Virtual Private Cloud (VPC):</b> ${vpc}</p>
            </div>
            </body>
            </html>
            " > /var/www/html/index.html
            
            # Clean up the temp files
            rm -f /tmp/local_ipv4 /tmp/az /tmp/macid
        EOT
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)

      + capacity_reservation_specification (known after apply)

      + cpu_options (known after apply)

      + ebs_block_device (known after apply)

      + enclave_options (known after apply)

      + ephemeral_block_device (known after apply)

      + instance_market_options (known after apply)

      + maintenance_options (known after apply)

      + metadata_options (known after apply)

      + network_interface (known after apply)

      + primary_network_interface (known after apply)

      + private_dns_name_options (known after apply)

      + root_block_device (known after apply)
    }

  # aws_vpc_endpoint.chewbacca_vpce_services["kms"] will be created
  + resource "aws_vpc_endpoint" "chewbacca_vpce_services" {
      + arn                   = (known after apply)
      + cidr_blocks           = (known after apply)
      + dns_entry             = (known after apply)
      + id                    = (known after apply)
      + ip_address_type       = (known after apply)
      + network_interface_ids = (known after apply)
      + owner_id              = (known after apply)
      + policy                = (known after apply)
      + prefix_list_id        = (known after apply)
      + private_dns_enabled   = true
      + region                = "sa-east-1"
      + requester_managed     = (known after apply)
      + route_table_ids       = (known after apply)
      + security_group_ids    = (known after apply)
      + service_name          = "com.amazonaws.sa-east-1.kms"
      + service_region        = (known after apply)
      + state                 = (known after apply)
      + subnet_ids            = (known after apply)
      + tags                  = {
          + "Name" = "peterock-vpce-kms"
        }
      + tags_all              = {
          + "Name" = "peterock-vpce-kms"
        }
      + vpc_endpoint_type     = "Interface"
      + vpc_id                = (known after apply)

      + dns_options (known after apply)

      + subnet_configuration (known after apply)
    }

  # aws_vpc_endpoint.chewbacca_vpce_services["s3"] will be created
  + resource "aws_vpc_endpoint" "chewbacca_vpce_services" {
      + arn                   = (known after apply)
      + cidr_blocks           = (known after apply)
      + dns_entry             = (known after apply)
      + id                    = (known after apply)
      + ip_address_type       = (known after apply)
      + network_interface_ids = (known after apply)
      + owner_id              = (known after apply)
      + policy                = (known after apply)
      + prefix_list_id        = (known after apply)
      + private_dns_enabled   = true
      + region                = "sa-east-1"
      + requester_managed     = (known after apply)
      + route_table_ids       = (known after apply)
      + security_group_ids    = (known after apply)
      + service_name          = "com.amazonaws.sa-east-1.s3"
      + service_region        = (known after apply)
      + state                 = (known after apply)
      + subnet_ids            = (known after apply)
      + tags                  = {
          + "Name" = "peterock-vpce-s3"
        }
      + tags_all              = {
          + "Name" = "peterock-vpce-s3"
        }
      + vpc_endpoint_type     = "Interface"
      + vpc_id                = (known after apply)

      + dns_options (known after apply)

      + subnet_configuration (known after apply)
    }

  # module.lab1-ab.aws_cloudwatch_log_group.chewbacca_log_group01 will be created
  + resource "aws_cloudwatch_log_group" "chewbacca_log_group01" {
      + arn                         = (known after apply)
      + deletion_protection_enabled = (known after apply)
      + id                          = (known after apply)
      + log_group_class             = (known after apply)
      + name                        = "/aws/ec2/peterock-rds-app"
      + name_prefix                 = (known after apply)
      + region                      = "sa-east-1"
      + retention_in_days           = 7
      + skip_destroy                = false
      + tags                        = {
          + "Name" = "peterock-log-group01"
        }
      + tags_all                    = {
          + "Name" = "peterock-log-group01"
        }
    }

  # module.lab1-ab.aws_cloudwatch_metric_alarm.chewbacca_db_alarm01 will be created
  + resource "aws_cloudwatch_metric_alarm" "chewbacca_db_alarm01" {
      + actions_enabled                       = true
      + alarm_actions                         = (known after apply)
      + alarm_name                            = "peterock-db-connection-failure"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 1
      + id                                    = (known after apply)
      + metric_name                           = "DBConnectionErrors"
      + namespace                             = "Lab/RDSApp"
      + period                                = 300
      + region                                = "sa-east-1"
      + statistic                             = "Sum"
      + tags                                  = {
          + "Name" = "peterock-alarm-db-fail"
        }
      + tags_all                              = {
          + "Name" = "peterock-alarm-db-fail"
        }
      + threshold                             = 3
      + treat_missing_data                    = "missing"
    }

  # module.lab1-ab.aws_db_instance.chewbacca_rds01 will be created
  + resource "aws_db_instance" "chewbacca_rds01" {
      + address                               = (known after apply)
      + allocated_storage                     = 20
      + apply_immediately                     = false
      + arn                                   = (known after apply)
      + auto_minor_version_upgrade            = true
      + availability_zone                     = (known after apply)
      + backup_retention_period               = (known after apply)
      + backup_target                         = (known after apply)
      + backup_window                         = (known after apply)
      + ca_cert_identifier                    = (known after apply)
      + character_set_name                    = (known after apply)
      + copy_tags_to_snapshot                 = false
      + database_insights_mode                = (known after apply)
      + db_name                               = "labdb"
      + db_subnet_group_name                  = "peterock-rds-subnet-group01"
      + dedicated_log_volume                  = false
      + delete_automated_backups              = true
      + domain_fqdn                           = (known after apply)
      + endpoint                              = (known after apply)
      + engine                                = "mysql"
      + engine_lifecycle_support              = (known after apply)
      + engine_version                        = (known after apply)
      + engine_version_actual                 = (known after apply)
      + hosted_zone_id                        = (known after apply)
      + id                                    = (known after apply)
      + identifier                            = "peterock-rds01"
      + identifier_prefix                     = (known after apply)
      + instance_class                        = "db.t3.micro"
      + iops                                  = (known after apply)
      + kms_key_id                            = (known after apply)
      + latest_restorable_time                = (known after apply)
      + license_model                         = (known after apply)
      + listener_endpoint                     = (known after apply)
      + maintenance_window                    = (known after apply)
      + master_user_secret                    = (known after apply)
      + master_user_secret_kms_key_id         = (known after apply)
      + monitoring_interval                   = 0
      + monitoring_role_arn                   = (known after apply)
      + multi_az                              = true
      + nchar_character_set_name              = (known after apply)
      + network_type                          = (known after apply)
      + option_group_name                     = (known after apply)
      + parameter_group_name                  = (known after apply)
      + password                              = (sensitive value)
      + password_wo                           = (write-only attribute)
      + performance_insights_enabled          = false
      + performance_insights_kms_key_id       = (known after apply)
      + performance_insights_retention_period = (known after apply)
      + port                                  = (known after apply)
      + publicly_accessible                   = false
      + region                                = "sa-east-1"
      + replica_mode                          = (known after apply)
      + replicas                              = (known after apply)
      + resource_id                           = (known after apply)
      + skip_final_snapshot                   = true
      + snapshot_identifier                   = (known after apply)
      + status                                = (known after apply)
      + storage_throughput                    = (known after apply)
      + storage_type                          = (known after apply)
      + tags                                  = {
          + "Name" = "peterock-rds01"
        }
      + tags_all                              = {
          + "Name" = "peterock-rds01"
        }
      + timezone                              = (known after apply)
      + upgrade_rollout_order                 = (known after apply)
      + username                              = "admin"
      + vpc_security_group_ids                = (known after apply)
    }

  # module.lab1-ab.aws_db_subnet_group.chewbacca_rds_subnet_group01 will be created
  + resource "aws_db_subnet_group" "chewbacca_rds_subnet_group01" {
      + arn                     = (known after apply)
      + description             = "Managed by Terraform"
      + id                      = (known after apply)
      + name                    = "peterock-rds-subnet-group01"
      + name_prefix             = (known after apply)
      + region                  = "sa-east-1"
      + subnet_ids              = (known after apply)
      + supported_network_types = (known after apply)
      + tags                    = {
          + "Name" = "peterock-rds-subnet-group01"
        }
      + tags_all                = {
          + "Name" = "peterock-rds-subnet-group01"
        }
      + vpc_id                  = (known after apply)
    }

  # module.lab1-ab.aws_iam_instance_profile.chewbacca_instance_profile01 will be created
  + resource "aws_iam_instance_profile" "chewbacca_instance_profile01" {
      + arn         = (known after apply)
      + create_date = (known after apply)
      + id          = (known after apply)
      + name        = "peterock-instance-profile01"
      + name_prefix = (known after apply)
      + path        = "/"
      + role        = "peterock-ec2-role01"
      + tags_all    = (known after apply)
      + unique_id   = (known after apply)
    }

  # module.lab1-ab.aws_iam_role.chewbacca_ec2_role01 will be created
  + resource "aws_iam_role" "chewbacca_ec2_role01" {
      + arn                   = (known after apply)
      + assume_role_policy    = jsonencode(
            {
              + Statement = [
                  + {
                      + Action   = "secretsmanager:GetSecretValue"
                      + Effect   = "Allow"
                      + Resource = "arn:aws:secretsmanager:sa-east-1:630400242534:secret:peterock/rds/mysql*"
                      + Sid      = "ReadSpecificSecret"
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + create_date           = (known after apply)
      + force_detach_policies = false
      + id                    = (known after apply)
      + managed_policy_arns   = (known after apply)
      + max_session_duration  = 3600
      + name                  = "peterock-ec2-role01"
      + name_prefix           = (known after apply)
      + path                  = "/"
      + tags_all              = (known after apply)
      + unique_id             = (known after apply)

      + inline_policy (known after apply)
    }

  # module.lab1-ab.aws_iam_role_policy_attachment.chewbacca_ec2_cw_attach will be created
  + resource "aws_iam_role_policy_attachment" "chewbacca_ec2_cw_attach" {
      + id         = (known after apply)
      + policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
      + role       = "peterock-ec2-role01"
    }

  # module.lab1-ab.aws_iam_role_policy_attachment.chewbacca_ec2_secrets_attach will be created
  + resource "aws_iam_role_policy_attachment" "chewbacca_ec2_secrets_attach" {
      + id         = (known after apply)
      + policy_arn = "arn:aws:iam::aws:policy/AWSSecretsManagerClientReadOnlyAccess"
      + role       = "peterock-ec2-role01"
    }

  # module.lab1-ab.aws_iam_role_policy_attachment.chewbacca_ec2_ssm_attach will be created
  + resource "aws_iam_role_policy_attachment" "chewbacca_ec2_ssm_attach" {
      + id         = (known after apply)
      + policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
      + role       = "peterock-ec2-role01"
    }

  # module.lab1-ab.aws_instance.chewbacca_ec201 will be created
  + resource "aws_instance" "chewbacca_ec201" {
      + ami                                  = "ami-0b11764ef057ab4b7"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + enable_primary_ipv6                  = (known after apply)
      + force_destroy                        = false
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = "peterock-instance-profile01"
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t3.micro"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = "ec2_key_pair"
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_group_id                   = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + region                               = "sa-east-1"
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = (known after apply)
      + tags                                 = {
          + "Name" = "peterock-ec201"
        }
      + tags_all                             = {
          + "Name" = "peterock-ec201"
        }
      + tenancy                              = (known after apply)
      + user_data                            = <<-EOT
            #!/bin/bash
            dnf update -y
            dnf install -y python3-pip
            pip3 install flask pymysql boto3
            
            mkdir -p /opt/rdsapp
            cat >/opt/rdsapp/app.py <<'PY'
            import json
            import os
            import boto3
            import pymysql
            from flask import Flask, request
            
            REGION = os.environ.get("AWS_REGION", "sa-east-1")
            SECRET_ID = os.environ.get("SECRET_ID", "peterock/rds/mysql")
            
            secrets = boto3.client("secretsmanager", region_name=REGION)
            
            def get_db_creds():
                resp = secrets.get_secret_value(SecretId=SECRET_ID)
                s = json.loads(resp["SecretString"])
                # When you use "Credentials for RDS database", AWS usually stores:
                # username, password, host, port, dbname (sometimes)
                return s
            
            def get_conn():
                c = get_db_creds()
                host = c["host"]
                user = c["username"]
                password = c["password"]
                port = int(c.get("port", 3306))
                db = c.get("dbname", "labdb")  # we'll create this if it doesn't exist
                return pymysql.connect(host=host, user=user, password=password, port=port, database=db, autocommit=True)
            
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
            
            @app.route("/add", methods=["POST", "GET"])
            def add_note():
                note = request.args.get("note", "").strip()
                if not note:
                    return "Missing note param. Try: /add?note=hello", 400
                conn = get_conn()
                cur = conn.cursor()
                cur.execute("INSERT INTO notes(note) VALUES(%s);", (note,))
                cur.close()
                conn.close()
                return f"Inserted note: {note}"
            
            @app.route("/list")
            def list_notes():
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
            
            systemctl daemon-reload
            systemctl enable rdsapp
            systemctl start rdsapp
        EOT
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)

      + capacity_reservation_specification (known after apply)

      + cpu_options (known after apply)

      + ebs_block_device (known after apply)

      + enclave_options (known after apply)

      + ephemeral_block_device (known after apply)

      + instance_market_options (known after apply)

      + maintenance_options (known after apply)

      + metadata_options (known after apply)

      + network_interface (known after apply)

      + primary_network_interface (known after apply)

      + private_dns_name_options (known after apply)

      + root_block_device (known after apply)
    }

  # module.lab1-ab.aws_internet_gateway.chewbacca_igw01 will be created
  + resource "aws_internet_gateway" "chewbacca_igw01" {
      + arn      = (known after apply)
      + id       = (known after apply)
      + owner_id = (known after apply)
      + region   = "sa-east-1"
      + tags     = {
          + "Name" = "peterock-igw01"
        }
      + tags_all = {
          + "Name" = "peterock-igw01"
        }
      + vpc_id   = (known after apply)
    }

  # module.lab1-ab.aws_key_pair.ec2_key_pair will be created
  + resource "aws_key_pair" "ec2_key_pair" {
      + arn             = (known after apply)
      + fingerprint     = (known after apply)
      + id              = (known after apply)
      + key_name        = "ec2_key_pair"
      + key_name_prefix = (known after apply)
      + key_pair_id     = (known after apply)
      + key_type        = (known after apply)
      + public_key      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCnxKbA3Du42MJ6xu8XvfyFfI50Gi6HGqRAgyqwlU1DVNBvZUtBmZokhwNAKwSLfi/m5cGQPAIbDLo2RO2DLfIq5FDy7wv0+T0ZKNSCWt+DSsdgjculg1V6bd1LQQc9+j9j4DeJYC3gHFwg8g4B1YWSaGD25oPye5GiuhEcGVSdMFHyDPEOz0POkgBIVRiQvbKL8PtrgVD/a0B3JjO7zl4u3RAZUJjvkMJTmE+r8j7uii6YKipRL7HafoGajvg1vpvchSNFp51CGT0YBUqkjSmDN7OG0WnbSWrQkgFopNcWJi3tO8exVFmPhdzb8DNcseX6NxxBo7G+7X4CM+3LdXbIMMabRVxjQCvoW64Cg+hLUGAStsSTPtKwa4ipB4xMt4lI+KGjyPmJ4KrKtcpEHAUDdE7d33p8noZCRC7SqsLKm4xkE/68c9aTYlIh6eHBbKryuewoX/FC0RyusI7/tm9TMHy6AHASzxEIwrR8KB9AA0Ckz/bxdWfIghagEAKKT1lziVDg7suxOjRfVzV1PhTcbloLHZrnZKU1Zil/IeoeXlZqqgYxViZZWNMis2AlBYjvu8eQ9puwnSFbnwo7TFuDpIOocZ908laqpjvbcAMIFgUJ6qtpZ42Qpmus0xVoJO/vSzxLY8y55vXfG6qZJXJsd6NJIMgGhTBXRGlcbi6+MQ== peter@DESKTOP-6CQK9QU"
      + region          = "sa-east-1"
      + tags_all        = (known after apply)
    }

  # module.lab1-ab.aws_route.chewbacca_public_default_route will be created
  + resource "aws_route" "chewbacca_public_default_route" {
      + destination_cidr_block = "0.0.0.0/0"
      + gateway_id             = (known after apply)
      + id                     = (known after apply)
      + instance_id            = (known after apply)
      + instance_owner_id      = (known after apply)
      + network_interface_id   = (known after apply)
      + origin                 = (known after apply)
      + region                 = "sa-east-1"
      + route_table_id         = (known after apply)
      + state                  = (known after apply)
    }

  # module.lab1-ab.aws_route_table.chewbacca_private_rt01 will be created
  + resource "aws_route_table" "chewbacca_private_rt01" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + region           = "sa-east-1"
      + route            = (known after apply)
      + tags             = {
          + "Name" = "peterock-private-rt01"
        }
      + tags_all         = {
          + "Name" = "peterock-private-rt01"
        }
      + vpc_id           = (known after apply)
    }

  # module.lab1-ab.aws_route_table.chewbacca_public_rt01 will be created
  + resource "aws_route_table" "chewbacca_public_rt01" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + region           = "sa-east-1"
      + route            = (known after apply)
      + tags             = {
          + "Name" = "peterock-public-rt01"
        }
      + tags_all         = {
          + "Name" = "peterock-public-rt01"
        }
      + vpc_id           = (known after apply)
    }

  # module.lab1-ab.aws_route_table_association.chewbacca_private_rta[0] will be created
  + resource "aws_route_table_association" "chewbacca_private_rta" {
      + id             = (known after apply)
      + region         = "sa-east-1"
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # module.lab1-ab.aws_route_table_association.chewbacca_private_rta[1] will be created
  + resource "aws_route_table_association" "chewbacca_private_rta" {
      + id             = (known after apply)
      + region         = "sa-east-1"
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # module.lab1-ab.aws_route_table_association.chewbacca_public_rta[0] will be created
  + resource "aws_route_table_association" "chewbacca_public_rta" {
      + id             = (known after apply)
      + region         = "sa-east-1"
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # module.lab1-ab.aws_route_table_association.chewbacca_public_rta[1] will be created
  + resource "aws_route_table_association" "chewbacca_public_rta" {
      + id             = (known after apply)
      + region         = "sa-east-1"
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # module.lab1-ab.aws_secretsmanager_secret.chewbacca_db_secret01 will be created
  + resource "aws_secretsmanager_secret" "chewbacca_db_secret01" {
      + arn                            = (known after apply)
      + force_overwrite_replica_secret = false
      + id                             = (known after apply)
      + name                           = "peterock/rds/mysql"
      + name_prefix                    = (known after apply)
      + policy                         = (known after apply)
      + recovery_window_in_days        = 0
      + region                         = "sa-east-1"
      + tags_all                       = (known after apply)

      + replica (known after apply)
    }

  # module.lab1-ab.aws_secretsmanager_secret_version.chewbacca_db_secret_version01 will be created
  + resource "aws_secretsmanager_secret_version" "chewbacca_db_secret_version01" {
      + arn                  = (known after apply)
      + has_secret_string_wo = (known after apply)
      + id                   = (known after apply)
      + region               = "sa-east-1"
      + secret_id            = (known after apply)
      + secret_string        = (sensitive value)
      + secret_string_wo     = (write-only attribute)
      + version_id           = (known after apply)
      + version_stages       = (known after apply)
    }

  # module.lab1-ab.aws_security_group.chewbacca_ec2_sg01 will be created
  + resource "aws_security_group" "chewbacca_ec2_sg01" {
      + arn                    = (known after apply)
      + description            = "EC2 app security group"
      + egress                 = (known after apply)
      + id                     = (known after apply)
      + ingress                = (known after apply)
      + name                   = "peterock-ec2-sg01"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + region                 = "sa-east-1"
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name" = "peterock-ec2-sg01"
        }
      + tags_all               = {
          + "Name" = "peterock-ec2-sg01"
        }
      + vpc_id                 = (known after apply)
    }

  # module.lab1-ab.aws_security_group.chewbacca_rds_sg01 will be created
  + resource "aws_security_group" "chewbacca_rds_sg01" {
      + arn                    = (known after apply)
      + description            = "RDS security group"
      + egress                 = (known after apply)
      + id                     = (known after apply)
      + ingress                = (known after apply)
      + name                   = "peterock-rds-sg01"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + region                 = "sa-east-1"
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name" = "peterock-rds-sg01"
        }
      + tags_all               = {
          + "Name" = "peterock-rds-sg01"
        }
      + vpc_id                 = (known after apply)
    }

  # module.lab1-ab.aws_security_group.chewbacca_vpce_sg01 will be created
  + resource "aws_security_group" "chewbacca_vpce_sg01" {
      + arn                    = (known after apply)
      + description            = "VPC Endpoint security group"
      + egress                 = (known after apply)
      + id                     = (known after apply)
      + ingress                = (known after apply)
      + name                   = "peterock-vpce-sg01"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + region                 = "sa-east-1"
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name" = "peterock-vpce-sg01"
        }
      + tags_all               = {
          + "Name" = "peterock-vpce-sg01"
        }
      + vpc_id                 = (known after apply)
    }

  # module.lab1-ab.aws_sns_topic.chewbacca_sns_topic01 will be created
  + resource "aws_sns_topic" "chewbacca_sns_topic01" {
      + arn                         = (known after apply)
      + beginning_archive_time      = (known after apply)
      + content_based_deduplication = false
      + fifo_throughput_scope       = (known after apply)
      + fifo_topic                  = false
      + id                          = (known after apply)
      + name                        = "peterock-db-incidents"
      + name_prefix                 = (known after apply)
      + owner                       = (known after apply)
      + policy                      = (known after apply)
      + region                      = "sa-east-1"
      + signature_version           = (known after apply)
      + tags_all                    = (known after apply)
      + tracing_config              = (known after apply)
    }

  # module.lab1-ab.aws_sns_topic_subscription.chewbacca_sns_sub01 will be created
  + resource "aws_sns_topic_subscription" "chewbacca_sns_sub01" {
      + arn                             = (known after apply)
      + confirmation_timeout_in_minutes = 1
      + confirmation_was_authenticated  = (known after apply)
      + endpoint                        = "chery.peter@gmail.com"
      + endpoint_auto_confirms          = false
      + filter_policy_scope             = (known after apply)
      + id                              = (known after apply)
      + owner_id                        = (known after apply)
      + pending_confirmation            = (known after apply)
      + protocol                        = "email"
      + raw_message_delivery            = false
      + region                          = "sa-east-1"
      + topic_arn                       = (known after apply)
    }

  # module.lab1-ab.aws_ssm_parameter.chewbacca_db_endpoint_param will be created
  + resource "aws_ssm_parameter" "chewbacca_db_endpoint_param" {
      + arn            = (known after apply)
      + data_type      = (known after apply)
      + has_value_wo   = (known after apply)
      + id             = (known after apply)
      + insecure_value = (known after apply)
      + key_id         = (known after apply)
      + name           = "/lab/db/endpoint"
      + region         = "sa-east-1"
      + tags           = {
          + "Name" = "peterock-param-db-endpoint"
        }
      + tags_all       = {
          + "Name" = "peterock-param-db-endpoint"
        }
      + tier           = (known after apply)
      + type           = "String"
      + value          = (sensitive value)
      + value_wo       = (write-only attribute)
      + version        = (known after apply)
    }

  # module.lab1-ab.aws_ssm_parameter.chewbacca_db_name_param will be created
  + resource "aws_ssm_parameter" "chewbacca_db_name_param" {
      + arn            = (known after apply)
      + data_type      = (known after apply)
      + has_value_wo   = (known after apply)
      + id             = (known after apply)
      + insecure_value = (known after apply)
      + key_id         = (known after apply)
      + name           = "/lab/db/name"
      + region         = "sa-east-1"
      + tags           = {
          + "Name" = "peterock-param-db-name"
        }
      + tags_all       = {
          + "Name" = "peterock-param-db-name"
        }
      + tier           = (known after apply)
      + type           = "String"
      + value          = (sensitive value)
      + value_wo       = (write-only attribute)
      + version        = (known after apply)
    }

  # module.lab1-ab.aws_ssm_parameter.chewbacca_db_port_param will be created
  + resource "aws_ssm_parameter" "chewbacca_db_port_param" {
      + arn            = (known after apply)
      + data_type      = (known after apply)
      + has_value_wo   = (known after apply)
      + id             = (known after apply)
      + insecure_value = (known after apply)
      + key_id         = (known after apply)
      + name           = "/lab/db/port"
      + region         = "sa-east-1"
      + tags           = {
          + "Name" = "peterock-param-db-port"
        }
      + tags_all       = {
          + "Name" = "peterock-param-db-port"
        }
      + tier           = (known after apply)
      + type           = "String"
      + value          = (sensitive value)
      + value_wo       = (write-only attribute)
      + version        = (known after apply)
    }

  # module.lab1-ab.aws_subnet.chewbacca_private_subnets[0] will be created
  + resource "aws_subnet" "chewbacca_private_subnets" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "sa-east-1a"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.98.101.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + region                                         = "sa-east-1"
      + tags                                           = {
          + "Name" = "peterock-private-subnet01"
        }
      + tags_all                                       = {
          + "Name" = "peterock-private-subnet01"
        }
      + vpc_id                                         = (known after apply)
    }

  # module.lab1-ab.aws_subnet.chewbacca_private_subnets[1] will be created
  + resource "aws_subnet" "chewbacca_private_subnets" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "sa-east-1b"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.98.102.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + region                                         = "sa-east-1"
      + tags                                           = {
          + "Name" = "peterock-private-subnet02"
        }
      + tags_all                                       = {
          + "Name" = "peterock-private-subnet02"
        }
      + vpc_id                                         = (known after apply)
    }

  # module.lab1-ab.aws_subnet.chewbacca_public_subnets[0] will be created
  + resource "aws_subnet" "chewbacca_public_subnets" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "sa-east-1a"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.98.1.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = true
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + region                                         = "sa-east-1"
      + tags                                           = {
          + "Name" = "peterock-public-subnet01"
        }
      + tags_all                                       = {
          + "Name" = "peterock-public-subnet01"
        }
      + vpc_id                                         = (known after apply)
    }

  # module.lab1-ab.aws_subnet.chewbacca_public_subnets[1] will be created
  + resource "aws_subnet" "chewbacca_public_subnets" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "sa-east-1b"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.98.2.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = true
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + region                                         = "sa-east-1"
      + tags                                           = {
          + "Name" = "peterock-public-subnet02"
        }
      + tags_all                                       = {
          + "Name" = "peterock-public-subnet02"
        }
      + vpc_id                                         = (known after apply)
    }

  # module.lab1-ab.aws_vpc.chewbacca_vpc01 will be created
  + resource "aws_vpc" "chewbacca_vpc01" {
      + arn                                  = (known after apply)
      + cidr_block                           = "10.98.0.0/16"
      + default_network_acl_id               = (known after apply)
      + default_route_table_id               = (known after apply)
      + default_security_group_id            = (known after apply)
      + dhcp_options_id                      = (known after apply)
      + enable_dns_hostnames                 = true
      + enable_dns_support                   = true
      + enable_network_address_usage_metrics = (known after apply)
      + id                                   = (known after apply)
      + instance_tenancy                     = "default"
      + ipv6_association_id                  = (known after apply)
      + ipv6_cidr_block                      = (known after apply)
      + ipv6_cidr_block_network_border_group = (known after apply)
      + main_route_table_id                  = (known after apply)
      + owner_id                             = (known after apply)
      + region                               = "sa-east-1"
      + tags                                 = {
          + "Name" = "peterock-vpc01"
        }
      + tags_all                             = {
          + "Name" = "peterock-vpc01"
        }
    }

  # module.lab1-ab.aws_vpc_endpoint.chewbacca_vpce_services["ec2messages"] will be created
  + resource "aws_vpc_endpoint" "chewbacca_vpce_services" {
      + arn                   = (known after apply)
      + cidr_blocks           = (known after apply)
      + dns_entry             = (known after apply)
      + id                    = (known after apply)
      + ip_address_type       = (known after apply)
      + network_interface_ids = (known after apply)
      + owner_id              = (known after apply)
      + policy                = (known after apply)
      + prefix_list_id        = (known after apply)
      + private_dns_enabled   = true
      + region                = "sa-east-1"
      + requester_managed     = (known after apply)
      + route_table_ids       = (known after apply)
      + security_group_ids    = (known after apply)
      + service_name          = "com.amazonaws.sa-east-1.ec2messages"
      + service_region        = (known after apply)
      + state                 = (known after apply)
      + subnet_ids            = (known after apply)
      + tags                  = {
          + "Name" = "peterock-vpce-ec2messages"
        }
      + tags_all              = {
          + "Name" = "peterock-vpce-ec2messages"
        }
      + vpc_endpoint_type     = "Interface"
      + vpc_id                = (known after apply)

      + dns_options (known after apply)

      + subnet_configuration (known after apply)
    }

  # module.lab1-ab.aws_vpc_endpoint.chewbacca_vpce_services["logs"] will be created
  + resource "aws_vpc_endpoint" "chewbacca_vpce_services" {
      + arn                   = (known after apply)
      + cidr_blocks           = (known after apply)
      + dns_entry             = (known after apply)
      + id                    = (known after apply)
      + ip_address_type       = (known after apply)
      + network_interface_ids = (known after apply)
      + owner_id              = (known after apply)
      + policy                = (known after apply)
      + prefix_list_id        = (known after apply)
      + private_dns_enabled   = true
      + region                = "sa-east-1"
      + requester_managed     = (known after apply)
      + route_table_ids       = (known after apply)
      + security_group_ids    = (known after apply)
      + service_name          = "com.amazonaws.sa-east-1.logs"
      + service_region        = (known after apply)
      + state                 = (known after apply)
      + subnet_ids            = (known after apply)
      + tags                  = {
          + "Name" = "peterock-vpce-logs"
        }
      + tags_all              = {
          + "Name" = "peterock-vpce-logs"
        }
      + vpc_endpoint_type     = "Interface"
      + vpc_id                = (known after apply)

      + dns_options (known after apply)

      + subnet_configuration (known after apply)
    }

  # module.lab1-ab.aws_vpc_endpoint.chewbacca_vpce_services["secretsmanager"] will be created
  + resource "aws_vpc_endpoint" "chewbacca_vpce_services" {
      + arn                   = (known after apply)
      + cidr_blocks           = (known after apply)
      + dns_entry             = (known after apply)
      + id                    = (known after apply)
      + ip_address_type       = (known after apply)
      + network_interface_ids = (known after apply)
      + owner_id              = (known after apply)
      + policy                = (known after apply)
      + prefix_list_id        = (known after apply)
      + private_dns_enabled   = true
      + region                = "sa-east-1"
      + requester_managed     = (known after apply)
      + route_table_ids       = (known after apply)
      + security_group_ids    = (known after apply)
      + service_name          = "com.amazonaws.sa-east-1.secretsmanager"
      + service_region        = (known after apply)
      + state                 = (known after apply)
      + subnet_ids            = (known after apply)
      + tags                  = {
          + "Name" = "peterock-vpce-secretsmanager"
        }
      + tags_all              = {
          + "Name" = "peterock-vpce-secretsmanager"
        }
      + vpc_endpoint_type     = "Interface"
      + vpc_id                = (known after apply)

      + dns_options (known after apply)

      + subnet_configuration (known after apply)
    }

  # module.lab1-ab.aws_vpc_endpoint.chewbacca_vpce_services["ssm"] will be created
  + resource "aws_vpc_endpoint" "chewbacca_vpce_services" {
      + arn                   = (known after apply)
      + cidr_blocks           = (known after apply)
      + dns_entry             = (known after apply)
      + id                    = (known after apply)
      + ip_address_type       = (known after apply)
      + network_interface_ids = (known after apply)
      + owner_id              = (known after apply)
      + policy                = (known after apply)
      + prefix_list_id        = (known after apply)
      + private_dns_enabled   = true
      + region                = "sa-east-1"
      + requester_managed     = (known after apply)
      + route_table_ids       = (known after apply)
      + security_group_ids    = (known after apply)
      + service_name          = "com.amazonaws.sa-east-1.ssm"
      + service_region        = (known after apply)
      + state                 = (known after apply)
      + subnet_ids            = (known after apply)
      + tags                  = {
          + "Name" = "peterock-vpce-ssm"
        }
      + tags_all              = {
          + "Name" = "peterock-vpce-ssm"
        }
      + vpc_endpoint_type     = "Interface"
      + vpc_id                = (known after apply)

      + dns_options (known after apply)

      + subnet_configuration (known after apply)
    }

  # module.lab1-ab.aws_vpc_endpoint.chewbacca_vpce_services["ssmmessages"] will be created
  + resource "aws_vpc_endpoint" "chewbacca_vpce_services" {
      + arn                   = (known after apply)
      + cidr_blocks           = (known after apply)
      + dns_entry             = (known after apply)
      + id                    = (known after apply)
      + ip_address_type       = (known after apply)
      + network_interface_ids = (known after apply)
      + owner_id              = (known after apply)
      + policy                = (known after apply)
      + prefix_list_id        = (known after apply)
      + private_dns_enabled   = true
      + region                = "sa-east-1"
      + requester_managed     = (known after apply)
      + route_table_ids       = (known after apply)
      + security_group_ids    = (known after apply)
      + service_name          = "com.amazonaws.sa-east-1.ssmmessages"
      + service_region        = (known after apply)
      + state                 = (known after apply)
      + subnet_ids            = (known after apply)
      + tags                  = {
          + "Name" = "peterock-vpce-ssmmessages"
        }
      + tags_all              = {
          + "Name" = "peterock-vpce-ssmmessages"
        }
      + vpc_endpoint_type     = "Interface"
      + vpc_id                = (known after apply)

      + dns_options (known after apply)

      + subnet_configuration (known after apply)
    }

  # module.lab1-ab.aws_vpc_security_group_egress_rule.ec2_all_outbound will be created
  + resource "aws_vpc_security_group_egress_rule" "ec2_all_outbound" {
      + arn                    = (known after apply)
      + cidr_ipv4              = "0.0.0.0/0"
      + description            = "Allow all outbound traffic"
      + id                     = (known after apply)
      + ip_protocol            = "-1"
      + region                 = "sa-east-1"
      + security_group_id      = (known after apply)
      + security_group_rule_id = (known after apply)
      + tags_all               = {}
    }

  # module.lab1-ab.aws_vpc_security_group_egress_rule.rds_all_outbound will be created
  + resource "aws_vpc_security_group_egress_rule" "rds_all_outbound" {
      + arn                    = (known after apply)
      + cidr_ipv4              = "0.0.0.0/0"
      + description            = "Allow all outbound traffic"
      + id                     = (known after apply)
      + ip_protocol            = "-1"
      + region                 = "sa-east-1"
      + security_group_id      = (known after apply)
      + security_group_rule_id = (known after apply)
      + tags_all               = {}
    }

  # module.lab1-ab.aws_vpc_security_group_egress_rule.vpce_all_outbound will be created
  + resource "aws_vpc_security_group_egress_rule" "vpce_all_outbound" {
      + arn                    = (known after apply)
      + cidr_ipv4              = "0.0.0.0/0"
      + description            = "Allow all outbound traffic"
      + id                     = (known after apply)
      + ip_protocol            = "-1"
      + region                 = "sa-east-1"
      + security_group_id      = (known after apply)
      + security_group_rule_id = (known after apply)
      + tags_all               = {}
    }

  # module.lab1-ab.aws_vpc_security_group_ingress_rule.http will be created
  + resource "aws_vpc_security_group_ingress_rule" "http" {
      + arn                    = (known after apply)
      + cidr_ipv4              = "108.56.232.140/32"
      + description            = "Allow HTTPS from MY PUBLIC IP"
      + from_port              = 443
      + id                     = (known after apply)
      + ip_protocol            = "tcp"
      + region                 = "sa-east-1"
      + security_group_id      = (known after apply)
      + security_group_rule_id = (known after apply)
      + tags_all               = {}
      + to_port                = 443
    }

  # module.lab1-ab.aws_vpc_security_group_ingress_rule.rds_port will be created
  + resource "aws_vpc_security_group_ingress_rule" "rds_port" {
      + arn                          = (known after apply)
      + description                  = "Allow MySQL-DB from VPC"
      + from_port                    = 3306
      + id                           = (known after apply)
      + ip_protocol                  = "tcp"
      + referenced_security_group_id = (known after apply)
      + region                       = "sa-east-1"
      + security_group_id            = (known after apply)
      + security_group_rule_id       = (known after apply)
      + tags_all                     = {}
      + to_port                      = 3306
    }

  # module.lab1-ab.aws_vpc_security_group_ingress_rule.ssh will be created
  + resource "aws_vpc_security_group_ingress_rule" "ssh" {
      + arn                    = (known after apply)
      + cidr_ipv4              = "108.56.232.140/32"
      + description            = "Allow SSH from VPC"
      + from_port              = 22
      + id                     = (known after apply)
      + ip_protocol            = "tcp"
      + region                 = "sa-east-1"
      + security_group_id      = (known after apply)
      + security_group_rule_id = (known after apply)
      + tags_all               = {}
      + to_port                = 22
    }

  # module.lab1-ab.aws_vpc_security_group_ingress_rule.vpce_https will be created
  + resource "aws_vpc_security_group_ingress_rule" "vpce_https" {
      + arn                          = (known after apply)
      + description                  = "Allow HTTPS from privates subnets"
      + from_port                    = 443
      + id                           = (known after apply)
      + ip_protocol                  = "tcp"
      + referenced_security_group_id = (known after apply)
      + region                       = "sa-east-1"
      + security_group_id            = (known after apply)
      + security_group_rule_id       = (known after apply)
      + tags_all                     = {}
      + to_port                      = 443
    }

Plan: 55 to add, 0 to change, 0 to destroy.
[90m
─────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't
guarantee to take exactly these actions if you run "terraform apply" now.
