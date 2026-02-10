# Explanation: DNS now points to CloudFront — nobody should ever see the ALB again.
resource "aws_route53_record" "chewbacca_apex_to_cf01" {
  zone_id = module.lab1-c.chewbacca_route53_zone_id
  #zone_id = local.chewbacca_zone_id
  name    = var.domain_name     # resilienetsolutions.click
  type    = "A"

  allow_overwrite = true  # Terraform overwrite exisiting Zone Record from ALB to CloudFront

  alias {
    name                   = aws_cloudfront_distribution.chewbacca_cf01.domain_name
    zone_id                = aws_cloudfront_distribution.chewbacca_cf01.hosted_zone_id
    evaluate_target_health = false
  }
}


# Explanation: app.chewbacca-growl.com also points to CloudFront — same doorway, different sign.
resource "aws_route53_record" "chewbacca_app_to_cf01" {
  zone_id = module.lab1-c.chewbacca_route53_zone_id
  name    = module.lab1-c.chewbacca_app_fqdn    # app.resilienetsolutions.click

  #zone_id = local.chewbacca_zone_id
  #name    = "${var.app_subdomain}.${var.domain_name}"
  type    = "A"

  allow_overwrite = true  # Terraform overwrite exisiting Zone Record from ALB to CloudFront

  alias {
    name                   = aws_cloudfront_distribution.chewbacca_cf01.domain_name
    zone_id                = aws_cloudfront_distribution.chewbacca_cf01.hosted_zone_id
    evaluate_target_health = false
  }
}