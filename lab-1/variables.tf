variable "project_name" {
  description = "Prefix for naming."
  type        = string
  default     = "peterock"
}

variable "ec2_ami_id" {
  description = "AMI ID for private EC2 host."
  type        = string
  default     = "ami-0b11764ef057ab4b7"
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

############################################
# Variables for Bonus C
############################################

variable "domain_name" {
  description = "Base domain students registered (e.g., chewbacca-growl.com)."
  type        = string
  #default     = "chewbacca-growl.com"
  default     = "resilienetsolutions.com"
}

variable "app_subdomain" {
  description = "App hostname prefix (e.g., app.chewbacca-growl.com)."
  type        = string
  default     = "app"
}

variable "certificate_validation_method" {
  description = "ACM validation method. Students can do DNS (Route53) or EMAIL."
  type        = string
  default     = "DNS"
}

variable "enable_waf" {
  description = "Toggle WAF creation."
  type        = bool
  default     = true
}

variable "alb_5xx_threshold" {
  description = "Alarm threshold for ALB 5xx count."
  type        = number
  default     = 10
}

variable "alb_5xx_period_seconds" {
  description = "CloudWatch alarm period."
  type        = number
  default     = 300
}

variable "alb_5xx_evaluation_periods" {
  description = "Evaluation periods for alarm."
  type        = number
  default     = 1
}

# Explanation: Used to specify Terraform-managed Zone (instead of pre-exisiting Zone ID)
variable "manage_route53_in_terraform" {
  description = "Terraform-managed Route 53 Zone"
  type = bool
  default = true
}

variable "route53_hosted_zone_id" {
  description = "Non-R53 Hosted Zone ID"
  type = string
  default = null
}
