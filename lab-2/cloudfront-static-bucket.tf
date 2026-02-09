# Cloudfront bucket serving as 2nd origin for distribution

resource "aws_s3_bucket" "armageddon_static_cf_bucket" {
  bucket = "${var.project_name}-static-${data.aws_caller_identity.my_self01.account_id}"
}

# Cloudfront origin access control for static bucket
resource "aws_cloudfront_origin_access_control" "static_oac" {
  name                              = "${var.project_name}-static-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# Cloudfront bucket public access block
resource "aws_s3_bucket_public_access_block" "armageddon_static_cf_pab01" {

  bucket                  = aws_s3_bucket.armageddon_static_cf_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Cloudfront bucket objects
resource "aws_s3_object" "static_index" {
  bucket = aws_s3_bucket.armageddon_static_cf_bucket.id
  key    = "static/index.html"
  source = "index.html"
  acl    = "private"
}

resource "aws_s3_object" "static_png01" {
  bucket = aws_s3_bucket.armageddon_static_cf_bucket.id
  key    = "static/doom-cosmic-realm.png"
  source = "doom-cosmic-realm.png"
  acl    = "private"
}

resource "aws_s3_object" "static_png02" {
  bucket = aws_s3_bucket.armageddon_static_cf_bucket.id
  key    = "static/cosmic_realm.png"
  source = "cosmic_realm.png"
  acl    = "private"
}


resource "aws_s3_object" "static_txt01" {
  bucket = aws_s3_bucket.armageddon_static_cf_bucket.id
  key    = "static/cosmic-realm.txt"
  source = "doom-cosmic-realm.txt"
  acl    = "private"
}

resource "aws_s3_bucket_ownership_controls" "armageddon_static_cf_bucket_owner01" {

  bucket = aws_s3_bucket.armageddon_static_cf_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}


data "aws_iam_policy_document" "armageddon_static_bucket_policy" {
  statement {
    sid     = "AllowCloudFrontReadViaOAC"
    effect  = "Allow"
    actions = ["s3:GetObject"]

    resources = [
      "${aws_s3_bucket.armageddon_static_cf_bucket.arn}/*"
    ]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.armageddon_cf01.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "armageddon_static_cf_bucket_policy" {
  bucket = aws_s3_bucket.armageddon_static_cf_bucket.id
  policy = data.aws_iam_policy_document.armageddon_static_bucket_policy.json
}
