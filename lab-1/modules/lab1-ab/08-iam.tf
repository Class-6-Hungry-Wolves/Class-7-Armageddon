############################################
# IAM Role + Instance Profile for EC2
############################################

# Explanation: Chewbacca refuses to carry static keys—this role lets EC2 assume permissions safely.
resource "aws_iam_role" "chewbacca_ec2_role01" {
  name = "${local.name_prefix}-ec2-role01"
  assume_role_policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Sid = "EC2AssumeRole"
          Effect = "Allow"
          Principal = { Service = "ec2.amazonaws.com" }
          Action = [
            "sts:AssumeRole",
          ]
        },
      ]
    }
  )

    tags = {
      Name = "${local.name_prefix}-ec2-iam-role"
    }
}

# Explanation: 
resource "aws_iam_policy" "chewbacca_ec2_read_secret01" {
  name        = "${local.name_prefix}-ec2-secrets-read01"
  description = "Least-privilege read for the lab DB secret"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "ReadSpecificSecret"
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = "arn:aws:secretsmanager:${var.aws_region}:${data.aws_caller_identity.chewbacca_self01.account_id}:secret:${local.name_prefix}/rds/mysql*"
      }
    ]
  })
}

# Explanation: 
resource "aws_iam_policy" "chewbacca_ec2_CWAgent_policy" {
  name        = "${local.name_prefix}-ec2-CWagent-policy"
  description = "CloudWatch Agent Server Policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "CloudWatchAgentServerPermissions"
        Effect   = "Allow"
        Action = [
          "cloudwatch:PutMetricData",
          "ec2:DescribeVolumes",
          "ec2:DescribeTags",
          "logs:PutLogEvents",
          "logs:PutRetentionPolicy",
          "logs:DescribeLogStreams",
          "logs:DescribeLogGroups",
          "logs:CreateLogStream",
          "logs:CreateLogGroup",
          "xray:PutTraceSegments",
          "xray:PutTelemetryRecords",
          "xray:GetSamplingRules",
          "xray:GetSamplingTargets",
          "xray:GetSamplingStatisticSummaries"
        ]
        Resource = "*"
      }
    ]
  })
}

# Explanation: 
resource "aws_iam_policy" "chewbacca_ec2_SSMParam_policy" {
  name        = "${local.name_prefix}-ec2-SSMParam-policy"
  description = "SSM Paramater Store Permission"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "AmazonSSMManagedInstanceCore",
        Effect = "Allow",
        Action = [
          "ssm:DescribeAssociation",
          "ssm:GetDeployablePatchSnapshotForInstance",
          "ssm:GetDocument",
          "ssm:DescribeDocument",
          "ssm:GetManifest",
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:GetParametersByPath",
          "ssm:ListAssociations",
          "ssm:ListInstanceAssociations",
          "ssm:PutInventory",
          "ssm:PutComplianceItems",
          "ssm:PutConfigurePackageResult",
          "ssm:UpdateAssociationStatus",
          "ssm:UpdateInstanceAssociationStatus",
          "ssm:UpdateInstanceInformation"
        ]
        #Resource = "arn:aws:ssm:${var.aws_region}:${data.aws_caller_identity.chewbacca_self01.account_id}:parameter/lab/db/*"
        Resource = "*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel"
        ],
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "ec2messages:AcknowledgeMessage",
          "ec2messages:DeleteMessage",
          "ec2messages:FailMessage",
          "ec2messages:GetEndpoint",
          "ec2messages:GetMessages",
          "ec2messages:SendReply"
        ],
        "Resource": "*"
      }
    ]
  })
}

resource "aws_iam_policy" "chewbacca_ec2_s3_access" {
  name        = "${local.name_prefix}-ec2-s3-access01"
  description = "Allows Private EC2 to access S3 bucket for package download/install"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "S3AccessObject"
        Effect = "Allow"
        Action = [
          "s3:GetObject"
        ]
        Resource = "*"
      }
    ]
  })
}


# Explanation: 
resource "aws_iam_role_policy_attachment" "chewbacca_attach_lp_secret01" {
  role       = aws_iam_role.chewbacca_ec2_role01.name
  policy_arn = aws_iam_policy.chewbacca_ec2_read_secret01.arn
}

# Explanation: 
resource "aws_iam_role_policy_attachment" "chewbacca_attach_cw_agent" {
  role       = aws_iam_role.chewbacca_ec2_role01.name
  policy_arn = aws_iam_policy.chewbacca_ec2_CWAgent_policy.arn
}

# Explanation: 
resource "aws_iam_role_policy_attachment" "chewbacca_attach_ssm_param" {
  role       = aws_iam_role.chewbacca_ec2_role01.name
  policy_arn = aws_iam_policy.chewbacca_ec2_SSMParam_policy.arn
}

# Explanation: 
resource "aws_iam_role_policy_attachment" "chewbacca_attach_s3_access" {
  role       = aws_iam_role.chewbacca_ec2_role01.name
  policy_arn = aws_iam_policy.chewbacca_ec2_s3_access.arn
}

# Explanation: Instance profile is the harness that straps the role onto the EC2 like bandolier ammo.
resource "aws_iam_instance_profile" "chewbacca_instance_profile01" {
  name = "${local.name_prefix}-instance-profile01"
  role = aws_iam_role.chewbacca_ec2_role01.name
}


############################################
# Lambda Function and Execution Role
############################################

# The Lambda needs an IAM role that allows it to interact with the secret and log its progress

# IAM Role for the Rotator Lambda
resource "aws_iam_role" "lambda_rotator_role" {
  name = "${local.name_prefix}-lambda-role01"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid = "LambdaAssumeRole"
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

# IAM Policy for Rotation Logic
resource "aws_iam_role_policy" "lambda_rotator_policy" {
  name = "${local.name_prefix}-lambda-policy"
  role = aws_iam_role.lambda_rotator_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        # Necessary permissions for the rotation lifecycle
        Sid = "RotateSecret"
        Effect   = "Allow"
        Action = [
          "secretsmanager:DescribeSecret",
          "secretsmanager:GetSecretValue",
          "secretsmanager:PutSecretValue",
          "secretsmanager:UpdateSecretVersionStage"
        ]
        Resource = "arn:aws:secretsmanager:${var.aws_region}:${data.aws_caller_identity.chewbacca_self01.account_id}:secret:${local.name_prefix}/rds/mysql*"
      },
      {
        # Permission to generate a random password (if applicable)
        Sid = "GenertateNewPassword"
        Effect   = "Allow"
        Action   = "secretsmanager:GetRandomPassword"
        Resource = "*"
      },
      {
        # Basic logging
        Sid = "AllowLogging"
        Effect   = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
        ]
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}
