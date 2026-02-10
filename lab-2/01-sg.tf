# Explanation: Only CloudFront origin-facing IPs may speak to the ALB — direct-to-ALB attacks die here.
resource "aws_security_group_rule" "chewbacca_alb_ingress_cf44301" {
  type              = "ingress"
  security_group_id = module.lab1-c.chewbacca_alb_sg01_id
  #security_group_id = aws_security_group.chewbacca_alb_sg01.id
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"

  prefix_list_ids = [
    data.aws_ec2_managed_prefix_list.chewbacca_cf_origin_facing01.id
  ]
}
