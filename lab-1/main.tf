#########################################################################################
#### =================================== Locals ===================================  ####
#########################################################################################

locals {
  name_prefix = var.project_name
  environment = var.environment
}

#########################################################################################
#### =================================== VPC =================================== ####
#########################################################################################

resource "aws_vpc" "armageddon-vpc01" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${local.name_prefix}-vpc01"
  }
}

#########################################################################################
#### =================================== Subnets =================================== ####
#########################################################################################

# Explanation: Public subnets are like docking bays—ships can land directly from space (internet).
resource "aws_subnet" "armageddon-public-subnets" {
  count                   = length(var.public_subnet_cidrs) # This a is 'length' function that count the number of items in the variable list
  vpc_id                  = aws_vpc.armageddon-vpc01.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.name_prefix}-public-subnet-${count.index + 1}" # count.index tells you the postion of the item within the list
  }
}

# Explanation: Private subnets are the hidden Rebel base—no direct access from the internet.
resource "aws_subnet" "armageddon-private-subnets" {
  count             = length(var.private_subnet_cidrs) # This a is 'length' function that count the number of items in the variable list
  vpc_id            = aws_vpc.armageddon-vpc01.id
  cidr_block        = var.private_subnet_cidrs[count.index] # This matches 1 item from the CIDRS list with another item within the AWS subnet resource list.
  availability_zone = var.azs[count.index]

  tags = {
    Name = "${local.name_prefix}-private-subnet-${count.index + 1}" # count.index tells you the postion of the item within the list
  }
}

########################################################################################
#### ============================== Internet Gateway ============================== ####
########################################################################################

# Explanation: Even Wookiees need to reach the wider galaxy—IGW is your door to the public internet.
resource "aws_internet_gateway" "armageddon-igw01" {
  vpc_id = aws_vpc.armageddon-vpc01.id

  tags = {
    Name = "${local.name_prefix}-igw01"
  }
}

#####################################################################################
#### =================================== EIP =================================== ####
#####################################################################################

# Explanation: lab_1a wants the private base to call home—EIP gives the NAT a stable “holonet address.”
resource "aws_eip" "armageddon-eip01" {
  domain = "vpc"

  tags = {
    Name = "${local.name_prefix}-eip01"
  }
}


#############################################################################################
#### =================================== NAT Gateway =================================== ####
#############################################################################################

# Explanation: NAT is lab_1a’s smuggler tunnel—private subnets can reach out without being seen.
resource "aws_nat_gateway" "armageddon-regional-nat01" {
  allocation_id = aws_eip.armageddon-eip01.id
  # subnet_id     = aws_subnet.armageddon-public-subnets[0].id # NAT in a public subnet -- Only apply when 'availability_mode' is set to 'zonal'
  vpc_id            = aws_vpc.armageddon-vpc01.id
  availability_mode = "regional" # Argument is needed to make the NAT regionally resilient -- best for terraform version = "> 6.26.0"
  connectivity_type = "public"   # Must be public if 'availability_mode' is regional

  tags = {
    Name = "${local.name_prefix}-regional-nat01"
  }

  depends_on = [aws_internet_gateway.armageddon-igw01]
}


##############################################################################################
#### =================================== Route Tables =================================== ####
##############################################################################################

