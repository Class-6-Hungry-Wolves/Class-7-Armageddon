############################################
# Security Groups (EC2 + RDS)
############################################

# EC2 Security Group - Controls access to the application server
resource "aws_security_group" "vandelay_ec2_sg01" {
  name        = "${local.name_prefix}-ec2-sg01"
  description = "EC2 app security group"
  vpc_id      = aws_vpc.vandelay_vpc01.id

  # Inbound: Allow HTTP (port 80) from anywhere for web application
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP from anywhere"
  }

  # Inbound: Allow SSH (port 22) from your IP only for troubleshooting
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
    description = "Allow SSH from admin IP"
  }

  # Outbound: Allow all traffic (required for app to reach RDS, Secrets Manager, etc.)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-ec2-sg01"
  })
}


# RDS Security Group - Least privilege: only EC2 app server can connect
resource "aws_security_group" "vandelay_rds_sg01" {
  name        = "${local.name_prefix}-rds-sg01"
  description = "RDS security group - only allows EC2 app server"
  vpc_id      = aws_vpc.vandelay_vpc01.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.vandelay_ec2_sg01.id]
    description     = "Allow MySQL from EC2 app server only"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-rds-sg01"
  })
}

############################################
# RDS Subnet Group
############################################

resource "aws_db_subnet_group" "vandelay_rds_subnet_group01" {
  name       = "${local.name_prefix}-rds-subnet-group01"
  subnet_ids = aws_subnet.vandelay_private_subnets[*].id

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-db-subnet-group01"
  })
}
