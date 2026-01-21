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
            "sts:AssumeRole"
          ]
        },
      ]
    }
  )

    tags = {
      Name = "${local.name_prefix}-ec2-iam-role"
    }
}

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


# Explanation: These policies are your Wookiee toolbelt—tighten them (least privilege) as a stretch goal.
resource "aws_iam_role_policy_attachment" "chewbacca_ec2_ssm_attach" {
  role       = aws_iam_role.chewbacca_ec2_role01.name
  policy_arn  = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Explanation: EC2 must read secrets/params during recovery—give it access (students should scope it down).
# resource "aws_iam_role_policy_attachment" "chewbacca_ec2_secrets_attach" {
#   role      = aws_iam_role.chewbacca_ec2_role01.name
#   #policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite" # TODO: student replaces w/ least privilege
#   policy_arn = "arn:aws:iam::aws:policy/AWSSecretsManagerClientReadOnlyAccess"
# }

# Explanation: CloudWatch logs are the “ship’s black box”—you need them when things explode.
resource "aws_iam_role_policy_attachment" "chewbacca_ec2_cw_attach" {
  role      = aws_iam_role.chewbacca_ec2_role01.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_role_policy_attachment" "chewbacca_attach_lp_secret01" {
  role       = aws_iam_role.chewbacca_ec2_role01.name
  policy_arn = aws_iam_policy.chewbacca_ec2_read_secret01.arn
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
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

