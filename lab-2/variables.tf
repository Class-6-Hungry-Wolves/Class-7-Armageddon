############################################
# My Global Lab-2 Variables
############################################

variable "project_name" {
  description = "Prefix for naming."
  type        = string
  default     = "peterock"
}

variable "ec2_ami_id" {
  description = "AMI ID for private EC2 host."
  type        = string
  #default = "ami-03a67d5e469699a7c"  #SA-EAST-1
  default = "ami-024ee5112d03921e2" #US-EAST-1
}

variable "ec2_instance_type" {
  description = "Private EC2 instance size."
  type        = string
  default     = "t3.micro"
}

variable "endpoint_policy_json" {
  description = "Optional custom endpoint policy as JSON"
  type        = string
  default     = null
}

variable "domain_name" {
  description = "Base domain students registered"
  type        = string
  default     = "resilienetsolutions.click"
}


############################################
# Lab2 Variables (From Theo)
############################################

#You’ll need this variable:
variable "cloudfront_acm_cert_arn" {
  description = "ACM certificate ARN in us-east-1 for CloudFront (covers resilienetsolutions.click and app.resilienetsolutions.click)."
  type        = string
  default = ""
}
