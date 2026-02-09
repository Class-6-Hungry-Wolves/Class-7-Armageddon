# Explanation: Outputs are your mission report—what got built and where to find it.
output "lab_1a_vpc_id" {
  value = aws_vpc.lab_1a_vpc.id
}

output "lab_1a_public_subnet_ids" {
  value = [for i in aws_subnet.lab_1a_public_subnet : i.id]
}

output "lab_1a_private_subnet_ids" {
  value = [for i in aws_subnet.lab_1a_database_subnet : i.id]
}

output "class_7_ec2_instance_id" {
  value = aws_instance.class_7_instance_from_terraform.id
}

output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "alb_arn" {
  value = aws_lb.alb.arn
}

output "alb_target_group_arn" {
  value = aws_lb_target_group.app_tg.arn
}

output "waf_arn" {
  value = aws_wafv2_web_acl.alb_waf.arn
}

output "route53_zone_id" {
  value = try(local.chewbacca_zone_id, "")
}

output "alb_https_url" {
  value = local.route53_enabled ? "https://${local.chewbacca_app_fqdn}" : "https://${aws_lb.alb.dns_name}"
}

output "apex_url_https" {
  value = "https://${var.domain_name}"
}

output "alb_logs_bucket_name" {
  value = var.enable_alb_access_logs ? aws_s3_bucket.alb_logs_bucket[0].bucket : null
}

output "chewbacca_waf_log_destination" {
  value = var.waf_log_destination
}

output "chewbacca_waf_cw_log_group_name" {
  value = var.waf_log_destination == "cloudwatch" ? aws_cloudwatch_log_group.chewbacca_waf_log_group01[0].name : null
}

output "chewbacca_waf_logs_s3_bucket" {
  value = var.waf_log_destination == "s3" ? aws_s3_bucket.chewbacca_waf_logs_bucket01[0].bucket : null
}

output "chewbacca_waf_firehose_name" {
  value = var.waf_log_destination == "firehose" ? aws_kinesis_firehose_delivery_stream.chewbacca_waf_firehose01[0].name : null
}

# output "chewbacca_ec2_instance_id" {
#   value = aws_instance.chewbacca_ec201.id
# }

# output "chewbacca_rds_endpoint" {
#   value = aws_db_instance.chewbacca_rds01.address
# }

# output "chewbacca_sns_topic_arn" {
#   value = aws_sns_topic.chewbacca_sns_topic01.arn
# }

# output "chewbacca_log_group_name" {
#   value = aws_cloudwatch_log_group.chewbacca_log_group01.name
# }
