# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Terraform infrastructure-as-code project deploying a production-grade AWS environment for "Vandelay Industries" (Lab 1 - EC2 to RDS Integration, Class 7: Armageddon). It demonstrates secure cloud application architecture with compute-to-database connectivity, credential management, monitoring, and advanced networking.

**AWS Region:** us-east-1
**Terraform Version:** >= 1.5.0
**AWS Provider:** ~> 5.0

## Common Commands

```bash
# Initialize Terraform (downloads providers, sets up backend)
terraform init

# Validate configuration syntax
terraform validate

# Preview changes before applying
terraform plan

# Apply infrastructure changes
terraform apply

# Apply with auto-approve (skip confirmation)
terraform apply -auto-approve

# Destroy all infrastructure
terraform destroy

# Show current state
terraform show

# List all outputs
terraform output

# Get specific output value
terraform output ec2_public_ip

# Format all .tf files
terraform fmt -recursive
```

## Architecture

### Three Deployment Tiers

1. **Core Lab (Basic):** VPC, public EC2, private RDS, security groups, Flask app
2. **Bonus A (Enhanced Security):** Private EC2, VPC Endpoints (SSM, S3, Secrets Manager, KMS, CloudWatch), Lambda secret rotation
3. **Bonus B (Production-Grade):** ALB with TLS/HTTPS, Route53 DNS, WAF with managed rule groups

### File Organization

| File | Purpose |
|------|---------|
| `00-auth.tf` | Terraform config, S3 backend |
| `01-vpc.tf` | VPC + Internet Gateway |
| `02-sg.tf` | Security Groups (EC2, RDS, VPCE) |
| `03-sub.tf` | Public/Private Subnets (2 AZs) |
| `04-nat.tf` | NAT Gateway + Elastic IP |
| `05-rtb.tf` | Route Tables + Routes |
| `07-compute.tf` | EC2, RDS, IAM roles, Secrets Manager, Lambda rotation |
| `08-cloudwatch.tf` | CloudWatch Logs, Alarms, SNS |
| `09-sh.tf` | Bonus A: Private EC2, VPC Endpoints |
| `10-bonus-b.tf` | Bonus B: ALB, TLS, Route53, WAF |
| `user_data.sh` | EC2 bootstrap script (Flask notes app) |

### Network Topology

- **VPC CIDR:** `10.75.0.0/16`
- **Public Subnets:** `10.75.1.0/24` (1a), `10.75.11.0/24` (1b) - EC2, ALB
- **Private Subnets:** `10.75.101.0/24` (1a), `10.75.128.0/24` (1b) - RDS, Lambda

### Security Model

- RDS only accessible from EC2 security group (no public access)
- EC2 retrieves database credentials from Secrets Manager via IAM role
- Lambda rotates RDS password every 30 days
- VPC Endpoints enable private access to AWS services without NAT

### Application Endpoints (Flask)

- `GET /` - Home page
- `GET /health` - Health check
- `GET /init` - Initialize database (creates notes table)
- `POST /add?note=hello_world` - Insert note
- `GET /list` - List all notes

## State Management

Backend configured in `main.tf`:
```hcl
backend "s3" {
  bucket = "class7-armagaggeon-tf-bucket"
  key    = "class7/fineqts/armageddontf/state-key"
  region = "us-east-1"
}
```

## Key Variables

Configure in `terraform.tfvars`:
- `my_ip` - IP address allowed for SSH access (restrict from `0.0.0.0/0`)
- `db_password` - RDS master password (sensitive)
- `sns_email_endpoint` - Email for CloudWatch alerts
- `domain_name` / `app_subdomain` - Route53 DNS (Bonus B)

## AWS CLI Verification Commands

```bash
# Verify EC2 instance
aws ec2 describe-instances --filters "Name=tag:Name,Values=vandelay*"

# Check RDS instance
aws rds describe-db-instances --db-instance-identifier vandelay-rds01

# Test Secrets Manager access
aws secretsmanager get-secret-value --secret-id lab/rds/mysql

# View CloudWatch alarms
aws cloudwatch describe-alarms --alarm-names vandelay-db-connection-failure
```
