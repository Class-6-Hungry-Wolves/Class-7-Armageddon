############################################
# Lab 3: Tokyo Security Groups
############################################

#-----------------------------------------------------------------------------
# EC2 Security Group
#-----------------------------------------------------------------------------

resource "aws_security_group" "chewbacca_ec2_sg01" {
  name        = "${local.tokyo_prefix}-ec2-sg01"
  description = "EC2 app security group - Tokyo"
  vpc_id      = aws_vpc.chewbacca_vpc01.id

  # Inbound: Allow HTTP from ALB
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.chewbacca_alb_sg01.id]
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

  # Outbound: Allow all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-ec2-sg01"
  })
}

#-----------------------------------------------------------------------------
# RDS Security Group (Tokyo Only - APPI Compliance)
#-----------------------------------------------------------------------------

resource "aws_security_group" "chewbacca_rds_sg01" {
  name        = "${local.tokyo_prefix}-rds-sg01"
  description = "RDS security group - only allows EC2 app servers"
  vpc_id      = aws_vpc.chewbacca_vpc01.id

  # Inbound: Allow MySQL from Tokyo EC2
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.chewbacca_ec2_sg01.id]
    description     = "Allow MySQL from Tokyo EC2 app server"
  }

  # Inbound: Allow MySQL from Lambda rotation function
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.chewbacca_rotation_lambda_sg01.id]
    description     = "Allow Lambda rotation function to connect to RDS"
  }

  # Outbound: Allow all
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-rds-sg01"
  })
}

#-----------------------------------------------------------------------------
# RDS Subnet Group
#-----------------------------------------------------------------------------

resource "aws_db_subnet_group" "chewbacca_rds_subnet_group01" {
  name = "${local.tokyo_prefix}-rds-subnet-group01"
  subnet_ids = [
    aws_subnet.chewbacca_private_subnet01.id,
    aws_subnet.chewbacca_private_subnet02.id
  ]

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-db-subnet-group01"
  })
}

#-----------------------------------------------------------------------------
# ALB Security Group
#-----------------------------------------------------------------------------

resource "aws_security_group" "chewbacca_alb_sg01" {
  name        = "${local.tokyo_prefix}-alb-sg01"
  description = "ALB security group - Tokyo"
  vpc_id      = aws_vpc.chewbacca_vpc01.id

  # Ingress rules added by origin cloaking (CloudFront only)

  # Outbound: Allow all
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound"
  }

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-alb-sg01"
  })
}

#-----------------------------------------------------------------------------
# Lambda Rotation Security Group
#-----------------------------------------------------------------------------

resource "aws_security_group" "chewbacca_rotation_lambda_sg01" {
  name        = "${local.tokyo_prefix}-rotation-lambda-sg01"
  description = "Security group for secret rotation Lambda"
  vpc_id      = aws_vpc.chewbacca_vpc01.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-rotation-lambda-sg01"
  })
}

#-----------------------------------------------------------------------------
# VPC Endpoint Security Group
#-----------------------------------------------------------------------------

resource "aws_security_group" "chewbacca_vpce_sg01" {
  name        = "${local.tokyo_prefix}-vpce-sg01"
  description = "SG for VPC Interface Endpoints"
  vpc_id      = aws_vpc.chewbacca_vpc01.id

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    security_groups = [
      aws_security_group.chewbacca_ec2_sg01.id,
      aws_security_group.chewbacca_rotation_lambda_sg01.id
    ]
    description = "Allow HTTPS from EC2 and Lambda"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-vpce-sg01"
  })
}
