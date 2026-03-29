locals {
  armageddon_fqdn = "${var.app_subdomain}.${var.root_domain_name}"
}


# ACM Certificate for CloudFront
resource "aws_acm_certificate" "armageddon_cf_cert01" {
  provider                  = aws.us-east-1
  domain_name               = local.armageddon_fqdn
  validation_method         = var.certificate_validation_method
  subject_alternative_names = [var.root_domain_name]

  tags = {
    Name = "${var.project_name}-armageddon-cf-cert"
  }
}

# ACM Certificate for Shinjuku ALB
resource "aws_acm_certificate" "shinjuku_alb_cert01" {
  domain_name               = local.armageddon_fqdn
  validation_method         = var.certificate_validation_method
  subject_alternative_names = [var.root_domain_name]

  tags = {
    Name = "${var.project_name}-armageddon-cf-cert"
  }
}

# Already existing Route53 Hosted Zone for hungrywolves.click
data "aws_route53_zone" "hungry_wolves_main_zone" {
  name         = var.root_domain_name
  private_zone = false
}



resource "aws_route53_record" "armageddon_cf_cert_validation_record01" {
  for_each = (var.manage_acm_validation_records && var.certificate_validation_method == "DNS") ? {
    for dvo in aws_acm_certificate.armageddon_cf_cert01.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  } : {}

  zone_id = data.aws_route53_zone.hungry_wolves_main_zone.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.record]
}



resource "aws_acm_certificate_validation" "armageddon_cf_cert01" {
  provider                = aws.us-east-1
  certificate_arn         = aws_acm_certificate.armageddon_cf_cert01.arn
  validation_record_fqdns = [for r in aws_route53_record.armageddon_cf_cert_validation_record01 : r.fqdn]
}

resource "aws_acm_certificate_validation" "shinjuku_alb_cert01" {
  certificate_arn         = aws_acm_certificate.shinjuku_alb_cert01.arn
  validation_record_fqdns = [for r in aws_route53_record.armageddon_cf_cert_validation_record01 : r.fqdn]
}




resource "aws_route53_record" "armageddon_cf_subdomain_a_record" {
  zone_id  = data.aws_route53_zone.hungry_wolves_main_zone.zone_id
  name     = local.armageddon_fqdn
  type     = "A"
  alias {
    name                   = aws_cloudfront_distribution.armageddon_cf01.domain_name
    zone_id                = aws_cloudfront_distribution.armageddon_cf01.hosted_zone_id
    evaluate_target_health = true
  }
}


resource "aws_route53_record" "armageddon_zone_apex_cf_a_record" {
  zone_id  = data.aws_route53_zone.hungry_wolves_main_zone.zone_id
  name     = var.root_domain_name
  type     = "A"
  alias {
    name                   = aws_cloudfront_distribution.armageddon_cf01.domain_name
    zone_id                = aws_cloudfront_distribution.armageddon_cf01.hosted_zone_id
    evaluate_target_health = true
  }
}
