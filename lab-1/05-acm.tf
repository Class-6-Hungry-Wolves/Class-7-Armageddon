############################################
# ACM Certificate (TLS) for my domain
############################################

# Explanation: TLS is the diplomatic passport — browsers trust you, and Chewbacca stops growling at plaintext.
resource "aws_acm_certificate" "chewbacca_acm_cert01" {
  domain_name       = local.chewbacca_fqdn
  validation_method = var.certificate_validation_method # Default is DNS (R53)

  # TODO: students can add subject_alternative_names like var.domain_name if desired
  subject_alternative_names = [ "${local.chewbacca_zone_name}" ]

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.project_name}-acm-cert01"
  }
}

# Explanation: This ties the “proof record” back to ACM—Chewbacca gets his green checkmark for TLS.
resource "aws_acm_certificate_validation" "chewbacca_acm_validation01_dns_bonus" {
  count = var.certificate_validation_method == "DNS" ? 1 : 0

  certificate_arn = aws_acm_certificate.chewbacca_acm_cert01.arn

  validation_record_fqdns = [
    for r in aws_route53_record.chewbacca_acm_validation_records01 : r.fqdn
  ]
}

# Explanation: Once validated, ACM becomes the “green checkmark” — until then, ALB HTTPS won’t work.
# resource "aws_acm_certificate_validation" "chewbacca_acm_validation01" {
#   certificate_arn = aws_acm_certificate.chewbacca_acm_cert01.arn

#   # TODO: if using DNS validation, students must pass validation_record_fqdns
#   validation_record_fqdns = [ aws_route53_record.chewbacca_acm_validation.fqdn ]
# }
