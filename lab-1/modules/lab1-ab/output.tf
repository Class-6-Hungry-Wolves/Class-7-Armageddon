#Outputs selected insfrastructure region
output "aws_region" {
  value = data.aws_region.chewbacca_region01.region
}

# Outputs the ID to your current terminal
output "account_id" {
  value = data.aws_caller_identity.chewbacca_self01.account_id
}

# VPC ID
output "vpc_id" {
  value = aws_vpc.chewbacca_vpc01.id
}

#Public subnet list
output "public_subnets" {
  value = aws_subnet.chewbacca_public_subnets
}

#Privtate subnet list
output "private_subnets" {
  value = aws_subnet.chewbacca_private_subnets
}

# Private Route Table ID used by S3 VPC Endpoint
output "private_route_table_id" {
  value = aws_route_table.chewbacca_private_rt01.id
}

# SG ID for EC2 instance (to be applied to private LAB1-c private EC2)
output "ec2_sg" {
  value = aws_security_group.chewbacca_ec2_sg01.id
}

# SG ID for VPC Endpoint instance
output "vpce_sg" {
  value = aws_security_group.chewbacca_vpce_sg01.id
}

# IAM Profile for EC2 (to be applied to private LAB1-c private EC2)
output "iam_instance_profile" {
  value = aws_iam_instance_profile.chewbacca_instance_profile01.id
}

# Secrets Manager name
output "secrets_manager_name" {
  value = aws_secretsmanager_secret.chewbacca_db_secret01.id
}

output "aws_cloudwatch_log_group_arn" {
  value = aws_cloudwatch_log_group.chewbacca_log_group01.arn
}

output "iam_role_name" {
  value = aws_iam_role.chewbacca_ec2_role01.name
}

output "aws_key_pair" {
  value = aws_key_pair.ec2_key_pair
}

# Outputs the ID of the regional EC2 Instanct Connect for SSH capability 
output "ec2_instance_connect" {
  value = data.aws_ec2_managed_prefix_list.ec2_instance_connect.id
}
