############################################
# Lab 3: Origin Cloaking
# ALBs only accept traffic from CloudFront
############################################

#-----------------------------------------------------------------------------
# AWS Managed Prefix List for CloudFront IPs
#-----------------------------------------------------------------------------

data "aws_ec2_managed_prefix_list" "chewbacca_cf_origin_facing01" {
  name = "com.amazonaws.global.cloudfront.origin-facing"
}

data "aws_ec2_managed_prefix_list" "liberdade_cf_origin_facing01" {
  provider = aws.saopaulo
  name     = "com.amazonaws.global.cloudfront.origin-facing"
}

#-----------------------------------------------------------------------------
# Secret Handshake (Origin Header)
#-----------------------------------------------------------------------------

resource "random_password" "chewbacca_origin_header_value01" {
  length  = 32
  special = false
}

#-----------------------------------------------------------------------------
# Tokyo ALB - CloudFront Only Access
#-----------------------------------------------------------------------------

resource "aws_security_group_rule" "chewbacca_alb_ingress_cf443" {
  type              = "ingress"
  security_group_id = aws_security_group.chewbacca_alb_sg01.id
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  prefix_list_ids   = [data.aws_ec2_managed_prefix_list.chewbacca_cf_origin_facing01.id]
  description       = "Allow HTTPS from CloudFront origin-facing IPs only"
}

resource "aws_lb_listener_rule" "chewbacca_require_origin_header01" {
  listener_arn = aws_lb_listener.chewbacca_https_listener01.arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.chewbacca_tg01.arn
  }

  condition {
    http_header {
      http_header_name = "X-Chewbacca-Growl"
      values           = [random_password.chewbacca_origin_header_value01.result]
    }
  }
}

resource "aws_lb_listener_rule" "chewbacca_default_block01" {
  listener_arn = aws_lb_listener.chewbacca_https_listener01.arn
  priority     = 99

  action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Forbidden - Chewbacca does not negotiate"
      status_code  = "403"
    }
  }

  condition {
    path_pattern {
      values = ["*"]
    }
  }
}

#-----------------------------------------------------------------------------
# São Paulo ALB - CloudFront Only Access
#-----------------------------------------------------------------------------

resource "aws_security_group_rule" "liberdade_alb_ingress_cf443" {
  provider          = aws.saopaulo
  type              = "ingress"
  security_group_id = aws_security_group.liberdade_alb_sg01.id
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  prefix_list_ids   = [data.aws_ec2_managed_prefix_list.liberdade_cf_origin_facing01.id]
  description       = "Allow HTTPS from CloudFront origin-facing IPs only"
}

resource "aws_lb_listener_rule" "liberdade_require_origin_header01" {
  provider     = aws.saopaulo
  listener_arn = aws_lb_listener.liberdade_https_listener01.arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.liberdade_tg01.arn
  }

  condition {
    http_header {
      http_header_name = "X-Chewbacca-Growl"
      values           = [random_password.chewbacca_origin_header_value01.result]
    }
  }
}

resource "aws_lb_listener_rule" "liberdade_default_block01" {
  provider     = aws.saopaulo
  listener_arn = aws_lb_listener.liberdade_https_listener01.arn
  priority     = 99

  action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Forbidden - Liberdade does not negotiate"
      status_code  = "403"
    }
  }

  condition {
    path_pattern {
      values = ["*"]
    }
  }
}
