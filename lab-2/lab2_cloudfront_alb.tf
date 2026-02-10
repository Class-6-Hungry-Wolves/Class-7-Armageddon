############################################
# Lab 2 - CloudFront Distribution -> ALB
############################################

resource "aws_cloudfront_distribution" "maxpayne_cf" {
  enabled         = true
  is_ipv6_enabled = true
  comment         = "${local.project_name_prefix}-${local.environment}-cf"

  aliases = [
    var.domain_name,
    "${var.app_subdomain}.${var.domain_name}"
  ]

  origin {
    domain_name = aws_lb.alb.dns_name
    origin_id   = "alb-origin"

    custom_header {
      name  = "X-Chewbacca-Growl"
      value = random_password.cf_origin_secret.result
    }

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    target_origin_id       = "alb-origin"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods  = ["GET", "HEAD", "OPTIONS"]

    compress = true

    cache_policy_id          = data.aws_cloudfront_cache_policy.caching_optimized.id
    origin_request_policy_id = data.aws_cloudfront_origin_request_policy.all_viewer.id
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.cloudfront_acm_cert_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  # Lab 2: WAF enforcement happens at CloudFront edge
  web_acl_id = try(aws_wafv2_web_acl.cf_waf.arn, null)

  price_class = "PriceClass_100"

  depends_on = [
    random_password.cf_origin_secret
  ]
}
