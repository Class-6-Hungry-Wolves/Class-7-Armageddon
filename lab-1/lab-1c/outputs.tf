###############################################
#### Lab 1c outputs (append to outputs.tf) ####
###############################################
# Explanation: Outputs are your mission report—what got built and where to find it.
output "armageddon_vpc_id" {
  value = aws_vpc.armageddon-vpc.id
}

output "armageddon_public_subnet_ids" {
  value = aws_subnet.armageddon-public-subnets[*].id
}

output "armageddon_private_subnet_ids" {
  value = aws_subnet.armageddon-private-subnets[*].id
}

output "armageddon_ec2_instance_id" {
  value = aws_instance.armageddon-ec2.id
}

output "ec2_public_ip" {
  value = "${aws_instance.armageddon-ec2.public_ip}"
}

output "note_app_initialization" {
  value = "http://${aws_instance.armageddon-ec2.public_ip}/init"
}

output "note_app_edits" {
  value = "http://${aws_instance.armageddon-ec2.public_ip}/add?note=Savalouwe!"
}

output "note_app_list" {
  value = "http://${aws_instance.armageddon-ec2.public_ip}/list"
}

output "armageddon_rds_endpoint" {
  value = aws_db_instance.armageddon-rds.address
}

output "armageddon_sns_topic_arn" {
  value = aws_sns_topic.armageddon-sns-topic.arn
}

output "armageddon_log_group_name" {
  value = aws_cloudwatch_log_group.armageddon-log-group.name
}

output "armageddon_cw_alarm_name" {
  value = aws_cloudwatch_metric_alarm.armageddon-db-alarm.namespace
}
