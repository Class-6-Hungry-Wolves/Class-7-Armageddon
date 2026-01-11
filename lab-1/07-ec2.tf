############################################
# EC2 Instance (App Host)
############################################

#Key pair resource for SSH access to EC2 instance
resource "aws_key_pair" "ec2_key_pair" {
  key_name   = "ec2_key_pair"
  public_key = var.public_key
  }

# Explanation: This is your “Han Solo box”—it talks to RDS and complains loudly when the DB is down.
resource "aws_instance" "chewbacca_ec201" {
  ami                     = var.ec2_ami_id
  instance_type           = var.ec2_instance_type
  key_name                = aws_key_pair.ec2_key_pair.key_name
  subnet_id               = aws_subnet.chewbacca_public_subnets[0].id
  vpc_security_group_ids  = [aws_security_group.chewbacca_ec2_sg01.id]
  iam_instance_profile    = aws_iam_instance_profile.chewbacca_instance_profile01.name

  # TODO: student supplies user_data to install app + CW agent + configure log shipping
  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "${local.name_prefix}-ec201"
  }
}
