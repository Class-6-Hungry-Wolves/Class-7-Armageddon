############################################
# S3 Bucket for ALB Access Logs
############################################

# Explanation: This bucket is Chewbacca’s log vault—every visitor to the ALB leaves footprints here.
resource "aws_s3_bucket" "chewbacca_alb_logs_bucket01" {
  count = var.enable_alb_access_logs ? 1 : 0
  bucket        = "${var.project_name}-alb-logs-${module.lab1-ab.account_id}"  # Must be unique globally
  force_destroy = true  # Allows deletion even if logs exist

  tags = {
    Name = "${var.project_name}-alb-logs-bucket01"
  }
}

# Explanation: Block public access—Chewbacca does not publish the ship’s black box to the galaxy.
resource "aws_s3_bucket_public_access_block" "chewbacca_alb_logs_pab01" {
  count = var.enable_alb_access_logs ? 1 : 0

  bucket                  = aws_s3_bucket.chewbacca_alb_logs_bucket01[0].id    #aws_s3_bucket.chewbacca_alb_logs_bucket01[0].id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


# Explanation: TLS-only—Chewbacca growls at plaintext and throws it out an airlock.
resource "aws_s3_bucket_policy" "chewbacca_alb_logs_policy01" {
  count = var.enable_alb_access_logs ? 1 : 0

  bucket = aws_s3_bucket.chewbacca_alb_logs_bucket01[0].id

  # NOTE: This is a skeleton. Students may need to adjust for region/account specifics.
  # NOTE: S3 bucket policy must explicitly grant permission to the AWS-managed ELB service account for your region
  # NOTE: AWS uses a specific, hidden account ID in each region to write load balancer logs. 
  #       If your policy uses your account ID as the principal, it will fail.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "DenyInsecureTransport"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.chewbacca_alb_logs_bucket01[0].arn,
          "${aws_s3_bucket.chewbacca_alb_logs_bucket01[0].arn}/*"
        ]
        Condition = {
          Bool = { "aws:SecureTransport" = "false" }
        }
      },
      {
        Sid    = "AllowELBPutObject"
        Effect = "Allow"
        Principal = {
          #Service = "elasticloadbalancing.amazonaws.com"
          AWS = data.aws_elb_service_account.main.arn
        }
        Action   = "s3:PutObject"
        Resource = "${aws_s3_bucket.chewbacca_alb_logs_bucket01[0].arn}/${var.alb_access_logs_prefix}/AWSLogs/${module.lab1-ab.account_id}/*"
      }
    ]
  })
}
