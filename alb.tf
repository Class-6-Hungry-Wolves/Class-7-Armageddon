#ALB Target Group for app instances
resource "aws_lb_target_group" "lab_2a_app_tg" {
  name        = "${local.name_prefix}-lab-2a-app-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.lab_2a_vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    matcher             = "200-399"
  }

    tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-lab-2a-app-tg"
  })
}

#Application Load Balancer
resource "aws_lb" "lab_2a_alb" {
  name               = "${local.name_prefix}-lab-2a-alb"
  load_balancer_type = "application"
  internal           = false

  security_groups = [
    aws_security_group.lab_2a_alb_sg.id
  ]

  #Public subnets for ALB
  subnets = [
    for s in aws_subnet.lab_2a_public_subnet : s.id
  ]

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-lab-2a-alb"
  })
}

#HTTP Listener – will later be fronted by CloudFront
#resource "aws_lb_listener" "lab_2a_http_listener" {
  #load_balancer_arn = aws_lb.lab_2a_alb.arn
  #port              = 80
 # protocol          = "HTTP"

  #default_action {
  #  type             = "forward"
  #  target_group_arn = aws_lb_target_group.lab_2a_app_tg.arn
  #}
#}


