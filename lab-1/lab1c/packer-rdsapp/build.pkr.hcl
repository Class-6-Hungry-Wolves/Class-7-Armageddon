packer {
  required_plugins {
    amazon-ebs = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

#################
### VARIABLES ###
#################
variable "region" {
  description = "AWS region to build the AMI in"
  type        = string
  default     = "null"
}

variable "packer_ami_name_prefix" {
  description = "Prefix for the name of the AMI built by Packer"
  type        = string
  default     = "null"
}

variable "builder_instance_type" {
  description = "Instance type for the Packer builder instance"
  type        = string
  default     = "t3.micro"
}

variable "vpc_id" {
  description = "VPC ID where the Packer builder instance will be launched"
  type        = string
  default     = "null"
}

variable "subnet_id" {
  description = "Subnet ID where the Packer builder instance will be launched"
  type        = string
  default     = "null"
}

variable "builder_sg_id" {
  description = "Security Group ID to associate with the Packer builder instance"
  type        = string
  default     = "null"
}

variable "builder_instance_profile_name" {
  description = "IAM Instance Profile name to associate with the Packer builder instance"
  type        = string
  default     = "null"
}

################
###  BUILD   ###    
################

source "amazon-ebs" "al2023" {
  region             = var.region
  instance_type      = var.builder_instance_type
  ami_name           = "${var.packer_ami_name_prefix}"
  vpc_id             = var.vpc_id
  subnet_id          = var.subnet_id       # This will be in the private subnet
  security_group_ids = [var.builder_sg_id] # This will be the Packer security group
  ssh_username       = "ec2-user"
  ssh_interface      = "session_manager"


  # We don't want SSH communication so we will be using SSM to connect to the instance
  communicator = "ssh"

  iam_instance_profile = var.builder_instance_profile_name

  source_ami_filter {
    filters = {
      name                = "al2023-ami-2023.*-x86_64"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    owners      = ["amazon"]
    most_recent = true
  }
  tags = {
    name    = "${var.packer_ami_name_prefix}"
    purpose = "class7-armageddon-rdsapp"
    builtby = "packer"
  }
}

build {
  name    = "rdsapp-ami"
  sources = ["source.amazon-ebs.al2023"]

  provisioner "shell" {
    script          = "packer-scripts/install_rdsapp.sh"
    execute_command = "sudo -E bash '{{ .Path }}'"
  }
}