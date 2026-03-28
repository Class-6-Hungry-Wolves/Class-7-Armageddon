variable "aws_region" {
  description = "Region where Shinjuku architecture is housed"
  type        = string
  default     = "ap-northeast-1"
}


variable "alternate_region" {
  description = "Region where Liberdade architecture is housed"
  type        = string
  default     = "sa-east-1"
}

variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "class7-armageddon"
}


variable "environment" {
  description = "Environment to deploy infrastructure"
  type        = string
  default     = "dev"
}


variable "vpc_cidr_block" {
  type        = string
  description = "VPC Cidr Block Range"
  default     = "10.81.0.0/16"
}
