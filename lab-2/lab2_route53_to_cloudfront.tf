resource "aws_route53_record" "apex_cf" {
  count   = var.enable_route53 && var.route53_hosted_zone_id != "" && var.domain_name != "" ? 1 : 0
  zone_id = var.route53_hosted_zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cf.domain_name
    zone_id                = aws_cloudfront_distribution.cf.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "app_cf" {
  count   = var.enable_route53 && var.route53_hosted_zone_id != "" && var.domain_name != "" && var.app_subdomain != "" ? 1 : 0
  zone_id = var.route53_hosted_zone_id
  name    = "${var.app_subdomain}.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cf.domain_name
    zone_id                = aws_cloudfront_distribution.cf.hosted_zone_id
    evaluate_target_health = false
  }
}
