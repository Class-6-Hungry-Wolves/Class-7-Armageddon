############################################
# Locals 
############################################

# locals {
#   # Explanation: Name prefix is the roar that echoes through every tag.
#   chewbacca_prefix = var.project_name

#   # TODO: Students should lock this down after apply using the real secret ARN from outputs/state
#   chewbacca_secret_arn_guess = "arn:aws:secretsmanager:${module.lab1-ab.aws_region}:${module.lab1-ab.account_id}:secret:${local.chewbacca_prefix}/rds/mysql*"
  
#   # Explanation: My public IP used in SGs
#   my_public_ip = "108.56.232.140/32"

#   # Explanation: Used in SGs
#   all_ips = "0.0.0.0/0"
# }


# ############################################
# # Bonus B - ALB (Public) -> Target Group (Private EC2) + TLS + WAF + Monitoring
# ############################################

# locals {
#   # Explanation: This is the roar address — where the galaxy finds your app.
#   chewbacca_fqdn = "${var.app_subdomain}.${var.domain_name}"
# }


# ############################################
# # Bonus B - Route53 (Hosted Zone + DNS records + ACM validation + ALIAS to ALB)
# ############################################

# locals {
#   # Explanation: Chewbacca needs a home planet—Route53 hosted zone is your DNS territory.
#   chewbacca_zone_name = var.domain_name

#   # Explanation: Use either Terraform-managed zone or a pre-existing zone ID (students choose their destiny).
#   chewbacca_zone_id = var.manage_route53_in_terraform ? aws_route53_zone.chewbacca_zone01[0].zone_id : var.route53_hosted_zone_id

#   # Explanation: This is the app address that will growl at the galaxy (app.chewbacca-growl.com).
#   chewbacca_app_fqdn = "${var.app_subdomain}.${var.domain_name}"
# }
