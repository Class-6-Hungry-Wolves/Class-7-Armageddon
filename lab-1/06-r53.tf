############################################
# Hosted Zone (optional creation)
############################################

# Explanation: A hosted zone is like claiming Kashyyyk in DNS—names here become law across the galaxy.
resource "aws_route53_zone" "chewbacca_zone01" {
  count = var.manage_route53_in_terraform ? 1 : 0

  name = local.chewbacca_zone_name

  tags = {
    Name = "${var.project_name}-zone01"
  }
}


############################################
# ALIAS record: app.chewbacca-growl.com -> ALB
############################################

# Explanation: This is the holographic sign outside the cantina—app.chewbacca-growl.com points to your ALB.
resource "aws_route53_record" "chewbacca_app_alias01" {
  zone_id = local.chewbacca_zone_id
  name    = local.chewbacca_app_fqdn
  type    = "A"

  alias {
    name                   = aws_lb.chewbacca_alb01.dns_name
    zone_id                = aws_lb.chewbacca_alb01.zone_id
    evaluate_target_health = true
  }
}


############################################
# Bonus B - Route53 Zone Apex + ALB Access Logs to S3
# Route53: Zone Apex (root domain) -> ALB
############################################

# Explanation: The zone apex is the throne room—chewbacca-growl.com itself should lead to the ALB.
resource "aws_route53_record" "chewbacca_apex_alias01" {
  zone_id = local.chewbacca_zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_lb.chewbacca_alb01.dns_name
    zone_id                = aws_lb.chewbacca_alb01.zone_id
    evaluate_target_health = true
  }
}


############################################
# ACM DNS Validation Records via R53
############################################

# ACM asks “prove you own this planet” — DNS validation is Chewbacca roaring in the right place.
resource "aws_route53_record" "chewbacca_acm_validation_records01" {
  for_each = var.certificate_validation_method == "DNS" ? {
    for dvo in aws_acm_certificate.chewbacca_acm_cert01.domain_validation_options :
    dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  } : {}

  zone_id = local.chewbacca_zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 60

  records = [each.value.record]
}
