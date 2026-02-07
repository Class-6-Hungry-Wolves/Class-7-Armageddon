############################################
# Lab 3: CloudFront Cache Policies
############################################

#-----------------------------------------------------------------------------
# AWS Managed Policies (Data Sources)
#-----------------------------------------------------------------------------

data "aws_cloudfront_cache_policy" "chewbacca_caching_disabled" {
  name = "Managed-CachingDisabled"
}

data "aws_cloudfront_origin_request_policy" "chewbacca_orp_all_viewer" {
  name = "Managed-AllViewerExceptHostHeader"
}

#-----------------------------------------------------------------------------
# Custom Cache Policy: Static Content (Aggressive)
#-----------------------------------------------------------------------------

resource "aws_cloudfront_cache_policy" "chewbacca_cache_static01" {
  name        = "${local.tokyo_prefix}-cache-static01"
  comment     = "Aggressive caching for /static/* - 1 day default, 1 year max"
  default_ttl = 86400     # 1 day
  max_ttl     = 31536000  # 1 year
  min_ttl     = 0

  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }

    query_strings_config {
      query_string_behavior = "none"
    }

    headers_config {
      header_behavior = "none"
    }

    enable_accept_encoding_gzip   = true
    enable_accept_encoding_brotli = true
  }
}

#-----------------------------------------------------------------------------
# Custom Origin Request Policy: Static Content (Minimal)
#-----------------------------------------------------------------------------

resource "aws_cloudfront_origin_request_policy" "chewbacca_orp_static01" {
  name    = "${local.tokyo_prefix}-orp-static01"
  comment = "Minimal forwarding for static assets"

  cookies_config {
    cookie_behavior = "none"
  }

  query_strings_config {
    query_string_behavior = "none"
  }

  headers_config {
    header_behavior = "none"
  }
}

#-----------------------------------------------------------------------------
# Custom Response Headers Policy: Static Content
#-----------------------------------------------------------------------------

resource "aws_cloudfront_response_headers_policy" "chewbacca_rsp_static01" {
  name    = "${local.tokyo_prefix}-rsp-static01"
  comment = "Add explicit Cache-Control for static content"

  custom_headers_config {
    items {
      header   = "Cache-Control"
      override = true
      value    = "public, max-age=86400, immutable"
    }
  }
}

#-----------------------------------------------------------------------------
# AWS Managed Policies for Honors (Origin-Driven Caching)
#-----------------------------------------------------------------------------

data "aws_cloudfront_cache_policy" "chewbacca_use_origin_headers01" {
  name = "Managed-CachingOptimized"
}

data "aws_cloudfront_origin_request_policy" "chewbacca_orp_all_viewer01" {
  name = "Managed-AllViewer"
}
