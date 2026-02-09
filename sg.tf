#Security Groups for Lab 2a

resource "aws_security_group" "lab_2a_alb_sg" {
  name        = "${local.name_prefix}-lab-2a-alb-sg"
  description = "Allows HTTP traffic to ALB"
  vpc_id      = aws_vpc.lab_2a_vpc.id


  ingress {
    description = "Allow HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-lab-2a-alb-sg"
  })
}

resource "aws_security_group" "lab_2a_app_sg" {
  name        = "${local.name_prefix}-lab-2a-app-sg"
  description = "Allows ALB to reach application EC2 instances"
  vpc_id      = aws_vpc.lab_2a_vpc.id

  ingress {
    description     = "Allow HTTP from ALB only"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.lab_2a_alb_sg.id]
  }

  # Optional: SSH from your IP if needed
  # ingress {
  #   description = "Allow SSH from my IP"
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = ["YOUR.IP.HERE/32"]
  # }

  # NOTE: This egress rule below matches the default AWS Security Group behavior. Do not modify this for this lab
  #It allows all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-lab-2a-app-sg"
  })
}

resource "aws_security_group" "lab_2a_rds_sg" {
  name        = "${local.name_prefix}-lab-2a-rds-sg"
  description = "Allows application to talk to database"
  vpc_id      = aws_vpc.lab_2a_vpc.id

  ingress {
    description     = "Allow MySQL from application servers"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.lab_2a_app_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-lab-2a-rds-sg"
  })
}