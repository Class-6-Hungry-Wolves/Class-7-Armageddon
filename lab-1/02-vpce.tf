############################################
#  VPC Endpoints (for S3 Gateway & KMS)
############################################

# NOTE: VPC Endpoints for the following services already built in Module LAB1-ab:
#       SSM, SSMMessges, EC2Messages, Logs, & SecretsManager

resource "aws_vpc_endpoint" "chewbacca_vpce_services" {
    for_each            = toset(local.services)
    vpc_id              = module.lab1-ab.vpc_id

    vpc_endpoint_type   = each.value == "s3" ? "Gateway" : "Interface"
    service_name        = "com.amazonaws.${module.lab1-ab.aws_region}.${each.value}"
    security_group_ids  = each.value == "s3" ? null : [module.lab1-ab.vpce_sg]
#    subnet_ids          = each.value == "s3" ? null : module.lab1-ab.private_subnet_ids
    subnet_ids          = each.value == "s3" ? null : [ for subnet in module.lab1-ab.private_subnets : subnet.id]
    private_dns_enabled = each.value == "s3" ? false : true

    #policy              = var.endpoint_policy_json

    tags = {
        Name = "${local.chewbacca_prefix}-vpce-${each.value}"
    }
}