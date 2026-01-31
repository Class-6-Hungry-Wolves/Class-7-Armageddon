locals {
  armageddon_fqdn = "${var.app_subdomain}.${var.root_domain_name}"
}

# ACM Certificate for armageddon RDS Notes app
resource "aws_acm_certificate" "armageddon_cert01" {
  domain_name       = local.armageddon_fqdn
  validation_method = "DNS"

  tags = {
    Name = "${var.project_name}-armageddon-cert"
  }
  
}


# Already existing Route53 Hosted Zone for hungrywolves.click
data "aws_route53_zone" "hungry_wolves_main_zone" {
  name         = var.root_domain_name
  private_zone = false
}



resource "aws_route53_record" "armageddon_cert_validation_record01" {
  for_each = ( var.manage_acm_validation_records && var.certificate_validation_method == "DNS" ) ? {
    for dvo in aws_acm_certificate.armageddon_cert01.domain_validation_options : dvo.domain_name => {
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



resource "aws_acm_certificate_validation" "armageddon_cert01" {
  certificate_arn         = aws_acm_certificate.armageddon_cert01.arn
  validation_record_fqdns = [for r in aws_route53_record.armageddon_cert_validation_record01 : r.fqdn]
}
