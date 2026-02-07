############################################
# Lab 3: Tokyo Routing (Public + Private Route Tables)
############################################

#-----------------------------------------------------------------------------
# PUBLIC ROUTE TABLE
#-----------------------------------------------------------------------------

resource "aws_route_table" "chewbacca_public_rt01" {
  vpc_id = aws_vpc.chewbacca_vpc01.id

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-public-rt01"
  })
}

resource "aws_route" "chewbacca_public_default_route" {
  route_table_id         = aws_route_table.chewbacca_public_rt01.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.chewbacca_igw01.id
}

resource "aws_route_table_association" "chewbacca_public_rta01" {
  subnet_id      = aws_subnet.chewbacca_public_subnet01.id
  route_table_id = aws_route_table.chewbacca_public_rt01.id
}

resource "aws_route_table_association" "chewbacca_public_rta02" {
  subnet_id      = aws_subnet.chewbacca_public_subnet02.id
  route_table_id = aws_route_table.chewbacca_public_rt01.id
}

#-----------------------------------------------------------------------------
# PRIVATE ROUTE TABLE
#-----------------------------------------------------------------------------

resource "aws_route_table" "chewbacca_private_rt01" {
  vpc_id = aws_vpc.chewbacca_vpc01.id

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-private-rt01"
  })
}

resource "aws_route" "chewbacca_private_default_route" {
  route_table_id         = aws_route_table.chewbacca_private_rt01.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.chewbacca_nat01.id
}

resource "aws_route_table_association" "chewbacca_private_rta01" {
  subnet_id      = aws_subnet.chewbacca_private_subnet01.id
  route_table_id = aws_route_table.chewbacca_private_rt01.id
}

resource "aws_route_table_association" "chewbacca_private_rta02" {
  subnet_id      = aws_subnet.chewbacca_private_subnet02.id
  route_table_id = aws_route_table.chewbacca_private_rt01.id
}
