# Explanation: Outputs are your mission report—what got built and where to find it.
output "shinjuku_vpc_id" {
  value = aws_vpc.shinjuku-vpc.id
}

output "shinjuku_vpc_cidr_block" {
  value = aws_vpc.shinjuku-vpc.cidr_block
}

output "shinjuku_public_subnet_ids" {
  value = [for i in aws_subnet.shinjuku-public-subnet : i.id]
}

output "shinjuku_private_subnet_ids" {
  value = [for i in aws_subnet.shinjuku-private-subnet : i.id]
}

output "shinjuku_database_subnet_ids" {
  value = [for i in aws_subnet.shinjuku-database-subnet : i.id]
}

output "shinjuku_tgw_id" {
  value = aws_ec2_transit_gateway.shinjuku_tgw01.id
}

output "shinjuku_tgw_rtb_id" {
  value = aws_ec2_transit_gateway_route_table.shinjuku_tgw01_rtb01.id 
}

output "shinjuku_tgw_vpc_attachment_id" {
  value = aws_ec2_transit_gateway_vpc_attachment.shinjuku_attach_tokyo_vpc01.id
}


output "shinjuku_app_security_group_id" {
  value = aws_security_group.shinjuku_app_sg.id
}

output "shinjuku_rds_security_group_id" {
  value = aws_security_group.shinjuku_rds_sg.id
}

output "shinjuku_packer_security_group_id" {
  value = aws_security_group.shinjuku_packer_sg.id
}

output "packer_builder_instance_profile_name" {
  value = aws_iam_instance_profile.packer_builder_instance_profile.name
}

# output "shinjuku_ec2_instance_id" {
#   value = var.enable_asg_creation ? aws_instance.shinjuku_ec2_instance[0].id : null
# }

# output "shinjuku_ec2_private_ip" {
#   value = var.enable_asg_creation ? aws_instance.shinjuku_ec2_instance[0].private_ip : null
# }
output "shinjuku_rds_endpoint" {
  value = aws_db_instance.shinjuku_rds01.address
}

output "cloudwatch_sns_topic_arn" {
  value = aws_sns_topic.armageddon_sns_topic01.arn
}

output "armageddon_log_group_name" {
  value = aws_cloudwatch_log_group.shinjuku_log_group01.name
}

output "armageddon_vpce_ssm_id" {
  value = aws_vpc_endpoint.shinjuku_vpce_ssm01.id
}

output "armageddon_vpce_logs_id" {
  value = aws_vpc_endpoint.shinjuku_vpce_logs01.id
}

output "armageddon_vpce_secrets_id" {
  value = aws_vpc_endpoint.shinjuku_vpce_secrets01.id
}

output "armageddon_vpce_s3_id" {
  value = aws_vpc_endpoint.shinjuku_vpce_s3_gw01.id
}

output "rds_app_alb_dns_name" {
  value = "http://${aws_lb.app_lb.dns_name}"
}

output "rds_app_alb_arn" {
  value = aws_lb.app_lb.arn
}

output "armageddon_rds_app_fqdn" {
  value = "http://${var.app_subdomain}.${var.root_domain_name}"
}


output "armageddon_target_group_arn" {
  value = aws_lb_target_group.rdsapp_tg01.arn
}

output "armageddon_acm_cert_arn" {
  value = aws_acm_certificate.armageddon_cf_cert01.arn
}

output "armageddon_waf_arn" {
  value = var.enable_waf ? aws_wafv2_web_acl.armageddon_cf_waf01[0].arn : null
}

output "armageddon_dashboard_name" {
  value = aws_cloudwatch_dashboard.armageddon_dashboard01.dashboard_name
}

output "armageddon_s3_alb_logs_bucket" {
  value = aws_s3_bucket.armageddon_alb_logs_bucket01[0].bucket
}


output "armageddon_waf_log_destination" {
  value = var.waf_log_destination
}

output "armageddon_waf_cw_log_group_name" {
  value = var.waf_log_destination == "cloudwatch" ? aws_cloudwatch_log_group.armageddon_waf_log_group01[0].name : null
}

output "armageddon_waf_logs_s3_bucket" {
  value = var.waf_log_destination == "s3" ? aws_s3_bucket.armageddon_waf_logs_bucket01[0].bucket : null
}

output "armageddon_waf_firehose_name" {
  value = var.waf_log_destination == "firehose" ? aws_kinesis_firehose_delivery_stream.armageddon_waf_firehose01[0].name : null
}


output "armageddon_waf_logs_firehose_bucket" {
  value = var.waf_log_destination == "firehose" ? aws_s3_bucket.armageddon_firehose_waf_dest_bucket01[0].bucket : null
}


output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.armageddon_cf01.id
}