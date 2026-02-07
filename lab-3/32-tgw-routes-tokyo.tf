############################################
# Lab 3: Tokyo VPC Routes to São Paulo via TGW
############################################

# Shinjuku returns traffic to Liberdade - because doctors need answers, not one-way tunnels
resource "aws_route" "shinjuku_to_sp_route01" {
  route_table_id         = aws_route_table.chewbacca_private_rt01.id
  destination_cidr_block = var.saopaulo_vpc_cidr # 10.76.0.0/16 - São Paulo VPC
  transit_gateway_id     = aws_ec2_transit_gateway.shinjuku_tgw01.id

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.shinjuku_attach_tokyo_vpc01
  ]
}
