#########################################################################################
#### =================================== Locals ===================================  ####
#########################################################################################

locals {
  name_prefix = var.project_name
  environment = var.environment
}

#########################################################################################
#### =================================== Network =================================== ####
#########################################################################################

#############
#### VPC ####
#############

resource "aws_vpc" "armageddon-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${local.name_prefix}-vpc"
  }
}

##################
#### Subnets  ####
###################

# Explanation: Public subnets are like docking bays—ships can land directly from space (internet).
resource "aws_subnet" "armageddon-public-subnets" {
  count             = length(var.public_subnet_cidrs) # This a is 'length' function that count the number of items in the variable list
  vpc_id            = aws_vpc.armageddon-vpc.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  # map_public_ip_on_launch = true # Best to attach to EC2 as you need to retrive the public IP to run the test

  tags = {
    Name = "${local.name_prefix}-public-subnet-${count.index + 1}" # count.index tells you the postion of the item within the list
  }
}

# Explanation: Private subnets are the hidden Rebel base—no direct access from the internet.
resource "aws_subnet" "armageddon-private-subnets" {
  count             = length(var.private_subnet_cidrs) # This a is 'length' function that count the number of items in the variable list
  vpc_id            = aws_vpc.armageddon-vpc.id
  cidr_block        = var.private_subnet_cidrs[count.index] # This matches 1 item from the CIDRS list with another item within the AWS subnet resource list.
  availability_zone = var.azs[count.index]

  tags = {
    Name = "${local.name_prefix}-private-subnet-${count.index + 1}" # count.index tells you the postion of the item within the list
  }
}

############################
####  Internet Gateway  ####
############################

# Explanation: Even Wookiees need to reach the wider galaxy—IGW is your door to the public internet.
resource "aws_internet_gateway" "armageddon-igw" {
  vpc_id = aws_vpc.armageddon-vpc.id

  tags = {
    Name = "${local.name_prefix}-igw"
  }
}

######################
####  Elastic IP  ####
######################

# Explanation: lab_1a wants the private base to call home—EIP gives the NAT a stable “holonet address.”
resource "aws_eip" "armageddon-eip" {
  domain = "vpc"

  tags = {
    Name = "${local.name_prefix}-eip"
  }
}

######################
#### NAT Gateway  ####
######################

# Explanation: NAT is lab_1a’s smuggler tunnel—private subnets can reach out without being seen.
resource "aws_nat_gateway" "armageddon-regional-nat" {
  allocation_id = aws_eip.armageddon-eip.id
  # subnet_id     = aws_subnet.armageddon-public-subnets[0].id # NAT in a public subnet -- Only apply when 'availability_mode' is set to 'zonal'
  vpc_id            = aws_vpc.armageddon-vpc.id
  availability_mode = "regional" # Argument is needed to make the NAT regionally resilient -- best for terraform version = "> 6.26.0"
  connectivity_type = "public"   # Must be public if 'availability_mode' is regional

  tags = {
    Name = "${local.name_prefix}-regional-nat"
  }

  depends_on = [aws_internet_gateway.armageddon-igw]
}

#######################
####  Route Tables ####
#######################

################## Public Route Table ##################
### Controls routing for public subnets ###
resource "aws_route_table" "public-rtb" {
  vpc_id = aws_vpc.armageddon-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.armageddon-igw.id
  }

  tags = {
    Name = "${local.name_prefix}-public-rtb"
  }
}

### Route Table Association for Public Subnets in each AZ ###
## Provisions resource to associate the route table and the public subnets ##
resource "aws_route_table_association" "pub-rtb-assoc" {
  count          = length(aws_subnet.armageddon-public-subnets)
  subnet_id      = aws_subnet.armageddon-public-subnets[count.index].id
  route_table_id = aws_route_table.public-rtb.id
}

################## Private Route Table ##################
### Controls routing for private subnets ###
resource "aws_route_table" "private-rtb" {
  vpc_id = aws_vpc.armageddon-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.armageddon-regional-nat.id
  }

  tags = {
    Name = "${local.name_prefix}-private-rtb"
  }
}

### Route Table Association for Private Subnets in each AZ ###
## Provisions resource to associate the route table and the private subnets ##
resource "aws_route_table_association" "pvt-rtb-assoc" {
  count          = length(aws_subnet.armageddon-private-subnets)
  subnet_id      = aws_subnet.armageddon-private-subnets[count.index].id
  route_table_id = aws_route_table.private-rtb.id
}

