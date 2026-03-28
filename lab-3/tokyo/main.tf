# Locals Block to keep in line with DRY methodology


locals {
  project_name_prefix = var.project_name
  environment         = var.environment
}





############################
####### NETWORK ############
############################




# VPC with DNS support and hostnames enabled

resource "aws_vpc" "shinjuku-vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-shinjuku-vpc"
  }
}

# Public Subnets where our ALB will be housed

resource "aws_subnet" "shinjuku-public-subnet" {
  vpc_id                  = aws_vpc.shinjuku-vpc.id
  for_each                = var.public_subnet_config
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.az
  map_public_ip_on_launch = true
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-shinjuku-public-subnet"
  }
}

# Private Subnets where our app lab app will reside
resource "aws_subnet" "shinjuku-private-subnet" {
  vpc_id            = aws_vpc.shinjuku-vpc.id
  for_each          = var.private_subnet_config
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-shinjuku-private-subnet"
  }
}


# Private Subnets where our RDS database will reside
resource "aws_subnet" "shinjuku-database-subnet" {
  vpc_id                  = aws_vpc.shinjuku-vpc.id
  for_each                = var.database_subnet_config
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.az
  map_public_ip_on_launch = false
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-shinjuku-database-subnet"
  }
}

# Internet gateway to establish outside internet communication
resource "aws_internet_gateway" "shinjuku_igw" {
  vpc_id = aws_vpc.shinjuku-vpc.id
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-shinjuku-igw"
  }
}


# Elastic IP to attach to nat gateway 
resource "aws_eip" "shinjuku_nat_eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.shinjuku_igw]
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-shinjuku-nat-eip"
  }
}

# NAT Gateway to provide outbound internet access to private resources
resource "aws_nat_gateway" "shinjuku_nat_gateway" {
  depends_on    = [aws_subnet.shinjuku-public-subnet]
  allocation_id = aws_eip.shinjuku_nat_eip.id
  subnet_id     = aws_subnet.shinjuku-public-subnet["shinjuku_public_subnet_1"].id
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-shinjuku-nat_gateway"
  }
}

# Public Route table with corresponding default route of 0.0.0.0/0 to provide access from all IPS
resource "aws_route_table" "shinjuku_public_rtb" {
  vpc_id = aws_vpc.shinjuku-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.shinjuku_igw.id
  }
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-shinjuku-public_rtb"
  }
}

# Private Route table with corresponding default route of 0.0.0.0/0 to provide access from all IPS
resource "aws_route_table" "shinjuku_private_rtb" {
  vpc_id = aws_vpc.shinjuku-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.shinjuku_nat_gateway.id
  }
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-shinjuku-private_rtb"
  }
}


resource "aws_route" "shinjuku_to_liberdade_route01" {
  route_table_id         = aws_route_table.shinjuku_private_rtb.id
  destination_cidr_block = "10.81.0.0/16" # Liberdade VPC CIDR block
  transit_gateway_id     = aws_ec2_transit_gateway.shinjuku_tgw01.id
}

# Public Route Table association for public subnets
resource "aws_route_table_association" "shinjuku_public_rtb_association" {
  for_each       = aws_subnet.shinjuku-public-subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.shinjuku_public_rtb.id
}

# Private Route Table association for private subnets
resource "aws_route_table_association" "shinjuku_private_rtb_association" {
  for_each       = aws_subnet.shinjuku-private-subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.shinjuku_private_rtb.id
}

# Private Route Table association for database subnets
resource "aws_route_table_association" "shinjuku_database_rtb_association" {
  for_each       = aws_subnet.shinjuku-database-subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.shinjuku_private_rtb.id
}


# Security group for our note inserting app
resource "aws_security_group" "shinjuku_app_sg" {
  name        = "${local.project_name_prefix}-${local.environment}-shinjuku-app-sg"
  description = "This is the app Security Group that will allow the app to have public internet access"
  vpc_id      = aws_vpc.shinjuku-vpc.id
}

# Security Group for our RDS MYSQL Database
resource "aws_security_group" "shinjuku_rds_sg" {
  name        = "${local.project_name_prefix}-${local.environment}-shinjuku-rds-sg"
  description = "This is the RDS Security Group that will only allow inbound access from our app"
  vpc_id      = aws_vpc.shinjuku-vpc.id
}

# Security group for rotation lambda
resource "aws_security_group" "shinjuku_lambda_sg" {
  name        = "${local.project_name_prefix}-${local.environment}-shinjuku-lambda-sg"
  description = "This is the rotation Lambda Security Group that will have outbound access to our database"
  vpc_id      = aws_vpc.shinjuku-vpc.id
}

