# Explanation: Outputs are your mission report—what got built and where to find it.
output "armagedonn_vpc_id" {
  value = aws_vpc.armagedonn-vpc01.id
}

output "armagedonn_public_subnet_ids" {
  value = aws_subnet.armagedonn-public-subnets[*].id
}

output "armagedonn_private_subnet_ids" {
  value = aws_subnet.armagedonn-private-subnets[*].id
}

# output "armagedonn_ec2_instance_id" {
#   value = aws_instance.armagedonn-ec201.id
# }

# output "armagedonn_rds_endpoint" {
#   value = aws_db_instance.armagedonn-rds01.address
# }

# output "armagedonn_sns_topic_arn" {
#   value = aws_sns_topic.armagedonn-sns-topic01.arn
# }

# output "armagedonn_log_group_name" {
#   value = aws_cloudwatch_log_group.armagedonn-log-group01.name
# }