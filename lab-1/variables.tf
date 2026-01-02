variable "aws_region" {
  description = "Region where AWS architecture is housed"
  type = string
  default = "us-east-1"
}


variable "project_name" {
  description = "The name of the project"
  type = string
  default = "class7-armageddon"
}


variable "environment" {
    description = "Enviroment to deploy infra structure"
    type = string 
    default = "dev"
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


# variable "" {
  
# }