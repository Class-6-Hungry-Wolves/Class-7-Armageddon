#EC2 App Layer – Launch Template + ASG
#Get latest Amazon Linux 2 AMI in your region
data "aws_ami" "lab_2a_amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_launch_template" "lab_2a_app_lt" {
  name_prefix   = "${local.name_prefix}-lab-2a-app-lt-"
  image_id      = data.aws_ami.lab_2a_amazon_linux_2.id
  instance_type = var.app_instance_type

  vpc_security_group_ids = [
    aws_security_group.lab_2a_app_sg.id
  ]

  #Optional: add user_data later to install your app
  #user_data = filebase64("${path.module}/user_data.sh")

  tag_specifications {
    resource_type = "instance"

    tags = merge(local.common_tags, {
      Name = "${local.name_prefix}-lab-2a-app"
      Role = "app"
    })
  }

  lifecycle {
    create_before_destroy = true
  }
}

#Autoscaling Group for app layer
# Using reasonable defaults (min=1, desired=1, max=2) for lab purposes.
# These can be adjusted without architectural impact.
resource "aws_autoscaling_group" "lab_2a_app_asg" {
  name                      = "${local.name_prefix}-lab-2a-app-asg"
  min_size                  = var.app_min_size
  max_size                  = var.app_max_size
  desired_capacity          = var.app_desired_capacity
  health_check_type         = "EC2"
  health_check_grace_period = 120


  vpc_zone_identifier = [
    for s in aws_subnet.lab_2a_database_subnet : s.id
  ]

  launch_template {
    id      = aws_launch_template.lab_2a_app_lt.id
    version = "$Latest"
  }
  
  target_group_arns = [aws_lb_target_group.lab_2a_app_tg.arn]

  tag {
    key                 = "Name"
    value               = "${local.name_prefix}-lab-2a-app-asg"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
