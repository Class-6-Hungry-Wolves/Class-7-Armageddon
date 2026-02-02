############################################
# Bonus A - Data
############################################

# Explanation: Chewbacca wants to know “who am I in this galaxy?” so ARNs can be scoped properly.
data "aws_caller_identity" "chewbacca_self01" {}

# Explanation: Region matters—hyperspace lanes change per sector.
data "aws_region" "chewbacca_region01" {}

data "archive_file" "rotation_lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/rotation_lambda.py"
  output_path = "${path.module}/rotation_lambda.zip"
}

# Explanation: Dynamically fetch the EC2 Instance Connect prefix list for the current region
data "aws_ec2_managed_prefix_list" "ec2_instance_connect" {
  filter {
    name   = "prefix-list-name" #Other opts: "owner-id" & "prefix-list-id"
    values = ["com.amazonaws.${var.aws_region}.ec2-instance-connect"]
  }
}