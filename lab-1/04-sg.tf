############################################
# Security Group: ALB
############################################

# Explanation: The ALB SG is the blast shield — only allow what the Rebellion needs (80/443).
resource "aws_security_group" "chewbacca_alb_sg01" {
  name        = "${var.project_name}-alb-sg01"
  description = "ALB security group"
  vpc_id      = module.lab1-ab.vpc_id

  # TODO: students add inbound 80/443 from 0.0.0.0/0

  tags = {
    Name = "${var.project_name}-alb-sg01"
  }
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.chewbacca_alb_sg01.id
  cidr_ipv4   = local.all_ips
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
  description = "Allow HTTP from any IP"
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.chewbacca_alb_sg01.id
  cidr_ipv4   = local.all_ips
  from_port   = 443
  to_port     = 443
  ip_protocol = "tcp"
  description = "Allow HTTPS from any IP"
}

 # TODO: students set outbound to target group port (usually 80) to private targets
resource "aws_vpc_security_group_egress_rule" "alb_outbound" {
  security_group_id = aws_security_group.chewbacca_alb_sg01.id
  cidr_ipv4         = local.all_ips
  ip_protocol       = "-1"
  description       = "Allow all outbound traffic"
}

# Explanation: Chewbacca only opens the hangar door — allow ALB -> EC2 on app port (e.g., 80).
# resource "aws_security_group_rule" "chewbacca_ec2_ingress_from_alb01" {
#   type                     = "ingress"
#   security_group_id        = module.lab1-ab.private_subnets[0].id
#   from_port                = 80
#   to_port                  = 80
#   protocol                 = "tcp"
#   source_security_group_id = aws_security_group.chewbacca_alb_sg01.id

#   # TODO: students ensure EC2 app listens on this port (or change to 8080, etc.)
#}