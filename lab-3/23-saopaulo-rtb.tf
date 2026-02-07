############################################
# Lab 3: São Paulo Routing (Public + Private Route Tables)
############################################

#-----------------------------------------------------------------------------
# PUBLIC ROUTE TABLE
#-----------------------------------------------------------------------------

resource "aws_route_table" "liberdade_public_rt01" {
  provider = aws.saopaulo
  vpc_id   = aws_vpc.liberdade_vpc01.id

  tags = merge(local.saopaulo_tags, {
    Name = "${local.saopaulo_prefix}-public-rt01"
  })
}

resource "aws_route" "liberdade_public_default_route" {
  provider               = aws.saopaulo
  route_table_id         = aws_route_table.liberdade_public_rt01.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.liberdade_igw01.id
}

resource "aws_route_table_association" "liberdade_public_rta01" {
  provider       = aws.saopaulo
  subnet_id      = aws_subnet.liberdade_public_subnet01.id
  route_table_id = aws_route_table.liberdade_public_rt01.id
}

resource "aws_route_table_association" "liberdade_public_rta02" {
  provider       = aws.saopaulo
  subnet_id      = aws_subnet.liberdade_public_subnet02.id
  route_table_id = aws_route_table.liberdade_public_rt01.id
}

#-----------------------------------------------------------------------------
# PRIVATE ROUTE TABLE
#-----------------------------------------------------------------------------

resource "aws_route_table" "liberdade_private_rt01" {
  provider = aws.saopaulo
  vpc_id   = aws_vpc.liberdade_vpc01.id

  tags = merge(local.saopaulo_tags, {
    Name = "${local.saopaulo_prefix}-private-rt01"
  })
}

resource "aws_route" "liberdade_private_default_route" {
  provider               = aws.saopaulo
  route_table_id         = aws_route_table.liberdade_private_rt01.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.liberdade_nat01.id
}

resource "aws_route_table_association" "liberdade_private_rta01" {
  provider       = aws.saopaulo
  subnet_id      = aws_subnet.liberdade_private_subnet01.id
  route_table_id = aws_route_table.liberdade_private_rt01.id
}

resource "aws_route_table_association" "liberdade_private_rta02" {
  provider       = aws.saopaulo
  subnet_id      = aws_subnet.liberdade_private_subnet02.id
  route_table_id = aws_route_table.liberdade_private_rt01.id
}
