#################
#### Locals  ####
#################

locals {
  name_prefix = var.project_name
  environment = var.environment
}

#############
#### VPC ####
#############

resource "aws_vpc" "armagedonn-vpc01" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${local.name_prefix}-vpc01"
  }
}

#################
#### Subnets ####
#################

# Explanation: Public subnets are like docking bays—ships can land directly from space (internet).
resource "aws_subnet" "armagedonn-public-subnets" {
  count                   = length(var.public_subnet_cidrs) # This a is 'length' function that count the number of items in the variable list
  vpc_id                  = aws_vpc.armagedonn-vpc01.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.name_prefix}-public-subnet-${count.index + 1}" # count.index tells you the postion of the item within the list
  }
}

# Explanation: Private subnets are the hidden Rebel base—no direct access from the internet.
resource "aws_subnet" "armagedonn-private-subnets" {
  count             = length(var.private_subnet_cidrs) # This a is 'length' function that count the number of items in the variable list
  vpc_id            = aws_vpc.armagedonn-vpc01.id
  cidr_block        = var.private_subnet_cidrs[count.index] # This matches 1 item from the CIDRS list with another item within the AWS subnet resource list.
  availability_zone = var.azs[count.index]

  tags = {
    Name = "${local.name_prefix}-private-subnet-${count.index + 1}" # count.index tells you the postion of the item within the list
  }
}