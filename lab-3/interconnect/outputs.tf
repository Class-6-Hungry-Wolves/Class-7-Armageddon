output "aws_ec2_transit_gateway_peering_attachment_accepter_liberdade_accept_peer01_id" {
  value = aws_ec2_transit_gateway_peering_attachment_accepter.liberdade_accept_peer01.id
}


output "aws_ec2_transit_gateway_peering_attachment_id"{
  value = aws_ec2_transit_gateway_peering_attachment.shinjuku_to_liberdade_peer01.id
}


output "aws_route_liberdade_to_shinjuku_route01_id" {
  value = aws_ec2_transit_gateway_route.liberdade_to_shinjuku_tgwroute01.id
}


output "aws_route_shinjuku_to_liberdade_route01_id" {
  value = aws_ec2_transit_gateway_route.shinjuku_to_liberdade_tgwroute01.id
}