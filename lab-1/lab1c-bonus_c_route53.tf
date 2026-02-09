locals {
  route53_enabled    = var.manage_route53_in_terraform && var.domain_name != ""
  chewbacca_app_fqdn = var.domain_name != "" ? "${var.app_subdomain}.${var.domain_name}" : ""
}

resource "aws_route53_zone" "chewbacca_zone" {
  count = local.route53_enabled ? 1 : 0
  name  = var.domain_name
}

locals {
  chewbacca_zone_id = local.route53_enabled ? aws_route53_zone.chewbacca_zone[0].zone_id : (var.route53_hosted_zone_id != "" ? var.route53_hosted_zone_id : "")
}

resource "aws_acm_certificate" "app_cert" {
  count             = local.route53_enabled ? 1 : 0
  domain_name       = local.chewbacca_app_fqdn
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "acm_validation" {
  count   = local.route53_enabled ? 1 : 0
  zone_id = local.chewbacca_zone_id

  name    = tolist(aws_acm_certificate.app_cert[0].domain_validation_options)[0].resource_record_name
  type    = tolist(aws_acm_certificate.app_cert[0].domain_validation_options)[0].resource_record_type
  records = [tolist(aws_acm_certificate.app_cert[0].domain_validation_options)[0].resource_record_value]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "app_cert_validation_dns" {
  count                   = local.route53_enabled ? 1 : 0
  certificate_arn         = aws_acm_certificate.app_cert[0].arn
  validation_record_fqdns = [aws_route53_record.acm_validation[0].fqdn]
}

############################################
# ALIAS record: app.<domain> -> ALB
############################################

resource "aws_route53_record" "app_alias" {
  count   = local.route53_enabled ? 1 : 0
  zone_id = local.chewbacca_zone_id
  name    = local.chewbacca_app_fqdn
  type    = "A"

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}

# Explanation: HTTPS listener is the real hangar bay — TLS terminates here, then traffic goes to private targets.
resource "aws_lb_listener" "https_443" {
  count             = local.route53_enabled ? 1 : 0
  load_balancer_arn = aws_lb.alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = aws_acm_certificate.app_cert[0].arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }

  depends_on = [
    aws_acm_certificate_validation.app_cert_validation_dns
  ]
}
