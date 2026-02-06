# Explanation: Outputs are your mission report—what got built and where to find it.
output "lab_1_vpc_id" {
  value = aws_vpc.lab-1-vpc.id
}

output "lab_1_public_subnet_ids" {
  value = [for i in aws_subnet.lab-1-public-subnet : i.id]
}

output "lab_1_private_subnet_ids" {
  value = [for i in aws_subnet.lab-1-private-subnet : i.id]
}

output "lab_1_database_subnet_ids" {
  value = [for i in aws_subnet.lab-1-database-subnet : i.id]
}


output "lab1_ec2_security_group_id" {
  value = aws_security_group.lab_1_ec2_sg.id
}

output "lab1_rds_security_group_id" {
  value = aws_security_group.lab_1_rds_sg.id
}

output "lab1_packer_security_group_id" {
  value = aws_security_group.lab_1_packer_sg.id
}

output "lab1_ec2_instance_id" {
  value = var.enable_runtime_instance_creation ? aws_instance.lab1_ec2_instance[0].id : null
}

output "lab1_ec2_private_ip" {
  value = var.enable_runtime_instance_creation ? aws_instance.lab1_ec2_instance[0].private_ip : null
}
output "lab1_rds_endpoint" {
  value = aws_db_instance.lab1-rds01.address
}

output "cloudwatch_sns_topic_arn" {
  value = aws_sns_topic.armageddon_sns_topic01.arn
}

output "armageddon_log_group_name" {
  value = aws_cloudwatch_log_group.lab1_log_group01.name
}

output "packer_builder_instance_profile_name" {
  value = aws_iam_instance_profile.packer_builder_instance_profile.name
}


output "armageddon_vpce_ssm_id" {
  value = aws_vpc_endpoint.lab1_vpce_ssm01.id
}

output "armageddon_vpce_logs_id" {
  value = aws_vpc_endpoint.lab1_vpce_logs01.id
}

output "armageddon_vpce_secrets_id" {
  value = aws_vpc_endpoint.lab1_vpce_secrets01.id
}

output "armageddon_vpce_s3_id" {
  value = aws_vpc_endpoint.lab1_vpce_s3_gw01.id
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
  value = aws_acm_certificate.armageddon_cert01.arn
}

output "armageddon_waf_arn" {
  value = var.enable_waf ? aws_wafv2_web_acl.armageddon_waf01[0].arn : null
}

output "armageddon_dashboard_name" {
  value = aws_cloudwatch_dashboard.armageddon_dashboard01.dashboard_name
}

output "armageddon_s3_alb_logs_bucket" {
  value = aws_s3_bucket.armageddon_alb_logs_bucket01[0].bucket
}