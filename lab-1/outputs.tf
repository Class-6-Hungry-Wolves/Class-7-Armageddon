# Explanation: Outputs are your mission report—what got built and where to find it.
output "armageddon_vpc_id" {
  value = aws_vpc.armageddon-vpc01.id
}

output "armageddon_public_subnet_ids" {
  value = aws_subnet.armageddon-public-subnets[*].id
}

output "armageddon_private_subnet_ids" {
  value = aws_subnet.armageddon-private-subnets[*].id
}

output "armageddon_ec2_instance_id" {
  value = aws_instance.armageddon-ec201.id
}

# output "armageddon_rds_endpoint" {
#   value = aws_db_instance.armageddon-rds01.address
# }

# output "armageddon_sns_topic_arn" {
#   value = aws_sns_topic.armageddon-sns-topic01.arn
# }

# output "armageddon_log_group_name" {
#   value = aws_cloudwatch_log_group.armageddon-log-group01.name
# }