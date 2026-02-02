############################################
# Bonus B: Application Load Balancer
############################################

# Explanation: The ALB is your public customs checkpoint — it speaks TLS and forwards to private targets.
resource "aws_lb" "chewbacca_alb01" {
  name               = "${var.project_name}-alb01"
  load_balancer_type = "application"
  internal           = false

  security_groups    = [aws_security_group.chewbacca_alb_sg01.id]
  subnets            = [for subnet in module.lab1-ab.public_subnets : subnet.id]

  # TODO: students can enable access logs to S3 as a stretch goal
  # Explanation: Configure the ALB to send logs to the S3 bucket
  access_logs {
    bucket  = aws_s3_bucket.chewbacca_alb_logs_bucket01[0].bucket # TODO: Create S3 bucket
    prefix  = var.alb_access_logs_prefix
    enabled = var.enable_alb_access_logs
  }

  tags = {
    Name = "${var.project_name}-alb01"
  }
}

############################################
# Target Group + Attachment
############################################

# Explanation: Target groups are Chewbacca’s “who do I forward to?” list — private EC2 lives here.
resource "aws_lb_target_group" "chewbacca_tg01" {
  name     = "${var.project_name}-tg01"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.lab1-ab.vpc_id

  # TODO: students set health check path to something real (e.g., /health)
  health_check {
    enabled             = true
    interval            = 30
    path                = "/health"
    port                = "traffic-port"
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    matcher             = "200-399"
  }

  tags = {
    Name = "${var.project_name}-tg01"
  }
}

# Explanation: Chewbacca personally introduces the ALB to the private EC2 — “this is my friend, don’t shoot.”
resource "aws_lb_target_group_attachment" "chewbacca_tg_attach01" {
  target_group_arn = aws_lb_target_group.chewbacca_tg01.arn
  target_id        = aws_instance.chewbacca_ec201_private_bonus.id
  port             = 80

  # TODO: students ensure EC2 security group allows inbound from ALB SG on this port (rule above)
}

############################################
# ALB Listeners: HTTP -> HTTPS redirect, HTTPS -> TG
############################################

# Explanation: HTTP listener is the decoy airlock — it redirects everyone to the secure entrance.
resource "aws_lb_listener" "chewbacca_http_listener01" { #Backend listener
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

# Explanation: HTTPS listener is the real hangar bay — TLS terminates here, then traffic goes to private targets.
resource "aws_lb_listener" "chewbacca_https_listener01" { #Frontend listener
  load_balancer_arn = aws_lb.chewbacca_alb01.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  #certificate_arn   = aws_acm_certificate_validation.chewbacca_acm_validation01.certificate_arn
  certificate_arn = aws_acm_certificate.chewbacca_acm_cert01.arn

  default_action {
    type             = "forward"
    # ARN of the Target Group to which to route traffic
    target_group_arn = aws_lb_target_group.chewbacca_tg01.arn
  }

  depends_on = [ aws_acm_certificate_validation.chewbacca_acm_validation01_dns_bonus ]
  #depends_on = [aws_acm_certificate_validation.chewbacca_acm_validation01]
}

