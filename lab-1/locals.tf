############################################
# Locals (naming convention: peterock-*)
############################################

locals {
  # Explanation: Name prefix is the roar that echoes through every tag.
  chewbacca_prefix = var.project_name

  # TODO: Students should lock this down after apply using the real secret ARN from outputs/state
  chewbacca_secret_arn_guess = "arn:aws:secretsmanager:${module.lab1-ab.aws_region}:${module.lab1-ab.account_id}:secret:${local.chewbacca_prefix}/rds/mysql*"
}

locals {
  services = [
    "s3", 
    "kms"
  ]
}
