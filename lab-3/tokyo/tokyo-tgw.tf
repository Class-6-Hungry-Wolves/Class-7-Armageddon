# Explanation: Shinjuku Station is the hub—Tokyo is the data authority.
resource "aws_ec2_transit_gateway" "shinjuku_tgw01" {
  description                     = "shinjuku-tgw01 (Tokyo hub)"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  tags                            = { Name = "shinjuku-tgw01" }
}

# Explanation: Shinjuku connects to the Tokyo VPC—this is the gate to the medical records vault.
resource "aws_ec2_transit_gateway_vpc_attachment" "shinjuku_attach_tokyo_vpc01" {
  transit_gateway_id = aws_ec2_transit_gateway.shinjuku_tgw01.id
  vpc_id             = aws_vpc.shinjuku-vpc.id
  subnet_ids         = [for i in aws_subnet.shinjuku-private-subnet : i.id]
  tags               = { Name = "shinjuku-attach-tokyo-vpc01" }
}


resource "aws_ec2_transit_gateway_route_table" "shinjuku_tgw01_rtb01" {
  transit_gateway_id = aws_ec2_transit_gateway.shinjuku_tgw01.id
  tags               = { Name = "shinjuku-tgw01-rtb01" }
}


resource "aws_ec2_transit_gateway_route_table_association" "shinjuku_tgw01_rtb01_assoc" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.shinjuku_attach_tokyo_vpc01.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.shinjuku_tgw01_rtb01.id
}
