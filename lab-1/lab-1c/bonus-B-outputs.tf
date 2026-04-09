# Explanation: Outputs are the mission coordinates — where to point your browser and your blasters.
output "armageddon_alb_dns_name" {
  value = aws_lb.armageddon-alb.dns_name
}

output "armageddon_app_fqdn" {
  value = "${var.app_subdomain}.${var.domain_name}"
}

output "armageddon_target_group_arn" {
  value = aws_lb_target_group.armageddon-tg.arn
}

output "armageddon_acm_cert_arn" {
  value = aws_acm_certificate.armageddon-acm-cert.arn
}

output "armageddon_waf_arn" {
  value = var.enable_waf ? aws_wafv2_web_acl.armageddon-waf[0].arn : null
}

output "armageddon_dashboard_name" {
  value = aws_cloudwatch_dashboard.armageddon-dashboard.dashboard_name
}