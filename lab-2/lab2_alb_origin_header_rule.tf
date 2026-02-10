resource "aws_lb_listener_rule" "origin_header_allow" {
  priority     = 10
  listener_arn = aws_lb_listener.https_443[0].arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }

  condition {
    http_header {
      http_header_name = var.origin_header_name
      values           = [var.origin_header_value]
    }
  }
}
