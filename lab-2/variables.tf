variable "aws_region" {
  description = "Region where AWS architecture is housed"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "class7-armageddon"
}

variable "environment" {
  description = "Environment to deploy infra structure"
  type        = string
  default     = "dev"
}

variable "vpc_cidr_block" {
  type        = string
  description = "VPC Cidr Block Range"
  default     = "10.80.0.0/16"
}

variable "public_subnet_config" {
  type = map(object({
    cidr_block = string
    az         = string
  }))
  description = "Public subnet cidr and AZ configuration"
  default = {
    "lab_1a_subnet_1" = {
      cidr_block = "10.80.6.0/24"
      az         = "us-east-1a"
    }
    "lab_1a_subnet_2" = {
      cidr_block = "10.80.7.0/24"
      az         = "us-east-1b"
    }
    "lab_1a_subnet_3" = {
      cidr_block = "10.80.8.0/24"
      az         = "us-east-1c"
    }
  }
}

variable "database_subnet_config" {
  type = map(object({
    cidr_block = string
    az         = string
  }))
  description = "Database Subnet CIDR and AZ configuration"
  default = {
    "lab_1a_database_subnet_1" = {
      cidr_block = "10.80.16.0/24"
      az         = "us-east-1a"
    }
    "lab_1a_database_subnet_2" = {
      cidr_block = "10.80.17.0/24"
      az         = "us-east-1b"
    }
    "lab_1a_database_subnet_3" = {
      cidr_block = "10.80.18.0/24"
      az         = "us-east-1c"
    }
  }
}

variable "instance_type" {
  description = "Instance type that EC2 lab app is using"
  type        = string
  default     = "t3.micro"
}

variable "db_engine" {
  description = "Database engine that RDS will be using"
  type        = string
  default     = "mysql"
}

variable "db_instance_class" {
  description = "RDS instance class."
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Initial database name."
  type        = string
  default     = "labdb"
}

variable "db_username" {
  description = "DB master username (students should use Secrets Manager in 1B/1C)."
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "DB master password (DO NOT hardcode in real life; for lab only)."
  type        = string
  sensitive   = true
  default     = "X4uU2UFiWgZA3x59S8we"
}

variable "alert_email" {
  description = "Email address to receive DB incident alerts"
  type        = string
  default     = "joshuakabalo2@gmail.com"
}

variable "app_domain_name" {
  description = "FQDN for the app (e.g., app.chewbacca-growl.com)"
  type        = string
}

variable "hosted_zone_name" {
  description = "Route53 hosted zone name (e.g., chewbacca-growl.com)"
  type        = string
}

variable "enable_route53" {
  description = "Set true if DNS is managed in Route53 and you want Terraform to create records"
  type        = bool
  default     = true
}

variable "enable_tls" {
  description = "Enable HTTPS listener + ACM (requires domain validation)"
  type        = bool
  default     = false
}
# Lab1C bonus-c
variable "manage_route53_in_terraform" {
  description = "If true, create/manage Route53 hosted zone + records in Terraform."
  type        = bool
  default     = false
}

variable "route53_hosted_zone_id" {
  description = "If manage_route53_in_terraform=false, provide existing Hosted Zone ID for domain."
  type        = string
  default     = ""
}

variable "domain_name" {
  description = "Base domain name (e.g., chewbacca-growl.com). Leave empty if you do not own a domain."
  type        = string
  default     = ""
}

variable "app_subdomain" {
  description = "App subdomain (e.g., app)."
  type        = string
  default     = "app"
}

#lab1c bonus-D
variable "enable_alb_access_logs" {
  type    = bool
  default = true
}

variable "alb_access_logs_prefix" {
  type    = string
  default = "alb-access-logs"
}

variable "waf_log_destination" {
  description = "Choose ONE destination per WebACL: cloudwatch | s3 | firehose"
  type        = string
  default     = "cloudwatch"
}

variable "waf_log_retention_days" {
  description = "Retention for WAF CloudWatch log group."
  type        = number
  default     = 14
}

variable "enable_waf_sampled_requests_only" {
  description = "If true, students can optionally filter/redact fields later. (Placeholder toggle.)"
  type        = bool
  default     = false
}

variable "cloudfront_waf_name" {
  type    = string
  default = "max-payne-cf-waf01"
}

variable "origin_header_name" {
  type    = string
  default = "X-Chewbacca-Growl"
}

variable "origin_header_value" {
  type      = string
  sensitive = true
}




