############################################
# WAFv2 Web ACL (Basic managed rules)
############################################

# Explanation: Cloudfront scoped WAF is the immovable wall at the edge. It blocks unwanted traffic before it reaches your VPC.
resource "aws_wafv2_web_acl" "armageddon_cf_waf01" {
  provider = aws.us-east-1
  count    = var.enable_waf ? 1 : 0

  name  = "${var.project_name}-cf-waf01"
  scope = "CLOUDFRONT"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${var.project_name}-cf-waf01"
    sampled_requests_enabled   = true
  }

  # Explanation: AWS managed rules are like hiring Rebel commandos — they’ve seen every trick.
  rule {
    name     = "AWSManagedRulesCommonRuleSet"
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
      metric_name                = "${var.project_name}-cf-waf-common"
      sampled_requests_enabled   = true
    }
  }

  tags = {
    Name = "${var.project_name}-cf-waf01"
  }
}

############################################
# CloudWatch Alarm: ALB 5xx -> SNS
############################################

# Explanation: When the ALB starts throwing 5xx, that’s the Falcon coughing — page the on-call Wookiee.
resource "aws_cloudwatch_metric_alarm" "armageddon_alb_5xx_alarm01" {
  alarm_name          = "${var.project_name}-alb-5xx-alarm01"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.alb_5xx_evaluation_periods
  threshold           = var.alb_5xx_threshold
  period              = var.alb_5xx_period_seconds
  statistic           = "Sum"
  treat_missing_data  = "notBreaching" # By default, data is treated as missing which causes alarm to display in the insufficient data state. Setting to "notBreaching" treats missing data as not breaching and alarm will be displayed in "OK" state.

  namespace   = "AWS/ApplicationELB"
  metric_name = "HTTPCode_ELB_5XX_Count"

  dimensions = {
    LoadBalancer = aws_lb.app_lb.arn_suffix
  }

  alarm_actions = [aws_sns_topic.armageddon_sns_topic01.arn]

  tags = {
    Name = "${var.project_name}-alb-5xx-alarm01"
  }
}



############################################
# CloudWatch Dashboard 
############################################

# Explanation: Dashboards are your cockpit HUD — Chewbacca wants dials, not vibes.
resource "aws_cloudwatch_dashboard" "armageddon_dashboard01" {
  dashboard_name = "${var.project_name}-dashboard01"

  dashboard_body = jsonencode({
    widgets = [

      # ================================
      # Row 1
      # ================================

      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6
        properties = {
          metrics = [
            ["AWS/ApplicationELB", "RequestCount", "LoadBalancer", aws_lb.app_lb.arn_suffix],
            [".", "HTTPCode_ELB_5XX_Count", ".", aws_lb.app_lb.arn_suffix]
          ]
          period = 300
          stat   = "Sum"
          region = var.aws_region
          title  = "Armageddon ALB: Requests + ELB 5XX"
        }
      },

      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6
        properties = {
          metrics = [
            ["AWS/ApplicationELB", "TargetResponseTime", "LoadBalancer", aws_lb.app_lb.arn_suffix]
          ]
          period = 300
          stat   = "Average"
          region = var.aws_region
          title  = "Armageddon ALB: Target Response Time"
        }
      },

      # ================================
      # Row 2
      # ================================

      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6
        properties = {
          metrics = [
            ["AWS/ApplicationELB", "HTTPCode_ELB_5XX_Count", "LoadBalancer", aws_lb.app_lb.arn_suffix],
            [".", "HTTPCode_Target_5XX_Count", ".", aws_lb.app_lb.arn_suffix, "TargetGroup", aws_lb_target_group.rdsapp_tg01.arn_suffix]
          ]
          period = 60
          stat   = "Sum"
          region = var.aws_region
          title  = "ALB 5XX: ELB vs Targets"
        }
      },

      {
        type   = "metric"
        x      = 12
        y      = 6
        width  = 12
        height = 6
        properties = {
          metrics = [
            ["AWS/ApplicationELB", "HealthyHostCount", "LoadBalancer", aws_lb.app_lb.arn_suffix, "TargetGroup", aws_lb_target_group.rdsapp_tg01.arn_suffix],
            [".", "UnHealthyHostCount", ".", aws_lb.app_lb.arn_suffix, "TargetGroup", aws_lb_target_group.rdsapp_tg01.arn_suffix]
          ]
          period = 60
          stat   = "Average"
          region = var.aws_region
          title  = "Target Health (Healthy vs Unhealthy)"
        }
      },

      # ================================
      # Row 3
      # ================================

      {
        type   = "metric"
        x      = 0
        y      = 12
        width  = 12
        height = 6
        properties = {
          metrics = [
            ["AWS/ApplicationELB", "HTTPCode_ELB_4XX_Count", "LoadBalancer", aws_lb.app_lb.arn_suffix],
            [".", "HTTPCode_Target_4XX_Count", ".", aws_lb.app_lb.arn_suffix, "TargetGroup", aws_lb_target_group.rdsapp_tg01.arn_suffix]
          ]
          period = 60
          stat   = "Sum"
          region = var.aws_region
          title  = "ALB 4XX: ELB vs Targets"
        }
      },

      {
        type   = "metric"
        x      = 12
        y      = 12
        width  = 12
        height = 6
        properties = {
          metrics = [
            ["Lab/RDSApp", "DBConnectionErrors"]
          ]
          period = 60
          stat   = "Sum"
          region = var.aws_region
          title  = "App: DBConnectionErrors"
        }
      }

    ]
  })
}
