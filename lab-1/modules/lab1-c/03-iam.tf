############################################
# Least-Privilege IAM (LAB 1C BONUS A)
############################################

# Explanation: Private EC2 instance using the same IAM Profile as Public EC2 instance
resource "aws_iam_instance_profile" "chewbacca_instance_profile02" {
  name = "${local.chewbacca_prefix}-instance-profile02"
  role = module.lab1-ab.iam_role_name
}