################## Public Route Table ##################
### Controls routing for public subnets ###
resource "aws_route_table" "public-rtb" {
  vpc_id = aws_vpc.armageddon-vpc01.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.armageddon-igw01.id
  }

  tags = {
    Name = "${local.name_prefix}-public-rtb01"
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
  vpc_id = aws_vpc.armageddon-vpc01.id

  route {
    # cidr_block   = aws_vpc.armageddon-vpc01.cidr_block # To make sure only VPC traffic is allowed -- #ask Joseph about the error
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.armageddon-regional-nat01.id
  }

  tags = {
    Name = "${local.name_prefix}-private-rtb01"
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

########################################
#### Security Group For Web App EC2 ####
########################################

# Explanation: EC2 SG is lab_1a’s bodyguard -— only let in what you mean to.
resource "aws_security_group" "armageddon-ec2-sg01" {
  name        = "${local.name_prefix}-ec2-sg01"
  description = "EC2 Web App security group"
  vpc_id      = aws_vpc.armageddon-vpc01.id

  ## DONE ## TODO: student adds inbound rules (HTTP 80, SSH 22 from their IP)

  tags = {
    Name = "${local.name_prefix}-ec2-sg01"
  }
}

# Allow ingress traffic via RDP
resource "aws_vpc_security_group_ingress_rule" "ec2_rdp_ingress" {
  security_group_id = aws_security_group.armageddon-ec2-sg01.id
  cidr_ipv4         = "0.0.0.0/0" # How do I specify it to be from my IP??
  from_port         = 3389
  ip_protocol       = "tcp"
  to_port           = 3389

  tags = {
    Name = "Allow RDP from my IP"
  }
}

# Allow all ingress traffic to EC2 via SSH
resource "aws_vpc_security_group_ingress_rule" "ec2_ssh_ingress" {
  security_group_id = aws_security_group.armageddon-ec2-sg01.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22

  tags = {
    Name = "Allow SSH from my IP"
  }
}

# Allow all ingress traffic to EC2 via HTTP
resource "aws_vpc_security_group_ingress_rule" "ec2_http_ingress" {
  security_group_id = aws_security_group.armageddon-ec2-sg01.id
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
  security_group_id            = aws_security_group.armageddon-ec2-sg01.id
  referenced_security_group_id = aws_security_group.armageddon-rds-sg01.id # Reference the Destination SG -- Allows Outbound traffic to RDS SG
  from_port                    = 80
  ip_protocol                  = "tcp"
  to_port                      = 80

  tags = {
    Name = "Allow all outbound HTTP traffic to Backend Server"
  }
}

#########################################
#### Security Group For RDS Instance ####
#########################################

# Explanation: RDS SG is the Rebel vault—only the app server gets a keycard.
resource "aws_security_group" "armageddon-rds-sg01" {
  name        = "${local.name_prefix}-rds-sg01"
  description = "RDS security group"
  vpc_id      = aws_vpc.armageddon-vpc01.id

  # TODO: student adds inbound MySQL 3306 from aws_security_group.armageddon-ec2_sg01.id

  tags = {
    Name = "${local.name_prefix}-rds-sg01"
  }
}

# Allow ingress Traffic from EC2 Security Group to RDS Instance and nowehere else
resource "aws_vpc_security_group_ingress_rule" "rds_rdp_ingress" {
  security_group_id            = aws_security_group.armageddon-rds-sg01.id
  referenced_security_group_id = aws_security_group.armageddon-ec2-sg01.id # Reference the Source SG -- Allow all inbound from EC2 SG
  from_port                    = 3306                                      # MySQL/Aurora port
  ip_protocol                  = "tcp"
  to_port                      = 3306

  tags = {
    Name = "Allow inbound MySQL/Aurora from EC2 SG"
  }
}

####################################################################################################
#### ================================= EC2 Instance (Web App) ================================= ####
####################################################################################################

data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true # Use the most recent AMI
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"] # The value is found in check AMI catalog or running instance in instance details section in the  console
  }                                       # Retuns a broader range of AMIs
}

# Explanation: This is your “Han Solo box”—it talks to RDS and complains loudly when the DB is down.
resource "aws_instance" "armageddon-ec201" {
  ami                    = data.aws_ami.amzn-linux-2023-ami.id
  instance_type          = var.ec2_instance_type
  subnet_id              = aws_subnet.armageddon-public-subnets[0].id
  vpc_security_group_ids = [aws_security_group.armageddon-ec2-sg01.id]
  # iam_instance_profile    = aws_iam_instance_profile.armageddon-instance-profile01.name

  # TODO: student supplies user_data to install app + CW agent + configure log shipping
  # user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "${local.name_prefix}-ec201"
  }
}
