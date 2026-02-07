############################################
# Lab 3: Tokyo ALB + TLS
############################################

#-----------------------------------------------------------------------------
# Route53 Hosted Zone Data Source
#-----------------------------------------------------------------------------

data "aws_route53_zone" "chewbacca_zone" {
  name         = var.domain_name
  private_zone = false
}

#-----------------------------------------------------------------------------
# ACM Certificate (Tokyo region for ALB)
#-----------------------------------------------------------------------------

resource "aws_acm_certificate" "chewbacca_tokyo_cert" {
  domain_name               = local.chewbacca_app_fqdn
  subject_alternative_names = ["*.${var.domain_name}", var.domain_name]
  validation_method         = "DNS"

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-acm-cert-tokyo"
  })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "chewbacca_tokyo_cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.chewbacca_tokyo_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = local.chewbacca_zone_id
}

resource "aws_acm_certificate_validation" "chewbacca_tokyo_cert_validated" {
  certificate_arn         = aws_acm_certificate.chewbacca_tokyo_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.chewbacca_tokyo_cert_validation : record.fqdn]

  timeouts {
    create = "5m"
  }
}

#-----------------------------------------------------------------------------
# Application Load Balancer
#-----------------------------------------------------------------------------

resource "aws_lb" "chewbacca_alb01" {
  name               = "${local.tokyo_prefix}-alb01"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.chewbacca_alb_sg01.id]
  subnets = [
    aws_subnet.chewbacca_public_subnet01.id,
    aws_subnet.chewbacca_public_subnet02.id
  ]

  enable_deletion_protection = false

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-alb01"
  })
}

#-----------------------------------------------------------------------------
# Target Group
#-----------------------------------------------------------------------------

resource "aws_lb_target_group" "chewbacca_tg01" {
  name     = "${local.tokyo_prefix}-tg01"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.chewbacca_vpc01.id

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

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-tg01"
  })
}

resource "aws_lb_target_group_attachment" "chewbacca_tg_attachment01" {
  target_group_arn = aws_lb_target_group.chewbacca_tg01.arn
  target_id        = aws_instance.chewbacca_ec201.id
  port             = 80
}

#-----------------------------------------------------------------------------
# ALB Listeners
#-----------------------------------------------------------------------------

resource "aws_lb_listener" "chewbacca_https_listener01" {
  load_balancer_arn = aws_lb.chewbacca_alb01.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = aws_acm_certificate.chewbacca_tokyo_cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.chewbacca_tg01.arn
  }

  depends_on = [aws_acm_certificate_validation.chewbacca_tokyo_cert_validated]
}

resource "aws_lb_listener" "chewbacca_http_listener01" {
  load_balancer_arn = aws_lb.chewbacca_alb01.arn
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
