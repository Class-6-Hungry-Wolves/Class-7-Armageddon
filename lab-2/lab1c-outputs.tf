output "bonus_b_alb_dns_name" {
  value       = try(aws_lb.alb.dns_name, null)
  description = "ALB DNS name (Bonus B)"
}

output "bonus_b_alb_arn" {
  value       = try(aws_lb.alb.arn, null)
  description = "ALB ARN (Bonus B)"
}

output "bonus_b_target_group_arn" {
  value       = try(aws_lb_target_group.app_tg.arn, null)
  description = "Target Group ARN (Bonus B)"
}

output "bonus_b_waf_arn" {
  value       = try(aws_wafv2_web_acl.alb_waf.arn, null)
  description = "WAF ARN for ALB (Bonus B) – null if WAF not created in this lab"
}

output "bonus_b_dashboard_name" {
  value       = try(aws_cloudwatch_dashboard.chewbacca.dashboard_name, null)
  description = "CloudWatch dashboard name (Bonus B) – null if not created"
}

output "bonus_b_alarm_name" {
  value       = try(aws_cloudwatch_metric_alarm.alb_5xx_alarm.alarm_name, null)
  description = "ALB 5XX alarm name (Bonus B) – null if not created"
}
