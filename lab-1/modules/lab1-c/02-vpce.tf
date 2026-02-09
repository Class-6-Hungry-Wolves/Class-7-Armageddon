############################################
#  VPC Endpoints (for S3 Gateway & KMS (Optional))
############################################

# Explanation: S3 is the supply depot—without this, your private world starves (updates, artifacts, logs).
resource "aws_vpc_endpoint" "chewbacca_vpce_s3_gw01" {
  vpc_id            = module.lab1-ab.vpc_id
  service_name      = "com.amazonaws.${module.lab1-ab.aws_region}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    module.lab1-ab.private_route_table_id
  ]

  tags = {
    Name = "${local.chewbacca_prefix}-vpce-s3-gw01"
  }
}


# Explanation: KMS is the encryption kyber crystal—Chewbacca prefers locked doors AND locked safes.
resource "aws_vpc_endpoint" "chewbacca_vpce_kms01" {
  vpc_id              = module.lab1-ab.vpc_id
  service_name        = "com.amazonaws.${module.lab1-ab.aws_region}.kms"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids          = module.lab1-ab.private_subnets[*].id
  security_group_ids  = [module.lab1-ab.vpce_sg]

  tags = {
    Name = "${local.chewbacca_prefix}-vpce-kms01"
  }
}
