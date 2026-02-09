locals {
  project_name = var.project_name
  environment  = var.environment
  owner        = var.owner

  name_prefix = "${local.project_name}-${local.environment}"

  common_tags = {
    Project     = local.project_name
    Environment = local.environment
    Owner       = local.owner
    Team        = "DevOps"
    ManagedBy   = "Terraform"
  }
  lab_2a_origin_header_name  = "X-Lab2-Origin-Secret"
  lab_2a_origin_header_value = "change-me-super-secret"
}
