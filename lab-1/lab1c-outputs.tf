output "bonus_b_alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "bonus_b_alb_arn" {
  value = aws_lb.alb.arn
}

output "bonus_b_target_group_arn" {
  value = aws_lb_target_group.app_tg.arn
}

output "bonus_b_waf_arn" {
  value = aws_wafv2_web_acl.alb_waf.arn
}

output "bonus_b_dashboard_name" {
  value = aws_cloudwatch_dashboard.chewbacca.dashboard_name
}

output "bonus_b_alarm_name" {
  value = aws_cloudwatch_metric_alarm.alb_5xx_alarm.alarm_name
}
