# Explanation: Outputs are your mission report—what got built and where to find it.
output "lab_1a_vpc_id" {
  value = aws_vpc.lab-1a-vpc.id
}

output "lab_1a_public_subnet_ids" {
  value = [for i in aws_subnet.lab-1a-public-subnet : i.id]
}

output "lab_1a_private_subnet_ids" {
  value = [for i in aws_subnet.lab-1a-database-subnet : i.id]
}

output "lab1_ec2_instance_id" {
  value = aws_instance.lab1_ec2_instance.id
}

output "lab1_ec2_public_ip" {
  value = aws_instance.lab1_ec2_instance.public_ip
}
output "lab1_rds_endpoint" {
  value = aws_db_instance.lab1-rds01.address
}

# output "chewbacca_sns_topic_arn" {
#   value = aws_sns_topic.chewbacca_sns_topic01.arn
# }

# output "chewbacca_log_group_name" {
#   value = aws_cloudwatch_log_group.chewbacca_log_group01.name
# }