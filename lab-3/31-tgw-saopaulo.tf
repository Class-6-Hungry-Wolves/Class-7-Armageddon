############################################
# Lab 3: São Paulo Transit Gateway (Liberdade Spoke)
# Secondary TGW for APPI-compliant cross-region connectivity
############################################

# Liberdade is São Paulo's Japanese town - local doctors, local compute, remote data
resource "aws_ec2_transit_gateway" "liberdade_tgw01" {
  provider                        = aws.saopaulo
  description                     = "liberdade-tgw01 (Sao Paulo spoke)"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"
  dns_support                     = "enable"

  tags = merge(local.saopaulo_tags, {
    Name = "${local.saopaulo_tgw_prefix}-tgw01"
  })
}

# Liberdade accepts the corridor from Shinjuku - permissions are explicit, not assumed
resource "aws_ec2_transit_gateway_peering_attachment_accepter" "liberdade_accept_peer01" {
  provider                      = aws.saopaulo
  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.shinjuku_to_liberdade_peer01.id

  tags = merge(local.saopaulo_tags, {
    Name = "${local.saopaulo_tgw_prefix}-accept-peer01"
  })
}

# Liberdade attaches to its VPC - compute can now reach Tokyo legally, through the controlled corridor
resource "aws_ec2_transit_gateway_vpc_attachment" "liberdade_attach_sp_vpc01" {
  provider           = aws.saopaulo
  transit_gateway_id = aws_ec2_transit_gateway.liberdade_tgw01.id
  vpc_id             = aws_vpc.liberdade_vpc01.id
  subnet_ids = [
    aws_subnet.liberdade_private_subnet01.id,
    aws_subnet.liberdade_private_subnet02.id
  ]

  tags = merge(local.saopaulo_tags, {
    Name = "${local.saopaulo_tgw_prefix}-attach-sp-vpc01"
  })
}

# TGW Route Table for São Paulo
resource "aws_ec2_transit_gateway_route_table" "liberdade_rt01" {
  provider           = aws.saopaulo
  transit_gateway_id = aws_ec2_transit_gateway.liberdade_tgw01.id

  tags = merge(local.saopaulo_tags, {
    Name = "${local.saopaulo_tgw_prefix}-rt01"
  })
}

# Associate São Paulo VPC attachment with route table
resource "aws_ec2_transit_gateway_route_table_association" "liberdade_sp_vpc_assoc" {
  provider                       = aws.saopaulo
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.liberdade_attach_sp_vpc01.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.liberdade_rt01.id
}

# Propagate São Paulo VPC routes
resource "aws_ec2_transit_gateway_route_table_propagation" "liberdade_sp_vpc_prop" {
  provider                       = aws.saopaulo
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.liberdade_attach_sp_vpc01.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.liberdade_rt01.id
}

# Static route to Tokyo via peering
resource "aws_ec2_transit_gateway_route" "liberdade_to_tokyo_static" {
  provider                       = aws.saopaulo
  destination_cidr_block         = var.tokyo_vpc_cidr # 10.75.0.0/16
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment_accepter.liberdade_accept_peer01.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.liberdade_rt01.id
}
