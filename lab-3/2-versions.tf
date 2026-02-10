terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
  backend "s3" {
    key    = "lab-3/292026.tfstate"
    region = "us-east-1"
    bucket = "class7-armageddon-tf-bucket"
  }
}