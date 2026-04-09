# ############################################
# # Bonus B - WAF Logging (CloudWatch Logs OR S3 OR Firehose)
# # One destination per Web ACL, choose via var.waf_log_destination.
# ############################################

# ############################################
# # Option 1: CloudWatch Logs destination
# ############################################

# # Explanation: WAF logs in CloudWatch are your “blaster-cam footage”—fast search, fast triage, fast truth.
# resource "aws_cloudwatch_log_group" "armageddon-waf-log-group" {
#   count = var.waf_log_destination == "cloudwatch" ? 1 : 0

#   # NOTE: AWS requires WAF log destination names start with aws-waf-logs- (students must not rename this).
#   name              = "aws-waf-logs-${var.project_name}-webacl"
#   retention_in_days = var.waf_log_retention_days

#   tags = {
#     Name = "${var.project_name}-waf-log-group"
#   }
# }

# # Explanation: This wire connects the shield generator to the black box—WAF -> CloudWatch Logs.
# resource "aws_wafv2_web_acl_logging_configuration" "armageddon-waf-logging" {
#   count = var.enable_waf && var.waf_log_destination == "cloudwatch" ? 1 : 0

#   resource_arn = aws_wafv2_web_acl.armageddon-waf[0].arn
#   log_destination_configs = [
#     aws_cloudwatch_log_group.armageddon-waf-log-group[0].arn
#   ]

#   # TODO: Students can add redacted_fields (authorization headers, cookies, etc.) as a stretch goal.
#   # redacted_fields { ... }

#   depends_on = [aws_wafv2_web_acl.armageddon-waf]
# }

# ############################################
# # Option 2: S3 destination (direct)
# ############################################

# # Explanation: S3 WAF logs are the long-term archive—Chewbacca likes receipts that survive dashboards.
# resource "aws_s3_bucket" "armageddon-waf-logs-bucket" {
#   count = var.waf_log_destination == "s3" ? 1 : 0

#   bucket = "aws-waf-logs-${var.project_name}-${data.aws_caller_identity.self.account_id}"

#   tags = {
#     Name = "${var.project_name}-waf-logs-bucket"
#   }
# }

# # Explanation: Public access blocked—WAF logs are not a bedtime story for the entire internet.
# resource "aws_s3_bucket_public_access_block" "armageddon-waf-logs-pab" {
#   count = var.waf_log_destination == "s3" ? 1 : 0

#   bucket                  = aws_s3_bucket.armageddon-waf-logs-bucket[0].id
#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

# # Explanation: Connect shield generator to archive vault—WAF -> S3.
# resource "aws_wafv2_web_acl_logging_configuration" "armageddon-waf-logging-s3" {
#   count = var.enable_waf && var.waf_log_destination == "s3" ? 1 : 0

#   resource_arn = aws_wafv2_web_acl.armageddon-waf[0].arn
#   log_destination_configs = [
#     aws_s3_bucket.armageddon-waf-logs-bucket[0].arn
#   ]

#   depends_on = [aws_wafv2_web_acl.armageddon-waf]
# }

# ############################################
# # Option 3: Firehose destination (classic “stream then store”)
# ############################################

# # Explanation: Firehose is the conveyor belt—WAF logs ride it to storage (and can fork to SIEM later).
# resource "aws_s3_bucket" "armageddon-firehose-waf-dest-bucket" {
#   count = var.waf_log_destination == "firehose" ? 1 : 0

#   bucket = "${var.project_name}-waf-firehose-dest-${data.aws_caller_identity.self.account_id}"

#   tags = {
#     Name = "${var.project_name}-waf-firehose-dest-bucket"
#   }
# }

# # Explanation: Firehose needs a role—Chewbacca doesn’t let random droids write into storage.
# resource "aws_iam_role" "armageddon-firehose-role" {
#   count = var.waf_log_destination == "firehose" ? 1 : 0
#   name  = "${var.project_name}-firehose-role01"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       Effect    = "Allow"
#       Principal = { Service = "firehose.amazonaws.com" }
#       Action    = "sts:AssumeRole"
#     }]
#   })
# }

# # Explanation: Minimal permissions—allow Firehose to put objects into the destination bucket.
# resource "aws_iam_role_policy" "armageddon-firehose-policy" {
#   count = var.waf_log_destination == "firehose" ? 1 : 0
#   name  = "${var.project_name}-firehose-policy"
#   role  = aws_iam_role.armageddon-firehose_role[0].id

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Action = [
#           "s3:AbortMultipartUpload",
#           "s3:GetBucketLocation",
#           "s3:GetObject",
#           "s3:ListBucket",
#           "s3:ListBucketMultipartUploads",
#           "s3:PutObject"
#         ]
#         Resource = [
#           aws_s3_bucket.armageddon-firehose-waf-dest-bucket[0].arn,
#           "${aws_s3_bucket.armageddon-firehose-waf-dest-bucket[0].arn}/*"
#         ]
#       }
#     ]
#   })
# }

# # Explanation: The delivery stream is the belt itself—logs move from WAF -> Firehose -> S3.
# resource "aws_kinesis_firehose_delivery_stream" "armageddon-waf_firehose" {
#   count       = var.waf_log_destination == "firehose" ? 1 : 0
#   name        = "aws-waf-logs-${var.project_name}-firehose"
#   destination = "extended_s3"

#   extended_s3_configuration {
#     role_arn   = aws_iam_role.armageddon-firehose_role[0].arn
#     bucket_arn = aws_s3_bucket.armageddon-firehose_waf_dest_bucket[0].arn
#     prefix     = "waf-logs/"
#   }
# }

# # Explanation: Connect shield generator to conveyor belt—WAF -> Firehose stream.
# resource "aws_wafv2_web_acl_logging_configuration" "armageddon-waf-logging-firehose" {
#   count = var.enable_waf && var.waf_log_destination == "firehose" ? 1 : 0

#   resource_arn = aws_wafv2_web_acl.armageddon-waf[0].arn
#   log_destination_configs = [
#     aws_kinesis_firehose_delivery_stream.armageddon-waf_firehose[0].arn
#   ]

#   depends_on = [aws_wafv2_web_acl.armageddon-waf]
# }
