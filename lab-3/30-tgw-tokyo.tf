############################################
# Lab 3: Tokyo Transit Gateway (Shinjuku Hub)
# Primary TGW for APPI-compliant cross-region connectivity
############################################

# Shinjuku Station is the hub - Tokyo is the data authority
resource "aws_ec2_transit_gateway" "shinjuku_tgw01" {
  description                     = "shinjuku-tgw01 (Tokyo hub)"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"
  dns_support                     = "enable"

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_tgw_prefix}-tgw01"
  })
}

# Shinjuku connects to the Tokyo VPC - this is the gate to the medical records vault
resource "aws_ec2_transit_gateway_vpc_attachment" "shinjuku_attach_tokyo_vpc01" {
  transit_gateway_id = aws_ec2_transit_gateway.shinjuku_tgw01.id
  vpc_id             = aws_vpc.chewbacca_vpc01.id
  subnet_ids = [
    aws_subnet.chewbacca_private_subnet01.id,
    aws_subnet.chewbacca_private_subnet02.id
  ]

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_tgw_prefix}-attach-tokyo-vpc01"
  })
}

# Shinjuku opens a corridor request to Liberdade - compute may travel, data may not
resource "aws_ec2_transit_gateway_peering_attachment" "shinjuku_to_liberdade_peer01" {
  transit_gateway_id      = aws_ec2_transit_gateway.shinjuku_tgw01.id
  peer_region             = "sa-east-1"
  peer_transit_gateway_id = aws_ec2_transit_gateway.liberdade_tgw01.id

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_tgw_prefix}-to-liberdade-peer01"
  })
}

# TGW Route Table for Tokyo
resource "aws_ec2_transit_gateway_route_table" "shinjuku_rt01" {
  transit_gateway_id = aws_ec2_transit_gateway.shinjuku_tgw01.id

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_tgw_prefix}-rt01"
  })
}

# Associate Tokyo VPC attachment with route table
resource "aws_ec2_transit_gateway_route_table_association" "shinjuku_tokyo_vpc_assoc" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.shinjuku_attach_tokyo_vpc01.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.shinjuku_rt01.id
}

# Propagate Tokyo VPC routes
resource "aws_ec2_transit_gateway_route_table_propagation" "shinjuku_tokyo_vpc_prop" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.shinjuku_attach_tokyo_vpc01.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.shinjuku_rt01.id
}

# Static route to São Paulo via peering
resource "aws_ec2_transit_gateway_route" "shinjuku_to_saopaulo_static" {
  destination_cidr_block         = var.saopaulo_vpc_cidr # 10.76.0.0/16
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.shinjuku_to_liberdade_peer01.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.shinjuku_rt01.id

  depends_on = [
    aws_ec2_transit_gateway_peering_attachment_accepter.liberdade_accept_peer01
  ]
}
