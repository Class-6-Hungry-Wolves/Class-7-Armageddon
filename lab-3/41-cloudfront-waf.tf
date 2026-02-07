############################################
# Lab 3: CloudFront WAF (Edge Protection)
# Must be in us-east-1 with scope = "CLOUDFRONT"
############################################

resource "aws_wafv2_web_acl" "chewbacca_cf_waf01" {
  provider = aws.useast1

  name        = "${local.tokyo_prefix}-cf-waf01"
  description = "CloudFront WAF for Chewbacca Multi-Region"
  scope       = "CLOUDFRONT"

  default_action {
    allow {}
  }

  # Rule 1: Block known malicious IPs
  rule {
    name     = "AWS-AWSManagedRulesAmazonIpReputationList"
    priority = 0

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAmazonIpReputationList"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "${local.tokyo_prefix}-cf-ip-reputation"
      sampled_requests_enabled   = true
    }
  }

  # Rule 2: Common attack patterns
  rule {
    name     = "AWS-AWSManagedRulesCommonRuleSet"
    priority = 1

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "${local.tokyo_prefix}-cf-common-rules"
      sampled_requests_enabled   = true
    }
  }

  # Rule 3: Known bad inputs (Log4j, etc.)
  rule {
    name     = "AWS-AWSManagedRulesKnownBadInputsRuleSet"
    priority = 2

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "${local.tokyo_prefix}-cf-bad-inputs"
      sampled_requests_enabled   = true
    }
  }

  # Rule 4: SQL injection
  rule {
    name     = "AWS-AWSManagedRulesSQLiRuleSet"
    priority = 3

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "${local.tokyo_prefix}-cf-sqli-rules"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${local.tokyo_prefix}-cf-waf"
    sampled_requests_enabled   = true
  }

  tags = merge(local.common_tags, {
    Name = "${local.tokyo_prefix}-cf-waf01"
  })
}
