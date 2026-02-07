############################################
# Lab 3: CloudFront DNS Records
# DNS points to CloudFront, NOT the ALBs directly
############################################

#-----------------------------------------------------------------------------
# ACM Certificate for CloudFront (must be in us-east-1)
#-----------------------------------------------------------------------------

resource "aws_acm_certificate" "chewbacca_cf_cert" {
  provider                  = aws.useast1
  domain_name               = var.domain_name
  subject_alternative_names = ["*.${var.domain_name}"]
  validation_method         = "DNS"

  tags = merge(local.common_tags, {
    Name = "${local.tokyo_prefix}-cf-acm-cert"
  })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "chewbacca_cf_cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.chewbacca_cf_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = local.chewbacca_zone_id
}

resource "aws_acm_certificate_validation" "chewbacca_cf_cert_validated" {
  provider                = aws.useast1
  certificate_arn         = aws_acm_certificate.chewbacca_cf_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.chewbacca_cf_cert_validation : record.fqdn]

  timeouts {
    create = "5m"
  }
}

#-----------------------------------------------------------------------------
# Root Domain -> CloudFront
#-----------------------------------------------------------------------------

resource "aws_route53_record" "chewbacca_apex_to_cf01" {
  zone_id = local.chewbacca_zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.chewbacca_cf01.domain_name
    zone_id                = aws_cloudfront_distribution.chewbacca_cf01.hosted_zone_id
    evaluate_target_health = false
  }
}

#-----------------------------------------------------------------------------
# App Subdomain -> CloudFront
#-----------------------------------------------------------------------------

resource "aws_route53_record" "chewbacca_app_to_cf01" {
  zone_id = local.chewbacca_zone_id
  name    = "${var.app_subdomain}.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.chewbacca_cf01.domain_name
    zone_id                = aws_cloudfront_distribution.chewbacca_cf01.hosted_zone_id
    evaluate_target_health = false
  }
}
