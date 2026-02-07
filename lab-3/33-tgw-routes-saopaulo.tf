############################################
# Lab 3: São Paulo VPC Routes to Tokyo via TGW
############################################

# Liberdade knows the way to Shinjuku - Tokyo CIDR routes go through the TGW corridor
resource "aws_route" "liberdade_to_tokyo_route01" {
  provider               = aws.saopaulo
  route_table_id         = aws_route_table.liberdade_private_rt01.id
  destination_cidr_block = var.tokyo_vpc_cidr # 10.75.0.0/16 - Tokyo VPC
  transit_gateway_id     = aws_ec2_transit_gateway.liberdade_tgw01.id

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.liberdade_attach_sp_vpc01
  ]
}