# Security group for packer builds. Had to use Packer because of Terraform limitations with file size for userdata. 
resource "aws_security_group" "shinjuku_packer_sg" {
  name        = "${local.project_name_prefix}-${local.environment}-shinjuku-packer-sg"
  description = "This is the Packer Security Group that will allow Packer to build the rdsapp AMI"
  vpc_id      = aws_vpc.shinjuku-vpc.id
}



# Default outbound rule for our App Security Group, do not touch
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_from_port_80_ipv4" {
  security_group_id = aws_security_group.shinjuku_app_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}





# Ingress/inbound rule for our Database Security Group that is allowing only the App Security Group to access it
resource "aws_vpc_security_group_ingress_rule" "allow_port_3306" {
  security_group_id            = aws_security_group.shinjuku_rds_sg.id
  referenced_security_group_id = aws_security_group.shinjuku_app_sg.id
  from_port                    = 3306
  ip_protocol                  = "tcp"
  to_port                      = 3306
}

# Ingress/inbound rule for our Database Security Group that is allowing only the Lambda Security Group to access it
resource "aws_vpc_security_group_ingress_rule" "allow_lambda_sg" {
  security_group_id            = aws_security_group.shinjuku_rds_sg.id
  referenced_security_group_id = aws_security_group.shinjuku_lambda_sg.id
  from_port                    = 3306
  ip_protocol                  = "tcp"
  to_port                      = 3306
}


# Default outbound rule for our Database Security Group, do not touch
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_from_port_3306_ipv4" {
  security_group_id = aws_security_group.shinjuku_rds_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


# Default outbound rule for Lambda Security Group, do not touch 
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_from_lambda_sg" {
  security_group_id = aws_security_group.shinjuku_lambda_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# Default outbound rule for Packer Security Group, do not touch
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_from_packer_sg" {
  security_group_id = aws_security_group.shinjuku_packer_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


#############################
######### IAM ###############

# IAM role for EC2 RDS Notes App to assume
resource "aws_iam_role" "ec2_app_role" {
  name = "${local.project_name_prefix}-${local.environment}-ec2-read-rds-secret"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = ["sts:AssumeRole"]
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

# IAM role for Lambda function to assume
resource "aws_iam_role" "lambda_secret_rotation_function_role" {
  name = "${local.project_name_prefix}-${local.environment}-lambda-secret-rotation-function-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = ["sts:AssumeRole"]
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}


# IAM role for Packer to assume during AMI build
resource "aws_iam_role" "packer_role" {
  name = "${local.project_name_prefix}-${local.environment}-packer-builder-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = ["sts:AssumeRole"]
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}


# IAM Policy document to allow EC2 RDS Notes App to read RDS secret from Secrets Manager and read DB parameters from SSM Parameter Store
data "aws_iam_policy_document" "ec2_read_rds_secret" {
  statement {
    sid    = "ReadSpecificSecret"
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
    ]
    resources = [
      "arn:aws:secretsmanager:ap-northeast-1:082258817095:secret:armageddon/rds/mysql*"
    ]
  }
  statement {
    sid    = "ReadDBValueParamsFromSSM"
    effect = "Allow"
    actions = [
      "ssm:GetParameters",
      "ssm:GetParameter",
      "ssm:GetParametersByPath"
    ]
    resources = ["arn:aws:ssm:ap-northeast-1:082258817095:parameter/armageddon/rds/mysql/*"]
  }

  statement {
    sid       = "DecryptSSMSecureString"
    effect    = "Allow"
    actions   = ["kms:Decrypt"]
    resources = ["arn:aws:kms:ap-northeast-1:082258817095:key/*"]
  }
}

# IAM Policy Document for EC2 RDS Notes App to read instance metadata
data "aws_iam_policy_document" "ec2_read_instance_metadata" {
  statement {
    sid       = "DescribeInstances"
    effect    = "Allow"
    actions   = ["ec2:DescribeInstances"]
    resources = ["*"]
  }

  statement {
    sid       = "GetInstanceProfile"
    effect    = "Allow"
    actions   = ["iam:GetInstanceProfile"]
    resources = ["arn:aws:iam::082258817095:instance-profile/lab1-dev-ec2-instance-profile"]
  }
}

# IAM Policy Document for RDS Notes App to write CloudWatch logs and put metrics into streams
data "aws_iam_policy_document" "ec2_cloudwatch_policy" {
  statement {
    sid    = "CloudWatchLogPerms"
    effect = "Allow"
    actions = ["logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents",
    "cloudwatch:PutMetricData"]
    resources = ["*"]
  }
}

# IAM Policy Document for EC2 Session Manager access
data "aws_iam_policy_document" "ec2_session_manager_role_policy" {
  statement {
    sid    = "EnableSSMSessionManager"
    effect = "Allow"
    actions = [
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenDataChannel",
      "ssmmessages:CreateControlChannel",
      "ssmmessages:OpenControlChannel",
      "ssm:UpdateInstanceInformation",
    ]
    resources = ["*"]
  }
  statement {
    sid    = "EnableEC2Messages"
    effect = "Allow"
    actions = [
      "ec2messages:AcknowledgeMessage",
      "ec2messages:DeleteMessage",
      "ec2messages:FailMessage",
      "ec2messages:GetEndpoint",
      "ec2messages:GetMessages",
      "ec2messages:SendReply"
    ]
    resources = ["*"]
  }
}


