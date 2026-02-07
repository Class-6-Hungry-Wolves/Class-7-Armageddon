############################################
# Lab 3: Tokyo Subnets (Public + Private)
############################################

#-----------------------------------------------------------------------------
# PUBLIC SUBNETS - Where ALB and NAT Gateway live
#-----------------------------------------------------------------------------

resource "aws_subnet" "chewbacca_public_subnet01" {
  vpc_id                  = aws_vpc.chewbacca_vpc01.id
  cidr_block              = var.tokyo_public_subnet_cidrs[0] # 10.75.1.0/24
  availability_zone       = var.tokyo_azs[0]                  # ap-northeast-1a
  map_public_ip_on_launch = true

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-public-subnet01"
    Tier = "public"
  })
}

resource "aws_subnet" "chewbacca_public_subnet02" {
  vpc_id                  = aws_vpc.chewbacca_vpc01.id
  cidr_block              = var.tokyo_public_subnet_cidrs[1] # 10.75.11.0/24
  availability_zone       = var.tokyo_azs[1]                  # ap-northeast-1c
  map_public_ip_on_launch = true

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-public-subnet02"
    Tier = "public"
  })
}

#-----------------------------------------------------------------------------
# PRIVATE SUBNETS - Where EC2 and RDS live (no direct internet access)
#-----------------------------------------------------------------------------

resource "aws_subnet" "chewbacca_private_subnet01" {
  vpc_id            = aws_vpc.chewbacca_vpc01.id
  cidr_block        = var.tokyo_private_subnet_cidrs[0] # 10.75.101.0/24
  availability_zone = var.tokyo_azs[0]                   # ap-northeast-1a

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-private-subnet01"
    Tier = "private"
  })
}

resource "aws_subnet" "chewbacca_private_subnet02" {
  vpc_id            = aws_vpc.chewbacca_vpc01.id
  cidr_block        = var.tokyo_private_subnet_cidrs[1] # 10.75.128.0/24
  availability_zone = var.tokyo_azs[1]                   # ap-northeast-1c

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-private-subnet02"
    Tier = "private"
  })
}
