####################################
#### Providers/Locals Variables ####
####################################

variable "aws_region" {
  description = "AWS Region for the Armageddon project."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Prefix for naming. Students should change from 'chewbacca' to their own."
  type        = string
  default     = "lab-1"
}

variable "environment" {
  description = "Environment name for resource tagging and naming (dev, staging, prod)"
  type        = string
  default     = "dev"
}

##############################
#### Networking Variables ####
##############################

variable "vpc_cidr" {
  description = "VPC CIDR (use 10.x.x.x/xx as instructed)."
  type        = string
  default     = "10.88.0.0/16" # TODO: student supplies
}

variable "map_public_ip_on_launch" {
  description = "Auto-assign public IP addresses to instances launched in public subnets"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "instance_tenancy" {
  description = "Tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"

  validation {
    condition     = contains(["default", "dedicated"], var.instance_tenancy)
    error_message = "Instance tenancy must be either 'default' or 'dedicated'."
  }
}

##########################
#### Subnet Variables ####
##########################

variable "availability_zones_count" {
  description = "Number of availability zones to use (determines number of subnets created)"
  type        = number
  default     = 3

  validation {
    condition     = var.availability_zones_count >= 2 && var.availability_zones_count <= 6
    error_message = "Availability zones count must be between 2 and 6 for high availability."
  }
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs (use 10.x.x.x/xx)."
  type        = list(string)
  default     = ["10.88.1.0/24", "10.88.2.0/24", "10.88.3.0/24"] # TODO: student supplies
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs (use 10.x.x.x/xx)."
  type        = list(string)
  default     = ["10.88.11.0/24", "10.88.12.0/24", "10.88.13.0/24"] # TODO: student supplies
}

variable "azs" {
  description = "Availability Zones list (match count with subnets)."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"] # TODO: student supplies
}

#######################
#### EC2 Variables ####
#######################
variable "ec2_instance_type" {
  description = "EC2 instance size for the app."
  type        = string
  default     = "t3.micro"
}

############################
#### Database Variables ####
############################
variable "db_engine" {
  description = "RDS engine."
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
  default     = "rds" # Students can change
}

variable "db_username" {
  description = "DB master username (students should use Secrets Manager in 1B/1C)."
  type        = string
  default     = "admin" # TODO: student supplies
}

variable "db_password" {
  description = "DB master password (DO NOT hardcode in real life; for lab only)."
  type        = string
  sensitive   = true
  default     = "TKOrpxKjGyu36956kJ" # TODO: student supplies
}

##############################
#### CloudWatch Variables ####
##############################
variable "log_retention_by_env" {
  description = "CloudWatch log retention by environment"
  type        = map(number)

  default = {
    dev  = 3
    test = 7
    prod = 30
  }
}

#################################
#### Notifications Variables ####
#################################
variable "sns_email_endpoint" {
  description = "Email for SNS subscription (PagerDuty simulation)."
  type        = string
  default     = "aahdjehuty.365@gmail.com" # TODO: student supplies
}

#######################
#### DNS Variables ####
#######################

variable "domain_name" {
  description = "Base domain students registered (e.g., chewbacca-growl.com)."
  type        = string
  default     = "lonbraj.click"
}

variable "app_subdomain" {
  description = "App hostname prefix (e.g., app.chewbacca-growl.com)."
  type        = string
  default     = "app"
}

variable "certificate_validation_method" {
  description = "ACM validation method. Students can do DNS (Route53) or EMAIL."
  type        = string
  default     = "DNS"
}

#######################
#### WAF Variables ####
#######################

variable "enable_waf" {
  description = "Toggle WAF creation."
  type        = bool
  default     = true
}

variable "waf_log_destination" {
  description = "Destination for the WAF logs.Choose the Web ACL for either: 'cloudwatch', 's3', or 'kinesis'."
  type        = string
  default     = "cloudwatch"
}

# Optional - only use if WAF log destination is 'cloudwatch'
variable "waf_log_retention_days" {
  description = "The number of days to retain the logs if log destination is 'cloudwatch'."
  type        = number
  default     = 1
}

##################################
#### Load Balancing Variables ####
##################################

variable "alb_5xx_threshold" {
  description = "Alarm threshold for ALB 5xx count."
  type        = number
  default     = 10
}

variable "alb_5xx_period_seconds" {
  description = "CloudWatch alarm period."
  type        = number
  default     = 300
}

variable "alb_5xx_evaluation_periods" {
  description = "Evaluation periods for alarm."
  type        = number
  default     = 1
}

variable "alb_access_logs_prefix" {
  description = ""
  type        = string
  default     = "alb-access-logs"
}

variable "enable_alb_access_logs" {
  description = "Provisions ccess logs to an S3 bucket"
  type        = bool
  default     = true
}

# ############################
# #### Route 53 Vairables ####
# ############################

# variable "manage_route53_in_terraform" {
#   description = "Set to true to manage the Route 53 zone"
#   type        = bool
#   default     = true
# }

# variable "route53_hosted_zone_id" {
#   description = "ID of an existing Route 53 Hosted Zone. Required if 'manage_route53_in_terraform' is set to false"
#   type        = string
#   default     = "" # Keep this optioaal so Terraform doesn't think you are creating a NEW one. 
# }
