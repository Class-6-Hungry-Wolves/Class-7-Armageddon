############################################
# Bonus A - Data + Locals
############################################

# Explanation: Chewbacca wants to know “who am I in this galaxy?” so ARNs can be scoped properly.
data "aws_caller_identity" "self" {}

# Explanation: Region matters—hyperspace lanes change per sector.
data "aws_region" "region" {}

locals {
  # TODO: Students should lock this down after apply using the real secret ARN from outputs/state
  armageddon_secret_arn = "arn:aws:secretsmanager:${data.aws_region.region.region}:${data.aws_caller_identity.self.account_id}:secret:${local.name_prefix}/rds/mysql*"
}

############################################
# Move EC2 into PRIVATE subnet (no public IP)
############################################

# Explanation: Chewbacca hates exposure—private subnets keep your compute off the public holonet.
resource "aws_instance" "armageddon-ec2-private-bonus" {
  ami                    = data.aws_ami.amzn-linux-2023-ami.id
  instance_type          = var.ec2_instance_type
  subnet_id              = aws_subnet.armageddon-private-subnets[0].id
  vpc_security_group_ids = [aws_security_group.armageddon-ec2-sg.id]
  iam_instance_profile   = aws_iam_instance_profile.armageddon-instance-profile.name

  # TODO: Students should remove/disable SSH inbound rules entirely and rely on SSM.
  # TODO: Students add user_data that installs app + CW agent; for true hard mode use a baked AMI.
  user_data = file("${path.module}/1c_user_data.sh")

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${local.name_prefix}-ec2-private"
  }
}

############################################
# Security Group for VPC Interface Endpoints
############################################

# Explanation: Even endpoints need guards—Chewbacca posts a Wookiee at every airlock.
resource "aws_security_group" "armageddon-vpce-sg" {
  name        = "${local.name_prefix}-vpce-sg"
  description = "SG for VPC Interface Endpoints"
  vpc_id      = aws_vpc.armageddon-vpc.id

  # TODO: Students must allow inbound 443 FROM the EC2 SG (or VPC CIDR) to endpoints.
  # NOTE: Interface endpoints ENIs receive traffic on 443.

  tags = {
    Name = "${local.name_prefix}-vpce-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ec2-vpce-https-ingress" {
  security_group_id            = aws_security_group.armageddon-vpce-sg.id
  referenced_security_group_id = aws_security_group.armageddon-ec2-sg.id
  from_port                    = 443
  ip_protocol                  = "tcp"
  to_port                      = 443

  tags = {
    Name = "Allow HTTPS inbound from EC2 Security Group to VPC Endpoints"
  }
}

############################################
# VPC Endpoint - S3 (Gateway)
############################################

# Explanation: S3 is the supply depot—without this, your private world starves (updates, artifacts, logs).
resource "aws_vpc_endpoint" "armageddon-vpce-s3-gw" {
  vpc_id            = aws_vpc.armageddon-vpc.id
  service_name      = "com.amazonaws.${data.aws_region.region.region}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.private-rtb.id
  ]

  tags = {
    Name = "${local.name_prefix}-vpce-s3-gw"
  }
}

############################################
# VPC Endpoints - SSM (Interface)
############################################

# Explanation: SSM is your Force choke—remote control without SSH, and nobody sees your keys.
resource "aws_vpc_endpoint" "armageddon-vpce-ssm" {
  vpc_id              = aws_vpc.armageddon-vpc.id
  service_name        = "com.amazonaws.${data.aws_region.region.region}.ssm"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = aws_subnet.armageddon-private-subnets[*].id
  security_group_ids = [aws_security_group.armageddon-vpce-sg.id]

  tags = {
    Name = "${local.name_prefix}-vpce-ssm"
  }
}

# Explanation: ec2messages is the Wookiee messenger—SSM sessions won’t work without it.
resource "aws_vpc_endpoint" "armageddon-vpce-ec2messages" {
  vpc_id              = aws_vpc.armageddon-vpc.id
  service_name        = "com.amazonaws.${data.aws_region.region.region}.ec2messages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = aws_subnet.armageddon-private-subnets[*].id
  security_group_ids = [aws_security_group.armageddon-vpce-sg.id]

  tags = {
    Name = "${local.name_prefix}-vpce-ec2messages"
  }
}

# Explanation: ssmmessages is the holonet channel—Session Manager needs it to talk back.
resource "aws_vpc_endpoint" "armageddon-vpce-ssmmessages" {
  vpc_id              = aws_vpc.armageddon-vpc.id
  service_name        = "com.amazonaws.${data.aws_region.region.region}.ssmmessages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = aws_subnet.armageddon-private-subnets[*].id
  security_group_ids = [aws_security_group.armageddon-vpce-sg.id]

  tags = {
    Name = "${local.name_prefix}-vpce-ssmmessages"
  }
}

############################################
# VPC Endpoint - CloudWatch Logs (Interface)
############################################

# Explanation: CloudWatch Logs is the ship’s black box—Chewbacca wants crash data, always.
resource "aws_vpc_endpoint" "armageddon-vpce-logs" {
  vpc_id              = aws_vpc.armageddon-vpc.id
  service_name        = "com.amazonaws.${data.aws_region.region.region}.logs"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = aws_subnet.armageddon-private-subnets[*].id
  security_group_ids = [aws_security_group.armageddon-vpce-sg.id]

  tags = {
    Name = "${local.name_prefix}-vpce-logs"
  }
}

############################################
# VPC Endpoint - Secrets Manager (Interface)
############################################

# Explanation: Secrets Manager is the locked vault—Chewbacca doesn’t put passwords on sticky notes.
resource "aws_vpc_endpoint" "armageddon-vpce-secrets" {
  vpc_id              = aws_vpc.armageddon-vpc.id
  service_name        = "com.amazonaws.${data.aws_region.region.region}.secretsmanager"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = aws_subnet.armageddon-private-subnets[*].id
  security_group_ids = [aws_security_group.armageddon-vpce-sg.id]

  tags = {
    Name = "${local.name_prefix}-vpce-secrets"
  }
}

############################################
# Optional: VPC Endpoint - KMS (Interface)
############################################

# Explanation: KMS is the encryption kyber crystal—Chewbacca prefers locked doors AND locked safes.
resource "aws_vpc_endpoint" "armageddon-vpce-kms" {
  vpc_id              = aws_vpc.armageddon-vpc.id
  service_name        = "com.amazonaws.${data.aws_region.region.region}.kms"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = aws_subnet.armageddon-private-subnets[*].id
  security_group_ids = [aws_security_group.armageddon-vpce-sg.id]

  tags = {
    Name = "${local.name_prefix}-vpce-kms"
  }
}

############################################
# Least-Privilege IAM (BONUS A)
############################################

# Explanation: Chewbacca doesn’t hand out the Falcon keys—this policy scopes reads to your lab paths only.
resource "aws_iam_policy" "armageddon-leastpriv-read-params" {
  name        = "${local.name_prefix}-lp-ssm-read"
  description = "Least-privilege read for SSM Parameter Store under /lab/db/*"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "ReadLabDbParams"
        Effect = "Allow"
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:GetParametersByPath"
        ]
        Resource = [
          "arn:aws:ssm:${data.aws_region.region.region}:${data.aws_caller_identity.self.account_id}:parameter/lab/db/*"
        ]
      }
    ]
  })
}

