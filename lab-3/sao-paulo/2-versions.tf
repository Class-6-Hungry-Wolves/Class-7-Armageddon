terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
  backend "s3" {
    key    = "lab-3/32626.tfstate"
    region = "sa-east-1"
    bucket = "tf-state-bucket-for-liberdade-architecture"
  }
}