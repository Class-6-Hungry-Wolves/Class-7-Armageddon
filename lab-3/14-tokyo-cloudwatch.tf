############################################
# Lab 3: Tokyo CloudWatch Monitoring
############################################

#-----------------------------------------------------------------------------
# CloudWatch Log Group
#-----------------------------------------------------------------------------

resource "aws_cloudwatch_log_group" "chewbacca_log_group01" {
  name              = "/aws/ec2/${local.tokyo_prefix}-rds-app"
  retention_in_days = 7

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-log-group01"
  })
}

#-----------------------------------------------------------------------------
# CloudWatch Alarm for DB Connection Errors
#-----------------------------------------------------------------------------

resource "aws_cloudwatch_metric_alarm" "chewbacca_db_alarm01" {
  alarm_name          = "${local.tokyo_prefix}-db-connection-failure"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "DBConnectionErrors"
  namespace           = "Chewbacca/RDSApp"
  period              = 300
  statistic           = "Sum"
  threshold           = 3

  alarm_actions = [aws_sns_topic.chewbacca_sns_topic01.arn]
  ok_actions    = [aws_sns_topic.chewbacca_sns_topic01.arn]

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-alarm-db-fail"
  })
}

#-----------------------------------------------------------------------------
# SNS Topic
#-----------------------------------------------------------------------------

resource "aws_sns_topic" "chewbacca_sns_topic01" {
  name = "${local.tokyo_prefix}-db-incidents"

  tags = local.tokyo_tags
}

resource "aws_sns_topic_subscription" "chewbacca_sns_sub01" {
  topic_arn = aws_sns_topic.chewbacca_sns_topic01.arn
  protocol  = "email"
  endpoint  = var.sns_email_endpoint
}

#-----------------------------------------------------------------------------
# WAF Logging
#-----------------------------------------------------------------------------

resource "aws_cloudwatch_log_group" "chewbacca_waf_logs" {
  name              = "aws-waf-logs-${local.tokyo_prefix}-tokyo-webacl"
  retention_in_days = var.waf_log_retention_days

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-waf-logs"
  })
}

resource "aws_wafv2_web_acl_logging_configuration" "chewbacca_tokyo_waf_logging" {
  log_destination_configs = [aws_cloudwatch_log_group.chewbacca_waf_logs.arn]
  resource_arn            = aws_wafv2_web_acl.chewbacca_tokyo_waf01.arn
}
