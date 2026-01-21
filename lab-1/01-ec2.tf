###########################################
# EC2 Instance (Private Host)
############################################

# Explanation: EC2 instance created as a private host
resource "aws_instance" "chewbacca_ec201_private_bonus" {
  ami                     = var.ec2_ami_id
  instance_type           = var.ec2_instance_type
  #subnet_id               = module.lab1-ab.ec2_private_subnet_id
  subnet_id               = module.lab1-ab.private_subnets[0].id
  vpc_security_group_ids  = [module.lab1-ab.ec2_sg]
  iam_instance_profile    = module.lab1-ab.iam_instance_profile

  # TODO: Students must allow inbound 443 FROM the EC2 SG (or VPC CIDR) to endpoints.
  # NOTE: Interface endpoints ENIs receive traffic on 443.

  user_data = file("${path.module}/user_data.sh") #Optional, but included

  tags = {
    Name = "${local.chewbacca_prefix}-ec201-private"
  }
}
