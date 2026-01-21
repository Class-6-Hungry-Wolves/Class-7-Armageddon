############################################
# (Optional but realistic) VPC Endpoints (Skeleton)
############################################

# Explanation: Endpoints keep traffic inside AWS like hyperspace lanes—less exposure, more control.
# TODO: students can add endpoints for SSM, Logs, Secrets Manager if doing “no public egress” variant.


resource "aws_vpc_endpoint" "chewbacca_vpce_services" {
    for_each            = toset(local.services)
    vpc_id              = aws_vpc.chewbacca_vpc01.id
    vpc_endpoint_type   = "Interface"
    service_name        = "com.amazonaws.${var.aws_region}.${each.value}"
    security_group_ids  = [aws_security_group.chewbacca_vpce_sg01.id]
    subnet_ids = aws_subnet.chewbacca_private_subnets[*].id
    private_dns_enabled = true

    #policy = var.endpoint_policy_json

    tags = {
        Name = "${local.name_prefix}-vpce-${each.value}"
    }
}