# Explanation: Chewbacca only opens *this* vault—GetSecretValue for only your secret (not the whole planet).
resource "aws_iam_policy" "armageddon-leastpriv-read-secret" {
  name        = "${local.name_prefix}-lp-secrets-read"
  description = "Least-privilege read for the lab DB secret"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "ReadOnlyLabSecret"
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = local.armageddon_secret_arn
      }
    ]
  })
}

# Explanation: When the Falcon logs scream, this lets Chewbacca ship logs to CloudWatch without giving away the Death Star plans.
resource "aws_iam_policy" "armageddon-leastpriv-cwlogs" {
  name        = "${local.name_prefix}-lp-cwlogs"
  description = "Least-privilege CloudWatch Logs write for the app log group"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "WriteLogs"
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ]
        Resource = [
          "${aws_cloudwatch_log_group.armageddon-log-group.arn}:*"
        ]
      }
    ]
  })
}

# Explanation: Attach the scoped policies—Chewbacca loves power, but only the safe kind.
resource "aws_iam_role_policy_attachment" "armageddon-attach-lp-params" {
  role       = aws_iam_role.armageddon-ec2-iam-role.name
  policy_arn = aws_iam_policy.armageddon-leastpriv-read-params.arn
}

resource "aws_iam_role_policy_attachment" "armageddon-attach-lp-secret" {
  role       = aws_iam_role.armageddon-ec2-iam-role.name
  policy_arn = aws_iam_policy.armageddon-leastpriv-read-secret.arn
}

resource "aws_iam_role_policy_attachment" "armageddon-attach-lp-cwlogs" {
  role       = aws_iam_role.armageddon-ec2-iam-role.name
  policy_arn = aws_iam_policy.armageddon-leastpriv-cwlogs.arn
}