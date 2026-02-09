############################################
# Bonus A: Security Groups (EC2 - Target Group )
############################################

# Explanation: EC2 SG is Chewbacca’s bodyguard—only let in what you mean to.
resource "aws_security_group" "target_group_ec2_sg01" {
  name        = "${var.project_name}-target-group-ec2-sg01"
  description = "Target Group app security group"
  vpc_id      = module.lab1-ab.vpc_id

  tags = {
    Name = "${var.project_name}-target-group-ec2-sg0"
  }
}

# Explanation: inbound rules (HTTP 80 from my IP)
resource "aws_vpc_security_group_ingress_rule" "alb_to_tg_http" {
  security_group_id = aws_security_group.target_group_ec2_sg01.id
  referenced_security_group_id = aws_security_group.chewbacca_alb_sg01.id
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
  description = "Allow HTTP from ALB"
}

# Explanation: inbound rules (SSH 22 from regional EC2 Instance Connect)
# resource "aws_vpc_security_group_ingress_rule" "ssh_InstConnect" {
#   security_group_id = aws_security_group.target_group_ec2_sg01.id
#   prefix_list_id    = "${module.lab1-ab.ec2_instance_connect}"
#   from_port         = 22
#   to_port           = 22
#   ip_protocol       = "tcp"
#   description       = "Allow SSH from Instance Connect"
# }

# Explanation: inbound rules (SSH 22 from Bastian Host - Public EC2)
resource "aws_vpc_security_group_ingress_rule" "ssh_private" {
  security_group_id = aws_security_group.target_group_ec2_sg01.id
  referenced_security_group_id = module.lab1-ab.ec2_sg
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  description       = "Allow SSH from Bastian Host to private EC2"
}

resource "aws_vpc_security_group_egress_rule" "ec2_all_outbound" {
  security_group_id = aws_security_group.target_group_ec2_sg01.id
  cidr_ipv4         = local.all_ips
  ip_protocol       = "-1"
  description       = "Allow all outbound traffic"
}


############################################
# Bonus B: Security Group: ALB
############################################

# Explanation: The ALB SG is the blast shield — only allow what the Rebellion needs (80/443).
resource "aws_security_group" "chewbacca_alb_sg01" {
  name        = "${var.project_name}-alb-sg01"
  description = "ALB security group"
  vpc_id      = module.lab1-ab.vpc_id

  # TODO: students add inbound 80/443 from 0.0.0.0/0 (see below)

  tags = {
    Name = "${var.project_name}-alb-sg01"
  }
}

resource "aws_vpc_security_group_ingress_rule" "any_to_alb_http" {
  security_group_id = aws_security_group.chewbacca_alb_sg01.id
  cidr_ipv4   = local.all_ips
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
  description = "Allow HTTP from any IP"
  # TODO: students ensure EC2 app listens on this port (or change to 8080, etc.)
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
  referenced_security_group_id = aws_security_group.target_group_ec2_sg01.id
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
  description = "Allow HTTP to Target Group"
}