# IAM Policy Document for Lambda that will rotate DB password
data "aws_iam_policy_document" "lambda_secret_rotation_function" {
  statement {
    sid    = "RotateSpecific"
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
      "secretsmanager:PutSecretValue",
      "secretsmanager:UpdateSecretVersionStage",
    ]
    resources = [
      "arn:aws:secretsmanager:ap-northeast-1:082258817095:secret:armageddon/rds/mysql*"
    ]
  }

  statement {
    sid       = "GenerateRandomPasswords"
    effect    = "Allow"
    actions   = ["secretsmanager:GetRandomPassword"]
    resources = ["*"]
  }


  statement {
    sid    = "AWSLambdaVPCAccessExecutionPermissions"
    effect = "Allow"
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeSubnets",
      "ec2:DeleteNetworkInterface",
      "ec2:AssignPrivateIpAddresses",
      "ec2:UnassignPrivateIpAddresses"
    ]
    resources = ["*"]
  }
}


# IAM policy for Secret Rotation Lambda
resource "aws_iam_policy" "lambda_secret_rotation_function_policy" {
  name   = "lambda-secret-rotation-function-policy"
  policy = data.aws_iam_policy_document.lambda_secret_rotation_function.json
}

# IAM policy for EC2 RDS Notes App
resource "aws_iam_policy" "ec2_read_rds_secret_policy" {
  name   = "ec2-read-rds-secret-policy"
  policy = data.aws_iam_policy_document.ec2_read_rds_secret.json
}


resource "aws_iam_policy" "ec2_cloudwatch_policy" {
  name   = "ec2-cloudwatch-policy"
  policy = data.aws_iam_policy_document.ec2_cloudwatch_policy.json
}


resource "aws_iam_policy" "ec2_read_instance_metadata_policy" {
  name   = "ec2-read-instance-metadata-policy"
  policy = data.aws_iam_policy_document.ec2_read_instance_metadata.json
}

# IAM policy attachment for Secret Rotation Lambda 
resource "aws_iam_role_policy_attachment" "lambda_secret_rotation_function_role_attachment" {
  role       = aws_iam_role.lambda_secret_rotation_function_role.name
  policy_arn = aws_iam_policy.lambda_secret_rotation_function_policy.arn
}

resource "aws_iam_policy" "ec2_session_manager_role_policy" {
  name   = "ec2-session-manager-role-policy"
  policy = data.aws_iam_policy_document.ec2_session_manager_role_policy.json
}

# IAM policy attachment for Packer builder role
resource "aws_iam_role_policy_attachment" "packer_builder_role_policy_attachment" {
  role       = aws_iam_role.packer_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}


# IAM policy attachment for EC2 RDS Notes App to read RDS secrets
resource "aws_iam_role_policy_attachment" "ec2_read_instance_metadata_role_attachment" {
  role       = aws_iam_role.ec2_app_role.name
  policy_arn = aws_iam_policy.ec2_read_instance_metadata_policy.arn
}

# IAM policy attachment for EC2 RDS Notes App to read instance metadata
resource "aws_iam_role_policy_attachment" "ec2_read_rds_secret_role_attachment" {
  role       = aws_iam_role.ec2_app_role.name
  policy_arn = aws_iam_policy.ec2_read_rds_secret_policy.arn
}

# IAM policy attachment for EC2 RDS Notes App to write CloudWatch logs and metrics
resource "aws_iam_role_policy_attachment" "ec2_cloudwatch_role_attachment" {
  role       = aws_iam_role.ec2_app_role.name
  policy_arn = aws_iam_policy.ec2_cloudwatch_policy.arn
}

# IAM policy attachment for EC2 RDS Notes App to use Session Manager
resource "aws_iam_role_policy_attachment" "ec2_session_manager_role_attachment" {
  role       = aws_iam_role.ec2_app_role.name
  policy_arn = aws_iam_policy.ec2_session_manager_role_policy.arn
}

# IAM instance profile for EC2 RDS Notes App to use to perform Secrets Manager, SSM, and Cloudwatch operations
resource "aws_iam_instance_profile" "lab1_ec2_instance_profile" {
  role = aws_iam_role.ec2_app_role.name
  name = "lab1-${local.environment}-ec2-instance-profile"
}

resource "aws_iam_instance_profile" "packer_builder_instance_profile" {
  role = aws_iam_role.packer_role.name
  name = "${local.project_name_prefix}-${local.environment}-packer-builder-instance-profile"
}
