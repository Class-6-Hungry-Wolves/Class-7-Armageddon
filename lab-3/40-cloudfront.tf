############################################
# Lab 3: CloudFront Distribution with Origin Group Failover
# Primary: Tokyo ALB | Secondary: São Paulo ALB
############################################

resource "aws_cloudfront_distribution" "chewbacca_cf01" {
  enabled         = true
  is_ipv6_enabled = true
  comment         = "${local.tokyo_prefix}-cf01-multi-region"

  #-----------------------------------------------------------------------------
  # Origin Group for Failover (Tokyo primary, São Paulo secondary)
  #-----------------------------------------------------------------------------
  origin_group {
    origin_id = "multi-region-failover"

    failover_criteria {
      status_codes = [500, 502, 503, 504]
    }

    member {
      origin_id = "tokyo-alb"
    }

    member {
      origin_id = "saopaulo-alb"
    }
  }

  #-----------------------------------------------------------------------------
  # Tokyo ALB Origin (Primary)
  #-----------------------------------------------------------------------------
  origin {
    origin_id   = "tokyo-alb"
    domain_name = aws_lb.chewbacca_alb01.dns_name

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }

    # Secret handshake - CloudFront whispers the secret growl
    custom_header {
      name  = "X-Chewbacca-Growl"
      value = random_password.chewbacca_origin_header_value01.result
    }
  }

  #-----------------------------------------------------------------------------
  # São Paulo ALB Origin (Failover)
  #-----------------------------------------------------------------------------
  origin {
    origin_id   = "saopaulo-alb"
    domain_name = aws_lb.liberdade_alb01.dns_name

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }

    # Same secret handshake for failover origin
    custom_header {
      name  = "X-Chewbacca-Growl"
      value = random_password.chewbacca_origin_header_value01.result
    }
  }

  #-----------------------------------------------------------------------------
  # Default Cache Behavior - Uses Origin Group for Failover
  #-----------------------------------------------------------------------------
  default_cache_behavior {
    target_origin_id       = "multi-region-failover"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods  = ["GET", "HEAD"]

    # Use AWS managed policies (API = no caching by default)
    cache_policy_id          = data.aws_cloudfront_cache_policy.chewbacca_caching_disabled.id
    origin_request_policy_id = data.aws_cloudfront_origin_request_policy.chewbacca_orp_all_viewer.id
  }

  #-----------------------------------------------------------------------------
  # Static Content Behavior - Aggressive Caching
  #-----------------------------------------------------------------------------
  ordered_cache_behavior {
    path_pattern           = "/static/*"
    target_origin_id       = "multi-region-failover"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]

    cache_policy_id            = aws_cloudfront_cache_policy.chewbacca_cache_static01.id
    origin_request_policy_id   = aws_cloudfront_origin_request_policy.chewbacca_orp_static01.id
    response_headers_policy_id = aws_cloudfront_response_headers_policy.chewbacca_rsp_static01.id
  }

  #-----------------------------------------------------------------------------
  # WAF at CloudFront Edge
  #-----------------------------------------------------------------------------
  web_acl_id = aws_wafv2_web_acl.chewbacca_cf_waf01.arn

  #-----------------------------------------------------------------------------
  # Aliases (Custom Domain Names)
  #-----------------------------------------------------------------------------
  aliases = [
    var.domain_name,
    "${var.app_subdomain}.${var.domain_name}"
  ]

  #-----------------------------------------------------------------------------
  # TLS Certificate (must be in us-east-1)
  #-----------------------------------------------------------------------------
  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.chewbacca_cf_cert.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  #-----------------------------------------------------------------------------
  # No Geographic Restrictions
  #-----------------------------------------------------------------------------
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = merge(local.common_tags, {
    Name = "${local.tokyo_prefix}-cf01"
  })

  depends_on = [aws_acm_certificate_validation.chewbacca_cf_cert_validated]
}
