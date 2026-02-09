# Locals Block to keep in line with DRY methodology

locals {
  project_name_prefix = var.project_name
  environment         = var.environment
}

# VPC with DNS support and hostnames enabled

resource "aws_vpc" "lab_1a_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-lab-1a-vpc"
  }
}

# Public Subnets where our EC2 will be housed

resource "aws_subnet" "lab_1a_public_subnet" {
  vpc_id                  = aws_vpc.lab_1a_vpc.id
  for_each                = var.public_subnet_config
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.az
  map_public_ip_on_launch = true
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-lab1a-public-subnet"
  }
}

# Private Subnets where our RDS database will reside
resource "aws_subnet" "lab_1a_database_subnet" {
  vpc_id                  = aws_vpc.lab_1a_vpc.id
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
  vpc_id = aws_vpc.lab_1a_vpc.id
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
  allocation_id = aws_eip.lab_1a_nat_eip.id
  subnet_id     = aws_subnet.lab_1a_public_subnet["lab_1a_subnet_1"].id
  depends_on    = [aws_internet_gateway.lab_1a_igw]
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-lab_1a_nat_gateway"
  }
}

# Public Route table with corresponding default route of 0.0.0.0/0 to provide access from all IPS
resource "aws_route_table" "lab_1a_public_rtb" {
  vpc_id = aws_vpc.lab_1a_vpc.id
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
  vpc_id = aws_vpc.lab_1a_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.lab_1a_nat_gateway.id
  }
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-lab_1a_private_rtb"
  }
}

# Public Route Table association for public subnets
resource "aws_route_table_association" "lab_1a_public_rtb_association" {
  for_each       = aws_subnet.lab_1a_public_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.lab_1a_public_rtb.id
}

# Private Route Table association for private subnets
resource "aws_route_table_association" "lab_1a_private_rtb_association" {
  for_each       = aws_subnet.lab_1a_database_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.lab_1a_private_rtb.id
}

# Security group for our note inserting app
resource "aws_security_group" "lab_1a_ec2_sg" {
  name        = "${local.project_name_prefix}-${local.environment}-lab1a-ec2-sg"
  description = "This is the EC2 Security Group that will allow the EC2 to have public internet access"
  vpc_id      = aws_vpc.lab_1a_vpc.id
}

# Security Group for our RDS MYSQL Database
resource "aws_security_group" "lab_1a_rds_sg" {
  name        = "${local.project_name_prefix}-${local.environment}-lab1a-rds-sg"
  description = "This is the RDS Security Group that will only allow inbound access from our EC2"
  vpc_id      = aws_vpc.lab_1a_vpc.id
}

# Ingress/inbound rule for our App Security Group that allows web traffic on port 80
resource "aws_vpc_security_group_ingress_rule" "allow_port_80" {
  security_group_id            = aws_security_group.lab_1a_ec2_sg.id
  referenced_security_group_id = aws_security_group.alb_sg.id
  from_port                    = 80
  ip_protocol                  = "tcp"
  to_port                      = 80
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

# Default outbound rule for our Database Security Group, do not touch
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_from_port_3306_ipv4" {
  security_group_id = aws_security_group.lab_1a_rds_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

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

resource "aws_instance" "class_7_instance_from_terraform" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.lab_1a_database_subnet["lab_1a_database_subnet_1"].id
  user_data              = file("./userdata.sh")
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  vpc_security_group_ids = [aws_security_group.lab_1a_ec2_sg.id]
  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-ec2-labapp-instance"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_db_subnet_group" "chewbacca_rds_subnet_group01" {
  name       = "${local.project_name_prefix}-${local.environment}-rds-subnet-group01"
  subnet_ids = [for i in aws_subnet.lab_1a_database_subnet : i.id]

  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-rds-subnet-group01"
  }
}

resource "aws_db_instance" "lab1_rds01" {
  identifier        = "${local.environment}rds01"
  engine            = var.db_engine
  instance_class    = var.db_instance_class
  allocated_storage = 20
  db_name           = var.db_name
  username          = var.db_username
  password          = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.chewbacca_rds_subnet_group01.name
  vpc_security_group_ids = [aws_security_group.lab_1a_rds_sg.id]

  publicly_accessible = false
  skip_final_snapshot = true
}

# Parameter Store entries for DB connection info

resource "aws_ssm_parameter" "db_endpoint" {
  name      = "/lab/db/endpoint"
  type      = "String"
  value     = aws_db_instance.lab1_rds01.address
  overwrite = true
}

resource "aws_ssm_parameter" "db_port" {
  name      = "/lab/db/port"
  type      = "String"
  value     = tostring(aws_db_instance.lab1_rds01.port)
  overwrite = true
}

resource "aws_ssm_parameter" "db_name" {
  name  = "/lab/db/name"
  type  = "String"
  value = var.db_name
}


#Disabled Nick's secretes manager + IAM block for my environment.
#Make sure the block is commented out otherwise terraform won't create the resource in your local environment

# Explanation: Secrets Manager is Chewbacca’s locked holster—credentials go here, not in code.

# Explanation: Secret payload—students should align this structure with their app (and support rotation later).
resource "aws_secretsmanager_secret_version" "armageddon_db_secret_version01" {
  secret_id = aws_secretsmanager_secret.rds_secret.id

  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
    host     = aws_db_instance.lab1_rds01.address
    port     = aws_db_instance.lab1_rds01.port
    dbname   = var.db_name
  })
}

