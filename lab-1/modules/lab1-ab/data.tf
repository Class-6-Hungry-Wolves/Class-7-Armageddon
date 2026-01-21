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