#variables.tf
variable "project_name" {
  description = "Base project name used for naming and tagging."
  type        = string
  default     = "chewbacca-lab2"
}

variable "environment" {
  description = "Dev deployment environment."
  type        = string
  default     = "dev"
}

variable "owner" {
  description = "Owner Tags."
  type        = string
  default     = "JMK"
}

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the Lab VPC"
}

variable "public_subnet_config" {
  description = "Map of public subnet configs (cidr_block, az)"
  type = map(object({
    cidr_block = string
    az         = string
  }))
}

variable "database_subnet_config" {
  description = "Map of database/private subnet configs (cidr_block, az)"
  type = map(object({
    cidr_block = string
    az         = string
  }))
}

variable "app_instance_type" {
  description = "EC2 instance type for the Lab 2a app layer"
  type        = string
  default     = "t3.micro"
}

variable "app_min_size" {
  description = "Minimum number of instances in the app ASG"
  type        = number
  default     = 1
}

variable "app_max_size" {
  description = "Maximum number of instances in the app ASG"
  type        = number
  default     = 3
}

variable "app_desired_capacity" {
  description = "Desired number of instances in the app ASG"
  type        = number
  default     = 1
}
