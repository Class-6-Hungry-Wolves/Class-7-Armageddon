# locals {
#   route53_enabled    = var.enable_route53 && var.domain_name != ""
#   chewbacca_app_fqdn = (var.app_subdomain != "" && var.domain_name != "") ? "${var.app_subdomain}.${var.domain_name}" : ""
#
#   chewbacca_zone_id  = (var.manage_route53_in_terraform && local.route53_enabled) ? aws_route53_zone.chewbacca_zone[0].zone_id : var.route53_hosted_zone_id
#
#   cloudfront_zone_id = "Z2FDTNDATAQYW2"
# }
#
# resource "aws_route53_zone" "chewbacca_zone" {
#   count = (var.manage_route53_in_terraform && local.route53_enabled) ? 1 : 0
#   name  = var.domain_name
# }
#
# ############################################
# # Lab 2 - Route53 ALIAS records: apex + app -> CloudFront
# ############################################
#
# resource "aws_route53_record" "apex_alias_cf" {
#   count   = local.route53_enabled && local.chewbacca_zone_id != "" ? 1 : 0
#   zone_id = local.chewbacca_zone_id
#   name    = var.domain_name
#   type    = "A"
#
#   alias {
#     name                   = aws_cloudfront_distribution.cf.domain_name
#     zone_id                = local.cloudfront_zone_id
#     evaluate_target_health = false
#   }
# }
#
# resource "aws_route53_record" "app_alias_cf" {
#   count   = local.route53_enabled && local.chewbacca_zone_id != "" && local.chewbacca_app_fqdn != "" ? 1 : 0
#   zone_id = local.chewbacca_zone_id
#   name    = local.chewbacca_app_fqdn
#   type    = "A"
#
#   alias {
#     name                   = aws_cloudfront_distribution.cf.domain_name
#     zone_id                = local.cloudfront_zone_id
#     evaluate_target_health = false
#   }
# }
#
# ############################################
# # Lab 2 - HTTPS listener default deny (403)
# ############################################
#
# resource "aws_lb_listener" "https_443" {_
