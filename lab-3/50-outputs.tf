############################################
# Lab 3: Outputs for Verification
############################################

#-----------------------------------------------------------------------------
# TOKYO VPC OUTPUTS
#-----------------------------------------------------------------------------

output "tokyo_vpc_id" {
  description = "ID of the Tokyo VPC"
  value       = aws_vpc.chewbacca_vpc01.id
}

output "tokyo_vpc_cidr" {
  description = "CIDR of the Tokyo VPC"
  value       = aws_vpc.chewbacca_vpc01.cidr_block
}

output "tokyo_public_subnet_ids" {
  description = "IDs of Tokyo public subnets"
  value = [
    aws_subnet.chewbacca_public_subnet01.id,
    aws_subnet.chewbacca_public_subnet02.id
  ]
}

output "tokyo_private_subnet_ids" {
  description = "IDs of Tokyo private subnets"
  value = [
    aws_subnet.chewbacca_private_subnet01.id,
    aws_subnet.chewbacca_private_subnet02.id
  ]
}

#-----------------------------------------------------------------------------
# SAO PAULO VPC OUTPUTS
#-----------------------------------------------------------------------------

output "saopaulo_vpc_id" {
  description = "ID of the Sao Paulo VPC"
  value       = aws_vpc.liberdade_vpc01.id
}

output "saopaulo_vpc_cidr" {
  description = "CIDR of the Sao Paulo VPC"
  value       = aws_vpc.liberdade_vpc01.cidr_block
}

output "saopaulo_public_subnet_ids" {
  description = "IDs of Sao Paulo public subnets"
  value = [
    aws_subnet.liberdade_public_subnet01.id,
    aws_subnet.liberdade_public_subnet02.id
  ]
}

output "saopaulo_private_subnet_ids" {
  description = "IDs of Sao Paulo private subnets"
  value = [
    aws_subnet.liberdade_private_subnet01.id,
    aws_subnet.liberdade_private_subnet02.id
  ]
}

#-----------------------------------------------------------------------------
# EC2 OUTPUTS
#-----------------------------------------------------------------------------

output "tokyo_ec2_instance_id" {
  description = "ID of the Tokyo EC2 instance"
  value       = aws_instance.chewbacca_ec201.id
}

output "saopaulo_ec2_instance_id" {
  description = "ID of the Sao Paulo EC2 instance"
  value       = aws_instance.liberdade_ec201.id
}

#-----------------------------------------------------------------------------
# RDS OUTPUTS (TOKYO ONLY - APPI COMPLIANCE)
#-----------------------------------------------------------------------------

output "tokyo_rds_endpoint" {
  description = "RDS endpoint address (Tokyo only - APPI compliance)"
  value       = aws_db_instance.chewbacca_rds01.address
}

output "tokyo_rds_port" {
  description = "RDS port number"
  value       = aws_db_instance.chewbacca_rds01.port
}

output "tokyo_rds_identifier" {
  description = "RDS instance identifier"
  value       = aws_db_instance.chewbacca_rds01.identifier
}

output "appi_compliance_status" {
  description = "APPI Compliance: RDS only in Tokyo"
  value       = "COMPLIANT - All PHI data stored exclusively in Tokyo (ap-northeast-1)"
}

#-----------------------------------------------------------------------------
# ALB OUTPUTS
#-----------------------------------------------------------------------------

output "tokyo_alb_dns_name" {
  description = "DNS name of Tokyo ALB"
  value       = aws_lb.chewbacca_alb01.dns_name
}

output "saopaulo_alb_dns_name" {
  description = "DNS name of Sao Paulo ALB"
  value       = aws_lb.liberdade_alb01.dns_name
}

#-----------------------------------------------------------------------------
# TRANSIT GATEWAY OUTPUTS
#-----------------------------------------------------------------------------

