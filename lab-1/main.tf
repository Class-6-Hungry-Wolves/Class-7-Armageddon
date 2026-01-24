# Locals Block to keep in line with DRY methodology


locals {
  project_name_prefix = var.project_name
  environment         = var.environment
}





############################
####### NETWORK ############
############################




# VPC with DNS support and hostnames enabled

resource "aws_vpc" "lab-1a-vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    name = "${local.project_name_prefix}-${local.environment}-lab-1a-vpc"
  }
}

# Public Subnets where our EC2 will be housed

resource "aws_subnet" "lab-1a-public-subnet" {
  vpc_id                  = aws_vpc.lab-1a-vpc.id
  for_each                = var.public_subnet_config
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.az
  map_public_ip_on_launch = true
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-lab1a-public-subnet"
  }
}

# Private Subnets where our RDS database will reside
resource "aws_subnet" "lab-1a-database-subnet" {
  vpc_id                  = aws_vpc.lab-1a-vpc.id
  for_each                = var.database_subnet_config
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.az
  map_public_ip_on_launch = false
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-lab1a-database-subnet"
  }
}

# Internet gateway to establish outside internet communication
resource "aws_internet_gateway" "lab_1a_igw" {
  vpc_id = aws_vpc.lab-1a-vpc.id
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-lab_1a_igw"
  }
}


# Elastic IP to attach to nat gateway 
resource "aws_eip" "lab_1a_nat_eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.lab_1a_igw]
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-lab_1a_nat_eip"
  }
}

# NAT Gateway to provide outbound internet access to private resources
resource "aws_nat_gateway" "lab_1a_nat_gateway" {
  depends_on    = [aws_subnet.lab-1a-public-subnet]
  allocation_id = aws_eip.lab_1a_nat_eip.id
  subnet_id     = aws_subnet.lab-1a-public-subnet["lab_1a_subnet_1"].id
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-lab_1a_nat_gateway"
  }
}

# Public Route table with corresponding default route of 0.0.0.0/0 to provide access from all IPS
resource "aws_route_table" "lab_1a_public_rtb" {
  vpc_id = aws_vpc.lab-1a-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab_1a_igw.id
  }
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-lab_1a_public_rtb"
  }
}

# Private Route table with corresponding default route of 0.0.0.0/0 to provide access from all IPS
resource "aws_route_table" "lab_1a_private_rtb" {
  vpc_id = aws_vpc.lab-1a-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.lab_1a_nat_gateway.id
  }
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-lab_1a_private_rtb"
  }
}

# Public Route Table association for public subnets
resource "aws_route_table_association" "lab_1a_public_rtb_association" {
  for_each       = aws_subnet.lab-1a-public-subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.lab_1a_public_rtb.id
}

# Private Route Table association for private subnets
resource "aws_route_table_association" "lab_1a_private_rtb_association" {
  for_each       = aws_subnet.lab-1a-database-subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.lab_1a_private_rtb.id
}






##############################
###### SECURITY GROUPS #######
##############################





# Security group for our note inserting app
resource "aws_security_group" "lab_1a_ec2_sg" {
  name        = "${local.project_name_prefix}-${local.environment}-lab1a-ec2-sg"
  description = "This is the EC2 Security Group that will allow the EC2 to have public internet access"
  vpc_id      = aws_vpc.lab-1a-vpc.id
}

# Security Group for our RDS MYSQL Database
resource "aws_security_group" "lab_1a_rds_sg" {
  name        = "${local.project_name_prefix}-${local.environment}-lab1a-rds-sg"
  description = "This is the RDS Security Group that will only allow inbound access from our EC2"
  vpc_id      = aws_vpc.lab-1a-vpc.id
}

# Security group for rotation lambda
resource "aws_security_group" "lab_1a_lambda_sg" {
  name        = "${local.project_name_prefix}-${local.environment}-lab1a-lambda-sg"
  description = "This is the rotation Lambda Security Group that will have outbound access to our database"
  vpc_id      = aws_vpc.lab-1a-vpc.id
}




# Ingress/inbound rule for our App Security Group that allows web traffic on port 80
resource "aws_vpc_security_group_ingress_rule" "allow_port_80" {
  security_group_id = aws_security_group.lab_1a_ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

# Optional ingress/inbound rule for our App Security Group that allows SSH access on port 22
resource "aws_vpc_security_group_ingress_rule" "allow_port_22" {
  security_group_id = aws_security_group.lab_1a_ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# Default outbound rule for our App Security Group, do not touch
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_from_port_80_ipv4" {
  security_group_id = aws_security_group.lab_1a_ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}





# Ingress/inbound rule for our Database Security Group that is allowing only the App Security Group to access it
resource "aws_vpc_security_group_ingress_rule" "allow_port_3306" {
  security_group_id            = aws_security_group.lab_1a_rds_sg.id
  referenced_security_group_id = aws_security_group.lab_1a_ec2_sg.id
  from_port                    = 3306
  ip_protocol                  = "tcp"
  to_port                      = 3306
}

# Ingress/inbound rule for our Database Security Group that is allowing only the Lambda Security Group to access it
resource "aws_vpc_security_group_ingress_rule" "allow_lambda_sg" {
  security_group_id            = aws_security_group.lab_1a_rds_sg.id
  referenced_security_group_id = aws_security_group.lab_1a_lambda_sg.id
  from_port                    = 3306
  ip_protocol                  = "tcp"
  to_port                      = 3306
}


# Default outbound rule for our Database Security Group, do not touch
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_from_port_3306_ipv4" {
  security_group_id = aws_security_group.lab_1a_rds_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}




