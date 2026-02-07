############################################
# Lab 3: São Paulo Regional WAF (for ALB)
############################################

resource "aws_wafv2_web_acl" "liberdade_sp_waf01" {
  provider    = aws.saopaulo
  name        = "${local.saopaulo_prefix}-sp-waf01"
  description = "WAF for Liberdade Sao Paulo ALB"
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  # Rule 1: IP Reputation List
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
      metric_name                = "${local.saopaulo_prefix}-sp-ip-reputation"
      sampled_requests_enabled   = true
    }
  }

  # Rule 2: Common Rule Set
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
      metric_name                = "${local.saopaulo_prefix}-sp-common-rules"
      sampled_requests_enabled   = true
    }
  }

  # Rule 3: Known Bad Inputs
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
      metric_name                = "${local.saopaulo_prefix}-sp-bad-inputs"
      sampled_requests_enabled   = true
    }
  }

  # Rule 4: SQLi Rule Set
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
      metric_name                = "${local.saopaulo_prefix}-sp-sqli-rules"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${local.saopaulo_prefix}-sp-waf"
    sampled_requests_enabled   = true
  }

  tags = merge(local.saopaulo_tags, {
    Name = "${local.saopaulo_prefix}-sp-waf01"
  })
}

resource "aws_wafv2_web_acl_association" "liberdade_sp_waf_alb_assoc" {
  provider     = aws.saopaulo
  resource_arn = aws_lb.liberdade_alb01.arn
  web_acl_arn  = aws_wafv2_web_acl.liberdade_sp_waf01.arn
}
