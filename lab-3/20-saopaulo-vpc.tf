############################################
# Lab 3: São Paulo VPC + Internet Gateway
# Secondary compute region (stateless - no RDS)
############################################

resource "aws_vpc" "liberdade_vpc01" {
  provider             = aws.saopaulo
  cidr_block           = var.saopaulo_vpc_cidr # 10.76.0.0/16
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.saopaulo_tags, {
    Name = "${local.saopaulo_prefix}-vpc01"
  })
}

resource "aws_internet_gateway" "liberdade_igw01" {
  provider = aws.saopaulo
  vpc_id   = aws_vpc.liberdade_vpc01.id

  tags = merge(local.saopaulo_tags, {
    Name = "${local.saopaulo_prefix}-igw01"
  })
}
