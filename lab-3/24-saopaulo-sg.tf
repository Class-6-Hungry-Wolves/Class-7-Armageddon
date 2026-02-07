############################################
# Lab 3: São Paulo Security Groups
# NOTE: No RDS Security Group - APPI Compliance
############################################

#-----------------------------------------------------------------------------
# EC2 Security Group
#-----------------------------------------------------------------------------

resource "aws_security_group" "liberdade_ec2_sg01" {
  provider    = aws.saopaulo
  name        = "${local.saopaulo_prefix}-ec2-sg01"
  description = "EC2 app security group - Sao Paulo"
  vpc_id      = aws_vpc.liberdade_vpc01.id

  # Inbound: Allow HTTP from ALB
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.liberdade_alb_sg01.id]
    description     = "Allow HTTP from ALB to EC2"
  }

  # Inbound: Allow SSH from admin IP (for troubleshooting)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
    description = "Allow SSH from admin IP"
  }

  # Outbound: Allow all traffic (needed for TGW to Tokyo RDS)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = merge(local.saopaulo_tags, {
    Name = "${local.saopaulo_prefix}-ec2-sg01"
  })
}

#-----------------------------------------------------------------------------
# ALB Security Group
#-----------------------------------------------------------------------------

resource "aws_security_group" "liberdade_alb_sg01" {
  provider    = aws.saopaulo
  name        = "${local.saopaulo_prefix}-alb-sg01"
  description = "ALB security group - Sao Paulo"
  vpc_id      = aws_vpc.liberdade_vpc01.id

  # Ingress rules added by origin cloaking (CloudFront only)

  # Outbound: Allow all
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound"
  }

  tags = merge(local.saopaulo_tags, {
    Name = "${local.saopaulo_prefix}-alb-sg01"
  })
}

#-----------------------------------------------------------------------------
# VPC Endpoint Security Group
#-----------------------------------------------------------------------------

resource "aws_security_group" "liberdade_vpce_sg01" {
  provider    = aws.saopaulo
  name        = "${local.saopaulo_prefix}-vpce-sg01"
  description = "SG for VPC Interface Endpoints"
  vpc_id      = aws_vpc.liberdade_vpc01.id

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.liberdade_ec2_sg01.id]
    description     = "Allow HTTPS from EC2"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.saopaulo_tags, {
    Name = "${local.saopaulo_prefix}-vpce-sg01"
  })
}
