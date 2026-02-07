############################################
# Lab 3: Common Locals and Tags
############################################

locals {
  # Tokyo naming prefix
  tokyo_prefix = "chewbacca"

  # São Paulo naming prefix
  saopaulo_prefix = "liberdade"

  # TGW naming prefixes
  tokyo_tgw_prefix    = "shinjuku"
  saopaulo_tgw_prefix = "liberdade"

  # Common tags
  common_tags = {
    Lab         = "lab3-multi-region"
    Environment = "development"
    Project     = var.project_name
  }

  # Tokyo-specific tags
  tokyo_tags = merge(local.common_tags, {
    Region = "ap-northeast-1"
    Prefix = local.tokyo_prefix
  })

  # São Paulo-specific tags
  saopaulo_tags = merge(local.common_tags, {
    Region = "sa-east-1"
    Prefix = local.saopaulo_prefix
  })

  # Route53 zone
  chewbacca_zone_id  = data.aws_route53_zone.chewbacca_zone.zone_id
  chewbacca_app_fqdn = "${var.app_subdomain}.${var.domain_name}"

  # ELB account IDs per region for ALB logging
  elb_account_id = {
    "us-east-1"      = "127311923021"
    "us-east-2"      = "033677994240"
    "us-west-1"      = "027434742980"
    "us-west-2"      = "797873946194"
    "eu-west-1"      = "156460612806"
    "eu-west-2"      = "652711504416"
    "eu-central-1"   = "054676820928"
    "ap-southeast-1" = "114774131450"
    "ap-southeast-2" = "783225319266"
    "ap-northeast-1" = "582318560864"
    "sa-east-1"      = "507241528517"
  }
}

# Data sources for account identity
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
