# WAF Web ACL for CloudFront 

resource "aws_wafv2_web_acl" "lab_2a_cf_waf" {
  name  = "${local.name_prefix}-lab-2a-cf-waf"
  scope = "CLOUDFRONT"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${local.name_prefix}-lab-2a-cf-waf"
    sampled_requests_enabled   = true
  }

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
      metric_name                = "${local.name_prefix}-lab-2a-cf-waf-common"
      sampled_requests_enabled   = true
    }
  }
}