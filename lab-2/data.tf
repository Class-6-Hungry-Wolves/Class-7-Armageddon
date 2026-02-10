# ############################################
# # LAB 2 LOCALS
# ############################################

# Explanation: Chewbacca only opens the hangar to CloudFront — everyone else gets the Wookiee roar.
data "aws_ec2_managed_prefix_list" "chewbacca_cf_origin_facing01" {
  name = "com.amazonaws.global.cloudfront.origin-facing"
}


# ------------------------------


# Explanation: Get the AWS Account ID for the ELB Service in the region (used in S3 Butcket Policy)
data "aws_elb_service_account" "main" {}

data "aws_prefix_list" "s3_prefix_list" {
  name = "com.amazonaws.${module.lab1-ab.aws_region}.s3"
}
