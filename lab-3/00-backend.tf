############################################
# Lab 3: Terraform Configuration and Backend
# Multi-Region APPI-Compliant Infrastructure
############################################

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket         = "class7-armagaggeon-tf-bucket"
    key            = "lab3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "lab3-tf-locks"
    encrypt        = true
  }
}
