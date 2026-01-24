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
  description = "Enviroment to deploy infra structure"
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


variable "db-engine" {
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
  default     = "rds01"
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


variable "sns_email_endpoint" {
  description = "Email endpoint for SNS topic subscription"
  type = string 
  default = "nicholasdfoster645@gmail.com"
}