#########################################################################################################
#### ================================= Security Groups (EC2 + RDS) ================================= ####
#########################################################################################################

##########################################
#### Security Group For EC2 (Web App) ####
##########################################

resource "aws_security_group" "armageddon-ec2-sg" {
  name        = "${local.name_prefix}-ec2-sg"
  description = "EC2 Web App security group"
  vpc_id      = aws_vpc.armageddon-vpc.id

  tags = {
    Name = "${local.name_prefix}-ec2-sg"
  }
}

# Allow ingress traffic via RDP
resource "aws_vpc_security_group_ingress_rule" "ec2-rdp-ingress" {
  security_group_id = aws_security_group.armageddon-ec2-sg.id
  cidr_ipv4         = "0.0.0.0/0" # How do I specify it to be from my IP??
  from_port         = 3389
  ip_protocol       = "tcp"
  to_port           = 3389

  tags = {
    Name = "Allow RDP from my IP"
  }
}

# Allow all ingress traffic to EC2 via SSH
resource "aws_vpc_security_group_ingress_rule" "ec2-ssh-ingress" {
  security_group_id = aws_security_group.armageddon-ec2-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22

  tags = {
    Name = "Allow SSH from my IP"
  }
}

# Allow all ingress traffic to EC2 via HTTP
resource "aws_vpc_security_group_ingress_rule" "ec2-http-ingress" {
  security_group_id = aws_security_group.armageddon-ec2-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80

  tags = {
    Name = "Allow HTTP from my IP"
  }
}

# TODO: student ensures outbound allows DB port to RDS SG (or allow all outbound)
# Allow Outbound Traffic to Backend Server
resource "aws_vpc_security_group_egress_rule" "ec2-http-egress" {
  security_group_id            = aws_security_group.armageddon-ec2-sg.id
  referenced_security_group_id = aws_security_group.armageddon-rds-sg.id # Reference the Destination SG -- Allows Outbound traffic to RDS SG
  from_port                    = 80
  ip_protocol                  = "tcp"
  to_port                      = 80

  tags = {
    Name = "Allow all outbound HTTP traffic to Backend Server"
  }
}

# Default -- Allow outbound traffic to all ports and IPs
resource "aws_vpc_security_group_egress_rule" "allow-egress-to-all" {
  security_group_id = aws_security_group.armageddon-ec2-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

#########################################
#### Security Group For RDS Instance ####
#########################################

# Explanation: RDS SG is the Rebel vault—only the app server gets a keycard.
resource "aws_security_group" "armageddon-rds-sg" {
  name        = "${local.name_prefix}-rds-sg"
  description = "RDS security group"
  vpc_id      = aws_vpc.armageddon-vpc.id

  # TODO: student adds inbound MySQL 3306 from aws_security_group.armageddon-ec2_sg.id

  tags = {
    Name = "${local.name_prefix}-rds-sg"
  }
}

# Allow ingress Traffic from EC2 Security Group to RDS Instance and nowehere else
resource "aws_vpc_security_group_ingress_rule" "rds-rdp-ingress" {
  security_group_id            = aws_security_group.armageddon-rds-sg.id
  referenced_security_group_id = aws_security_group.armageddon-ec2-sg.id # Reference the Source SG -- Allow all inbound from EC2 SG
  from_port                    = 3306                                    # MySQL/Aurora port
  ip_protocol                  = "tcp"
  to_port                      = 3306

  tags = {
    Name = "Allow inbound MySQL/Aurora from EC2 SG"
  }
}

# Default -- Allow outbound traffic to all ports and IPs
resource "aws_vpc_security_group_egress_rule" "rdp-egress-to-all" {
  security_group_id = aws_security_group.armageddon-rds-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

####################################################################################################
#### ================================= EC2 Instance (Web App) ================================= ####
####################################################################################################

# AMI Daat Block to make code more resuable instade of hard-coded
data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true # Use the most recent AMI
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"] # The value is found in check AMI catalog or running instance in instance details section in the  console
  }                                       # Retuns a broader range of AMIs
}

