############################################
# Lab 3: São Paulo VPC Endpoints
############################################

#-----------------------------------------------------------------------------
# S3 Gateway Endpoint
#-----------------------------------------------------------------------------

resource "aws_vpc_endpoint" "liberdade_vpce_s3_gw01" {
  provider          = aws.saopaulo
  vpc_id            = aws_vpc.liberdade_vpc01.id
  service_name      = "com.amazonaws.sa-east-1.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.liberdade_private_rt01.id
  ]

  tags = merge(local.saopaulo_tags, {
    Name = "${local.saopaulo_prefix}-vpce-s3-gw01"
  })
}

#-----------------------------------------------------------------------------
# SSM Interface Endpoints
#-----------------------------------------------------------------------------

resource "aws_vpc_endpoint" "liberdade_vpce_ssm01" {
  provider            = aws.saopaulo
  vpc_id              = aws_vpc.liberdade_vpc01.id
  service_name        = "com.amazonaws.sa-east-1.ssm"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids = [
    aws_subnet.liberdade_private_subnet01.id,
    aws_subnet.liberdade_private_subnet02.id
  ]
  security_group_ids = [aws_security_group.liberdade_vpce_sg01.id]

  tags = merge(local.saopaulo_tags, {
    Name = "${local.saopaulo_prefix}-vpce-ssm01"
  })
}

resource "aws_vpc_endpoint" "liberdade_vpce_ec2messages01" {
  provider            = aws.saopaulo
  vpc_id              = aws_vpc.liberdade_vpc01.id
  service_name        = "com.amazonaws.sa-east-1.ec2messages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids = [
    aws_subnet.liberdade_private_subnet01.id,
    aws_subnet.liberdade_private_subnet02.id
  ]
  security_group_ids = [aws_security_group.liberdade_vpce_sg01.id]

  tags = merge(local.saopaulo_tags, {
    Name = "${local.saopaulo_prefix}-vpce-ec2messages01"
  })
}

resource "aws_vpc_endpoint" "liberdade_vpce_ssmmessages01" {
  provider            = aws.saopaulo
  vpc_id              = aws_vpc.liberdade_vpc01.id
  service_name        = "com.amazonaws.sa-east-1.ssmmessages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids = [
    aws_subnet.liberdade_private_subnet01.id,
    aws_subnet.liberdade_private_subnet02.id
  ]
  security_group_ids = [aws_security_group.liberdade_vpce_sg01.id]

  tags = merge(local.saopaulo_tags, {
    Name = "${local.saopaulo_prefix}-vpce-ssmmessages01"
  })
}

#-----------------------------------------------------------------------------
# CloudWatch Logs Endpoint
#-----------------------------------------------------------------------------

resource "aws_vpc_endpoint" "liberdade_vpce_logs01" {
  provider            = aws.saopaulo
  vpc_id              = aws_vpc.liberdade_vpc01.id
  service_name        = "com.amazonaws.sa-east-1.logs"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids = [
    aws_subnet.liberdade_private_subnet01.id,
    aws_subnet.liberdade_private_subnet02.id
  ]
  security_group_ids = [aws_security_group.liberdade_vpce_sg01.id]

  tags = merge(local.saopaulo_tags, {
    Name = "${local.saopaulo_prefix}-vpce-logs01"
  })
}

#-----------------------------------------------------------------------------
# CloudWatch Monitoring Endpoint
#-----------------------------------------------------------------------------

resource "aws_vpc_endpoint" "liberdade_vpce_monitoring01" {
  provider            = aws.saopaulo
  vpc_id              = aws_vpc.liberdade_vpc01.id
  service_name        = "com.amazonaws.sa-east-1.monitoring"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids = [
    aws_subnet.liberdade_private_subnet01.id,
    aws_subnet.liberdade_private_subnet02.id
  ]
  security_group_ids = [aws_security_group.liberdade_vpce_sg01.id]

  tags = merge(local.saopaulo_tags, {
    Name = "${local.saopaulo_prefix}-vpce-monitoring01"
  })
}
