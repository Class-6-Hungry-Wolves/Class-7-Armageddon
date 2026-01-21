[0m[1mmodule.lab1-ab.data.aws_caller_identity.chewbacca_self01: Reading...[0m[0m
[0m[1mmodule.lab1-ab.data.aws_region.chewbacca_region01: Reading...[0m[0m
[0m[1mmodule.lab1-ab.data.aws_region.chewbacca_region01: Read complete after 0s [id=sa-east-1][0m
[0m[1mmodule.lab1-ab.data.aws_caller_identity.chewbacca_self01: Read complete after 0s [id=630400242534][0m

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  [32m+[0m create[0m

Terraform will perform the following actions:

[1m  # aws_iam_policy.chewbacca_leastpriv_cwlogs01[0m will be created
[0m  [32m+[0m[0m resource "aws_iam_policy" "chewbacca_leastpriv_cwlogs01" {
      [32m+[0m[0m arn              = (known after apply)
      [32m+[0m[0m attachment_count = (known after apply)
      [32m+[0m[0m description      = "Least-privilege CloudWatch Logs write for the app log group"
      [32m+[0m[0m id               = (known after apply)
      [32m+[0m[0m name             = "peterock-lp-cwlogs01"
      [32m+[0m[0m name_prefix      = (known after apply)
      [32m+[0m[0m path             = "/"
      [32m+[0m[0m policy           = (known after apply)
      [32m+[0m[0m policy_id        = (known after apply)
      [32m+[0m[0m tags_all         = (known after apply)
    }

[1m  # aws_iam_policy.chewbacca_leastpriv_read_params01[0m will be created
[0m  [32m+[0m[0m resource "aws_iam_policy" "chewbacca_leastpriv_read_params01" {
      [32m+[0m[0m arn              = (known after apply)
      [32m+[0m[0m attachment_count = (known after apply)
      [32m+[0m[0m description      = "Least-privilege read for SSM Parameter Store under /lab/db/*"
      [32m+[0m[0m id               = (known after apply)
      [32m+[0m[0m name             = "peterock-lp-ssm-read01"
      [32m+[0m[0m name_prefix      = (known after apply)
      [32m+[0m[0m path             = "/"
      [32m+[0m[0m policy           = jsonencode(
            {
              [32m+[0m[0m Statement = [
                  [32m+[0m[0m {
                      [32m+[0m[0m Action   = [
                          [32m+[0m[0m "ssm:GetParameter",
                          [32m+[0m[0m "ssm:GetParameters",
                          [32m+[0m[0m "ssm:GetParametersByPath",
                        ]
                      [32m+[0m[0m Effect   = "Allow"
                      [32m+[0m[0m Resource = [
                          [32m+[0m[0m "arn:aws:ssm:sa-east-1:630400242534:parameter/lab/db/*",
                        ]
                      [32m+[0m[0m Sid      = "ReadLabDbParams"
                    },
                ]
              [32m+[0m[0m Version   = "2012-10-17"
            }
        )
      [32m+[0m[0m policy_id        = (known after apply)
      [32m+[0m[0m tags_all         = (known after apply)
    }

[1m  # aws_iam_policy.chewbacca_leastpriv_read_secret01[0m will be created
[0m  [32m+[0m[0m resource "aws_iam_policy" "chewbacca_leastpriv_read_secret01" {
      [32m+[0m[0m arn              = (known after apply)
      [32m+[0m[0m attachment_count = (known after apply)
      [32m+[0m[0m description      = "Least-privilege read for the lab DB secret"
      [32m+[0m[0m id               = (known after apply)
      [32m+[0m[0m name             = "peterock-lp-secrets-read01"
      [32m+[0m[0m name_prefix      = (known after apply)
      [32m+[0m[0m path             = "/"
      [32m+[0m[0m policy           = jsonencode(
            {
              [32m+[0m[0m Statement = [
                  [32m+[0m[0m {
                      [32m+[0m[0m Action   = [
                          [32m+[0m[0m "secretsmanager:GetSecretValue",
                          [32m+[0m[0m "secretsmanager:DescribeSecret",
                        ]
                      [32m+[0m[0m Effect   = "Allow"
                      [32m+[0m[0m Resource = "arn:aws:secretsmanager:sa-east-1:630400242534:secret:peterock/rds/mysql*"
                      [32m+[0m[0m Sid      = "ReadOnlyLabSecret"
                    },
                ]
              [32m+[0m[0m Version   = "2012-10-17"
            }
        )
      [32m+[0m[0m policy_id        = (known after apply)
      [32m+[0m[0m tags_all         = (known after apply)
    }

[1m  # aws_iam_role_policy_attachment.chewbacca_attach_lp_cwlogs01[0m will be created
[0m  [32m+[0m[0m resource "aws_iam_role_policy_attachment" "chewbacca_attach_lp_cwlogs01" {
      [32m+[0m[0m id         = (known after apply)
      [32m+[0m[0m policy_arn = (known after apply)
      [32m+[0m[0m role       = "peterock-ec2-role01"
    }

[1m  # aws_iam_role_policy_attachment.chewbacca_attach_lp_params01[0m will be created
[0m  [32m+[0m[0m resource "aws_iam_role_policy_attachment" "chewbacca_attach_lp_params01" {
      [32m+[0m[0m id         = (known after apply)
      [32m+[0m[0m policy_arn = (known after apply)
      [32m+[0m[0m role       = "peterock-ec2-role01"
    }

[1m  # aws_iam_role_policy_attachment.chewbacca_attach_lp_secret01[0m will be created
[0m  [32m+[0m[0m resource "aws_iam_role_policy_attachment" "chewbacca_attach_lp_secret01" {
      [32m+[0m[0m id         = (known after apply)
      [32m+[0m[0m policy_arn = (known after apply)
      [32m+[0m[0m role       = "peterock-ec2-role01"
    }

[1m  # aws_instance.chewbacca_ec201_private_bonus[0m will be created
[0m  [32m+[0m[0m resource "aws_instance" "chewbacca_ec201_private_bonus" {
      [32m+[0m[0m ami                                  = "ami-0b11764ef057ab4b7"
      [32m+[0m[0m arn                                  = (known after apply)
      [32m+[0m[0m associate_public_ip_address          = (known after apply)
      [32m+[0m[0m availability_zone                    = (known after apply)
      [32m+[0m[0m disable_api_stop                     = (known after apply)
      [32m+[0m[0m disable_api_termination              = (known after apply)
      [32m+[0m[0m ebs_optimized                        = (known after apply)
      [32m+[0m[0m enable_primary_ipv6                  = (known after apply)
      [32m+[0m[0m force_destroy                        = false
      [32m+[0m[0m get_password_data                    = false
      [32m+[0m[0m host_id                              = (known after apply)
      [32m+[0m[0m host_resource_group_arn              = (known after apply)
      [32m+[0m[0m iam_instance_profile                 = (known after apply)
      [32m+[0m[0m id                                   = (known after apply)
      [32m+[0m[0m instance_initiated_shutdown_behavior = (known after apply)
      [32m+[0m[0m instance_lifecycle                   = (known after apply)
      [32m+[0m[0m instance_state                       = (known after apply)
      [32m+[0m[0m instance_type                        = "t3.micro"
      [32m+[0m[0m ipv6_address_count                   = (known after apply)
      [32m+[0m[0m ipv6_addresses                       = (known after apply)
      [32m+[0m[0m key_name                             = (known after apply)
      [32m+[0m[0m monitoring                           = (known after apply)
      [32m+[0m[0m outpost_arn                          = (known after apply)
      [32m+[0m[0m password_data                        = (known after apply)
      [32m+[0m[0m placement_group                      = (known after apply)
      [32m+[0m[0m placement_group_id                   = (known after apply)
      [32m+[0m[0m placement_partition_number           = (known after apply)
      [32m+[0m[0m primary_network_interface_id         = (known after apply)
      [32m+[0m[0m private_dns                          = (known after apply)
      [32m+[0m[0m private_ip                           = (known after apply)
      [32m+[0m[0m public_dns                           = (known after apply)
      [32m+[0m[0m public_ip                            = (known after apply)
      [32m+[0m[0m region                               = "sa-east-1"
      [32m+[0m[0m secondary_private_ips                = (known after apply)
      [32m+[0m[0m security_groups                      = (known after apply)
      [32m+[0m[0m source_dest_check                    = true
      [32m+[0m[0m spot_instance_request_id             = (known after apply)
      [32m+[0m[0m subnet_id                            = (known after apply)
      [32m+[0m[0m tags                                 = {
          [32m+[0m[0m "Name" = "peterock-ec201-private"
        }
      [32m+[0m[0m tags_all                             = {
          [32m+[0m[0m "Name" = "peterock-ec201-private"
        }
      [32m+[0m[0m tenancy                              = (known after apply)
      [32m+[0m[0m user_data                            = <<-EOT
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
      [32m+[0m[0m user_data_base64                     = (known after apply)
      [32m+[0m[0m user_data_replace_on_change          = false
      [32m+[0m[0m vpc_security_group_ids               = (known after apply)

      [32m+[0m[0m capacity_reservation_specification (known after apply)

      [32m+[0m[0m cpu_options (known after apply)

      [32m+[0m[0m ebs_block_device (known after apply)

      [32m+[0m[0m enclave_options (known after apply)

      [32m+[0m[0m ephemeral_block_device (known after apply)

      [32m+[0m[0m instance_market_options (known after apply)

      [32m+[0m[0m maintenance_options (known after apply)

      [32m+[0m[0m metadata_options (known after apply)

      [32m+[0m[0m network_interface (known after apply)

      [32m+[0m[0m primary_network_interface (known after apply)

      [32m+[0m[0m private_dns_name_options (known after apply)

      [32m+[0m[0m root_block_device (known after apply)
    }

[1m  # aws_security_group.chewbacca_alb_sg01[0m will be created
[0m  [32m+[0m[0m resource "aws_security_group" "chewbacca_alb_sg01" {
      [32m+[0m[0m arn                    = (known after apply)
      [32m+[0m[0m description            = "ALB security group"
      [32m+[0m[0m egress                 = (known after apply)
      [32m+[0m[0m id                     = (known after apply)
      [32m+[0m[0m ingress                = (known after apply)
      [32m+[0m[0m name                   = "peterock-alb-sg01"
      [32m+[0m[0m name_prefix            = (known after apply)
      [32m+[0m[0m owner_id               = (known after apply)
      [32m+[0m[0m region                 = "sa-east-1"
      [32m+[0m[0m revoke_rules_on_delete = false
      [32m+[0m[0m tags                   = {
          [32m+[0m[0m "Name" = "peterock-alb-sg01"
        }
      [32m+[0m[0m tags_all               = {
          [32m+[0m[0m "Name" = "peterock-alb-sg01"
        }
      [32m+[0m[0m vpc_id                 = (known after apply)
    }

[1m  # aws_security_group_rule.chewbacca_ec2_ingress_from_alb01[0m will be created
[0m  [32m+[0m[0m resource "aws_security_group_rule" "chewbacca_ec2_ingress_from_alb01" {
      [32m+[0m[0m from_port                = 80
      [32m+[0m[0m id                       = (known after apply)
      [32m+[0m[0m protocol                 = "tcp"
      [32m+[0m[0m region                   = "sa-east-1"
      [32m+[0m[0m security_group_id        = (known after apply)
      [32m+[0m[0m security_group_rule_id   = (known after apply)
      [32m+[0m[0m self                     = false
      [32m+[0m[0m source_security_group_id = (known after apply)
      [32m+[0m[0m to_port                  = 80
      [32m+[0m[0m type                     = "ingress"
    }

[1m  # aws_vpc_endpoint.chewbacca_vpce_services["kms"][0m will be created
[0m  [32m+[0m[0m resource "aws_vpc_endpoint" "chewbacca_vpce_services" {
      [32m+[0m[0m arn                   = (known after apply)
      [32m+[0m[0m cidr_blocks           = (known after apply)
      [32m+[0m[0m dns_entry             = (known after apply)
      [32m+[0m[0m id                    = (known after apply)
      [32m+[0m[0m ip_address_type       = (known after apply)
      [32m+[0m[0m network_interface_ids = (known after apply)
      [32m+[0m[0m owner_id              = (known after apply)
      [32m+[0m[0m policy                = (known after apply)
      [32m+[0m[0m prefix_list_id        = (known after apply)
      [32m+[0m[0m private_dns_enabled   = true
      [32m+[0m[0m region                = "sa-east-1"
      [32m+[0m[0m requester_managed     = (known after apply)
      [32m+[0m[0m route_table_ids       = (known after apply)
      [32m+[0m[0m security_group_ids    = (known after apply)
      [32m+[0m[0m service_name          = "com.amazonaws.sa-east-1.kms"
      [32m+[0m[0m service_region        = (known after apply)
      [32m+[0m[0m state                 = (known after apply)
      [32m+[0m[0m subnet_ids            = (known after apply)
      [32m+[0m[0m tags                  = {
          [32m+[0m[0m "Name" = "peterock-vpce-kms"
        }
      [32m+[0m[0m tags_all              = {
          [32m+[0m[0m "Name" = "peterock-vpce-kms"
        }
      [32m+[0m[0m vpc_endpoint_type     = "Interface"
      [32m+[0m[0m vpc_id                = (known after apply)

      [32m+[0m[0m dns_options (known after apply)

      [32m+[0m[0m subnet_configuration (known after apply)
    }

[1m  # aws_vpc_endpoint.chewbacca_vpce_services["s3"][0m will be created
[0m  [32m+[0m[0m resource "aws_vpc_endpoint" "chewbacca_vpce_services" {
      [32m+[0m[0m arn                   = (known after apply)
      [32m+[0m[0m cidr_blocks           = (known after apply)
      [32m+[0m[0m dns_entry             = (known after apply)
      [32m+[0m[0m id                    = (known after apply)
      [32m+[0m[0m ip_address_type       = (known after apply)
      [32m+[0m[0m network_interface_ids = (known after apply)
      [32m+[0m[0m owner_id              = (known after apply)
      [32m+[0m[0m policy                = (known after apply)
      [32m+[0m[0m prefix_list_id        = (known after apply)
      [32m+[0m[0m private_dns_enabled   = false
      [32m+[0m[0m region                = "sa-east-1"
      [32m+[0m[0m requester_managed     = (known after apply)
      [32m+[0m[0m route_table_ids       = (known after apply)
      [32m+[0m[0m security_group_ids    = (known after apply)
      [32m+[0m[0m service_name          = "com.amazonaws.sa-east-1.s3"
      [32m+[0m[0m service_region        = (known after apply)
      [32m+[0m[0m state                 = (known after apply)
      [32m+[0m[0m subnet_ids            = (known after apply)
      [32m+[0m[0m tags                  = {
          [32m+[0m[0m "Name" = "peterock-vpce-s3"
        }
      [32m+[0m[0m tags_all              = {
          [32m+[0m[0m "Name" = "peterock-vpce-s3"
        }
      [32m+[0m[0m vpc_endpoint_type     = "Gateway"
      [32m+[0m[0m vpc_id                = (known after apply)

      [32m+[0m[0m dns_options (known after apply)

      [32m+[0m[0m subnet_configuration (known after apply)
    }

[1m  # aws_vpc_security_group_egress_rule.alb_outbound[0m will be created
[0m  [32m+[0m[0m resource "aws_vpc_security_group_egress_rule" "alb_outbound" {
      [32m+[0m[0m arn                    = (known after apply)
      [32m+[0m[0m cidr_ipv4              = "0.0.0.0/0"
      [32m+[0m[0m description            = "Allow all outbound traffic"
      [32m+[0m[0m id                     = (known after apply)
      [32m+[0m[0m ip_protocol            = "-1"
      [32m+[0m[0m region                 = "sa-east-1"
      [32m+[0m[0m security_group_id      = (known after apply)
      [32m+[0m[0m security_group_rule_id = (known after apply)
      [32m+[0m[0m tags_all               = {}
    }

[1m  # aws_vpc_security_group_ingress_rule.http[0m will be created
[0m  [32m+[0m[0m resource "aws_vpc_security_group_ingress_rule" "http" {
      [32m+[0m[0m arn                    = (known after apply)
      [32m+[0m[0m cidr_ipv4              = "0.0.0.0/0"
      [32m+[0m[0m description            = "Allow HTTP from any IP"
      [32m+[0m[0m from_port              = 80
      [32m+[0m[0m id                     = (known after apply)
      [32m+[0m[0m ip_protocol            = "tcp"
      [32m+[0m[0m region                 = "sa-east-1"
      [32m+[0m[0m security_group_id      = (known after apply)
      [32m+[0m[0m security_group_rule_id = (known after apply)
      [32m+[0m[0m tags_all               = {}
      [32m+[0m[0m to_port                = 80
    }

[1m  # aws_vpc_security_group_ingress_rule.https[0m will be created
[0m  [32m+[0m[0m resource "aws_vpc_security_group_ingress_rule" "https" {
      [32m+[0m[0m arn                    = (known after apply)
      [32m+[0m[0m cidr_ipv4              = "0.0.0.0/0"
      [32m+[0m[0m description            = "Allow HTTPS from any IP"
      [32m+[0m[0m from_port              = 443
      [32m+[0m[0m id                     = (known after apply)
      [32m+[0m[0m ip_protocol            = "tcp"
      [32m+[0m[0m region                 = "sa-east-1"
      [32m+[0m[0m security_group_id      = (known after apply)
      [32m+[0m[0m security_group_rule_id = (known after apply)
      [32m+[0m[0m tags_all               = {}
      [32m+[0m[0m to_port                = 443
    }

[1m  # module.lab1-ab.aws_cloudwatch_log_group.chewbacca_log_group01[0m will be created
[0m  [32m+[0m[0m resource "aws_cloudwatch_log_group" "chewbacca_log_group01" {
      [32m+[0m[0m arn                         = (known after apply)
      [32m+[0m[0m deletion_protection_enabled = (known after apply)
      [32m+[0m[0m id                          = (known after apply)
      [32m+[0m[0m log_group_class             = (known after apply)
      [32m+[0m[0m name                        = "/aws/ec2/peterock-rds-app"
      [32m+[0m[0m name_prefix                 = (known after apply)
      [32m+[0m[0m region                      = "sa-east-1"
      [32m+[0m[0m retention_in_days           = 7
      [32m+[0m[0m skip_destroy                = false
      [32m+[0m[0m tags                        = {
          [32m+[0m[0m "Name" = "peterock-log-group01"
        }
      [32m+[0m[0m tags_all                    = {
          [32m+[0m[0m "Name" = "peterock-log-group01"
        }
    }

[1m  # module.lab1-ab.aws_cloudwatch_metric_alarm.chewbacca_db_alarm01[0m will be created
[0m  [32m+[0m[0m resource "aws_cloudwatch_metric_alarm" "chewbacca_db_alarm01" {
      [32m+[0m[0m actions_enabled                       = true
      [32m+[0m[0m alarm_actions                         = (known after apply)
      [32m+[0m[0m alarm_name                            = "peterock-db-connection-failure"
      [32m+[0m[0m arn                                   = (known after apply)
      [32m+[0m[0m comparison_operator                   = "GreaterThanOrEqualToThreshold"
      [32m+[0m[0m evaluate_low_sample_count_percentiles = (known after apply)
      [32m+[0m[0m evaluation_periods                    = 1
      [32m+[0m[0m id                                    = (known after apply)
      [32m+[0m[0m metric_name                           = "DBConnectionErrors"
      [32m+[0m[0m namespace                             = "Lab/RDSApp"
      [32m+[0m[0m period                                = 300
      [32m+[0m[0m region                                = "sa-east-1"
      [32m+[0m[0m statistic                             = "Sum"
      [32m+[0m[0m tags                                  = {
          [32m+[0m[0m "Name" = "peterock-alarm-db-fail"
        }
      [32m+[0m[0m tags_all                              = {
          [32m+[0m[0m "Name" = "peterock-alarm-db-fail"
        }
      [32m+[0m[0m threshold                             = 3
      [32m+[0m[0m treat_missing_data                    = "missing"
    }

[1m  # module.lab1-ab.aws_db_instance.chewbacca_rds01[0m will be created
[0m  [32m+[0m[0m resource "aws_db_instance" "chewbacca_rds01" {
      [32m+[0m[0m address                               = (known after apply)
      [32m+[0m[0m allocated_storage                     = 20
      [32m+[0m[0m apply_immediately                     = false
      [32m+[0m[0m arn                                   = (known after apply)
      [32m+[0m[0m auto_minor_version_upgrade            = true
      [32m+[0m[0m availability_zone                     = (known after apply)
      [32m+[0m[0m backup_retention_period               = (known after apply)
      [32m+[0m[0m backup_target                         = (known after apply)
      [32m+[0m[0m backup_window                         = (known after apply)
      [32m+[0m[0m ca_cert_identifier                    = (known after apply)
      [32m+[0m[0m character_set_name                    = (known after apply)
      [32m+[0m[0m copy_tags_to_snapshot                 = false
      [32m+[0m[0m database_insights_mode                = (known after apply)
      [32m+[0m[0m db_name                               = "labdb"
      [32m+[0m[0m db_subnet_group_name                  = "peterock-rds-subnet-group01"
      [32m+[0m[0m dedicated_log_volume                  = false
      [32m+[0m[0m delete_automated_backups              = true
      [32m+[0m[0m domain_fqdn                           = (known after apply)
      [32m+[0m[0m endpoint                              = (known after apply)
      [32m+[0m[0m engine                                = "mysql"
      [32m+[0m[0m engine_lifecycle_support              = (known after apply)
      [32m+[0m[0m engine_version                        = (known after apply)
      [32m+[0m[0m engine_version_actual                 = (known after apply)
      [32m+[0m[0m hosted_zone_id                        = (known after apply)
      [32m+[0m[0m id                                    = (known after apply)
      [32m+[0m[0m identifier                            = "peterock-rds01"
      [32m+[0m[0m identifier_prefix                     = (known after apply)
      [32m+[0m[0m instance_class                        = "db.t3.micro"
      [32m+[0m[0m iops                                  = (known after apply)
      [32m+[0m[0m kms_key_id                            = (known after apply)
      [32m+[0m[0m latest_restorable_time                = (known after apply)
      [32m+[0m[0m license_model                         = (known after apply)
      [32m+[0m[0m listener_endpoint                     = (known after apply)
      [32m+[0m[0m maintenance_window                    = (known after apply)
      [32m+[0m[0m master_user_secret                    = (known after apply)
      [32m+[0m[0m master_user_secret_kms_key_id         = (known after apply)
      [32m+[0m[0m monitoring_interval                   = 0
      [32m+[0m[0m monitoring_role_arn                   = (known after apply)
      [32m+[0m[0m multi_az                              = true
      [32m+[0m[0m nchar_character_set_name              = (known after apply)
      [32m+[0m[0m network_type                          = (known after apply)
      [32m+[0m[0m option_group_name                     = (known after apply)
      [32m+[0m[0m parameter_group_name                  = (known after apply)
      [32m+[0m[0m password                              = (sensitive value)
      [32m+[0m[0m password_wo                           = (write-only attribute)
      [32m+[0m[0m performance_insights_enabled          = false
      [32m+[0m[0m performance_insights_kms_key_id       = (known after apply)
      [32m+[0m[0m performance_insights_retention_period = (known after apply)
      [32m+[0m[0m port                                  = (known after apply)
      [32m+[0m[0m publicly_accessible                   = false
      [32m+[0m[0m region                                = "sa-east-1"
      [32m+[0m[0m replica_mode                          = (known after apply)
      [32m+[0m[0m replicas                              = (known after apply)
      [32m+[0m[0m resource_id                           = (known after apply)
      [32m+[0m[0m skip_final_snapshot                   = true
      [32m+[0m[0m snapshot_identifier                   = (known after apply)
      [32m+[0m[0m status                                = (known after apply)
      [32m+[0m[0m storage_throughput                    = (known after apply)
      [32m+[0m[0m storage_type                          = (known after apply)
      [32m+[0m[0m tags                                  = {
          [32m+[0m[0m "Name" = "peterock-rds01"
        }
      [32m+[0m[0m tags_all                              = {
          [32m+[0m[0m "Name" = "peterock-rds01"
        }
      [32m+[0m[0m timezone                              = (known after apply)
      [32m+[0m[0m upgrade_rollout_order                 = (known after apply)
      [32m+[0m[0m username                              = "admin"
      [32m+[0m[0m vpc_security_group_ids                = (known after apply)
    }

[1m  # module.lab1-ab.aws_db_subnet_group.chewbacca_rds_subnet_group01[0m will be created
[0m  [32m+[0m[0m resource "aws_db_subnet_group" "chewbacca_rds_subnet_group01" {
      [32m+[0m[0m arn                     = (known after apply)
      [32m+[0m[0m description             = "Managed by Terraform"
      [32m+[0m[0m id                      = (known after apply)
      [32m+[0m[0m name                    = "peterock-rds-subnet-group01"
      [32m+[0m[0m name_prefix             = (known after apply)
      [32m+[0m[0m region                  = "sa-east-1"
      [32m+[0m[0m subnet_ids              = (known after apply)
      [32m+[0m[0m supported_network_types = (known after apply)
      [32m+[0m[0m tags                    = {
          [32m+[0m[0m "Name" = "peterock-rds-subnet-group01"
        }
      [32m+[0m[0m tags_all                = {
          [32m+[0m[0m "Name" = "peterock-rds-subnet-group01"
        }
      [32m+[0m[0m vpc_id                  = (known after apply)
    }

[1m  # module.lab1-ab.aws_iam_instance_profile.chewbacca_instance_profile01[0m will be created
[0m  [32m+[0m[0m resource "aws_iam_instance_profile" "chewbacca_instance_profile01" {
      [32m+[0m[0m arn         = (known after apply)
      [32m+[0m[0m create_date = (known after apply)
      [32m+[0m[0m id          = (known after apply)
      [32m+[0m[0m name        = "peterock-instance-profile01"
      [32m+[0m[0m name_prefix = (known after apply)
      [32m+[0m[0m path        = "/"
      [32m+[0m[0m role        = "peterock-ec2-role01"
      [32m+[0m[0m tags_all    = (known after apply)
      [32m+[0m[0m unique_id   = (known after apply)
    }

[1m  # module.lab1-ab.aws_iam_policy.chewbacca_ec2_read_secret01[0m will be created
[0m  [32m+[0m[0m resource "aws_iam_policy" "chewbacca_ec2_read_secret01" {
      [32m+[0m[0m arn              = (known after apply)
      [32m+[0m[0m attachment_count = (known after apply)
      [32m+[0m[0m description      = "Least-privilege read for the lab DB secret"
      [32m+[0m[0m id               = (known after apply)
      [32m+[0m[0m name             = "peterock-ec2-secrets-read01"
      [32m+[0m[0m name_prefix      = (known after apply)
      [32m+[0m[0m path             = "/"
      [32m+[0m[0m policy           = jsonencode(
            {
              [32m+[0m[0m Statement = [
                  [32m+[0m[0m {
                      [32m+[0m[0m Action   = [
                          [32m+[0m[0m "secretsmanager:GetSecretValue",
                          [32m+[0m[0m "secretsmanager:DescribeSecret",
                        ]
                      [32m+[0m[0m Effect   = "Allow"
                      [32m+[0m[0m Resource = "arn:aws:secretsmanager:sa-east-1:630400242534:secret:peterock/rds/mysql*"
                      [32m+[0m[0m Sid      = "ReadSpecificSecret"
                    },
                ]
              [32m+[0m[0m Version   = "2012-10-17"
            }
        )
      [32m+[0m[0m policy_id        = (known after apply)
      [32m+[0m[0m tags_all         = (known after apply)
    }

[1m  # module.lab1-ab.aws_iam_role.chewbacca_ec2_role01[0m will be created
[0m  [32m+[0m[0m resource "aws_iam_role" "chewbacca_ec2_role01" {
      [32m+[0m[0m arn                   = (known after apply)
      [32m+[0m[0m assume_role_policy    = jsonencode(
            {
              [32m+[0m[0m Statement = [
                  [32m+[0m[0m {
                      [32m+[0m[0m Action    = [
                          [32m+[0m[0m "sts:AssumeRole",
                        ]
                      [32m+[0m[0m Effect    = "Allow"
                      [32m+[0m[0m Principal = {
                          [32m+[0m[0m Service = "ec2.amazonaws.com"
                        }
                      [32m+[0m[0m Sid       = "EC2AssumeRole"
                    },
                ]
              [32m+[0m[0m Version   = "2012-10-17"
            }
        )
      [32m+[0m[0m create_date           = (known after apply)
      [32m+[0m[0m force_detach_policies = false
      [32m+[0m[0m id                    = (known after apply)
      [32m+[0m[0m managed_policy_arns   = (known after apply)
      [32m+[0m[0m max_session_duration  = 3600
      [32m+[0m[0m name                  = "peterock-ec2-role01"
      [32m+[0m[0m name_prefix           = (known after apply)
      [32m+[0m[0m path                  = "/"
      [32m+[0m[0m tags                  = {
          [32m+[0m[0m "Name" = "peterock-ec2-iam-role"
        }
      [32m+[0m[0m tags_all              = {
          [32m+[0m[0m "Name" = "peterock-ec2-iam-role"
        }
      [32m+[0m[0m unique_id             = (known after apply)

      [32m+[0m[0m inline_policy (known after apply)
    }

[1m  # module.lab1-ab.aws_iam_role_policy_attachment.chewbacca_attach_lp_secret01[0m will be created
[0m  [32m+[0m[0m resource "aws_iam_role_policy_attachment" "chewbacca_attach_lp_secret01" {
      [32m+[0m[0m id         = (known after apply)
      [32m+[0m[0m policy_arn = (known after apply)
      [32m+[0m[0m role       = "peterock-ec2-role01"
    }

[1m  # module.lab1-ab.aws_iam_role_policy_attachment.chewbacca_ec2_cw_attach[0m will be created
[0m  [32m+[0m[0m resource "aws_iam_role_policy_attachment" "chewbacca_ec2_cw_attach" {
      [32m+[0m[0m id         = (known after apply)
      [32m+[0m[0m policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
      [32m+[0m[0m role       = "peterock-ec2-role01"
    }

[1m  # module.lab1-ab.aws_iam_role_policy_attachment.chewbacca_ec2_secrets_attach[0m will be created
[0m  [32m+[0m[0m resource "aws_iam_role_policy_attachment" "chewbacca_ec2_secrets_attach" {
      [32m+[0m[0m id         = (known after apply)
      [32m+[0m[0m policy_arn = "arn:aws:iam::aws:policy/AWSSecretsManagerClientReadOnlyAccess"
      [32m+[0m[0m role       = "peterock-ec2-role01"
    }

[1m  # module.lab1-ab.aws_iam_role_policy_attachment.chewbacca_ec2_ssm_attach[0m will be created
[0m  [32m+[0m[0m resource "aws_iam_role_policy_attachment" "chewbacca_ec2_ssm_attach" {
      [32m+[0m[0m id         = (known after apply)
      [32m+[0m[0m policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
      [32m+[0m[0m role       = "peterock-ec2-role01"
    }

[1m  # module.lab1-ab.aws_instance.chewbacca_ec201[0m will be created
[0m  [32m+[0m[0m resource "aws_instance" "chewbacca_ec201" {
      [32m+[0m[0m ami                                  = "ami-0b11764ef057ab4b7"
      [32m+[0m[0m arn                                  = (known after apply)
      [32m+[0m[0m associate_public_ip_address          = (known after apply)
      [32m+[0m[0m availability_zone                    = (known after apply)
      [32m+[0m[0m disable_api_stop                     = (known after apply)
      [32m+[0m[0m disable_api_termination              = (known after apply)
      [32m+[0m[0m ebs_optimized                        = (known after apply)
      [32m+[0m[0m enable_primary_ipv6                  = (known after apply)
      [32m+[0m[0m force_destroy                        = false
      [32m+[0m[0m get_password_data                    = false
      [32m+[0m[0m host_id                              = (known after apply)
      [32m+[0m[0m host_resource_group_arn              = (known after apply)
      [32m+[0m[0m iam_instance_profile                 = "peterock-instance-profile01"
      [32m+[0m[0m id                                   = (known after apply)
      [32m+[0m[0m instance_initiated_shutdown_behavior = (known after apply)
      [32m+[0m[0m instance_lifecycle                   = (known after apply)
      [32m+[0m[0m instance_state                       = (known after apply)
      [32m+[0m[0m instance_type                        = "t3.micro"
      [32m+[0m[0m ipv6_address_count                   = (known after apply)
      [32m+[0m[0m ipv6_addresses                       = (known after apply)
      [32m+[0m[0m key_name                             = "ec2_key_pair"
      [32m+[0m[0m monitoring                           = (known after apply)
      [32m+[0m[0m outpost_arn                          = (known after apply)
      [32m+[0m[0m password_data                        = (known after apply)
      [32m+[0m[0m placement_group                      = (known after apply)
      [32m+[0m[0m placement_group_id                   = (known after apply)
      [32m+[0m[0m placement_partition_number           = (known after apply)
      [32m+[0m[0m primary_network_interface_id         = (known after apply)
      [32m+[0m[0m private_dns                          = (known after apply)
      [32m+[0m[0m private_ip                           = (known after apply)
      [32m+[0m[0m public_dns                           = (known after apply)
      [32m+[0m[0m public_ip                            = (known after apply)
      [32m+[0m[0m region                               = "sa-east-1"
      [32m+[0m[0m secondary_private_ips                = (known after apply)
      [32m+[0m[0m security_groups                      = (known after apply)
      [32m+[0m[0m source_dest_check                    = true
      [32m+[0m[0m spot_instance_request_id             = (known after apply)
      [32m+[0m[0m subnet_id                            = (known after apply)
      [32m+[0m[0m tags                                 = {
          [32m+[0m[0m "Name" = "peterock-ec201"
        }
      [32m+[0m[0m tags_all                             = {
          [32m+[0m[0m "Name" = "peterock-ec201"
        }
      [32m+[0m[0m tenancy                              = (known after apply)
      [32m+[0m[0m user_data                            = <<-EOT
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
      [32m+[0m[0m user_data_base64                     = (known after apply)
      [32m+[0m[0m user_data_replace_on_change          = false
      [32m+[0m[0m vpc_security_group_ids               = (known after apply)

      [32m+[0m[0m capacity_reservation_specification (known after apply)

      [32m+[0m[0m cpu_options (known after apply)

      [32m+[0m[0m ebs_block_device (known after apply)

      [32m+[0m[0m enclave_options (known after apply)

      [32m+[0m[0m ephemeral_block_device (known after apply)

      [32m+[0m[0m instance_market_options (known after apply)

      [32m+[0m[0m maintenance_options (known after apply)

      [32m+[0m[0m metadata_options (known after apply)

      [32m+[0m[0m network_interface (known after apply)

      [32m+[0m[0m primary_network_interface (known after apply)

      [32m+[0m[0m private_dns_name_options (known after apply)

      [32m+[0m[0m root_block_device (known after apply)
    }

[1m  # module.lab1-ab.aws_internet_gateway.chewbacca_igw01[0m will be created
[0m  [32m+[0m[0m resource "aws_internet_gateway" "chewbacca_igw01" {
      [32m+[0m[0m arn      = (known after apply)
      [32m+[0m[0m id       = (known after apply)
      [32m+[0m[0m owner_id = (known after apply)
      [32m+[0m[0m region   = "sa-east-1"
      [32m+[0m[0m tags     = {
          [32m+[0m[0m "Name" = "peterock-igw01"
        }
      [32m+[0m[0m tags_all = {
          [32m+[0m[0m "Name" = "peterock-igw01"
        }
      [32m+[0m[0m vpc_id   = (known after apply)
    }

[1m  # module.lab1-ab.aws_key_pair.ec2_key_pair[0m will be created
[0m  [32m+[0m[0m resource "aws_key_pair" "ec2_key_pair" {
      [32m+[0m[0m arn             = (known after apply)
      [32m+[0m[0m fingerprint     = (known after apply)
      [32m+[0m[0m id              = (known after apply)
      [32m+[0m[0m key_name        = "ec2_key_pair"
      [32m+[0m[0m key_name_prefix = (known after apply)
      [32m+[0m[0m key_pair_id     = (known after apply)
      [32m+[0m[0m key_type        = (known after apply)
      [32m+[0m[0m public_key      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCnxKbA3Du42MJ6xu8XvfyFfI50Gi6HGqRAgyqwlU1DVNBvZUtBmZokhwNAKwSLfi/m5cGQPAIbDLo2RO2DLfIq5FDy7wv0+T0ZKNSCWt+DSsdgjculg1V6bd1LQQc9+j9j4DeJYC3gHFwg8g4B1YWSaGD25oPye5GiuhEcGVSdMFHyDPEOz0POkgBIVRiQvbKL8PtrgVD/a0B3JjO7zl4u3RAZUJjvkMJTmE+r8j7uii6YKipRL7HafoGajvg1vpvchSNFp51CGT0YBUqkjSmDN7OG0WnbSWrQkgFopNcWJi3tO8exVFmPhdzb8DNcseX6NxxBo7G+7X4CM+3LdXbIMMabRVxjQCvoW64Cg+hLUGAStsSTPtKwa4ipB4xMt4lI+KGjyPmJ4KrKtcpEHAUDdE7d33p8noZCRC7SqsLKm4xkE/68c9aTYlIh6eHBbKryuewoX/FC0RyusI7/tm9TMHy6AHASzxEIwrR8KB9AA0Ckz/bxdWfIghagEAKKT1lziVDg7suxOjRfVzV1PhTcbloLHZrnZKU1Zil/IeoeXlZqqgYxViZZWNMis2AlBYjvu8eQ9puwnSFbnwo7TFuDpIOocZ908laqpjvbcAMIFgUJ6qtpZ42Qpmus0xVoJO/vSzxLY8y55vXfG6qZJXJsd6NJIMgGhTBXRGlcbi6+MQ== peter@DESKTOP-6CQK9QU"
      [32m+[0m[0m region          = "sa-east-1"
      [32m+[0m[0m tags_all        = (known after apply)
    }

[1m  # module.lab1-ab.aws_route.chewbacca_public_default_route[0m will be created
[0m  [32m+[0m[0m resource "aws_route" "chewbacca_public_default_route" {
      [32m+[0m[0m destination_cidr_block = "0.0.0.0/0"
      [32m+[0m[0m gateway_id             = (known after apply)
      [32m+[0m[0m id                     = (known after apply)
      [32m+[0m[0m instance_id            = (known after apply)
      [32m+[0m[0m instance_owner_id      = (known after apply)
      [32m+[0m[0m network_interface_id   = (known after apply)
      [32m+[0m[0m origin                 = (known after apply)
      [32m+[0m[0m region                 = "sa-east-1"
      [32m+[0m[0m route_table_id         = (known after apply)
      [32m+[0m[0m state                  = (known after apply)
    }

[1m  # module.lab1-ab.aws_route_table.chewbacca_private_rt01[0m will be created
[0m  [32m+[0m[0m resource "aws_route_table" "chewbacca_private_rt01" {
      [32m+[0m[0m arn              = (known after apply)
      [32m+[0m[0m id               = (known after apply)
      [32m+[0m[0m owner_id         = (known after apply)
      [32m+[0m[0m propagating_vgws = (known after apply)
      [32m+[0m[0m region           = "sa-east-1"
      [32m+[0m[0m route            = (known after apply)
      [32m+[0m[0m tags             = {
          [32m+[0m[0m "Name" = "peterock-private-rt01"
        }
      [32m+[0m[0m tags_all         = {
          [32m+[0m[0m "Name" = "peterock-private-rt01"
        }
      [32m+[0m[0m vpc_id           = (known after apply)
    }

[1m  # module.lab1-ab.aws_route_table.chewbacca_public_rt01[0m will be created
[0m  [32m+[0m[0m resource "aws_route_table" "chewbacca_public_rt01" {
      [32m+[0m[0m arn              = (known after apply)
      [32m+[0m[0m id               = (known after apply)
      [32m+[0m[0m owner_id         = (known after apply)
      [32m+[0m[0m propagating_vgws = (known after apply)
      [32m+[0m[0m region           = "sa-east-1"
      [32m+[0m[0m route            = (known after apply)
      [32m+[0m[0m tags             = {
          [32m+[0m[0m "Name" = "peterock-public-rt01"
        }
      [32m+[0m[0m tags_all         = {
          [32m+[0m[0m "Name" = "peterock-public-rt01"
        }
      [32m+[0m[0m vpc_id           = (known after apply)
    }

[1m  # module.lab1-ab.aws_route_table_association.chewbacca_private_rta[0][0m will be created
[0m  [32m+[0m[0m resource "aws_route_table_association" "chewbacca_private_rta" {
      [32m+[0m[0m id             = (known after apply)
      [32m+[0m[0m region         = "sa-east-1"
      [32m+[0m[0m route_table_id = (known after apply)
      [32m+[0m[0m subnet_id      = (known after apply)
    }

[1m  # module.lab1-ab.aws_route_table_association.chewbacca_private_rta[1][0m will be created
[0m  [32m+[0m[0m resource "aws_route_table_association" "chewbacca_private_rta" {
      [32m+[0m[0m id             = (known after apply)
      [32m+[0m[0m region         = "sa-east-1"
      [32m+[0m[0m route_table_id = (known after apply)
      [32m+[0m[0m subnet_id      = (known after apply)
    }

[1m  # module.lab1-ab.aws_route_table_association.chewbacca_public_rta[0][0m will be created
[0m  [32m+[0m[0m resource "aws_route_table_association" "chewbacca_public_rta" {
      [32m+[0m[0m id             = (known after apply)
      [32m+[0m[0m region         = "sa-east-1"
      [32m+[0m[0m route_table_id = (known after apply)
      [32m+[0m[0m subnet_id      = (known after apply)
    }

[1m  # module.lab1-ab.aws_route_table_association.chewbacca_public_rta[1][0m will be created
[0m  [32m+[0m[0m resource "aws_route_table_association" "chewbacca_public_rta" {
      [32m+[0m[0m id             = (known after apply)
      [32m+[0m[0m region         = "sa-east-1"
      [32m+[0m[0m route_table_id = (known after apply)
      [32m+[0m[0m subnet_id      = (known after apply)
    }

[1m  # module.lab1-ab.aws_secretsmanager_secret.chewbacca_db_secret01[0m will be created
[0m  [32m+[0m[0m resource "aws_secretsmanager_secret" "chewbacca_db_secret01" {
      [32m+[0m[0m arn                            = (known after apply)
      [32m+[0m[0m force_overwrite_replica_secret = false
      [32m+[0m[0m id                             = (known after apply)
      [32m+[0m[0m name                           = "peterock/rds/mysql"
      [32m+[0m[0m name_prefix                    = (known after apply)
      [32m+[0m[0m policy                         = (known after apply)
      [32m+[0m[0m recovery_window_in_days        = 0
      [32m+[0m[0m region                         = "sa-east-1"
      [32m+[0m[0m tags_all                       = (known after apply)

      [32m+[0m[0m replica (known after apply)
    }

[1m  # module.lab1-ab.aws_secretsmanager_secret_version.chewbacca_db_secret_version01[0m will be created
[0m  [32m+[0m[0m resource "aws_secretsmanager_secret_version" "chewbacca_db_secret_version01" {
      [32m+[0m[0m arn                  = (known after apply)
      [32m+[0m[0m has_secret_string_wo = (known after apply)
      [32m+[0m[0m id                   = (known after apply)
      [32m+[0m[0m region               = "sa-east-1"
      [32m+[0m[0m secret_id            = (known after apply)
      [32m+[0m[0m secret_string        = (sensitive value)
      [32m+[0m[0m secret_string_wo     = (write-only attribute)
      [32m+[0m[0m version_id           = (known after apply)
      [32m+[0m[0m version_stages       = (known after apply)
    }

[1m  # module.lab1-ab.aws_security_group.chewbacca_ec2_sg01[0m will be created
[0m  [32m+[0m[0m resource "aws_security_group" "chewbacca_ec2_sg01" {
      [32m+[0m[0m arn                    = (known after apply)
      [32m+[0m[0m description            = "EC2 app security group"
      [32m+[0m[0m egress                 = (known after apply)
      [32m+[0m[0m id                     = (known after apply)
      [32m+[0m[0m ingress                = (known after apply)
      [32m+[0m[0m name                   = "peterock-ec2-sg01"
      [32m+[0m[0m name_prefix            = (known after apply)
      [32m+[0m[0m owner_id               = (known after apply)
      [32m+[0m[0m region                 = "sa-east-1"
      [32m+[0m[0m revoke_rules_on_delete = false
      [32m+[0m[0m tags                   = {
          [32m+[0m[0m "Name" = "peterock-ec2-sg01"
        }
      [32m+[0m[0m tags_all               = {
          [32m+[0m[0m "Name" = "peterock-ec2-sg01"
        }
      [32m+[0m[0m vpc_id                 = (known after apply)
    }

[1m  # module.lab1-ab.aws_security_group.chewbacca_rds_sg01[0m will be created
[0m  [32m+[0m[0m resource "aws_security_group" "chewbacca_rds_sg01" {
      [32m+[0m[0m arn                    = (known after apply)
      [32m+[0m[0m description            = "RDS security group"
      [32m+[0m[0m egress                 = (known after apply)
      [32m+[0m[0m id                     = (known after apply)
      [32m+[0m[0m ingress                = (known after apply)
      [32m+[0m[0m name                   = "peterock-rds-sg01"
      [32m+[0m[0m name_prefix            = (known after apply)
      [32m+[0m[0m owner_id               = (known after apply)
      [32m+[0m[0m region                 = "sa-east-1"
      [32m+[0m[0m revoke_rules_on_delete = false
      [32m+[0m[0m tags                   = {
          [32m+[0m[0m "Name" = "peterock-rds-sg01"
        }
      [32m+[0m[0m tags_all               = {
          [32m+[0m[0m "Name" = "peterock-rds-sg01"
        }
      [32m+[0m[0m vpc_id                 = (known after apply)
    }

[1m  # module.lab1-ab.aws_security_group.chewbacca_vpce_sg01[0m will be created
[0m  [32m+[0m[0m resource "aws_security_group" "chewbacca_vpce_sg01" {
      [32m+[0m[0m arn                    = (known after apply)
      [32m+[0m[0m description            = "VPC Endpoint security group"
      [32m+[0m[0m egress                 = (known after apply)
      [32m+[0m[0m id                     = (known after apply)
      [32m+[0m[0m ingress                = (known after apply)
      [32m+[0m[0m name                   = "peterock-vpce-sg01"
      [32m+[0m[0m name_prefix            = (known after apply)
      [32m+[0m[0m owner_id               = (known after apply)
      [32m+[0m[0m region                 = "sa-east-1"
      [32m+[0m[0m revoke_rules_on_delete = false
      [32m+[0m[0m tags                   = {
          [32m+[0m[0m "Name" = "peterock-vpce-sg01"
        }
      [32m+[0m[0m tags_all               = {
          [32m+[0m[0m "Name" = "peterock-vpce-sg01"
        }
      [32m+[0m[0m vpc_id                 = (known after apply)
    }

[1m  # module.lab1-ab.aws_sns_topic.chewbacca_sns_topic01[0m will be created
[0m  [32m+[0m[0m resource "aws_sns_topic" "chewbacca_sns_topic01" {
      [32m+[0m[0m arn                         = (known after apply)
      [32m+[0m[0m beginning_archive_time      = (known after apply)
      [32m+[0m[0m content_based_deduplication = false
      [32m+[0m[0m fifo_throughput_scope       = (known after apply)
      [32m+[0m[0m fifo_topic                  = false
      [32m+[0m[0m id                          = (known after apply)
      [32m+[0m[0m name                        = "peterock-db-incidents"
      [32m+[0m[0m name_prefix                 = (known after apply)
      [32m+[0m[0m owner                       = (known after apply)
      [32m+[0m[0m policy                      = (known after apply)
      [32m+[0m[0m region                      = "sa-east-1"
      [32m+[0m[0m signature_version           = (known after apply)
      [32m+[0m[0m tags_all                    = (known after apply)
      [32m+[0m[0m tracing_config              = (known after apply)
    }

[1m  # module.lab1-ab.aws_sns_topic_subscription.chewbacca_sns_sub01[0m will be created
[0m  [32m+[0m[0m resource "aws_sns_topic_subscription" "chewbacca_sns_sub01" {
      [32m+[0m[0m arn                             = (known after apply)
      [32m+[0m[0m confirmation_timeout_in_minutes = 1
      [32m+[0m[0m confirmation_was_authenticated  = (known after apply)
      [32m+[0m[0m endpoint                        = "chery.peter@gmail.com"
      [32m+[0m[0m endpoint_auto_confirms          = false
      [32m+[0m[0m filter_policy_scope             = (known after apply)
      [32m+[0m[0m id                              = (known after apply)
      [32m+[0m[0m owner_id                        = (known after apply)
      [32m+[0m[0m pending_confirmation            = (known after apply)
      [32m+[0m[0m protocol                        = "email"
      [32m+[0m[0m raw_message_delivery            = false
      [32m+[0m[0m region                          = "sa-east-1"
      [32m+[0m[0m topic_arn                       = (known after apply)
    }

[1m  # module.lab1-ab.aws_ssm_parameter.chewbacca_db_endpoint_param[0m will be created
[0m  [32m+[0m[0m resource "aws_ssm_parameter" "chewbacca_db_endpoint_param" {
      [32m+[0m[0m arn            = (known after apply)
      [32m+[0m[0m data_type      = (known after apply)
      [32m+[0m[0m has_value_wo   = (known after apply)
      [32m+[0m[0m id             = (known after apply)
      [32m+[0m[0m insecure_value = (known after apply)
      [32m+[0m[0m key_id         = (known after apply)
      [32m+[0m[0m name           = "/lab/db/endpoint"
      [32m+[0m[0m region         = "sa-east-1"
      [32m+[0m[0m tags           = {
          [32m+[0m[0m "Name" = "peterock-param-db-endpoint"
        }
      [32m+[0m[0m tags_all       = {
          [32m+[0m[0m "Name" = "peterock-param-db-endpoint"
        }
      [32m+[0m[0m tier           = (known after apply)
      [32m+[0m[0m type           = "String"
      [32m+[0m[0m value          = (sensitive value)
      [32m+[0m[0m value_wo       = (write-only attribute)
      [32m+[0m[0m version        = (known after apply)
    }

[1m  # module.lab1-ab.aws_ssm_parameter.chewbacca_db_name_param[0m will be created
[0m  [32m+[0m[0m resource "aws_ssm_parameter" "chewbacca_db_name_param" {
      [32m+[0m[0m arn            = (known after apply)
      [32m+[0m[0m data_type      = (known after apply)
      [32m+[0m[0m has_value_wo   = (known after apply)
      [32m+[0m[0m id             = (known after apply)
      [32m+[0m[0m insecure_value = (known after apply)
      [32m+[0m[0m key_id         = (known after apply)
      [32m+[0m[0m name           = "/lab/db/name"
      [32m+[0m[0m region         = "sa-east-1"
      [32m+[0m[0m tags           = {
          [32m+[0m[0m "Name" = "peterock-param-db-name"
        }
      [32m+[0m[0m tags_all       = {
          [32m+[0m[0m "Name" = "peterock-param-db-name"
        }
      [32m+[0m[0m tier           = (known after apply)
      [32m+[0m[0m type           = "String"
      [32m+[0m[0m value          = (sensitive value)
      [32m+[0m[0m value_wo       = (write-only attribute)
      [32m+[0m[0m version        = (known after apply)
    }

[1m  # module.lab1-ab.aws_ssm_parameter.chewbacca_db_port_param[0m will be created
[0m  [32m+[0m[0m resource "aws_ssm_parameter" "chewbacca_db_port_param" {
      [32m+[0m[0m arn            = (known after apply)
      [32m+[0m[0m data_type      = (known after apply)
      [32m+[0m[0m has_value_wo   = (known after apply)
      [32m+[0m[0m id             = (known after apply)
      [32m+[0m[0m insecure_value = (known after apply)
      [32m+[0m[0m key_id         = (known after apply)
      [32m+[0m[0m name           = "/lab/db/port"
      [32m+[0m[0m region         = "sa-east-1"
      [32m+[0m[0m tags           = {
          [32m+[0m[0m "Name" = "peterock-param-db-port"
        }
      [32m+[0m[0m tags_all       = {
          [32m+[0m[0m "Name" = "peterock-param-db-port"
        }
      [32m+[0m[0m tier           = (known after apply)
      [32m+[0m[0m type           = "String"
      [32m+[0m[0m value          = (sensitive value)
      [32m+[0m[0m value_wo       = (write-only attribute)
      [32m+[0m[0m version        = (known after apply)
    }

[1m  # module.lab1-ab.aws_subnet.chewbacca_private_subnets[0][0m will be created
[0m  [32m+[0m[0m resource "aws_subnet" "chewbacca_private_subnets" {
      [32m+[0m[0m arn                                            = (known after apply)
      [32m+[0m[0m assign_ipv6_address_on_creation                = false
      [32m+[0m[0m availability_zone                              = "sa-east-1a"
      [32m+[0m[0m availability_zone_id                           = (known after apply)
      [32m+[0m[0m cidr_block                                     = "10.98.101.0/24"
      [32m+[0m[0m enable_dns64                                   = false
      [32m+[0m[0m enable_resource_name_dns_a_record_on_launch    = false
      [32m+[0m[0m enable_resource_name_dns_aaaa_record_on_launch = false
      [32m+[0m[0m id                                             = (known after apply)
      [32m+[0m[0m ipv6_cidr_block_association_id                 = (known after apply)
      [32m+[0m[0m ipv6_native                                    = false
      [32m+[0m[0m map_public_ip_on_launch                        = false
      [32m+[0m[0m owner_id                                       = (known after apply)
      [32m+[0m[0m private_dns_hostname_type_on_launch            = (known after apply)
      [32m+[0m[0m region                                         = "sa-east-1"
      [32m+[0m[0m tags                                           = {
          [32m+[0m[0m "Name" = "peterock-private-subnet01"
        }
      [32m+[0m[0m tags_all                                       = {
          [32m+[0m[0m "Name" = "peterock-private-subnet01"
        }
      [32m+[0m[0m vpc_id                                         = (known after apply)
    }

[1m  # module.lab1-ab.aws_subnet.chewbacca_private_subnets[1][0m will be created
[0m  [32m+[0m[0m resource "aws_subnet" "chewbacca_private_subnets" {
      [32m+[0m[0m arn                                            = (known after apply)
      [32m+[0m[0m assign_ipv6_address_on_creation                = false
      [32m+[0m[0m availability_zone                              = "sa-east-1b"
      [32m+[0m[0m availability_zone_id                           = (known after apply)
      [32m+[0m[0m cidr_block                                     = "10.98.102.0/24"
      [32m+[0m[0m enable_dns64                                   = false
      [32m+[0m[0m enable_resource_name_dns_a_record_on_launch    = false
      [32m+[0m[0m enable_resource_name_dns_aaaa_record_on_launch = false
      [32m+[0m[0m id                                             = (known after apply)
      [32m+[0m[0m ipv6_cidr_block_association_id                 = (known after apply)
      [32m+[0m[0m ipv6_native                                    = false
      [32m+[0m[0m map_public_ip_on_launch                        = false
      [32m+[0m[0m owner_id                                       = (known after apply)
      [32m+[0m[0m private_dns_hostname_type_on_launch            = (known after apply)
      [32m+[0m[0m region                                         = "sa-east-1"
      [32m+[0m[0m tags                                           = {
          [32m+[0m[0m "Name" = "peterock-private-subnet02"
        }
      [32m+[0m[0m tags_all                                       = {
          [32m+[0m[0m "Name" = "peterock-private-subnet02"
        }
      [32m+[0m[0m vpc_id                                         = (known after apply)
    }

[1m  # module.lab1-ab.aws_subnet.chewbacca_public_subnets[0][0m will be created
[0m  [32m+[0m[0m resource "aws_subnet" "chewbacca_public_subnets" {
      [32m+[0m[0m arn                                            = (known after apply)
      [32m+[0m[0m assign_ipv6_address_on_creation                = false
      [32m+[0m[0m availability_zone                              = "sa-east-1a"
      [32m+[0m[0m availability_zone_id                           = (known after apply)
      [32m+[0m[0m cidr_block                                     = "10.98.1.0/24"
      [32m+[0m[0m enable_dns64                                   = false
      [32m+[0m[0m enable_resource_name_dns_a_record_on_launch    = false
      [32m+[0m[0m enable_resource_name_dns_aaaa_record_on_launch = false
      [32m+[0m[0m id                                             = (known after apply)
      [32m+[0m[0m ipv6_cidr_block_association_id                 = (known after apply)
      [32m+[0m[0m ipv6_native                                    = false
      [32m+[0m[0m map_public_ip_on_launch                        = true
      [32m+[0m[0m owner_id                                       = (known after apply)
      [32m+[0m[0m private_dns_hostname_type_on_launch            = (known after apply)
      [32m+[0m[0m region                                         = "sa-east-1"
      [32m+[0m[0m tags                                           = {
          [32m+[0m[0m "Name" = "peterock-public-subnet01"
        }
      [32m+[0m[0m tags_all                                       = {
          [32m+[0m[0m "Name" = "peterock-public-subnet01"
        }
      [32m+[0m[0m vpc_id                                         = (known after apply)
    }

[1m  # module.lab1-ab.aws_subnet.chewbacca_public_subnets[1][0m will be created
[0m  [32m+[0m[0m resource "aws_subnet" "chewbacca_public_subnets" {
      [32m+[0m[0m arn                                            = (known after apply)
      [32m+[0m[0m assign_ipv6_address_on_creation                = false
      [32m+[0m[0m availability_zone                              = "sa-east-1b"
      [32m+[0m[0m availability_zone_id                           = (known after apply)
      [32m+[0m[0m cidr_block                                     = "10.98.2.0/24"
      [32m+[0m[0m enable_dns64                                   = false
      [32m+[0m[0m enable_resource_name_dns_a_record_on_launch    = false
      [32m+[0m[0m enable_resource_name_dns_aaaa_record_on_launch = false
      [32m+[0m[0m id                                             = (known after apply)
      [32m+[0m[0m ipv6_cidr_block_association_id                 = (known after apply)
      [32m+[0m[0m ipv6_native                                    = false
      [32m+[0m[0m map_public_ip_on_launch                        = true
      [32m+[0m[0m owner_id                                       = (known after apply)
      [32m+[0m[0m private_dns_hostname_type_on_launch            = (known after apply)
      [32m+[0m[0m region                                         = "sa-east-1"
      [32m+[0m[0m tags                                           = {
          [32m+[0m[0m "Name" = "peterock-public-subnet02"
        }
      [32m+[0m[0m tags_all                                       = {
          [32m+[0m[0m "Name" = "peterock-public-subnet02"
        }
      [32m+[0m[0m vpc_id                                         = (known after apply)
    }

[1m  # module.lab1-ab.aws_vpc.chewbacca_vpc01[0m will be created
[0m  [32m+[0m[0m resource "aws_vpc" "chewbacca_vpc01" {
      [32m+[0m[0m arn                                  = (known after apply)
      [32m+[0m[0m cidr_block                           = "10.98.0.0/16"
      [32m+[0m[0m default_network_acl_id               = (known after apply)
      [32m+[0m[0m default_route_table_id               = (known after apply)
      [32m+[0m[0m default_security_group_id            = (known after apply)
      [32m+[0m[0m dhcp_options_id                      = (known after apply)
      [32m+[0m[0m enable_dns_hostnames                 = true
      [32m+[0m[0m enable_dns_support                   = true
      [32m+[0m[0m enable_network_address_usage_metrics = (known after apply)
      [32m+[0m[0m id                                   = (known after apply)
      [32m+[0m[0m instance_tenancy                     = "default"
      [32m+[0m[0m ipv6_association_id                  = (known after apply)
      [32m+[0m[0m ipv6_cidr_block                      = (known after apply)
      [32m+[0m[0m ipv6_cidr_block_network_border_group = (known after apply)
      [32m+[0m[0m main_route_table_id                  = (known after apply)
      [32m+[0m[0m owner_id                             = (known after apply)
      [32m+[0m[0m region                               = "sa-east-1"
      [32m+[0m[0m tags                                 = {
          [32m+[0m[0m "Name" = "peterock-vpc01"
        }
      [32m+[0m[0m tags_all                             = {
          [32m+[0m[0m "Name" = "peterock-vpc01"
        }
    }

[1m  # module.lab1-ab.aws_vpc_endpoint.chewbacca_vpce_services["ec2messages"][0m will be created
[0m  [32m+[0m[0m resource "aws_vpc_endpoint" "chewbacca_vpce_services" {
      [32m+[0m[0m arn                   = (known after apply)
      [32m+[0m[0m cidr_blocks           = (known after apply)
      [32m+[0m[0m dns_entry             = (known after apply)
      [32m+[0m[0m id                    = (known after apply)
      [32m+[0m[0m ip_address_type       = (known after apply)
      [32m+[0m[0m network_interface_ids = (known after apply)
      [32m+[0m[0m owner_id              = (known after apply)
      [32m+[0m[0m policy                = (known after apply)
      [32m+[0m[0m prefix_list_id        = (known after apply)
      [32m+[0m[0m private_dns_enabled   = true
      [32m+[0m[0m region                = "sa-east-1"
      [32m+[0m[0m requester_managed     = (known after apply)
      [32m+[0m[0m route_table_ids       = (known after apply)
      [32m+[0m[0m security_group_ids    = (known after apply)
      [32m+[0m[0m service_name          = "com.amazonaws.sa-east-1.ec2messages"
      [32m+[0m[0m service_region        = (known after apply)
      [32m+[0m[0m state                 = (known after apply)
      [32m+[0m[0m subnet_ids            = (known after apply)
      [32m+[0m[0m tags                  = {
          [32m+[0m[0m "Name" = "peterock-vpce-ec2messages"
        }
      [32m+[0m[0m tags_all              = {
          [32m+[0m[0m "Name" = "peterock-vpce-ec2messages"
        }
      [32m+[0m[0m vpc_endpoint_type     = "Interface"
      [32m+[0m[0m vpc_id                = (known after apply)

      [32m+[0m[0m dns_options (known after apply)

      [32m+[0m[0m subnet_configuration (known after apply)
    }

[1m  # module.lab1-ab.aws_vpc_endpoint.chewbacca_vpce_services["logs"][0m will be created
[0m  [32m+[0m[0m resource "aws_vpc_endpoint" "chewbacca_vpce_services" {
      [32m+[0m[0m arn                   = (known after apply)
      [32m+[0m[0m cidr_blocks           = (known after apply)
      [32m+[0m[0m dns_entry             = (known after apply)
      [32m+[0m[0m id                    = (known after apply)
      [32m+[0m[0m ip_address_type       = (known after apply)
      [32m+[0m[0m network_interface_ids = (known after apply)
      [32m+[0m[0m owner_id              = (known after apply)
      [32m+[0m[0m policy                = (known after apply)
      [32m+[0m[0m prefix_list_id        = (known after apply)
      [32m+[0m[0m private_dns_enabled   = true
      [32m+[0m[0m region                = "sa-east-1"
      [32m+[0m[0m requester_managed     = (known after apply)
      [32m+[0m[0m route_table_ids       = (known after apply)
      [32m+[0m[0m security_group_ids    = (known after apply)
      [32m+[0m[0m service_name          = "com.amazonaws.sa-east-1.logs"
      [32m+[0m[0m service_region        = (known after apply)
      [32m+[0m[0m state                 = (known after apply)
      [32m+[0m[0m subnet_ids            = (known after apply)
      [32m+[0m[0m tags                  = {
          [32m+[0m[0m "Name" = "peterock-vpce-logs"
        }
      [32m+[0m[0m tags_all              = {
          [32m+[0m[0m "Name" = "peterock-vpce-logs"
        }
      [32m+[0m[0m vpc_endpoint_type     = "Interface"
      [32m+[0m[0m vpc_id                = (known after apply)

      [32m+[0m[0m dns_options (known after apply)

      [32m+[0m[0m subnet_configuration (known after apply)
    }

[1m  # module.lab1-ab.aws_vpc_endpoint.chewbacca_vpce_services["secretsmanager"][0m will be created
[0m  [32m+[0m[0m resource "aws_vpc_endpoint" "chewbacca_vpce_services" {
      [32m+[0m[0m arn                   = (known after apply)
      [32m+[0m[0m cidr_blocks           = (known after apply)
      [32m+[0m[0m dns_entry             = (known after apply)
      [32m+[0m[0m id                    = (known after apply)
      [32m+[0m[0m ip_address_type       = (known after apply)
      [32m+[0m[0m network_interface_ids = (known after apply)
      [32m+[0m[0m owner_id              = (known after apply)
      [32m+[0m[0m policy                = (known after apply)
      [32m+[0m[0m prefix_list_id        = (known after apply)
      [32m+[0m[0m private_dns_enabled   = true
      [32m+[0m[0m region                = "sa-east-1"
      [32m+[0m[0m requester_managed     = (known after apply)
      [32m+[0m[0m route_table_ids       = (known after apply)
      [32m+[0m[0m security_group_ids    = (known after apply)
      [32m+[0m[0m service_name          = "com.amazonaws.sa-east-1.secretsmanager"
      [32m+[0m[0m service_region        = (known after apply)
      [32m+[0m[0m state                 = (known after apply)
      [32m+[0m[0m subnet_ids            = (known after apply)
      [32m+[0m[0m tags                  = {
          [32m+[0m[0m "Name" = "peterock-vpce-secretsmanager"
        }
      [32m+[0m[0m tags_all              = {
          [32m+[0m[0m "Name" = "peterock-vpce-secretsmanager"
        }
      [32m+[0m[0m vpc_endpoint_type     = "Interface"
      [32m+[0m[0m vpc_id                = (known after apply)

      [32m+[0m[0m dns_options (known after apply)

      [32m+[0m[0m subnet_configuration (known after apply)
    }

[1m  # module.lab1-ab.aws_vpc_endpoint.chewbacca_vpce_services["ssm"][0m will be created
[0m  [32m+[0m[0m resource "aws_vpc_endpoint" "chewbacca_vpce_services" {
      [32m+[0m[0m arn                   = (known after apply)
      [32m+[0m[0m cidr_blocks           = (known after apply)
      [32m+[0m[0m dns_entry             = (known after apply)
      [32m+[0m[0m id                    = (known after apply)
      [32m+[0m[0m ip_address_type       = (known after apply)
      [32m+[0m[0m network_interface_ids = (known after apply)
      [32m+[0m[0m owner_id              = (known after apply)
      [32m+[0m[0m policy                = (known after apply)
      [32m+[0m[0m prefix_list_id        = (known after apply)
      [32m+[0m[0m private_dns_enabled   = true
      [32m+[0m[0m region                = "sa-east-1"
      [32m+[0m[0m requester_managed     = (known after apply)
      [32m+[0m[0m route_table_ids       = (known after apply)
      [32m+[0m[0m security_group_ids    = (known after apply)
      [32m+[0m[0m service_name          = "com.amazonaws.sa-east-1.ssm"
      [32m+[0m[0m service_region        = (known after apply)
      [32m+[0m[0m state                 = (known after apply)
      [32m+[0m[0m subnet_ids            = (known after apply)
      [32m+[0m[0m tags                  = {
          [32m+[0m[0m "Name" = "peterock-vpce-ssm"
        }
      [32m+[0m[0m tags_all              = {
          [32m+[0m[0m "Name" = "peterock-vpce-ssm"
        }
      [32m+[0m[0m vpc_endpoint_type     = "Interface"
      [32m+[0m[0m vpc_id                = (known after apply)

      [32m+[0m[0m dns_options (known after apply)

      [32m+[0m[0m subnet_configuration (known after apply)
    }

[1m  # module.lab1-ab.aws_vpc_endpoint.chewbacca_vpce_services["ssmmessages"][0m will be created
[0m  [32m+[0m[0m resource "aws_vpc_endpoint" "chewbacca_vpce_services" {
      [32m+[0m[0m arn                   = (known after apply)
      [32m+[0m[0m cidr_blocks           = (known after apply)
      [32m+[0m[0m dns_entry             = (known after apply)
      [32m+[0m[0m id                    = (known after apply)
      [32m+[0m[0m ip_address_type       = (known after apply)
      [32m+[0m[0m network_interface_ids = (known after apply)
      [32m+[0m[0m owner_id              = (known after apply)
      [32m+[0m[0m policy                = (known after apply)
      [32m+[0m[0m prefix_list_id        = (known after apply)
      [32m+[0m[0m private_dns_enabled   = true
      [32m+[0m[0m region                = "sa-east-1"
      [32m+[0m[0m requester_managed     = (known after apply)
      [32m+[0m[0m route_table_ids       = (known after apply)
      [32m+[0m[0m security_group_ids    = (known after apply)
      [32m+[0m[0m service_name          = "com.amazonaws.sa-east-1.ssmmessages"
      [32m+[0m[0m service_region        = (known after apply)
      [32m+[0m[0m state                 = (known after apply)
      [32m+[0m[0m subnet_ids            = (known after apply)
      [32m+[0m[0m tags                  = {
          [32m+[0m[0m "Name" = "peterock-vpce-ssmmessages"
        }
      [32m+[0m[0m tags_all              = {
          [32m+[0m[0m "Name" = "peterock-vpce-ssmmessages"
        }
      [32m+[0m[0m vpc_endpoint_type     = "Interface"
      [32m+[0m[0m vpc_id                = (known after apply)

      [32m+[0m[0m dns_options (known after apply)

      [32m+[0m[0m subnet_configuration (known after apply)
    }

[1m  # module.lab1-ab.aws_vpc_security_group_egress_rule.ec2_all_outbound[0m will be created
[0m  [32m+[0m[0m resource "aws_vpc_security_group_egress_rule" "ec2_all_outbound" {
      [32m+[0m[0m arn                    = (known after apply)
      [32m+[0m[0m cidr_ipv4              = "0.0.0.0/0"
      [32m+[0m[0m description            = "Allow all outbound traffic"
      [32m+[0m[0m id                     = (known after apply)
      [32m+[0m[0m ip_protocol            = "-1"
      [32m+[0m[0m region                 = "sa-east-1"
      [32m+[0m[0m security_group_id      = (known after apply)
      [32m+[0m[0m security_group_rule_id = (known after apply)
      [32m+[0m[0m tags_all               = {}
    }

[1m  # module.lab1-ab.aws_vpc_security_group_egress_rule.rds_all_outbound[0m will be created
[0m  [32m+[0m[0m resource "aws_vpc_security_group_egress_rule" "rds_all_outbound" {
      [32m+[0m[0m arn                    = (known after apply)
      [32m+[0m[0m cidr_ipv4              = "0.0.0.0/0"
      [32m+[0m[0m description            = "Allow all outbound traffic"
      [32m+[0m[0m id                     = (known after apply)
      [32m+[0m[0m ip_protocol            = "-1"
      [32m+[0m[0m region                 = "sa-east-1"
      [32m+[0m[0m security_group_id      = (known after apply)
      [32m+[0m[0m security_group_rule_id = (known after apply)
      [32m+[0m[0m tags_all               = {}
    }

[1m  # module.lab1-ab.aws_vpc_security_group_egress_rule.vpce_all_outbound[0m will be created
[0m  [32m+[0m[0m resource "aws_vpc_security_group_egress_rule" "vpce_all_outbound" {
      [32m+[0m[0m arn                    = (known after apply)
      [32m+[0m[0m cidr_ipv4              = "0.0.0.0/0"
      [32m+[0m[0m description            = "Allow all outbound traffic"
      [32m+[0m[0m id                     = (known after apply)
      [32m+[0m[0m ip_protocol            = "-1"
      [32m+[0m[0m region                 = "sa-east-1"
      [32m+[0m[0m security_group_id      = (known after apply)
      [32m+[0m[0m security_group_rule_id = (known after apply)
      [32m+[0m[0m tags_all               = {}
    }

[1m  # module.lab1-ab.aws_vpc_security_group_ingress_rule.http[0m will be created
[0m  [32m+[0m[0m resource "aws_vpc_security_group_ingress_rule" "http" {
      [32m+[0m[0m arn                    = (known after apply)
      [32m+[0m[0m cidr_ipv4              = "108.56.232.140/32"
      [32m+[0m[0m description            = "Allow HTTP from MY PUBLIC IP"
      [32m+[0m[0m from_port              = 80
      [32m+[0m[0m id                     = (known after apply)
      [32m+[0m[0m ip_protocol            = "tcp"
      [32m+[0m[0m region                 = "sa-east-1"
      [32m+[0m[0m security_group_id      = (known after apply)
      [32m+[0m[0m security_group_rule_id = (known after apply)
      [32m+[0m[0m tags_all               = {}
      [32m+[0m[0m to_port                = 80
    }

[1m  # module.lab1-ab.aws_vpc_security_group_ingress_rule.https[0m will be created
[0m  [32m+[0m[0m resource "aws_vpc_security_group_ingress_rule" "https" {
      [32m+[0m[0m arn                    = (known after apply)
      [32m+[0m[0m cidr_ipv4              = "108.56.232.140/32"
      [32m+[0m[0m description            = "Allow HTTPS from MY PUBLIC IP"
      [32m+[0m[0m from_port              = 443
      [32m+[0m[0m id                     = (known after apply)
      [32m+[0m[0m ip_protocol            = "tcp"
      [32m+[0m[0m region                 = "sa-east-1"
      [32m+[0m[0m security_group_id      = (known after apply)
      [32m+[0m[0m security_group_rule_id = (known after apply)
      [32m+[0m[0m tags_all               = {}
      [32m+[0m[0m to_port                = 443
    }

[1m  # module.lab1-ab.aws_vpc_security_group_ingress_rule.rds_port[0m will be created
[0m  [32m+[0m[0m resource "aws_vpc_security_group_ingress_rule" "rds_port" {
      [32m+[0m[0m arn                          = (known after apply)
      [32m+[0m[0m description                  = "Allow MySQL-DB from VPC"
      [32m+[0m[0m from_port                    = 3306
      [32m+[0m[0m id                           = (known after apply)
      [32m+[0m[0m ip_protocol                  = "tcp"
      [32m+[0m[0m referenced_security_group_id = (known after apply)
      [32m+[0m[0m region                       = "sa-east-1"
      [32m+[0m[0m security_group_id            = (known after apply)
      [32m+[0m[0m security_group_rule_id       = (known after apply)
      [32m+[0m[0m tags_all                     = {}
      [32m+[0m[0m to_port                      = 3306
    }

[1m  # module.lab1-ab.aws_vpc_security_group_ingress_rule.ssh[0m will be created
[0m  [32m+[0m[0m resource "aws_vpc_security_group_ingress_rule" "ssh" {
      [32m+[0m[0m arn                    = (known after apply)
      [32m+[0m[0m cidr_ipv4              = "108.56.232.140/32"
      [32m+[0m[0m description            = "Allow SSH from VPC"
      [32m+[0m[0m from_port              = 22
      [32m+[0m[0m id                     = (known after apply)
      [32m+[0m[0m ip_protocol            = "tcp"
      [32m+[0m[0m region                 = "sa-east-1"
      [32m+[0m[0m security_group_id      = (known after apply)
      [32m+[0m[0m security_group_rule_id = (known after apply)
      [32m+[0m[0m tags_all               = {}
      [32m+[0m[0m to_port                = 22
    }

[1m  # module.lab1-ab.aws_vpc_security_group_ingress_rule.vpce_https[0m will be created
[0m  [32m+[0m[0m resource "aws_vpc_security_group_ingress_rule" "vpce_https" {
      [32m+[0m[0m arn                          = (known after apply)
      [32m+[0m[0m description                  = "Allow HTTPS from privates subnets"
      [32m+[0m[0m from_port                    = 443
      [32m+[0m[0m id                           = (known after apply)
      [32m+[0m[0m ip_protocol                  = "tcp"
      [32m+[0m[0m referenced_security_group_id = (known after apply)
      [32m+[0m[0m region                       = "sa-east-1"
      [32m+[0m[0m security_group_id            = (known after apply)
      [32m+[0m[0m security_group_rule_id       = (known after apply)
      [32m+[0m[0m tags_all                     = {}
      [32m+[0m[0m to_port                      = 443
    }

[1mPlan:[0m [0m63 to add, 0 to change, 0 to destroy.
[90m
─────────────────────────────────────────────────────────────────────────────[0m

Note: You didn't use the -out option to save this plan, so Terraform can't
guarantee to take exactly these actions if you run "terraform apply" now.
