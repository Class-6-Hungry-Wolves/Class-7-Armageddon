# Explanation: Chewbacca only opens the hangar to CloudFront — everyone else gets the Wookiee roar.
data "aws_ec2_managed_prefix_list" "armageddon_cf_origin_facing01" {
  name = "com.amazonaws.global.cloudfront.origin-facing"
}


# Explanation: Only CloudFront origin-facing IPs may speak to the ALB — direct-to-ALB attacks die here.
resource "aws_security_group_rule" "armageddon_alb_ingress_cf44301" {
  type              = "ingress"
  security_group_id = aws_security_group.alb_sg.id
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"

  prefix_list_ids = [
    data.aws_ec2_managed_prefix_list.armageddon_cf_origin_facing01.id
  ]
}



# Explanation: This is Chewbacca’s secret handshake — if the header isn’t present, you don’t get in.
resource "random_password" "armageddon_origin_header_value01" {
  length  = 32
  special = false
}



# Explanation: ALB checks for Chewbacca’s secret growl — no growl, no service.
resource "aws_lb_listener_rule" "armageddon_require_origin_header01" {
  listener_arn = aws_lb_listener.app_lb_listener_https.arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rdsapp_tg01.arn
  }

  condition {
    http_header {
      http_header_name = "x-cf-wraith-call"
      values           = [random_password.armageddon_origin_header_value01.result]
    }
  }
}
