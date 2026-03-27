variable "aws_region" {
  description = "Region where AWS architecture is housed"
  type        = string
  default     = "sa-east-1"
}

variable "cloudfront_acm_cert_region" {
  description = "Region where Cloudfront ACM Certificate is housed"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "class7-armageddon"
}


variable "environment" {
  description = "Enviroment to deploy infra structure"
  type        = string
  default     = "dev"
}


variable "vpc_cidr_block" {
  type        = string
  description = "VPC Cidr Block Range"
  default     = "10.81.0.0/16"
}


variable "public_subnet_config" {
  type = map(object({
    cidr_block = string
    az         = string
  }))
  description = "Public subnet cidr and AZ configuration"
  default = {
    "liberdade_public_subnet_1" = {
      cidr_block = "10.81.6.0/24"
      az         = "sa-east-1a"
    }
    "liberdade_public_subnet_2" = {
      cidr_block = "10.81.7.0/24"
      az         = "sa-east-1b"
    }
    "liberdade_public_subnet_3" = {
      cidr_block = "10.81.8.0/24"
      az         = "sa-east-1c"
    }
  }
}


variable "private_subnet_config" {
  type = map(object({
    cidr_block = string
    az         = string
  }))
  description = "Private subnet cidr and AZ configuration"
  default = {
    "liberdade_private_subnet_1" = {
      cidr_block = "10.81.16.0/24"
      az         = "sa-east-1a"
    }
    "liberdade_private_subnet_2" = {
      cidr_block = "10.81.17.0/24"
      az         = "sa-east-1b"
    }
    "liberdade_private_subnet_3" = {
      cidr_block = "10.81.18.0/24"
      az         = "sa-east-1c"
    }
  }
}




variable "instance_type" {
  description = "Instance type that EC2 lab app is using"
  type        = string
  default     = "t3.micro"
}



variable "sns_email_endpoint" {
  description = "Email endpoint for SNS topic subscription"
  type        = string
  default     = "nicholasdfoster645@gmail.com"
}

variable "packer_ami_name_prefix" {
  description = "AMI name for Packer built AMI"
  type        = string
  default     = "class7-armageddon-ami"
}

variable "enable_runtime_instance_creation" {
  description = "Enable runtime instance for Packer builds"
  # ^ Set to false first time so that AMI can be built. Once AMI is built, set to true.
  type    = bool
  default = true
}


variable "app_subdomain" {
  description = "Hostname prefix for app domain"
  type        = string
  default     = "app"
}


variable "root_domain_name" {
  description = "Root domain name for Route53 hosted zone"
  type        = string
  default     = "hungrywolves.click"
}


variable "certificate_validation_method" {
  description = "Method to validate ACM certificate"
  type        = string
  default     = "DNS"
}

# Guardrail to avoid accidental ACM validation record management upon rerunning Terraform, losing state, or having existing CNAME records.
variable "manage_acm_validation_records" {
  description = "Whether to manage ACM validation records in Route53"
  type        = bool
  default     = true
}


variable "enable_waf" {
  description = "Whether or not to enable WAF (Web Application Firewall)"
  type        = bool
  default     = true
}



variable "alb_5xx_threshold" {
  description = "Alarm threshold for ALB 5xx count."
  type        = number
  default     = 10
}

variable "alb_5xx_period_seconds" {
  description = "CloudWatch alarm period."
  type        = number
  default     = 120
}

variable "alb_5xx_evaluation_periods" {
  description = "Evaluation periods for alarm."
  type        = number
  default     = 2
}

variable "enable_alb_access_logs" {
  description = "Enable ALB access logging to S3."
  type        = bool
  default     = true
}

variable "alb_access_logs_prefix" {
  description = "S3 prefix for ALB access logs."
  type        = string
  default     = "alb-access-logs"
}


variable "waf_log_destination" {
  description = "Destination for WAF logs. Choose one of the following per Web ACL: 'cloudwatch', 's3', or 'kinesis'."
  type        = string
  default     = "cloudwatch"
}


variable "waf_log_retention_days" {
  description = "Retention for WAF CloudWatch log group."
  type        = number
  default     = 14
}

variable "enable_waf_sampled_requests_only" {
  description = "If true, can optionally filter/redact fields later. (Placeholder toggle.)"
  type        = bool
  default     = false
}
