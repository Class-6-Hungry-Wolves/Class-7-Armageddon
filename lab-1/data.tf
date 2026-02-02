# Explanation: Get the AWS Account ID for the ELB Service in the region (used in S3 Butcket Policy)
data "aws_elb_service_account" "main" {}

data "aws_prefix_list" "s3_prefix_list" {
  name = "com.amazonaws.${module.lab1-ab.aws_region}.s3"
}
