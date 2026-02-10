# Explanation: ALB checks for Chewbacca’s secret growl — no growl, no service.
resource "aws_lb_listener_rule" "chewbacca_require_origin_header01" {
  #listener_arn = aws_lb_listener.chewbacca_https_listener01.arn
  listener_arn = module.lab1-c.chewbacca_https_listener01.arn
  priority     = 10

  action {
    type             = "forward"
    #target_group_arn = aws_lb_target_group.chewbacca_tg01.arn
    target_group_arn = module.lab1-c.chewbacca_tg01.arn
  }

  condition {
    http_header {
      http_header_name = "X-Chewbacca-Growl"
      values           = [random_password.chewbacca_origin_header_value01.result]
    }
  }
}

# Explanation: If you don’t know the growl, you get a 403 — Chewbacca does not negotiate.
resource "aws_lb_listener_rule" "chewbacca_default_block01" {
  listener_arn = module.lab1-c.chewbacca_https_listener01.arn
  #listener_arn = aws_lb_listener.chewbacca_https_listener01.arn
  priority     = 99

  action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Forbidden"
      status_code  = "403"
    }
  }

  condition {
    path_pattern { values = ["*"] }
  }
}
