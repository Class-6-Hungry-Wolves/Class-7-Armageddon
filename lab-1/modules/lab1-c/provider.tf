# Configure the AWS Provider
provider "aws" {
  region = module.lab1-ab.aws_region
}