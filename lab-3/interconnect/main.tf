# Explanation: Liberdade accepts the corridor from Shinjuku—permissions are explicit, not assumed.
resource "aws_ec2_transit_gateway_peering_attachment_accepter" "liberdade_accept_peer01" {
  provider                      = aws.saopaulo
  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.shinjuku_to_liberdade_peer01.id # created in Tokyo module/state
  tags                          = { Name = "liberdade-accept-peer01" }
}


# Explanation: Shinjuku opens a corridor request to Liberdade—compute may travel, data may not.
resource "aws_ec2_transit_gateway_peering_attachment" "shinjuku_to_liberdade_peer01" {
  transit_gateway_id      = data.terraform_remote_state.shinjuku_state.outputs.shinjuku_tgw_id # created in Tokyo module/state
  peer_region             = "sa-east-1"
  peer_transit_gateway_id = data.terraform_remote_state.liberdade_state.outputs.liberdade_tgw_id # created in Sao Paulo module/state
  tags                    = { Name = "shinjuku-to-liberdade-peer01" }
}

# VPC Route Association: Liberdade routes to Shinjuku through the peering attachment corridor.
resource "aws_ec2_transit_gateway_route" "shinjuku_to_liberdade_tgwroute01" {
  destination_cidr_block         = data.terraform_remote_state.liberdade_state.outputs.liberdade_vpc_cidr_block # Liberdade VPC CIDR block
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.shinjuku_to_liberdade_peer01.id   # created in Tokyo module/state
  transit_gateway_route_table_id = data.terraform_remote_state.shinjuku_state.outputs.shinjuku_tgw_rtb_id       # created in Tokyo module/state
  depends_on = [
    aws_ec2_transit_gateway_peering_attachment_accepter.liberdade_accept_peer01
  ]
}

# VPC Route Association: Shinjuku routes to Liberdade through the peering attachment corridor.
resource "aws_ec2_transit_gateway_route" "liberdade_to_shinjuku_tgwroute01" {
  provider                       = aws.saopaulo
  destination_cidr_block         = data.terraform_remote_state.shinjuku_state.outputs.shinjuku_vpc_cidr_block # Shinjuku VPC CIDR block
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.shinjuku_to_liberdade_peer01.id # created in Tokyo module/state
  transit_gateway_route_table_id = data.terraform_remote_state.liberdade_state.outputs.liberdade_tgw_rtb_id   # created in Sao Paulo module/state
  depends_on = [
    aws_ec2_transit_gateway_peering_attachment_accepter.liberdade_accept_peer01
  ]
}

# Liberdade routes to itself through the peering attachment corridor, ensuring local routing is correct.
resource "aws_ec2_transit_gateway_route" "liberdade_local_route01" {
  provider                       = aws.saopaulo
  destination_cidr_block         = data.terraform_remote_state.liberdade_state.outputs.liberdade_vpc_cidr_block        # Liberdade VPC CIDR block
  transit_gateway_attachment_id  = data.terraform_remote_state.liberdade_state.outputs.liberdade_tgw_vpc_attachment_id # created in Sao Paulo module/state
  transit_gateway_route_table_id = data.terraform_remote_state.liberdade_state.outputs.liberdade_tgw_rtb_id            # created in Sao Paulo module/state
}

# Shinjuku routes to itself through the peering attachment corridor, ensuring local routing is correct.
resource "aws_ec2_transit_gateway_route" "shinjuku_local_route01" {
  destination_cidr_block         = data.terraform_remote_state.shinjuku_state.outputs.shinjuku_vpc_cidr_block        # Shinjuku VPC CIDR block
  transit_gateway_attachment_id  = data.terraform_remote_state.shinjuku_state.outputs.shinjuku_tgw_vpc_attachment_id # created in Tokyo module/state
  transit_gateway_route_table_id = data.terraform_remote_state.shinjuku_state.outputs.shinjuku_tgw_rtb_id            # created in Tokyo module/state
}


# Shinjuku associates peering attachment with its TGW route table so arriving peer traffic is evaluated against the correct routes.
# This in combination with the local routes will deliver incoming traffic to local VPC and thus enabling Liberdade to communicate with Shinjuku.
resource "aws_ec2_transit_gateway_route_table_association" "shinjuku_to_liberdade_peering_assoc01" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.shinjuku_to_liberdade_peer01.id # created in Tokyo module/state
  transit_gateway_route_table_id = data.terraform_remote_state.shinjuku_state.outputs.shinjuku_tgw_rtb_id     # created in Tokyo module/state
}

# Liberdade associates peering attachment with its TGW route table so arriving peer traffic is evaluated against the correct routes.
# This in combination with the local routes will deliver incoming traffic to local VPC and thus enabling Shinjuku to communicate with Liberdade.
resource "aws_ec2_transit_gateway_route_table_association" "liberdade_to_shinjuku_peering_assoc01" {
  provider                       = aws.saopaulo
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment_accepter.liberdade_accept_peer01.id # created in Tokyo module/state
  transit_gateway_route_table_id = data.terraform_remote_state.liberdade_state.outputs.liberdade_tgw_rtb_id       # created in Sao Paulo module/state
}