# Default outbound rule for Lambda Security Group, do not touch 
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_from_lambda_sg" {
  security_group_id = aws_security_group.lab_1a_lambda_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}






#############################
######### IAM ###############

# IAM role for EC2 RDS Notes App to assume
resource "aws_iam_role" "ec2_read_rds_secret_role" {
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

# IAM Policy document to pass gates in validation folder
data "aws_iam_policy_document" "ec2_read_rds_secret" {
  statement {
    sid    = "ReadSpecificSecret"
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
    ]
    resources = [
      "arn:aws:secretsmanager:us-east-1:082258817095:secret:armageddon/rds/mysql*"
    ]
  }

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

  statement {
    sid = "ReadDBValueParamsFromSSM"
    effect = "Allow"
    actions = [ 
          "ssm:GetParameters",
          "ssm:GetParameter",
          "ssm:GetParametersByPath"
     ]
     resources = ["arn:aws:ssm:us-east-1:082258817095:parameter/armageddon/rds/mysql/*"]
  }

  statement {
    sid = "DecryptSSMSecureString"
    effect = "Allow"
    actions = ["kms:Decrypt"]
    resources = [ "arn:aws:kms:us-east-1:082258817095:key/*" ]
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
      "arn:aws:secretsmanager:us-east-1:082258817095:secret:armageddon/rds/mysql*"
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

# IAM policy attachment for Secret Rotation Lambda 
resource "aws_iam_role_policy_attachment" "lambda_secret_rotation_function_role_attachment" {
  role       = aws_iam_role.lambda_secret_rotation_function_role.name
  policy_arn = aws_iam_policy.lambda_secret_rotation_function_policy.arn
}


# IAM policy attachment for EC2 RDS Notes App
resource "aws_iam_role_policy_attachment" "ec2_read_rds_secret_role_attachment" {
  role       = aws_iam_role.ec2_read_rds_secret_role.name
  policy_arn = aws_iam_policy.ec2_read_rds_secret_policy.arn
}

# IAM instance profile for EC2 RDS Notes App to use to perform Secrets Manager operations
resource "aws_iam_instance_profile" "lab1_ec2_instance_profile" {
  role = aws_iam_role.ec2_read_rds_secret_role.name
  name = "lab1-${local.environment}-ec2-instance-profile"
}




#############################
##### EC2 INSTANCE ##########
#############################

data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon"]
}

data "aws_key_pair" "lab1a-key-pair" {
  key_name           = "lab1a-key-pair"
  include_public_key = true

  filter {
    name   = "key-name"
    values = ["lab1a-key-pair"]
  }
}


# EC2 instance that will house our RDS Notes App
resource "aws_instance" "lab1_ec2_instance" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = data.aws_key_pair.lab1a-key-pair.key_name
  subnet_id              = aws_subnet.lab-1a-public-subnet["lab_1a_subnet_1"].id
  user_data              = file("./userdata.sh")
  iam_instance_profile   = aws_iam_instance_profile.lab1_ec2_instance_profile.name
  vpc_security_group_ids = [aws_security_group.lab_1a_ec2_sg.id]
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-ec2-labapp-instance"
  }
  lifecycle {
    create_before_destroy = true
  }
}



#################################
######### DATABASE ##############
#################################

# Private Database Subnet group for our RDS database
resource "aws_db_subnet_group" "lab1b_rds_subnet_group01" {
  name       = "${local.project_name_prefix}-${local.environment}-rds-subnet-group01"
  subnet_ids = [for i in aws_subnet.lab-1a-database-subnet : i.id]

  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-rds-subnet-group01"
  }
}

# RDS MYSQL Database that will house our notes table
resource "aws_db_instance" "lab1-rds01" {
  identifier        = "${local.environment}rds01"
  engine            = var.db-engine
  instance_class    = var.db_instance_class
  allocated_storage = 20
  db_name           = var.db_name
  username          = var.db_username
  password          = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.lab1b_rds_subnet_group01.name
  vpc_security_group_ids = [aws_security_group.lab_1a_rds_sg.id]

  publicly_accessible = false
  skip_final_snapshot = true
  lifecycle {
    ignore_changes = [password] # Prevents overwriting state when rotation occurs
  }
}

############################################
# PARAMETER STORE (SSM Parameters)
############################################

