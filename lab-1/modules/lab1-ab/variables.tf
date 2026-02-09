variable "aws_region" {
  description = "AWS Region for the PeteRock fleet to patrol."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Prefix for naming."
  type        = string
  default     = "peterock"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.98.0.0/16" # TODO: student supplies
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs."
  type        = list(string)
  default     = ["10.98.1.0/24", "10.98.2.0/24"] # TODO: student supplies
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs (use 10.x.x.x/xx)."
  type        = list(string)
  default     = ["10.98.101.0/24", "10.98.102.0/24"] # TODO: student supplies
}

variable "azs" {
  description = "Availability Zones list (match count with subnets)."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"] # TODO: student supplies
}

variable "ec2_ami_id" {
  description = "AMI ID for the EC2 app host."
  type        = string
  #default     = "ami-0b11764ef057ab4b7"
  #default = "ami-03a67d5e469699a7c"  #SA-EAST-1
  default = "ami-024ee5112d03921e2" #US-EAST-1
}

variable "ec2_instance_type" {
  description = "EC2 instance size for the app."
  type        = string
  default     = "t3.micro"
}

variable "db_engine" {
  description = "RDS engine."
  type        = string
  default     = "mysql"
}

variable "db_instance_class" {
  description = "RDS instance class."
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Initial database name."
  type        = string
  default     = "labdb" # Students can change
}

variable "db_username" {
  description = "DB master username (students should use Secrets Manager in 1B/1C)."
  type        = string
  default     = "admin" # TODO: student supplies
}

variable "db_password" {
  description = "DB master password (DO NOT hardcode in real life; for lab only)."
  type        = string
  sensitive   = true
  default     = "Pa$$word1234!" # TODO: student supplies
}

variable "sns_email_endpoint" {
  description = "Email for SNS subscription (PagerDuty simulation)."
  type        = string
  default     = "chery.peter@gmail.com" # TODO: student supplies
}

variable "endpoint_policy_json" {
  description = "Optional custom endpoint policy as JSON"
  type        = string
  default     = null
}

variable "public_key" {
  description = "Key pair public key portion for SSH access to EC2"
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCnxKbA3Du42MJ6xu8XvfyFfI50Gi6HGqRAgyqwlU1DVNBvZUtBmZokhwNAKwSLfi/m5cGQPAIbDLo2RO2DLfIq5FDy7wv0+T0ZKNSCWt+DSsdgjculg1V6bd1LQQc9+j9j4DeJYC3gHFwg8g4B1YWSaGD25oPye5GiuhEcGVSdMFHyDPEOz0POkgBIVRiQvbKL8PtrgVD/a0B3JjO7zl4u3RAZUJjvkMJTmE+r8j7uii6YKipRL7HafoGajvg1vpvchSNFp51CGT0YBUqkjSmDN7OG0WnbSWrQkgFopNcWJi3tO8exVFmPhdzb8DNcseX6NxxBo7G+7X4CM+3LdXbIMMabRVxjQCvoW64Cg+hLUGAStsSTPtKwa4ipB4xMt4lI+KGjyPmJ4KrKtcpEHAUDdE7d33p8noZCRC7SqsLKm4xkE/68c9aTYlIh6eHBbKryuewoX/FC0RyusI7/tm9TMHy6AHASzxEIwrR8KB9AA0Ckz/bxdWfIghagEAKKT1lziVDg7suxOjRfVzV1PhTcbloLHZrnZKU1Zil/IeoeXlZqqgYxViZZWNMis2AlBYjvu8eQ9puwnSFbnwo7TFuDpIOocZ908laqpjvbcAMIFgUJ6qtpZ42Qpmus0xVoJO/vSzxLY8y55vXfG6qZJXJsd6NJIMgGhTBXRGlcbi6+MQ== peter@DESKTOP-6CQK9QU"
}