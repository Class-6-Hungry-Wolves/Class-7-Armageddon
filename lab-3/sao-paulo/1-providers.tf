# Default Tokyo region for stateful Shinjuku architecture: ap-northeast-1 
provider "aws" {
  region = var.aws_region
  alias = "saopaulo"
}


# Cloudfront ACM certificate must be in us-east-1 region, so another provider with alias us-east-1 must be defined to create ACM certificate in us-east-1.
provider "aws" {
  alias  = "us-east-1"
  region = var.cloudfront_acm_cert_region
}
