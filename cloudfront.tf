resource "aws_cloudfront_distribution" "lab_2a_cf" {
  enabled             = true
  comment             = "${local.name_prefix}-lab-2a-cloudfront"
  default_root_object = ""

  # Origin: ALB
  origin {
    domain_name = aws_lb.lab_2a_alb.dns_name
    origin_id   = "lab-2a-alb-origin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"   # switch to https-only when ALB has TLS
      origin_ssl_protocols   = ["TLSv1.2"]
    }

   # origin_custom_header {
   #  name  = local.lab_2a_origin_header_name
   # value = local.lab_2a_origin_header_value
   # }
  }

  default_cache_behavior {
    target_origin_id       = "lab-2a-alb-origin"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]

    compress = true

    forwarded_values {
      query_string = true

      cookies {
        forward = "all"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  web_acl_id = aws_wafv2_web_acl.lab_2a_cf_waf.arn

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-lab-2a-cf"
  })
}
