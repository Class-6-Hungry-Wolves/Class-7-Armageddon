# Explanation: Liberdade is São Paulo’s Japanese town—local doctors, local compute, remote data.
resource "aws_ec2_transit_gateway" "liberdade_tgw01" {
  provider                        = aws.saopaulo
  description                     = "liberdade-tgw01 (Sao Paulo spoke)"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  tags                            = { Name = "liberdade-tgw01" }
}

# Explanation: Liberdade attaches to its VPC—compute can now reach Tokyo legally, through the controlled corridor.
resource "aws_ec2_transit_gateway_vpc_attachment" "liberdade_attach_lib_vpc01" {
  provider           = aws.saopaulo
  transit_gateway_id = aws_ec2_transit_gateway.liberdade_tgw01.id
  vpc_id             = aws_vpc.liberdade-vpc.id
  subnet_ids         = [for i in aws_subnet.liberdade-private-subnet : i.id]
  tags               = { Name = "liberdade-attach-lib-vpc01" }
}

resource "aws_ec2_transit_gateway_route_table" "liberdade_tgw01_rtb01" {
  provider           = aws.saopaulo
  transit_gateway_id = aws_ec2_transit_gateway.liberdade_tgw01.id
  tags               = { Name = "liberdade-tgw01-rtb01" }
}

resource "aws_ec2_transit_gateway_route_table_association" "liberdade_tgw01_rtb01_assoc" {
  provider                       = aws.saopaulo
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.liberdade_attach_lib_vpc01.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.liberdade_tgw01_rtb01.id
}