# Explanation: This is your “Han Solo box”—it talks to RDS and complains loudly when the DB is down.
resource "aws_instance" "armageddon-ec2" {
  ami                         = data.aws_ami.amzn-linux-2023-ami.id
  instance_type               = var.ec2_instance_type
  subnet_id                   = aws_subnet.armageddon-public-subnets[0].id
  vpc_security_group_ids      = [aws_security_group.armageddon-ec2-sg.id]
  iam_instance_profile        = aws_iam_instance_profile.armageddon-instance-profile.name
  associate_public_ip_address = true # Best to attach to EC2 as you need to retrive the public IP to run the test

  # TODO: student supplies user_data to install app + CW agent + configure log shipping
  user_data = file("${path.module}/1a_user_data.sh")

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${local.name_prefix}-ec2"
  }
}

##########################################################################################
#### ================================= RDS Instance ================================= ####
##########################################################################################

# Private Subnet group DB Instance
resource "aws_db_subnet_group" "armageddon-rds-subnet-group" {
  name       = "armageddon-rds-subnet-group"
  subnet_ids = aws_subnet.armageddon-private-subnets[*].id # Using splat expression [*] collects all IDs from all intances by the count

  tags = {
    Name = "${local.name_prefix}-rds-subnet-group"
  }
}

resource "aws_db_instance" "armageddon-rds" {
  identifier        = "${local.name_prefix}rds" # Only alphanumericals -- do not include hyphens or underscores
  engine            = var.db_engine
  instance_class    = var.db_instance_class
  allocated_storage = 20
  db_name           = var.db_name
  username          = var.db_username
  password          = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.armageddon-rds-subnet-group.name
  vpc_security_group_ids = [aws_security_group.armageddon-rds-sg.id]

  publicly_accessible = false
  skip_final_snapshot = true
  multi_az            = true # ensures that DB is resilient across multiple AZs -- takes a while to deploy if enabled

  lifecycle {
    ignore_changes = [password]
  }

  # TODO: student sets multi_az / backups / monitoring as stretch goals

  tags = {
    Name = "${local.name_prefix}-rds"
  }
}

#################################################################################
#### ================================= IAM ================================= ####
#################################################################################

# Configures EC2 Instance Profile
resource "aws_iam_instance_profile" "armageddon-instance-profile" {
  name = "armageddon-instance-profile"
  role = aws_iam_role.armageddon-ec2-iam-role.name
}

# Using jsonencode -- allows for reference Terraform resources, variables, and local variables
resource "aws_iam_role" "armageddon-ec2-iam-role" {
  name = "armageddon-ec2-iam-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "${local.name_prefix}-ec2-iam-role"
  }
}

# Attaches policy to the role
resource "aws_iam_role_policy_attachment" "policy-attachment" {
  role       = aws_iam_role.armageddon-ec2-iam-role.name
  policy_arn = aws_iam_policy.armageddon-iam-policy.arn
}

# Generates IAM policy
resource "aws_iam_policy" "armageddon-iam-policy" {
  name        = "armageddon-iam-policy"
  description = "Provides permissions to retrieve secrets from Secrets Manager"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["secretsmanager:GetSecretValue"] # Using jsonencode for Theo's in-line policy json document
        Effect   = "Allow"
        Sid      = "SecretsPolicyPermissions"
        Resource = aws_secretsmanager_secret.armageddon-db-secret.arn # Resouces are referneced in ARN format -- Not as hardcoded as Theo's
      },
    ]
  })
}

#############################################################################################
#### ================================= Secrets Manager ================================= ####
#############################################################################################

# Explanation: Secrets Manager is lab_1a’s locked holster—credentials go here, not in code.
resource "aws_secretsmanager_secret" "armageddon-db-secret" {
  name                           = "${local.name_prefix}/rds/mysql01" # delete the '01' or added if the previous secret is still not deleted
  recovery_window_in_days        = 0
  force_overwrite_replica_secret = true
}

# Explanation: Secret payload—students should align this structure with their app (and support rotation later).
resource "aws_secretsmanager_secret_version" "armageddon-db-secret-version" {
  secret_id = aws_secretsmanager_secret.armageddon-db-secret.id

  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
    host     = aws_db_instance.armageddon-rds.address
    port     = aws_db_instance.armageddon-rds.port
    dbname   = var.db_name
  })

  lifecycle {
    ignore_changes = [secret_string]
  }
}





