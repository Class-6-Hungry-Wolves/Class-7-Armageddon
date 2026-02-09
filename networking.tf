# VPC with DNS support and hostnames enabled
resource "aws_vpc" "lab_2a_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-lab-2a-vpc"
  })
}

# Public Subnets where our EC2 / ALB will be housed
resource "aws_subnet" "lab_2a_public_subnet" {
  vpc_id                  = aws_vpc.lab_2a_vpc.id
  for_each                = var.public_subnet_config
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-lab-2a-public-subnet-${each.key}"
    Tier = "public"
  })
}

# Private Subnets where our RDS database (and/or app) will reside
resource "aws_subnet" "lab_2a_database_subnet" {
  vpc_id                  = aws_vpc.lab_2a_vpc.id
  for_each                = var.database_subnet_config
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.az
  map_public_ip_on_launch = false

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-lab-2a-database-subnet-${each.key}"
    Tier = "private-db"
  })
}

# Internet gateway to establish outside internet communication
resource "aws_internet_gateway" "lab_2a_igw" {
  vpc_id = aws_vpc.lab_2a_vpc.id

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-lab-2a-igw"
  })
}

# Elastic IP to attach to NAT gateway
resource "aws_eip" "lab_2a_nat_eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.lab_2a_igw]

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-lab-2a-nat-eip"
  })
}

# NAT Gateway to provide outbound internet access to private resources
resource "aws_nat_gateway" "lab_2a_nat_gateway" {
  depends_on    = [aws_subnet.lab_2a_public_subnet]
  allocation_id = aws_eip.lab_2a_nat_eip.id
  subnet_id     = aws_subnet.lab_2a_public_subnet["lab_2a_subnet_1"].id # keep same key you used in lab1

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-lab-2a-nat-gateway"
  })
}

# Public Route table (0.0.0.0/0 via IGW)
resource "aws_route_table" "lab_2a_public_rtb" {
  vpc_id = aws_vpc.lab_2a_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab_2a_igw.id
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-lab-2a-public-rtb"
  })
}

# Private Route table (0.0.0.0/0 via NAT)
resource "aws_route_table" "lab_2a_private_rtb" {
  vpc_id = aws_vpc.lab_2a_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.lab_2a_nat_gateway.id
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-lab-2a-private-rtb"
  })
}

# Public Route Table associations for public subnets
resource "aws_route_table_association" "lab_2a_public_rtb_association" {
  for_each       = aws_subnet.lab_2a_public_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.lab_2a_public_rtb.id
}

# Private Route Table associations for private/database subnets
resource "aws_route_table_association" "lab_2a_private_rtb_association" {
  for_each       = aws_subnet.lab_2a_database_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.lab_2a_private_rtb.id
}