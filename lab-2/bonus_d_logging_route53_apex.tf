resource "aws_route53_record" "apex_alias" {
  zone_id = local.chewbacca_zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_s3_bucket" "alb_logs_bucket" {
  count  = var.enable_alb_access_logs ? 1 : 0
  bucket = "${local.project_name_prefix}-${local.environment}-alb-logs-${data.aws_caller_identity.current.account_id}"
}

resource "aws_s3_bucket_public_access_block" "alb_logs_block" {
  for_each = var.enable_alb_access_logs ? { "enabled" = true } : {}

  bucket                  = aws_s3_bucket.alb_logs_bucket[0].id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "alb_logs_policy" {
  for_each = var.enable_alb_access_logs ? { "enabled" = true } : {}

  statement {
    principals {
      type        = "Service"
      identifiers = ["logdelivery.elasticloadbalancing.amazonaws.com"]
    }

    actions = ["s3:PutObject"]
    resources = [
      "${aws_s3_bucket.alb_logs_bucket[0].arn}/${var.alb_access_logs_prefix}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }

  statement {
    principals {
      type        = "Service"
      identifiers = ["logdelivery.elasticloadbalancing.amazonaws.com"]
    }

    actions   = ["s3:GetBucketAcl"]
    resources = [aws_s3_bucket.alb_logs_bucket[0].arn]
  }
}

resource "aws_s3_bucket_policy" "alb_logs_bucket_policy" {
  for_each = var.enable_alb_access_logs ? { "enabled" = true } : {}

  bucket = aws_s3_bucket.alb_logs_bucket[0].id
  policy = data.aws_iam_policy_document.alb_logs_policy["enabled"].json
}

