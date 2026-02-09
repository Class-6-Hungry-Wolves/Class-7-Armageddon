###########################################
# EC2 Instance (Private Host)
############################################

# Explanation: EC2 instance created as a private host
resource "aws_instance" "chewbacca_ec201_private_bonus" {
  ami                     = var.ec2_ami_id
  instance_type           = var.ec2_instance_type
  key_name                = module.lab1-ab.aws_key_pair_name
  #subnet_id               = module.lab1-ab.ec2_private_subnet_id
  subnet_id               = module.lab1-ab.private_subnets[0].id
  vpc_security_group_ids  = [aws_security_group.target_group_ec2_sg01.id]
  iam_instance_profile    = aws_iam_instance_profile.chewbacca_instance_profile02.id

  # TODO: Students must allow inbound 443 FROM the EC2 SG (or VPC CIDR) to endpoints.
  # NOTE: Interface endpoints ENIs receive traffic on 443.

  user_data = file("${path.module}/user_data.sh") #Optional, but included

  tags = {
    Name = "${local.chewbacca_prefix}-ec201-private"
  }
}


###########################################
# Elastic IP to be used for public facing app DNS record
############################################

# resource "aws_eip" "peterock_eip01" {
#   domain = "vpc"
# }

# resource "aws_eip_domain_name" "peterock_eip01_domain" {
#   allocation_id = aws_eip.peterock_eip01.domain
#   domain_name   = aws_route53_record.chewbacca_acm_validation.fqdn
#}