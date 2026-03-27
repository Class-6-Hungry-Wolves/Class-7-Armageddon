# Locals Block to keep in line with DRY methodology


locals {
  project_name_prefix = var.project_name
  environment         = var.environment
}





############################
####### NETWORK ############
############################




# VPC with DNS support and hostnames enabled

resource "aws_vpc" "shinjuku-vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-shinjuku-vpc"
  }
}

# Public Subnets where our ALB will be housed

resource "aws_subnet" "shinjuku-public-subnet" {
  vpc_id                  = aws_vpc.shinjuku-vpc.id
  for_each                = var.public_subnet_config
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.az
  map_public_ip_on_launch = true
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-shinjuku-public-subnet"
  }
}

# Private Subnets where our EC2 lab app will reside
resource "aws_subnet" "shinjuku-private-subnet" {
  vpc_id            = aws_vpc.shinjuku-vpc.id
  for_each          = var.private_subnet_config
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-shinjuku-private-subnet"
  }
}


# Private Subnets where our RDS database will reside
resource "aws_subnet" "shinjuku-database-subnet" {
  vpc_id                  = aws_vpc.shinjuku-vpc.id
  for_each                = var.database_subnet_config
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.az
  map_public_ip_on_launch = false
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-shinjuku-database-subnet"
  }
}

# Internet gateway to establish outside internet communication
resource "aws_internet_gateway" "shinjuku_igw" {
  vpc_id = aws_vpc.shinjuku-vpc.id
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-shinjuku-igw"
  }
}


# Elastic IP to attach to nat gateway 
resource "aws_eip" "shinjuku_nat_eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.shinjuku_igw]
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-shinjuku-nat-eip"
  }
}

# NAT Gateway to provide outbound internet access to private resources
resource "aws_nat_gateway" "shinjuku_nat_gateway" {
  depends_on    = [aws_subnet.shinjuku-public-subnet]
  allocation_id = aws_eip.shinjuku_nat_eip.id
  subnet_id     = aws_subnet.shinjuku-public-subnet["shinjuku_public_subnet_1"].id
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-shinjuku-nat_gateway"
  }
}

# Public Route table with corresponding default route of 0.0.0.0/0 to provide access from all IPS
resource "aws_route_table" "shinjuku_public_rtb" {
  vpc_id = aws_vpc.shinjuku-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.shinjuku_igw.id
  }
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-shinjuku-public_rtb"
  }
}

# Private Route table with corresponding default route of 0.0.0.0/0 to provide access from all IPS
resource "aws_route_table" "shinjuku_private_rtb" {
  vpc_id = aws_vpc.shinjuku-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.shinjuku_nat_gateway.id
  }
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-shinjuku-private_rtb"
  }
}




# Public Route Table association for public subnets
resource "aws_route_table_association" "shinjuku_public_rtb_association" {
  for_each       = aws_subnet.shinjuku-public-subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.shinjuku_public_rtb.id
}

# Private Route Table association for private subnets
resource "aws_route_table_association" "shinjuku_private_rtb_association" {
  for_each       = aws_subnet.shinjuku-private-subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.shinjuku_private_rtb.id
}

# Private Route Table association for database subnets
resource "aws_route_table_association" "shinjuku_database_rtb_association" {
  for_each       = aws_subnet.shinjuku-database-subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.shinjuku_private_rtb.id
}