############################################
# Step 1: Add locals to namespace AWS resources to avoid naming collisions
############################################

locals {
  owner = "jmk" # you can change this to your initials, name or anything you want
}

############################################
# Step 2: Use the local variable in the secret name
############################################

resource "aws_secretsmanager_secret" "rds_secret" {
  name                    = "lab/${local.owner}/rds/mysql"
  recovery_window_in_days = 0
}

data "aws_caller_identity" "current" {}

# IAM Role that EC2 instances will assume

# This role is assumed by the EC2 service (ec2.amazonaws.com).
resource "aws_iam_role" "ec2_role" {
  # Name of the role in AWS IAM (visible in console)
  name = "${local.owner}-lab-ec2-role"

  # Trust policy: allows EC2 to call sts:AssumeRole on this role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Recommended Inline Policy attached to EC2 role
# This is the "inline policy attachment" your teacher is talking about.
# It defines WHAT the role can do once EC2 assumes it.

resource "aws_iam_role_policy" "ec2_inline" {
  # Name of the inline policy in AWS (shows under the role)
  name = "${local.owner}-lab-ec2-inline-policy"

  # Attach this policy directly to the EC2 role above
  role = aws_iam_role.ec2_role.id

  # IAM policy document in JSON format
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "ReadOnlyThisSecret",
        Effect = "Allow",
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ],
        Resource = aws_secretsmanager_secret.rds_secret.arn
      },
      {
        Sid    = "ReadOnlyLabParameters",
        Effect = "Allow",
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:GetParametersByPath"
        ],
        Resource = "arn:aws:ssm:${var.aws_region}:${data.aws_caller_identity.current.account_id}:parameter/lab/*"
      },
      {
        Sid    = "WriteLabLogs",
        Effect = "Allow",
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ],
        Resource = [
          "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:${aws_cloudwatch_log_group.lab_rds_app.name}:*",
          "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:${aws_cloudwatch_log_group.lab_rds_app.name}:log-stream:*"
        ]
      }
    ]
  })
}

# Instance Profile EC2 will use
# EC2 cannot attach a role directly. It uses an instance profile
# which wraps the role and is referenced by the EC2 instance.

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${local.owner}-lab-ec2-profile"
  role = aws_iam_role.ec2_role.name
}

# CloudWatch Log Group for Lab 1b application logs

resource "aws_cloudwatch_log_group" "lab_rds_app" {
  name              = "/aws/ec2/lab-rds-app"
  retention_in_days = 7

  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-lab-rds-app-log-group"
  }
}

# SNS topic for DB incident alerts (PagerDuty simulation)

resource "aws_sns_topic" "lab_db_incidents" {
  name = "lab-db-incidents"
}

# Email subscription to the SNS topic

resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.lab_db_incidents.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

# CloudWatch Alarm for DB connection errors (Lab 1C
resource "aws_cloudwatch_metric_alarm" "db_connection_errors_alarm" {
  alarm_name          = "${local.project_name_prefix}-${local.environment}-db-connection-errors"
  alarm_description   = "Triggers when DBConnectionErrors >= 3 in 5 minutes"
  namespace           = "Lab/DB"
  metric_name         = "DBConnectionErrors"
  statistic           = "Sum"
  period              = 60 # 60 seconds per datapoint
  evaluation_periods  = 5  # 5 x 60s = 5 minutes
  threshold           = 3
  comparison_operator = "GreaterThanOrEqualToThreshold"

  treat_missing_data = "notBreaching"

  alarm_actions = [
    aws_sns_topic.lab_db_incidents.arn
  ]

  ok_actions = [
    aws_sns_topic.lab_db_incidents.arn
  ]
}

# VPC Interface Endpoints for private EC2 + SSM + Logs + Secrets
resource "aws_security_group" "vpce_sg" {
  name        = "${local.project_name_prefix}-${local.environment}-vpce-sg"
  description = "VPC endpoint SG"
  vpc_id      = aws_vpc.lab_1a_vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "vpce_allow_443_from_ec2" {
  security_group_id            = aws_security_group.vpce_sg.id
  referenced_security_group_id = aws_security_group.lab_1a_ec2_sg.id
  from_port                    = 443
  to_port                      = 443
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "vpce_allow_all_out" {
  security_group_id = aws_security_group.vpce_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

locals {
  interface_endpoint_services = toset([
    "ssm",
    "ec2messages",
    "ssmmessages",
    "logs",
    "secretsmanager"
  ])
}

resource "aws_vpc_endpoint" "interface" {
  for_each            = local.interface_endpoint_services
  vpc_id              = aws_vpc.lab_1a_vpc.id
  service_name        = "com.amazonaws.${var.aws_region}.${each.value}"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = [for s in aws_subnet.lab_1a_database_subnet : s.id]
  security_group_ids = [aws_security_group.vpce_sg.id]

  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-vpce-${each.value}"
  }
}

# Use S3 Gateway Endpoint (common “gotcha” for private environments)
resource "aws_vpc_endpoint" "s3_gateway" {
  vpc_id            = aws_vpc.lab_1a_vpc.id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.lab_1a_private_rtb.id
  ]

  tags = {
    Name = "${local.project_name_prefix}-${local.environment}-vpce-s3"
  }
}

resource "aws_route53_zone" "maxpayne" {
  name = "maxpayne.lol"
}
