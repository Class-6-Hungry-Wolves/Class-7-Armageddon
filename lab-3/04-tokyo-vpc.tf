############################################
# Lab 3: Tokyo VPC + Internet Gateway
# Primary region for APPI-compliant data storage
############################################

resource "aws_vpc" "chewbacca_vpc01" {
  cidr_block           = var.tokyo_vpc_cidr # 10.75.0.0/16
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-vpc01"
  })
}

resource "aws_internet_gateway" "chewbacca_igw01" {
  vpc_id = aws_vpc.chewbacca_vpc01.id

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-igw01"
  })
}
