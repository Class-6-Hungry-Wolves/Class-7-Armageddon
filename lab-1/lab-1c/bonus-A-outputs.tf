#Bonus-A outputs (append to outputs.tf)

# Explanation: These outputs prove Chewbacca built private hyperspace lanes (endpoints) instead of public chaos.
output "armageddon_vpce_ssm_id" {
  value = aws_vpc_endpoint.armageddon-vpce-ssm.id
}

output "armageddon_vpce_logs_id" {
  value = aws_vpc_endpoint.armageddon-vpce-logs.id
}

output "armageddon_vpce_secrets_id" {
  value = aws_vpc_endpoint.armageddon-vpce-secrets.id
}

output "armageddon_vpce_s3_id" {
  value = aws_vpc_endpoint.armageddon-vpce-s3-gw.id
}

output "armageddon_private_ec2_instance_id_bonus" {
  value = aws_instance.armageddon-ec2-private-bonus.id
}
