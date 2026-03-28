# Locals Block to keep in line with DRY methodology


locals {
  project_name_prefix = var.project_name
  environment         = var.environment
}





############################
####### NETWORK ############
############################




# VPC with DNS support and hostnames enabled

resource "aws_vpc" "liberdade-vpc" {
  provider = aws.saopaulo
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-liberdade-vpc"
  }
}

# Public Subnets where our ALB will be housed

resource "aws_subnet" "liberdade-public-subnet" {
  provider = aws.saopaulo

  vpc_id                  = aws_vpc.liberdade-vpc.id
  for_each                = var.public_subnet_config
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.az
  map_public_ip_on_launch = true
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-liberdade-public-subnet"
  }
}

# Private Subnets where our EC2 lab app will reside
resource "aws_subnet" "liberdade-private-subnet" {
  provider          = aws.saopaulo
  vpc_id            = aws_vpc.liberdade-vpc.id
  for_each          = var.private_subnet_config
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-liberdade-private-subnet"
  }
}


# Internet gateway to establish outside internet communication
resource "aws_internet_gateway" "liberdade_igw" {
  provider = aws.saopaulo
  vpc_id   = aws_vpc.liberdade-vpc.id
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-liberdade-igw"
  }
}


# Elastic IP to attach to nat gateway 
resource "aws_eip" "liberdade_nat_eip" {
  provider   = aws.saopaulo
  domain     = "vpc"
  depends_on = [aws_internet_gateway.liberdade_igw]
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-liberdade-nat-eip"
  }
}

# NAT Gateway to provide outbound internet access to private resources
resource "aws_nat_gateway" "liberdade_nat_gateway" {
  provider      = aws.saopaulo
  depends_on    = [aws_subnet.liberdade-public-subnet]
  allocation_id = aws_eip.liberdade_nat_eip.id
  subnet_id     = aws_subnet.liberdade-public-subnet["liberdade_public_subnet_1"].id
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-liberdade-nat_gateway"
  }
}

# Public Route table with corresponding default route of 0.0.0.0/0 to provide access from all IPS
resource "aws_route_table" "liberdade_public_rtb" {
  provider = aws.saopaulo
  vpc_id   = aws_vpc.liberdade-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.liberdade_igw.id
  }
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-liberdade-public_rtb"
  }
}

# Private Route table with corresponding default route of 0.0.0.0/0 to provide access from all IPS
resource "aws_route_table" "liberdade_private_rtb" {
  provider = aws.saopaulo
  vpc_id   = aws_vpc.liberdade-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.liberdade_nat_gateway.id
  }
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-liberdade-private_rtb"
  }
}


resource "aws_route" "liberdade_to_shinjuku_route01" {
  provider               = aws.saopaulo
  route_table_id         = aws_route_table.liberdade_private_rtb.id
  destination_cidr_block = "10.80.0.0/16" # Shinjuku VPC CIDR block
  transit_gateway_id     = aws_ec2_transit_gateway.liberdade_tgw01.id
}



# Public Route Table association for public subnets
resource "aws_route_table_association" "liberdade_public_rtb_association" {
  provider       = aws.saopaulo
  for_each       = aws_subnet.liberdade-public-subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.liberdade_public_rtb.id
}

# Private Route Table association for private subnets
resource "aws_route_table_association" "liberdade_private_rtb_association" {
  provider       = aws.saopaulo
  for_each       = aws_subnet.liberdade-private-subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.liberdade_private_rtb.id
}
