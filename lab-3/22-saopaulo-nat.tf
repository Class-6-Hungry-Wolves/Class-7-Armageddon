############################################
# Lab 3: São Paulo NAT Gateway + EIP
############################################

resource "aws_eip" "liberdade_nat_eip01" {
  provider = aws.saopaulo
  domain   = "vpc"

  tags = merge(local.saopaulo_tags, {
    Name = "${local.saopaulo_prefix}-nat-eip01"
  })
}

resource "aws_nat_gateway" "liberdade_nat01" {
  provider      = aws.saopaulo
  allocation_id = aws_eip.liberdade_nat_eip01.id
  subnet_id     = aws_subnet.liberdade_public_subnet01.id

  tags = merge(local.saopaulo_tags, {
    Name = "${local.saopaulo_prefix}-nat01"
  })

  depends_on = [aws_internet_gateway.liberdade_igw01]
}
