# Locals Block to keep in line with DRY methodology


locals {
  project_name_prefix = var.project_name
  environment         = var.environment
}


# VPC with DNS support and hostnames enabled

resource "aws_vpc" "lab-1a-vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    name = "${local.project_name_prefix}-${local.environment}-lab-1a-vpc"
  }
}

# Public Subnets where our EC2 will be housed

resource "aws_subnet" "lab-1a-public-subnet" {
  vpc_id                  = aws_vpc.lab-1a-vpc.id
  for_each                = var.public_subnet_config
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.az
  map_public_ip_on_launch = true
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-lab1a-public-subnet"
  }
}

# Private Subnets where our RDS database will reside
resource "aws_subnet" "lab-1a-database-subnet" {
  vpc_id                  = aws_vpc.lab-1a-vpc.id
  for_each                = var.database_subnet_config
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.az
  map_public_ip_on_launch = false
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-lab1a-database-subnet"
  }
}

# Internet gateway to establish outside internet communication
resource "aws_internet_gateway" "lab_1a_igw" {
  vpc_id = aws_vpc.lab-1a-vpc.id
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-lab_1a_igw"
  }
}


# Elastic IP to attach to nat gateway 
resource "aws_eip" "lab_1a_nat_eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.lab_1a_igw]
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-lab_1a_nat_eip"
  }
}

# NAT Gateway to provide outbound internet access to private resources
resource "aws_nat_gateway" "lab_1a_nat_gateway" {
  depends_on    = [aws_subnet.lab-1a-public-subnet]
  allocation_id = aws_eip.lab_1a_nat_eip.id
  subnet_id     = aws_subnet.lab-1a-public-subnet["lab_1a_subnet_1"].id
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-lab_1a_nat_gateway"
  }
}

# Public Route table with corresponding default route of 0.0.0.0/0 to provide access from all IPS
resource "aws_route_table" "lab_1a_public_rtb" {
  vpc_id = aws_vpc.lab-1a-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab_1a_igw.id
  }
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-lab_1a_public_rtb"
  }
}

# Private Route table with corresponding default route of 0.0.0.0/0 to provide access from all IPS
resource "aws_route_table" "lab_1a_private_rtb" {
  vpc_id = aws_vpc.lab-1a-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.lab_1a_nat_gateway.id
  }
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-lab_1a_public_rtb"
  }
}

# Public Route Table association for public subnets
resource "aws_route_table_association" "lab_1a_public_rtb_association" {
  for_each       = aws_subnet.lab-1a-public-subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.lab_1a_public_rtb.id
}

# Private Route Table association for private subnets
resource "aws_route_table_association" "lab_1a_private_rtb_association" {
  for_each       = aws_subnet.lab-1a-database-subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.lab_1a_private_rtb.id
}


resource "aws_security_group" "lab_1a_ec2_sg" {
  name        = "${local.project_name_prefix}-${local.environment}-lab1a-ec2-sg"
  description = "This is the EC2 Security Group that will allow the EC2 to have public internet access"
  vpc_id      = aws_vpc.lab-1a-vpc.id
}

resource "aws_security_group" "lab_1a_rds_sg" {
  name        = "${local.project_name_prefix}-${local.environment}-lab1a-rds-sg"
  description = "This is the RDS Security Group that will only allow inbound access from our EC2"
  vpc_id      = aws_vpc.lab-1a-vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_port_80" {
  security_group_id = aws_security_group.lab_1a_ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_from_port_80_ipv4" {
  security_group_id = aws_security_group.lab_1a_ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}



resource "aws_vpc_security_group_ingress_rule" "allow_port_3306" {
  security_group_id            = aws_security_group.lab_1a_rds_sg.id 
  referenced_security_group_id = aws_security_group.lab_1a_ec2_sg.id
  from_port                    = 3306
  ip_protocol                  = "tcp"
  to_port                      = 3306
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_from_port_3306_ipv4" {
  security_group_id = aws_security_group.lab_1a_rds_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


