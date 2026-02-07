############################################
# Lab 3: Tokyo EC2 Instance (App Host)
############################################

#-----------------------------------------------------------------------------
# IAM Role + Instance Profile
#-----------------------------------------------------------------------------

resource "aws_iam_role" "chewbacca_ec2_role01" {
  name = "${local.tokyo_prefix}-ec2-role01"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })

  tags = local.tokyo_tags
}

resource "aws_iam_role_policy" "chewbacca_ec2_read_secret" {
  name = "${local.tokyo_prefix}-ec2-read-secret-policy"
  role = aws_iam_role.chewbacca_ec2_role01.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "ReadSpecificSecret"
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = "arn:aws:secretsmanager:ap-northeast-1:${data.aws_caller_identity.current.account_id}:secret:chewbacca/rds/mysql*"
      },
      {
        Sid    = "ReadSSMParams"
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

resource "aws_iam_role_policy_attachment" "chewbacca_ec2_ssm_attach" {
  role       = aws_iam_role.chewbacca_ec2_role01.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "chewbacca_ec2_cw_attach" {
  role       = aws_iam_role.chewbacca_ec2_role01.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_instance_profile" "chewbacca_instance_profile01" {
  name = "${local.tokyo_prefix}-instance-profile01"
  role = aws_iam_role.chewbacca_ec2_role01.name
}

#-----------------------------------------------------------------------------
# EC2 Instance (Private Subnet)
#-----------------------------------------------------------------------------

resource "aws_instance" "chewbacca_ec201" {
  ami                    = var.tokyo_ec2_ami_id
  instance_type          = var.ec2_instance_type
  subnet_id              = aws_subnet.chewbacca_private_subnet01.id
  vpc_security_group_ids = [aws_security_group.chewbacca_ec2_sg01.id]
  iam_instance_profile   = aws_iam_instance_profile.chewbacca_instance_profile01.name

  user_data = file("${path.module}/user_data_tokyo.sh")

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-ec201"
  })
}
