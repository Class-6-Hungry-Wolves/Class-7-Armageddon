############################################
# Lab 3: Tokyo VPC Endpoints
############################################

#-----------------------------------------------------------------------------
# S3 Gateway Endpoint
#-----------------------------------------------------------------------------

resource "aws_vpc_endpoint" "chewbacca_vpce_s3_gw01" {
  vpc_id            = aws_vpc.chewbacca_vpc01.id
  service_name      = "com.amazonaws.ap-northeast-1.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.chewbacca_private_rt01.id
  ]

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-vpce-s3-gw01"
  })
}

#-----------------------------------------------------------------------------
# SSM Interface Endpoints
#-----------------------------------------------------------------------------

resource "aws_vpc_endpoint" "chewbacca_vpce_ssm01" {
  vpc_id              = aws_vpc.chewbacca_vpc01.id
  service_name        = "com.amazonaws.ap-northeast-1.ssm"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids = [
    aws_subnet.chewbacca_private_subnet01.id,
    aws_subnet.chewbacca_private_subnet02.id
  ]
  security_group_ids = [aws_security_group.chewbacca_vpce_sg01.id]

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-vpce-ssm01"
  })
}

resource "aws_vpc_endpoint" "chewbacca_vpce_ec2messages01" {
  vpc_id              = aws_vpc.chewbacca_vpc01.id
  service_name        = "com.amazonaws.ap-northeast-1.ec2messages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids = [
    aws_subnet.chewbacca_private_subnet01.id,
    aws_subnet.chewbacca_private_subnet02.id
  ]
  security_group_ids = [aws_security_group.chewbacca_vpce_sg01.id]

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-vpce-ec2messages01"
  })
}

resource "aws_vpc_endpoint" "chewbacca_vpce_ssmmessages01" {
  vpc_id              = aws_vpc.chewbacca_vpc01.id
  service_name        = "com.amazonaws.ap-northeast-1.ssmmessages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids = [
    aws_subnet.chewbacca_private_subnet01.id,
    aws_subnet.chewbacca_private_subnet02.id
  ]
  security_group_ids = [aws_security_group.chewbacca_vpce_sg01.id]

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-vpce-ssmmessages01"
  })
}

#-----------------------------------------------------------------------------
# CloudWatch Logs Endpoint
#-----------------------------------------------------------------------------

resource "aws_vpc_endpoint" "chewbacca_vpce_logs01" {
  vpc_id              = aws_vpc.chewbacca_vpc01.id
  service_name        = "com.amazonaws.ap-northeast-1.logs"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids = [
    aws_subnet.chewbacca_private_subnet01.id,
    aws_subnet.chewbacca_private_subnet02.id
  ]
  security_group_ids = [aws_security_group.chewbacca_vpce_sg01.id]

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-vpce-logs01"
  })
}

#-----------------------------------------------------------------------------
# CloudWatch Monitoring Endpoint
#-----------------------------------------------------------------------------

resource "aws_vpc_endpoint" "chewbacca_vpce_monitoring01" {
  vpc_id              = aws_vpc.chewbacca_vpc01.id
  service_name        = "com.amazonaws.ap-northeast-1.monitoring"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids = [
    aws_subnet.chewbacca_private_subnet01.id,
    aws_subnet.chewbacca_private_subnet02.id
  ]
  security_group_ids = [aws_security_group.chewbacca_vpce_sg01.id]

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-vpce-monitoring01"
  })
}

#-----------------------------------------------------------------------------
# Secrets Manager Endpoint
#-----------------------------------------------------------------------------

resource "aws_vpc_endpoint" "chewbacca_vpce_secretsmanager01" {
  vpc_id              = aws_vpc.chewbacca_vpc01.id
  service_name        = "com.amazonaws.ap-northeast-1.secretsmanager"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids = [
    aws_subnet.chewbacca_private_subnet01.id,
    aws_subnet.chewbacca_private_subnet02.id
  ]
  security_group_ids = [aws_security_group.chewbacca_vpce_sg01.id]

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-vpce-secretsmanager01"
  })
}

#-----------------------------------------------------------------------------
# KMS Endpoint
#-----------------------------------------------------------------------------

resource "aws_vpc_endpoint" "chewbacca_vpce_kms01" {
  vpc_id              = aws_vpc.chewbacca_vpc01.id
  service_name        = "com.amazonaws.ap-northeast-1.kms"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids = [
    aws_subnet.chewbacca_private_subnet01.id,
    aws_subnet.chewbacca_private_subnet02.id
  ]
  security_group_ids = [aws_security_group.chewbacca_vpce_sg01.id]

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-vpce-kms01"
  })
}
