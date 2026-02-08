#=============================================================================
# TERRAFORM.TFVARS - Vandelay Industries Configuration
#=============================================================================
# This file contains YOUR specific values for the lab.
# 
# ⚠️  IMPORTANT: 
#     - Do NOT commit this file to version control (add to .gitignore)
#     - The db_password is sensitive!
#=============================================================================

#-----------------------------------------------------------------------------
# YOUR VALUES - FILL THESE IN
#-----------------------------------------------------------------------------

# Project name - already set to vandelay
project_name = "vandelay"

# AWS Region
aws_region = "us-east-1"

# EC2 AMI - Find the latest Amazon Linux 2023 AMI by running:
# aws ec2 describe-images --region us-east-1 --owners amazon \
#   --filters "Name=name,Values=al2023-ami-2023*-x86_64" \
#   --query "Images | sort_by(@, &CreationDate) | [-1].ImageId" --output text
ec2_ami_id = "ami-0532be01f26a3de55"  # ← Replace with your AMI ID!

# Your IP address for SSH access (find it at https://whatismyip.com)
# Format: "YOUR.IP.ADDRESS/32" (the /32 means just your single IP)
my_ip = "***REDACTED_IP***/32"  # ← Replace with "YOUR.IP.HERE/32" for security!

# Database password - minimum 8 characters
# Use a strong password! Example: "VandelayRocks2024!"
db_password = "***REDACTED_PASSWORD***"  # ← Replace with your password!

# Your email for CloudWatch alerts
sns_email_endpoint = "gaijinmzungu@gmail.com"  # ← Replace with your email!

#-----------------------------------------------------------------------------
# OPTIONAL - These have good defaults but you can customize
#-----------------------------------------------------------------------------

# VPC CIDR - default is fine for most cases
# vpc_cidr = "10.0.0.0/16"

# Subnet CIDRs - default is fine
# public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
# private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]

# Availability Zones - default is fine for us-east-1
# azs = ["us-east-1a", "us-east-1b"]

# EC2 instance type - t3.micro is free tier
# ec2_instance_type = "t3.micro"

# RDS settings - defaults are fine
# db_engine         = "mysql"
# db_instance_class = "db.t3.micro"
# db_name           = "vandelaydb"
# db_username       = "admin"
