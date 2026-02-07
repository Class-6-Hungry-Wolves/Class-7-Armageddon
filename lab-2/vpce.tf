locals {
  project_name = var.project_name
}




############################################
# Security Group for VPC Interface Endpoints
############################################

# Explanation: Even endpoints need guards—lab1 posts a Wookiee at every airlock.
resource "aws_security_group" "lab1_vpce_sg01" {
  name        = "${local.project_name}-vpce-sg01"
  description = "SG for VPC Interface Endpoints"
  vpc_id      = aws_vpc.lab-1-vpc.id

  # TODO: Students must allow inbound 443 FROM the EC2 SG (or VPC CIDR) to endpoints.
  # NOTE: Interface endpoints ENIs receive traffic on 443.

  tags = {
    Name = "${local.project_name}-vpce-sg01"
  }
}

resource "aws_vpc_security_group_ingress_rule" "vpce_https_inbound_from_ec2_sg" {
  security_group_id            = aws_security_group.lab1_vpce_sg01.id
  referenced_security_group_id = aws_security_group.lab_1_ec2_sg.id
  ip_protocol                  = "tcp"
  from_port                    = 443
  to_port                      = 443
  description                  = "Allow HTTPS inbound from EC2 SG to VPC Endpoints"

}

resource "aws_vpc_security_group_egress_rule" "vpce_https_outbound_to_service" {
  security_group_id = aws_security_group.lab1_vpce_sg01.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}



############################################
# VPC Endpoint - S3 (Gateway)
############################################

# Explanation: S3 is the supply depot—without this, your private world starves (updates, artifacts, logs).
resource "aws_vpc_endpoint" "lab1_vpce_s3_gw01" {
  vpc_id            = aws_vpc.lab-1-vpc.id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.lab_1_private_rtb.id
  ]

  tags = {
    Name = "${local.project_name}-vpce-s3-gw01"
  }
}

############################################
# VPC Endpoints - SSM (Interface)
############################################

# Explanation: SSM is your Force choke—remote control without SSH, and nobody sees your keys.
resource "aws_vpc_endpoint" "lab1_vpce_ssm01" {
  vpc_id              = aws_vpc.lab-1-vpc.id
  service_name        = "com.amazonaws.${var.aws_region}.ssm"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = [for i in aws_subnet.lab-1-private-subnet : i.id]
  security_group_ids = [aws_security_group.lab1_vpce_sg01.id]

  tags = {
    Name = "${local.project_name}-vpce-ssm01"
  }
}

# Explanation: ec2messages is the Wookiee messenger—SSM sessions won’t work without it.
resource "aws_vpc_endpoint" "lab1_vpce_ec2messages01" {
  vpc_id              = aws_vpc.lab-1-vpc.id
  service_name        = "com.amazonaws.${var.aws_region}.ec2messages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = [for i in aws_subnet.lab-1-private-subnet : i.id]
  security_group_ids = [aws_security_group.lab1_vpce_sg01.id]

  tags = {
    Name = "${local.project_name}-vpce-ec2messages01"
  }
}

# Explanation: ssmmessages is the holonet channel—Session Manager needs it to talk back.
resource "aws_vpc_endpoint" "lab1_vpce_ssmmessages01" {
  vpc_id              = aws_vpc.lab-1-vpc.id
  service_name        = "com.amazonaws.${var.aws_region}.ssmmessages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = [for i in aws_subnet.lab-1-private-subnet : i.id]
  security_group_ids = [aws_security_group.lab1_vpce_sg01.id]

  tags = {
    Name = "${local.project_name}-vpce-ssmmessages01"
  }
}

############################################
# VPC Endpoint - CloudWatch Logs (Interface)
############################################

# Explanation: CloudWatch Logs is the ship’s black box—lab1 wants crash data, always.
resource "aws_vpc_endpoint" "lab1_vpce_logs01" {
  vpc_id              = aws_vpc.lab-1-vpc.id
  service_name        = "com.amazonaws.${var.aws_region}.logs"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = [for i in aws_subnet.lab-1-private-subnet : i.id]
  security_group_ids = [aws_security_group.lab1_vpce_sg01.id]

  tags = {
    Name = "${local.project_name}-vpce-logs01"
  }
}

resource "aws_vpc_endpoint" "lab1_vpce_monitoring01" {
  vpc_id              = aws_vpc.lab-1-vpc.id
  service_name        = "com.amazonaws.${var.aws_region}.monitoring"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = [for i in aws_subnet.lab-1-private-subnet : i.id]
  security_group_ids = [aws_security_group.lab1_vpce_sg01.id]

  tags = {
    Name = "${local.project_name}-vpce-logs01"
  }
}

############################################
# VPC Endpoint - Secrets Manager (Interface)
############################################

# Explanation: Secrets Manager is the locked vault—lab1 doesn’t put passwords on sticky notes.
resource "aws_vpc_endpoint" "lab1_vpce_secrets01" {
  vpc_id              = aws_vpc.lab-1-vpc.id
  service_name        = "com.amazonaws.${var.aws_region}.secretsmanager"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = [for i in aws_subnet.lab-1-private-subnet : i.id]
  security_group_ids = [aws_security_group.lab1_vpce_sg01.id]

  tags = {
    Name = "${local.project_name}-vpce-secrets01"
  }
}

############################################
# Optional: VPC Endpoint - KMS (Interface)
############################################

# Explanation: KMS is the encryption kyber crystal—lab1 prefers locked doors AND locked safes.
resource "aws_vpc_endpoint" "lab1_vpce_kms01" {
  vpc_id              = aws_vpc.lab-1-vpc.id
  service_name        = "com.amazonaws.${var.aws_region}.kms"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = [for i in aws_subnet.lab-1-private-subnet : i.id]
  security_group_ids = [aws_security_group.lab1_vpce_sg01.id]

  tags = {
    Name = "${local.project_name}-vpce-kms01"
  }
}
