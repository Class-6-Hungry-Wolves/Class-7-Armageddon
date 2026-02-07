############################################
# Lab 3: São Paulo EC2 Instance (Stateless App Host)
# Connects to Tokyo RDS via Transit Gateway
############################################

#-----------------------------------------------------------------------------
# IAM Role + Instance Profile
#-----------------------------------------------------------------------------

resource "aws_iam_role" "liberdade_ec2_role01" {
  provider = aws.saopaulo
  name     = "${local.saopaulo_prefix}-ec2-role01"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })

  tags = local.saopaulo_tags
}

# Cross-region access to Tokyo Secrets Manager
resource "aws_iam_role_policy" "liberdade_ec2_read_secret" {
  provider = aws.saopaulo
  name     = "${local.saopaulo_prefix}-ec2-read-secret-policy"
  role     = aws_iam_role.liberdade_ec2_role01.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "ReadTokyoSecret"
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = "arn:aws:secretsmanager:ap-northeast-1:${data.aws_caller_identity.current.account_id}:secret:chewbacca/rds/mysql*"
      },
      {
        Sid    = "ReadTokyoSSMParams"
        Effect = "Allow"
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:GetParametersByPath"
        ]
        Resource = "arn:aws:ssm:ap-northeast-1:${data.aws_caller_identity.current.account_id}:parameter/chewbacca/*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "liberdade_ec2_ssm_attach" {
  provider   = aws.saopaulo
  role       = aws_iam_role.liberdade_ec2_role01.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "liberdade_ec2_cw_attach" {
  provider   = aws.saopaulo
  role       = aws_iam_role.liberdade_ec2_role01.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_instance_profile" "liberdade_instance_profile01" {
  provider = aws.saopaulo
  name     = "${local.saopaulo_prefix}-instance-profile01"
  role     = aws_iam_role.liberdade_ec2_role01.name
}

#-----------------------------------------------------------------------------
# EC2 Instance (Private Subnet - Stateless)
#-----------------------------------------------------------------------------

resource "aws_instance" "liberdade_ec201" {
  provider               = aws.saopaulo
  ami                    = var.saopaulo_ec2_ami_id
  instance_type          = var.ec2_instance_type
  subnet_id              = aws_subnet.liberdade_private_subnet01.id
  vpc_security_group_ids = [aws_security_group.liberdade_ec2_sg01.id]
  iam_instance_profile   = aws_iam_instance_profile.liberdade_instance_profile01.name

  user_data = file("${path.module}/user_data_saopaulo.sh")

  tags = merge(local.saopaulo_tags, {
    Name       = "${local.saopaulo_prefix}-ec201"
    Compliance = "APPI-Stateless"
  })
}
