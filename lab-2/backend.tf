
#Local state is used so that my branch can deploy and manage it's own EC2 -> RDS environment.


#Remote S3 backend for Terraform state management. 
terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    bucket  = "jmk-terraform-state-72"
    key     = "lab-1/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}


#S3 backend disabled for this branch because the bucket and state file are owned by Nick.
#Using this backend will return 403 forbidden errors.
/* 
  backend "s3" {
    key = "lab-1/1a/112026.tfstate"
    region = "us-east-1"
    bucket = "class7-armageddon-tf-bucket"
  }
  */


