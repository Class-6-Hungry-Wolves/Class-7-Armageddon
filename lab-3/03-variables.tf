############################################
# Lab 3: Variables Configuration
############################################

#-----------------------------------------------------------------------------
# General Variables
#-----------------------------------------------------------------------------

variable "project_name" {
  description = "Project name for resource tagging"
  type        = string
  default     = "chewbacca"
}

#-----------------------------------------------------------------------------
# Tokyo VPC Variables
#-----------------------------------------------------------------------------

variable "tokyo_vpc_cidr" {
  description = "VPC CIDR for Tokyo region"
  type        = string
  default     = "10.75.0.0/16"
}

variable "tokyo_public_subnet_cidrs" {
  description = "Public subnet CIDRs for Tokyo"
  type        = list(string)
  default     = ["10.75.1.0/24", "10.75.11.0/24"]
}

variable "tokyo_private_subnet_cidrs" {
  description = "Private subnet CIDRs for Tokyo"
  type        = list(string)
  default     = ["10.75.101.0/24", "10.75.128.0/24"]
}

variable "tokyo_azs" {
  description = "Availability Zones for Tokyo"
  type        = list(string)
  default     = ["ap-northeast-1a", "ap-northeast-1c"]
}

#-----------------------------------------------------------------------------
# São Paulo VPC Variables
#-----------------------------------------------------------------------------

variable "saopaulo_vpc_cidr" {
  description = "VPC CIDR for São Paulo region"
  type        = string
  default     = "10.76.0.0/16"
}

variable "saopaulo_public_subnet_cidrs" {
  description = "Public subnet CIDRs for São Paulo"
  type        = list(string)
  default     = ["10.76.1.0/24", "10.76.11.0/24"]
}

variable "saopaulo_private_subnet_cidrs" {
  description = "Private subnet CIDRs for São Paulo"
  type        = list(string)
  default     = ["10.76.101.0/24", "10.76.128.0/24"]
}

variable "saopaulo_azs" {
  description = "Availability Zones for São Paulo"
  type        = list(string)
  default     = ["sa-east-1a", "sa-east-1c"]
}

#-----------------------------------------------------------------------------
# EC2 Variables
#-----------------------------------------------------------------------------

variable "tokyo_ec2_ami_id" {
  description = "AMI ID for EC2 in Tokyo (Amazon Linux 2023)"
  type        = string
  default     = "ami-0d52744d6551d851e" # Amazon Linux 2023 in ap-northeast-1
}

variable "saopaulo_ec2_ami_id" {
  description = "AMI ID for EC2 in São Paulo (Amazon Linux 2023)"
  type        = string
  default     = "ami-0c820c196a818d66a" # Amazon Linux 2023 in sa-east-1
}

variable "ec2_instance_type" {
  description = "EC2 instance size"
  type        = string
  default     = "t3.micro"
}

#-----------------------------------------------------------------------------
# RDS Variables (Tokyo Only - APPI Compliance)
#-----------------------------------------------------------------------------

variable "db_engine" {
  description = "RDS engine"
  type        = string
  default     = "mysql"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Initial database name"
  type        = string
  default     = "labmysql"
}

variable "db_username" {
  description = "DB master username"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "DB master password (use Secrets Manager in production)"
  type        = string
  sensitive   = true
  default     = "jNhnA2DFcGrxmMtIo4EvfkQPbsxK4v8"
}

#-----------------------------------------------------------------------------
# DNS and TLS Variables
#-----------------------------------------------------------------------------

variable "domain_name" {
  description = "Root domain name"
  type        = string
  default     = "keepuneat.click"
}

variable "app_subdomain" {
  description = "Subdomain for the application"
  type        = string
  default     = "app"
}

#-----------------------------------------------------------------------------
# Notification Variables
#-----------------------------------------------------------------------------

variable "sns_email_endpoint" {
  description = "Email for SNS subscription"
  type        = string
  default     = "gaijinmzungu@gmail.com"
}

variable "my_ip" {
  description = "Your IP address for SSH access (format: x.x.x.x/32)"
  type        = string
  default     = "0.0.0.0/0"
}

#-----------------------------------------------------------------------------
# Logging Variables
#-----------------------------------------------------------------------------

variable "waf_log_retention_days" {
  description = "Number of days to retain WAF logs"
  type        = number
  default     = 30
}

variable "enable_alb_access_logs" {
  description = "Enable ALB access logging to S3"
  type        = bool
  default     = false
}

variable "alb_access_logs_prefix" {
  description = "S3 prefix for ALB access logs"
  type        = string
  default     = "alb-logs"
}

variable "alb_logs_retention_days" {
  description = "Number of days to retain ALB logs"
  type        = number
  default     = 90
}
