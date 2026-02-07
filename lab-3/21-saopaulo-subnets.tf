############################################
# Lab 3: São Paulo Subnets (Public + Private)
############################################

#-----------------------------------------------------------------------------
# PUBLIC SUBNETS - Where ALB and NAT Gateway live
#-----------------------------------------------------------------------------

resource "aws_subnet" "liberdade_public_subnet01" {
  provider                = aws.saopaulo
  vpc_id                  = aws_vpc.liberdade_vpc01.id
  cidr_block              = var.saopaulo_public_subnet_cidrs[0] # 10.76.1.0/24
  availability_zone       = var.saopaulo_azs[0]                  # sa-east-1a
  map_public_ip_on_launch = true

  tags = merge(local.saopaulo_tags, {
    Name = "${local.saopaulo_prefix}-public-subnet01"
    Tier = "public"
  })
}

resource "aws_subnet" "liberdade_public_subnet02" {
  provider                = aws.saopaulo
  vpc_id                  = aws_vpc.liberdade_vpc01.id
  cidr_block              = var.saopaulo_public_subnet_cidrs[1] # 10.76.11.0/24
  availability_zone       = var.saopaulo_azs[1]                  # sa-east-1c
  map_public_ip_on_launch = true

  tags = merge(local.saopaulo_tags, {
    Name = "${local.saopaulo_prefix}-public-subnet02"
    Tier = "public"
  })
}

#-----------------------------------------------------------------------------
# PRIVATE SUBNETS - Where EC2 lives (no RDS - APPI compliance)
#-----------------------------------------------------------------------------

resource "aws_subnet" "liberdade_private_subnet01" {
  provider          = aws.saopaulo
  vpc_id            = aws_vpc.liberdade_vpc01.id
  cidr_block        = var.saopaulo_private_subnet_cidrs[0] # 10.76.101.0/24
  availability_zone = var.saopaulo_azs[0]                   # sa-east-1a

  tags = merge(local.saopaulo_tags, {
    Name = "${local.saopaulo_prefix}-private-subnet01"
    Tier = "private"
  })
}

resource "aws_subnet" "liberdade_private_subnet02" {
  provider          = aws.saopaulo
  vpc_id            = aws_vpc.liberdade_vpc01.id
  cidr_block        = var.saopaulo_private_subnet_cidrs[1] # 10.76.128.0/24
  availability_zone = var.saopaulo_azs[1]                   # sa-east-1c

  tags = merge(local.saopaulo_tags, {
    Name = "${local.saopaulo_prefix}-private-subnet02"
    Tier = "private"
  })
}
