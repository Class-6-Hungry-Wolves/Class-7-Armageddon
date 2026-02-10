resource "aws_security_group" "alb_sg" {
  name        = "${local.project_name_prefix}-${local.environment}-alb-sg"
  description = "ALB security group"
  vpc_id      = aws_vpc.lab_1a_vpc.id
}

data "aws_ec2_managed_prefix_list" "cloudfront_origin" {
  name = "com.amazonaws.global.cloudfront.origin-facing"
}

resource "aws_vpc_security_group_ingress_rule" "alb_in_443_from_cloudfront" {
  security_group_id = aws_security_group.alb_sg.id
  prefix_list_id    = data.aws_ec2_managed_prefix_list.cloudfront_origin.id
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "alb_out_to_targets" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_lb" "alb" {
  name               = "chewbacca-alb01"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [for s in aws_subnet.lab_1a_public_subnet : s.id]

  access_logs {
    bucket  = aws_s3_bucket.alb_logs_bucket[0].bucket
    prefix  = var.alb_access_logs_prefix
    enabled = var.enable_alb_access_logs
  }
}

resource "aws_lb_target_group" "app_tg" {
  name        = "chewbacca-tg01"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.lab_1a_vpc.id
  target_type = "instance"

  health_check {
    enabled             = true
    path                = "/"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "app_target" {
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = aws_instance.class_7_instance_from_terraform.id
  port             = 80
}

resource "aws_cloudwatch_metric_alarm" "alb_5xx_alarm" {
  alarm_name          = "chewbacca-alb-5xx"
  alarm_description   = "ALB 5XX spikes"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "notBreaching"

  namespace   = "AWS/ApplicationELB"
  metric_name = "HTTPCode_ELB_5XX_Count"

  dimensions = {
    LoadBalancer = aws_lb.alb.arn_suffix
  }

  alarm_actions = [aws_sns_topic.lab_db_incidents.arn]
  ok_actions    = [aws_sns_topic.lab_db_incidents.arn]
}

resource "aws_cloudwatch_dashboard" "chewbacca" {
  dashboard_name = "chewbacca-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric",
        x      = 0,
        y      = 0,
        width  = 12,
        height = 6,
        properties = {
          region      = var.aws_region
          annotations = { horizontal = [] }

          metrics = [
            ["AWS/ApplicationELB", "RequestCount", "LoadBalancer", aws_lb.alb.arn_suffix],
            [".", "HTTPCode_ELB_5XX_Count", ".", "."],
            [".", "TargetResponseTime", ".", "."]
          ]

          period = 60
          stat   = "Sum"
          title  = "ALB Requests / 5XX / TargetResponseTime"
        }
      }
    ]
  })
}
