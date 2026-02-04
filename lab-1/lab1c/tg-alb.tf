###########################
# Target Group for ALB ####
###########################

# Target group for RDS Notes App 
resource "aws_lb_target_group" "rdsapp_tg01" {
  name     = "${var.project_name}-tg01"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.lab-1-vpc.id

  # TODO: students set health check path to something real (e.g., /health)
  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
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


resource "aws_lb_target_group_attachment" "rdsapp_tg_attachment01" {
  count            = var.enable_runtime_instance_creation ? 1 : 0 # If runtime instance creation is disabled, this will not be created
  target_group_arn = aws_lb_target_group.rdsapp_tg01.arn
  target_id        = aws_instance.lab1_ec2_instance[0].id
  port             = 80
}




###########################
# Security Group for ALB ##
###########################


resource "aws_security_group" "alb_sg" {
  name        = "${var.project_name}-alb-sg"
  description = "Security group for ALB that allows HTTP and HTTPS traffic"
  vpc_id      = aws_vpc.lab-1-vpc.id
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
  security_group_id            = aws_security_group.lab_1_ec2_sg.id
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
  subnets            = [for i in aws_subnet.lab-1-public-subnet : i.id]

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
  certificate_arn   = aws_acm_certificate_validation.armageddon_cert01.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rdsapp_tg01.arn
  }

  depends_on = [aws_acm_certificate_validation.armageddon_cert01]
}