############################################
# Lab 3: Tokyo NAT Gateway + EIP
# Allows private subnets to reach internet (outbound only)
############################################

resource "aws_eip" "chewbacca_nat_eip01" {
  domain = "vpc"

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-nat-eip01"
  })
}

resource "aws_nat_gateway" "chewbacca_nat01" {
  allocation_id = aws_eip.chewbacca_nat_eip01.id
  subnet_id     = aws_subnet.chewbacca_public_subnet01.id

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-nat01"
  })

  depends_on = [aws_internet_gateway.chewbacca_igw01]
}
