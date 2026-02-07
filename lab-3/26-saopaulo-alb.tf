############################################
# Lab 3: São Paulo ALB + TLS
############################################

#-----------------------------------------------------------------------------
# ACM Certificate (São Paulo region for ALB)
#-----------------------------------------------------------------------------

resource "aws_acm_certificate" "liberdade_sp_cert" {
  provider                  = aws.saopaulo
  domain_name               = local.chewbacca_app_fqdn
  subject_alternative_names = ["*.${var.domain_name}", var.domain_name]
  validation_method         = "DNS"

  tags = merge(local.saopaulo_tags, {
    Name = "${local.saopaulo_prefix}-acm-cert-sp"
  })

  lifecycle {
    create_before_destroy = true
  }
}

# DNS validation records are shared with Tokyo cert (already created in 11-tokyo-alb.tf)
# Just reference the same validation

resource "aws_acm_certificate_validation" "liberdade_sp_cert_validated" {
  provider                = aws.saopaulo
  certificate_arn         = aws_acm_certificate.liberdade_sp_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.chewbacca_tokyo_cert_validation : record.fqdn]

  timeouts {
    create = "5m"
  }
}

#-----------------------------------------------------------------------------
# Application Load Balancer
#-----------------------------------------------------------------------------

resource "aws_lb" "liberdade_alb01" {
  provider           = aws.saopaulo
  name               = "${local.saopaulo_prefix}-alb01"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.liberdade_alb_sg01.id]
  subnets = [
    aws_subnet.liberdade_public_subnet01.id,
    aws_subnet.liberdade_public_subnet02.id
  ]

  enable_deletion_protection = false

  tags = merge(local.saopaulo_tags, {
    Name = "${local.saopaulo_prefix}-alb01"
  })
}

#-----------------------------------------------------------------------------
# Target Group
#-----------------------------------------------------------------------------

resource "aws_lb_target_group" "liberdade_tg01" {
  provider = aws.saopaulo
  name     = "${local.saopaulo_prefix}-tg01"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.liberdade_vpc01.id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/health"
    protocol            = "HTTP"
    matcher             = "200"
  }

  tags = merge(local.saopaulo_tags, {
    Name = "${local.saopaulo_prefix}-tg01"
  })
}

resource "aws_lb_target_group_attachment" "liberdade_tg_attachment01" {
  provider         = aws.saopaulo
  target_group_arn = aws_lb_target_group.liberdade_tg01.arn
  target_id        = aws_instance.liberdade_ec201.id
  port             = 80
}

#-----------------------------------------------------------------------------
# ALB Listeners
#-----------------------------------------------------------------------------

resource "aws_lb_listener" "liberdade_https_listener01" {
  provider          = aws.saopaulo
  load_balancer_arn = aws_lb.liberdade_alb01.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = aws_acm_certificate.liberdade_sp_cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.liberdade_tg01.arn
  }

  depends_on = [aws_acm_certificate_validation.liberdade_sp_cert_validated]
}

resource "aws_lb_listener" "liberdade_http_listener01" {
  provider          = aws.saopaulo
  load_balancer_arn = aws_lb.liberdade_alb01.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
