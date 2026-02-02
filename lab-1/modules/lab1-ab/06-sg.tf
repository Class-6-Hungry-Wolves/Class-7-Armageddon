############################################
# Security Groups (EC2 + RDS)
############################################

# Explanation: EC2 SG is Chewbacca’s bodyguard—only let in what you mean to.
resource "aws_security_group" "chewbacca_ec2_sg01" {
  name        = "${local.name_prefix}-ec2-sg01"
  description = "EC2 app security group"
  vpc_id      = aws_vpc.chewbacca_vpc01.id

  # TODO: student adds inbound rules (HTTP 80, SSH 22 from their IP)
  # TODO: student ensures outbound allows DB port to RDS SG (or allow all outbound)

  tags = {
    Name = "${local.name_prefix}-ec2-sg01"
  }
}

# Explanation: inbound rules (HTTP 80 from my IP)
resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.chewbacca_ec2_sg01.id
  cidr_ipv4   = local.my_public_ip
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
  description = "Allow HTTP from MY PUBLIC IP"
}

# Explanation: inbound rules (HTTP$ 443 from my IP)
resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.chewbacca_ec2_sg01.id
  cidr_ipv4   = local.my_public_ip
  from_port   = 443
  to_port     = 443
  ip_protocol = "tcp"
  description = "Allow HTTPS from MY PUBLIC IP"
}

# Explanation: inbound rules (SSH 22 from my IP)
resource "aws_vpc_security_group_ingress_rule" "ssh_me" {
  security_group_id = aws_security_group.chewbacca_ec2_sg01.id
  cidr_ipv4   = local.my_public_ip
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"
  description = "Allow SSH from VPC"
}

# Explanation: inbound rules (SSH 22 from regional EC2 Instance Connect)
resource "aws_vpc_security_group_ingress_rule" "ssh_instConnect" {
  security_group_id = aws_security_group.chewbacca_ec2_sg01.id
  prefix_list_id    = data.aws_ec2_managed_prefix_list.ec2_instance_connect.id
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  description       = "Allow SSH from Instance Connect"
}

# Explanation: inbound rules (SSH 22 from regional EC2 Instance Connect)
resource "aws_vpc_security_group_ingress_rule" "ssh_private" {
  security_group_id = aws_security_group.chewbacca_ec2_sg01.id
  referenced_security_group_id = aws_security_group.chewbacca_ec2_sg01.id
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  description       = "Allow SSH from Bastian Host to private EC2"
}

resource "aws_vpc_security_group_egress_rule" "ec2_all_outbound" {
  security_group_id = aws_security_group.chewbacca_ec2_sg01.id
  cidr_ipv4         = local.all_ips
  ip_protocol       = "-1"
  description       = "Allow all outbound traffic"
}

# Explanation: RDS SG is the Rebel vault—only the app server gets a keycard.
resource "aws_security_group" "chewbacca_rds_sg01" {
  name        = "${local.name_prefix}-rds-sg01"
  description = "RDS security group"
  vpc_id      = aws_vpc.chewbacca_vpc01.id

  tags = {
    Name = "${local.name_prefix}-rds-sg01"
  }
}

# Explanation: adds inbound MySQL 3306 from aws_security_group.chewbacca_ec2_sg01.id
resource "aws_vpc_security_group_ingress_rule" "rds_port" {
  security_group_id = aws_security_group.chewbacca_rds_sg01.id
  referenced_security_group_id = aws_security_group.chewbacca_ec2_sg01.id
  #cidr_ipv4   = var.vpc_cidr
  from_port   = 3306
  to_port     = 3306
  ip_protocol = "tcp"
  description = "Allow MySQL-DB from VPC"
}

resource "aws_vpc_security_group_egress_rule" "rds_all_outbound" {
  security_group_id = aws_security_group.chewbacca_rds_sg01.id
  cidr_ipv4         = local.all_ips
  ip_protocol       = "-1"
  description       = "Allow all outbound traffic"
}

# Explanation: VPC Endpoint Interface SG allowing HTTPS from the private subnets.
resource "aws_security_group" "chewbacca_vpce_sg01" {
  name        = "${local.name_prefix}-vpce-sg01"
  description = "VPC Endpoint security group"
  vpc_id      = aws_vpc.chewbacca_vpc01.id

  tags = {
    Name = "${local.name_prefix}-vpce-sg01"
  }
}

resource "aws_vpc_security_group_ingress_rule" "vpce_https" {
  #for_each = toset(var.private_subnet_cidrs)
  security_group_id = aws_security_group.chewbacca_vpce_sg01.id
  #cidr_ipv4 = each.value
  referenced_security_group_id = aws_security_group.chewbacca_ec2_sg01.id
  from_port   = 443
  to_port     = 443
  ip_protocol = "tcp"
  description = "Allow HTTPS from privates subnets"
}

resource "aws_vpc_security_group_egress_rule" "vpce_all_outbound" {
  security_group_id = aws_security_group.chewbacca_vpce_sg01.id
  cidr_ipv4         = local.all_ips
  ip_protocol       = "-1"
  description       = "Allow all outbound traffic"
}