output "tokyo_tgw_id" {
  description = "ID of Tokyo Transit Gateway (Shinjuku Hub)"
  value       = aws_ec2_transit_gateway.shinjuku_tgw01.id
}

output "saopaulo_tgw_id" {
  description = "ID of Sao Paulo Transit Gateway (Liberdade Spoke)"
  value       = aws_ec2_transit_gateway.liberdade_tgw01.id
}

output "tgw_peering_attachment_id" {
  description = "ID of TGW peering attachment"
  value       = aws_ec2_transit_gateway_peering_attachment.shinjuku_to_liberdade_peer01.id
}

#-----------------------------------------------------------------------------
# CLOUDFRONT OUTPUTS
#-----------------------------------------------------------------------------

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  value       = aws_cloudfront_distribution.chewbacca_cf01.id
}

output "cloudfront_domain_name" {
  description = "CloudFront distribution domain name"
  value       = aws_cloudfront_distribution.chewbacca_cf01.domain_name
}

output "cloudfront_origin_group" {
  description = "CloudFront origin group for failover"
  value       = "multi-region-failover (Tokyo primary, Sao Paulo secondary)"
}

#-----------------------------------------------------------------------------
# APPLICATION URLs
#-----------------------------------------------------------------------------

output "app_url" {
  description = "Application URL via CloudFront"
  value       = "https://${var.app_subdomain}.${var.domain_name}"
}

output "root_url" {
  description = "Root domain URL via CloudFront"
  value       = "https://${var.domain_name}"
}

#-----------------------------------------------------------------------------
# SECURITY OUTPUTS
#-----------------------------------------------------------------------------

output "tokyo_rds_sg_id" {
  description = "ID of Tokyo RDS security group"
  value       = aws_security_group.chewbacca_rds_sg01.id
}

output "origin_cloaking_enabled" {
  description = "Origin cloaking status"
  value       = "ENABLED - Both ALBs only accept CloudFront traffic with X-Chewbacca-Growl header"
}

#-----------------------------------------------------------------------------
# MONITORING OUTPUTS
#-----------------------------------------------------------------------------

output "tokyo_sns_topic_arn" {
  description = "ARN of Tokyo SNS topic for alerts"
  value       = aws_sns_topic.chewbacca_sns_topic01.arn
}

output "tokyo_log_group_name" {
  description = "Name of Tokyo CloudWatch log group"
  value       = aws_cloudwatch_log_group.chewbacca_log_group01.name
}

#-----------------------------------------------------------------------------
# VERIFICATION COMMANDS
#-----------------------------------------------------------------------------

output "verification_commands" {
  description = "Commands to verify the deployment"
  value = {
    rds_tokyo_check    = "aws rds describe-db-instances --region ap-northeast-1 --query 'DBInstances[].DBInstanceIdentifier'"
    rds_saopaulo_check = "aws rds describe-db-instances --region sa-east-1 --query 'DBInstances[].DBInstanceIdentifier' # Should be empty"
    tgw_peering_check  = "aws ec2 describe-transit-gateway-peering-attachments --region ap-northeast-1"
    cloudfront_check   = "aws cloudfront get-distribution --id ${aws_cloudfront_distribution.chewbacca_cf01.id} --query 'Distribution.DistributionConfig.OriginGroups'"
  }
}

#-----------------------------------------------------------------------------
# ARCHITECTURE SUMMARY
#-----------------------------------------------------------------------------

output "architecture_summary" {
  description = "Multi-region architecture summary"
  value = {
    tokyo_vpc        = "10.75.0.0/16"
    saopaulo_vpc     = "10.76.0.0/16"
    rds_location     = "Tokyo ONLY (APPI compliant)"
    compute_regions  = ["Tokyo", "Sao Paulo"]
    tgw_hub          = "Shinjuku (Tokyo)"
    tgw_spoke        = "Liberdade (Sao Paulo)"
    cloudfront_setup = "Origin Group Failover (Tokyo primary)"
  }
}
