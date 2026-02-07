variable "gcp_project_id" { default = "aaa-gcp" }
variable "gcp_region"     { default = "us-central1" }

variable "nihonmachi_vpc_cidr"     { default = "10.169.25.0/16" }
variable "nihonmachi_subnet_cidr"  { default = "10.169.25.0/24" }

variable "allowed_vpn_cidrs" {
  type    = list(string)
  default = ["10.150.67.0/24"] # students: add AWS Tokyo VPC CIDR, corp VPN CIDR, etc.
}

# Tokyo RDS endpoint (private resolvable/reachable over VPN)
variable "tokyo_rds_host" { default = "tokyo-rds-endpoint.example" }
variable "tokyo_rds_port" { default = 3306 }

# DB user is OK to store as plain var; password should not be in TF state (use Secret Manager)
variable "tokyo_rds_user" { default = "appuser" }

# Secret name holding DB password (created outside TF or by TF—your choice)
variable "db_password_secret_name" { default = "nihonmachi-tokyo-rds-password" }