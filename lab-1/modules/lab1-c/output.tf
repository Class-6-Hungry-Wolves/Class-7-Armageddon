############################################
# EC2 Instance (Private Host)
############################################

# # Explanation: These outputs prove Chewbacca built private hyperspace lanes (endpoints) instead of public chaos.
# output "chewbacca_vpce_ssm_id" {
#   value = aws_vpc_endpoint.chewbacca_vpce_ssm01.id
# }

# output "chewbacca_vpce_logs_id" {
#   value = aws_vpc_endpoint.chewbacca_vpce_logs01.id
# }

# output "chewbacca_vpce_secrets_id" {
#   value = aws_vpc_endpoint.chewbacca_vpce_secrets01.id
# }

# output "chewbacca_vpce_s3_id" {
#   value = aws_vpc_endpoint.chewbacca_vpce_s3_gw01.id
# }

# output "chewbacca_private_ec2_instance_id_bonus" {
#   value = aws_instance.chewbacca_ec201_private_bonus.id
# }

# output "vpce_services_ids" {
#   value = [for service in data.aws_vpc_endpoint_service.vpce_services : service.id]
# }


############################################
# Output for Bonus B
############################################

# Explanation: Outputs are the mission coordinates — where to point your browser and your blasters.
output "chewbacca_alb_dns_name" {
  value = aws_lb.chewbacca_alb01.dns_name
}

output "chewbacca_app_fqdn" {
  value = "${var.app_subdomain}.${var.domain_name}"
}

output "chewbacca_target_group_arn" {
  value = aws_lb_target_group.chewbacca_tg01.arn
}

output "chewbacca_acm_cert_arn" {
  value = aws_acm_certificate.chewbacca_acm_cert01.arn
}

# output "chewbacca_waf_arn" {
#   value = var.enable_waf ? aws_wafv2_web_acl.chewbacca_waf01[0].arn : null
# }

output "chewbacca_dashboard_name" {
  value = aws_cloudwatch_dashboard.chewbacca_dashboard01.dashboard_name
}


############################################
# Output for Bonus C
############################################

# Explanation: Outputs are the nav computer readout—Chewbacca needs coordinates that humans can paste into browsers.
output "chewbacca_route53_zone_id" {
  value = local.chewbacca_zone_id
}

output "chewbacca_app_url_https" {
  value = "https://${var.app_subdomain}.${var.domain_name}"
}


###########################################
# Output for Bonus D
############################################

# Explanation: The apex URL is the front gate—humans type this when they forget subdomains.
output "chewbacca_apex_url_https" {
  value = "https://${var.domain_name}"
}

# Explanation: Log bucket name is where the footprints live—useful when hunting 5xx or WAF blocks.
output "chewbacca_alb_logs_bucket_name" {
  value = var.enable_alb_access_logs ? aws_s3_bucket.chewbacca_alb_logs_bucket01[0].bucket: null
}


###########################################
# Output for Bonus D
############################################

# Explanation: Coordinates for the WAF log destination—Chewbacca wants to know where the footprints landed.
output "chewbacca_waf_log_destination" {
  value = var.waf_log_destination
}

output "chewbacca_waf_cw_log_group_name" {
  value = var.waf_log_destination == "cloudwatch" ? aws_cloudwatch_log_group.chewbacca_waf_log_group01[0].name : null
}

output "chewbacca_waf_logs_s3_bucket" {
  value = var.waf_log_destination == "s3" ? aws_s3_bucket.chewbacca_alb_logs_bucket01[0].bucket : null
}

# output "chewbacca_waf_firehose_name" {
#   value = var.waf_log_destination == "firehose" ? aws_kinesis_firehose_delivery_stream.chewbacca_waf_firehose01[0].name : null
# }


###########################################
# Additional Output for Lab 2
############################################

output "chewbacca_https_listener01" {
  value = aws_lb_listener.chewbacca_https_listener01
}

output "chewbacca_tg01" {
  value = aws_lb_target_group.chewbacca_tg01
}

output "chewbacca_alb_sg01_id" {
  value = aws_security_group.chewbacca_alb_sg01.id
}
