###########################
# Target Group for ALB ####
###########################

# Target group for RDS Notes App 
resource "aws_lb_target_group" "rdsapp_tg01" {
  name     = "${var.project_name}-tg01"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.shinjuku-vpc.id

  health_check {
    enabled             = true
    interval            = 30
    path                = "/health"   # Path in our install_rdsapp.sh Flask app returns 200 if healty, and 503 if unhealthy.
    port                = "80"
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 5
    matcher             = "200-399"
  }

  tags = {
    Name = "${var.project_name}-tg01"
  }
}


###########################
# Security Group for ALB ##
###########################


resource "aws_security_group" "alb_sg" {
  name        = "${var.project_name}-alb-sg"
  description = "Security group for ALB that allows HTTP and HTTPS traffic"
  vpc_id      = aws_vpc.shinjuku-vpc.id
  tags = {
    Name = "${var.project_name}-alb-sg"
  }
}


# Ingress/inbound rule for our ALB Security Group that allows web traffic on port 80 
resource "aws_vpc_security_group_ingress_rule" "allow_port_80_alb_sg" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}


# Ingress/inbound rule for our ALB Security Group that allows web traffic on port 443
resource "aws_vpc_security_group_ingress_rule" "allow_port_443_alb_sg" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}



# Egress/outbound rule for our ALB Security Group that allows all outbound traffic
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_alb_sg" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}



# Ingress/inbound rule for our RDS Notes App EC2 Security Group to allow traffic from ALB SG on port 80
resource "aws_vpc_security_group_ingress_rule" "allow_alb_to_rdsapp_sg" {
  security_group_id            = aws_security_group.shinjuku_app_sg.id
  referenced_security_group_id = aws_security_group.alb_sg.id
  from_port                    = 80
  ip_protocol                  = "tcp"
  to_port                      = 80
}



#############################
# Application Load Balancer #
#############################

resource "aws_lb" "app_lb" {
  name               = "${var.project_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [for i in aws_subnet.shinjuku-public-subnet : i.id]

  access_logs {
    bucket  = aws_s3_bucket.armageddon_alb_logs_bucket01[0].bucket
    prefix  = var.alb_access_logs_prefix
    enabled = var.enable_alb_access_logs
  }

  tags = {
    Name = "${var.project_name}-alb"
  }
}




#########################
# Listener for ALB ######
#########################



# Decoy listener for HTTP traffic on port 80. Will redirect to HTTPS for better security.
resource "aws_lb_listener" "app_lb_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      protocol    = "HTTPS"
      port        = "443"
      status_code = "HTTP_301"
    }
  }
}


# Actual listener for HTTPS traffic on port 443. This listener will receive traffic from decoy listener and forward to RDS Notes App target group.
resource "aws_lb_listener" "app_lb_listener_https" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = aws_acm_certificate_validation.shinjuku_alb_cert01.certificate_arn

  default_action {
    type             = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Forbidden"
      status_code  = "403"
    }
  }

  depends_on = [aws_acm_certificate_validation.shinjuku_alb_cert01]
}



resource "aws_autoscaling_group" "shinjuku_asg01" {
  name_prefix               = "shinjuku-asg01"
  min_size                  = 3
  max_size                  = 9
  desired_capacity          = 6
  vpc_zone_identifier       = [for i in aws_subnet.shinjuku-private-subnet : i.id]
  launch_template {
    id      = aws_launch_template.shinjuku-LT01.id
    version = "$Latest"
  }
    enabled_metrics = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupTotalInstances"]

  # Instance protection for launching
  initial_lifecycle_hook {
    name                  = "instance-protection-launch"
    lifecycle_transition  = "autoscaling:EC2_INSTANCE_LAUNCHING"
    default_result        = "CONTINUE"
    heartbeat_timeout     = 60
    notification_metadata = "{\"key\":\"value\"}"
  }

  # Instance protection for terminating
  initial_lifecycle_hook {
    name                 = "scale-in-protection"
    lifecycle_transition = "autoscaling:EC2_INSTANCE_TERMINATING"
    default_result       = "CONTINUE"
    heartbeat_timeout    = 300
  }
}


# Auto Scaling Policy
resource "aws_autoscaling_policy" "shinjuku_asg01_scaling_policy" {
  name                   = "asg01-cpu-target"
  autoscaling_group_name = aws_autoscaling_group.shinjuku_asg01.name

  policy_type               = "TargetTrackingScaling"
  estimated_instance_warmup = 120

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 75.0
  }
}

# Enabling instance scale-in protection
resource "aws_autoscaling_attachment" "shinjuku_asg01_attachment" {
  autoscaling_group_name = aws_autoscaling_group.shinjuku_asg01.name
  lb_target_group_arn    = aws_lb_target_group.rdsapp_tg01.arn
}