# Explanation: Parameter Store is the database's map. Endpoints and config live here for fast recovery.
resource "aws_ssm_parameter" "lab1b_db_endpoint_param" {
  name  = "/armageddon/rds/mysql/host"
  type  = "SecureString"
  value = aws_db_instance.lab1-rds01.address

  tags = {
    Name = "${local.project_name_prefix}-param-db-endpoint"
  }
}

# Explanation: DB port is the secret handshake. Without it, no entry.
resource "aws_ssm_parameter" "lab1b_db_port_param" {
  name  = "/armageddon/rds/mysql/port"
  type  = "SecureString"
  value = tostring(aws_db_instance.lab1-rds01.port)

  tags = {
    Name = "${local.project_name_prefix}-param-db-port"
  }
}

# Explanation: DB name is the label on the crate—without it, you’re rummaging in the dark.
resource "aws_ssm_parameter" "lab1b_db_name_param" {
  name  = "/armageddon/rds/mysql/dbname"
  type  = "SecureString"
  value = var.db_name

  tags = {
    Name = "${local.project_name_prefix}-param-db-name"
  }
}



###########################
##### SECRETS MANAGER #####
###########################






# Explanation: Secrets Manager is lab1b’s locked holster—credentials go here, not in code.
resource "aws_secretsmanager_secret" "armageddon_db_secret01" {
  name                    = "armageddon/rds/mysql"
  recovery_window_in_days = 0
}

# Explanation: Secret payload—students should align this structure with their app (and support rotation later).
resource "aws_secretsmanager_secret_version" "armageddon_db_secret_version01" {
  secret_id = aws_secretsmanager_secret.armageddon_db_secret01.id

  secret_string = jsonencode({
    engine   = var.db-engine
    username = var.db_username
    password = var.db_password
  })
  lifecycle {
    ignore_changes = [secret_string] # Prevents overwriting state when rotation occurs
  }
}



resource "aws_secretsmanager_secret_rotation" "rotation" {
  secret_id           = aws_secretsmanager_secret.armageddon_db_secret01.id
  rotation_lambda_arn = aws_lambda_function.lab1a_lambda_secret_rotation_function.arn
  rotate_immediately  = true # For lab testing purposes only; remove for production

  rotation_rules {
    automatically_after_days = 30
  }
}



##############################
###### LAMBDA FUNCTION #######
##############################
data "archive_file" "rotation_zip" {
  type        = "zip"
  source_file = "lambda/rotation_lambda.py"
  output_path = "rotation_lambda.zip"
}



resource "aws_lambda_function" "lab1a_lambda_secret_rotation_function" {
  function_name    = "lab1a_lambda_secret_rotation_function"
  role             = aws_iam_role.lambda_secret_rotation_function_role.arn
  architectures    = ["x86_64"]
  filename         = data.archive_file.rotation_zip.output_path
  runtime          = "python3.13"
  handler          = "rotation_lambda.lambda_handler"
  source_code_hash = data.archive_file.rotation_zip.output_base64sha256

  timeout = 30

  vpc_config {
    subnet_ids         = [for i in aws_subnet.lab-1a-database-subnet : i.id]
    security_group_ids = [aws_security_group.lab_1a_lambda_sg.id]
  }
}



resource "aws_lambda_permission" "secretsmanager_invoke" {
  statement_id  = "AllowExecutionFromSecretsManager"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lab1a_lambda_secret_rotation_function.function_name
  principal     = "secretsmanager.amazonaws.com"
  source_arn    = "arn:aws:secretsmanager:us-east-1:082258817095:secret:armageddon/rds/mysql*"
}



############################################
# CLOUDWATCH LOGS (Log Group)
############################################

# Log Group for RDS Notes App
resource "aws_cloudwatch_log_group" "lab1b_log_group01" {
  name              = "/aws/ec2/armageddon-rds-app"
  retention_in_days = 7

  tags = {
    Name = "${local.project_name_prefix}-log-group01"
  }
}


resource "aws_cloudwatch_metric_alarm" "rds01_db_alarm01" {
  alarm_name          = "${local.project_name_prefix}-db-connection-failure"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "DBConnectionErrors"
  namespace           = "Lab/RDSApp"
  period              = 300
  statistic           = "Sum"
  threshold           = 3

  alarm_actions       = [aws_sns_topic.armageddon_sns_topic01.arn]

  tags = {
    Name = "${local.project_name_prefix}-alarm-db-fail"
  }
}


# Explanation: SNS is the distress beacon—when the DB dies, the galaxy (your inbox) must hear about it.
resource "aws_sns_topic" "armageddon_sns_topic01" {
  name = "${local.project_name_prefix}-db-incidents"
}

# Explanation: Email subscription = “poor man’s PagerDuty”—still enough to wake you up at 3AM.
resource "aws_sns_topic_subscription" "armageddon_sns_sub01" {
  topic_arn = aws_sns_topic.armageddon_sns_topic01.arn
  protocol  = "email"
  endpoint  = var.sns_email_endpoint
}