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
  value = var.enable_runtime_instance_creation ? "http://${aws_instance.lab1_ec2_instance[0].private_ip}/init" : null
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

# output "fingerprint" {
#   value = data.aws_key_pair.lab1-key-pair.fingerprint
# }

# output "name" {
#   value = data.aws_key_pair.lab1-key-pair.key_name
# }

# output "id" {
#   value = data.aws_key_pair.lab1-key-pair.id
# }

output "packer_builder_instance_profile_name" {
  value = aws_iam_instance_profile.packer_builder_instance_profile.name
}