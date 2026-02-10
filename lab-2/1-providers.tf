provider "aws" {
  region = var.aws_region
}

# CloudFront + ACM viewer certs must be in us-east-1
provider "aws" {
  alias  = "use1"
  region = "us-east-1"
}
