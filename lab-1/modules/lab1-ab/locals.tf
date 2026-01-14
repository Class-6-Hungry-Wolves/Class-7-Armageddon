############################################
# Locals (naming convention: Chewbacca-*)
############################################
locals {
  name_prefix = var.project_name
  my_public_ip = "108.56.232.140/32"
  all_ips = "0.0.0.0/0"
}

locals {
  services = [
    "ssm", 
    "ssmmessages", 
    "ec2messages", 
    "secretsmanager", 
    "logs"
  ]
}
