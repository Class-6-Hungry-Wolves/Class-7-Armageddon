# Packer install document 


### What is Packer?

HashiCorp Packer is an open-source tool that automates the creation of identical machine images (for VMs, containers, and cloud) from a single source configuration. 

It enables "infrastructure as code" to build "golden images" with pre-installed software, improving consistency, speed, and portability across multiple platforms like AWS, Azure, and VMware.




### Why was this even necessary to begin with?


As I continued to work on this project, I was adding more things to my bootstrapping script which is now called install_rdsapp.sh.

Eventually I got to a point around Lab 1c where I wanted to added things like more detailed logging with the Dimensions argument which increased the size of my app, so much so that it got too big for AWS to run upon launching my EC2 instance. 

The maximum size allowed for user data is 16,384 KB. At the time of me writing this, the app is now at 18.5 KB. This is where Packer comes in. Instead of waiting for AWS to download all the python dependancies and agents onto the app I could now have everything pre-installed onto the EC2. So I now have my own custom AMI that is able to be ran on the EC2.



# Installing Packer
From the official Hashicorp Packer website
https://developer.hashicorp.com/packer/tutorials/docker-get-started/get-started-install-cli

### Mac Install via Brew

First, install the HashiCorp tap, a repository of all our Homebrew packages.
```
brew tap hashicorp/tap
```
Now, install Packer with hashicorp/tap/packer.
```
brew install hashicorp/tap/packer
```
To update to the latest, run
```
brew upgrade hashicorp/tap/packer
```
Verify installation by running 

```
packer --version
```

### Windows via Chocolatey

Chocolatey is a free and open-source package management system for Windows.

If you're using Windows and Chocolatey, you can install Packer by running choco install.

```
choco install packer
```
Verify installation by running 

```
packer --version
```

Chocolatey for whatever reason does not have the current version of Packer in their package manager so if you want to update Packer to the most recent version you will have to go directly to the downloads website (https://www.packer.io/downloads)and get the latest version for your Windows machine. The options are 32 bit (386) and 64 bit (AMD64)

At the time of me writing this, 1.15 is the most recent version. 



### Running Packer
Upon verifying that you have Packer installed run the following command:

```
packer init .
```
This will initialize packer in whatever directory you will working with it in that has packer configuration files (e.g. build.pkr.hcl), similar to Terraform.




This file build.pkr.hcl is where packer will actually build the AMI we'll be using for our app. Variables are null with the exception of the instance_type variable because we will be adding them in a different way from hardcoding the values into the blocks. 

How it works is that Packer will build a temporary EC2 instance, and then from that EC2 instance it will create an AMI that we can then use for our RDS App EC2. This will build it using the already provisioned infrastructure from Terraform. 

```
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
```

Upon running this for the first time, cat the contents of the outputs from terraform provisioning into packer.pkrvars.hcl




```
cat > packer.pkrvars.hcl <<EOF
region = "us-east-1"
packer_ami_name_prefix = "class7-armageddon-ami"
vpc_id = "$(terraform output -raw lab_1_vpc_id)"
private_subnet_id = "$(terraform output -json lab_1_private_subnet_ids | jq -r '.[0]')"
builder_sg_id = "$(terraform output -raw lab1_ec2_security_group_id)"
builder_instance_profile_name = "$(terraform output -raw packer_builder_instance_profile_name)"
EOF
```


When file is created within the directory, run 

```
packer validate .
packer build -var-file=packer.pkrvars.hcl .
```

This will take anywher from 10-12 minutes if you run with the variables as is.