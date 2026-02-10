locals {
  # toggle booleans
  waf_dest_cloudwatch = var.waf_log_destination == "cloudwatch"
  waf_dest_s3         = var.waf_log_destination == "s3"
  waf_dest_firehose   = var.waf_log_destination == "firehose"

  # DRY naming aligned with main.tf
  waf_prefix = "${local.project_name_prefix}-${local.environment}"

  # REQUIRED prefix: aws-waf-logs-
  waf_log_group_name = "aws-waf-logs-${local.waf_prefix}-webacl01"
  waf_s3_bucket_name = "aws-waf-logs-${local.waf_prefix}-${data.aws_caller_identity.current.account_id}"
  waf_firehose_name  = "aws-waf-logs-${local.waf_prefix}-firehose01"
}

# A) CloudWatch destination
resource "aws_cloudwatch_log_group" "chewbacca_waf_log_group01" {
  count             = local.waf_dest_cloudwatch ? 1 : 0
  name              = local.waf_log_group_name
  retention_in_days = var.waf_log_retention_days
}

# B) S3 destination
resource "aws_s3_bucket" "chewbacca_waf_logs_bucket01" {
  count  = local.waf_dest_s3 ? 1 : 0
  bucket = local.waf_s3_bucket_name
}

resource "aws_s3_bucket_public_access_block" "chewbacca_waf_logs_pab01" {
  count  = local.waf_dest_s3 ? 1 : 0
  bucket = aws_s3_bucket.chewbacca_waf_logs_bucket01[0].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# C) Firehose destination
resource "aws_s3_bucket" "chewbacca_firehose_dest_bucket01" {
  count  = local.waf_dest_firehose ? 1 : 0
  bucket = "chewbacca-firehose-dest-${local.waf_prefix}-${data.aws_caller_identity.current.account_id}"
}

resource "aws_s3_bucket_public_access_block" "chewbacca_firehose_dest_pab01" {
  count  = local.waf_dest_firehose ? 1 : 0
  bucket = aws_s3_bucket.chewbacca_firehose_dest_bucket01[0].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_iam_role" "chewbacca_firehose_role01" {
  count = local.waf_dest_firehose ? 1 : 0
  name  = "chewbacca-firehose-role01-${local.waf_prefix}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "firehose.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "chewbacca_firehose_role_policy01" {
  count = local.waf_dest_firehose ? 1 : 0
  name  = "chewbacca-firehose-policy01-${local.waf_prefix}"
  role  = aws_iam_role.chewbacca_firehose_role01[0].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "s3:AbortMultipartUpload",
        "s3:GetBucketLocation",
        "s3:GetObject",
        "s3:ListBucket",
        "s3:ListBucketMultipartUploads",
        "s3:PutObject"
      ]
      Resource = [
        aws_s3_bucket.chewbacca_firehose_dest_bucket01[0].arn,
        "${aws_s3_bucket.chewbacca_firehose_dest_bucket01[0].arn}/*"
      ]
    }]
  })
}

resource "aws_kinesis_firehose_delivery_stream" "chewbacca_waf_firehose01" {
  count       = local.waf_dest_firehose ? 1 : 0
  name        = local.waf_firehose_name
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn   = aws_iam_role.chewbacca_firehose_role01[0].arn
    bucket_arn = aws_s3_bucket.chewbacca_firehose_dest_bucket01[0].arn
    prefix     = "waf-logs/"
  }
}

# WAF logging configuration (ONE destination)
resource "aws_wafv2_web_acl_logging_configuration" "chewbacca_waf_logging01" {
  # IMPORTANT: you already have this Web ACL in your ALB section
resource_arn = aws_wafv2_web_acl.cf_waf.arn


  log_destination_configs = [
    local.waf_dest_cloudwatch ? aws_cloudwatch_log_group.chewbacca_waf_log_group01[0].arn :
    local.waf_dest_s3 ? aws_s3_bucket.chewbacca_waf_logs_bucket01[0].arn :
    aws_kinesis_firehose_delivery_stream.chewbacca_waf_firehose01[0].arn
  ]
}

# Guardrail
resource "null_resource" "validate_waf_log_destination" {
  triggers = { choice = var.waf_log_destination }

  lifecycle {
    precondition {
      condition     = contains(["cloudwatch", "s3", "firehose"], var.waf_log_destination)
      error_message = "var.waf_log_destination must be one of: cloudwatch | s3 | firehose"
    }
  }
}
