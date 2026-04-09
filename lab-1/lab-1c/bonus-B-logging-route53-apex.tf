# ############################################
# # Bonus B - Route53 Zone Apex + ALB Access Logs to S3
# ############################################

# ############################################
# # Route53: Zone Apex (root domain) -> ALB
# ############################################

# # Explanation: The zone apex is the throne room—chewbacca-growl.com itself should lead to the ALB.
# resource "aws_route53_record" "armageddon-apex-alias" {
#   zone_id = local.armageddon_zone_id
#   name    = var.domain_name
#   type    = "A"

#   alias {
#     name                   = aws_lb.armageddon-alb.dns_name
#     zone_id                = aws_lb.armageddon-alb.zone_id
#     evaluate_target_health = true
#   }
# }

# ############################################
# # S3 bucket for ALB access logs
# ############################################

# # Explanation: This bucket is Chewbacca’s log vault—every visitor to the ALB leaves footprints here.
# resource "aws_s3_bucket" "armageddon-alb-logs-bucket" {
#   count = var.enable_alb_access_logs ? 1 : 0

#   bucket = "${var.project_name}-alb-logs-${data.aws_caller_identity.self.account_id}"

#   tags = {
#     Name = "${var.project_name}-alb-logs-bucket"
#   }
# }

# # Explanation: Block public access—Chewbacca does not publish the ship’s black box to the galaxy.
# resource "aws_s3_bucket_public_access_block" "armageddon-alb-logs-pab" {
#   count = var.enable_alb_access_logs ? 1 : 0

#   bucket                  = aws_s3_bucket.armageddon-alb-logs-bucket[0].id
#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

# # Explanation: Bucket ownership controls prevent log delivery chaos—Chewbacca likes clean chain-of-custody.
# resource "aws_s3_bucket_ownership_controls" "armageddon-alb-logs-owner" {
#   count = var.enable_alb_access_logs ? 1 : 0

#   bucket = aws_s3_bucket.armageddon-alb-logs-bucket[0].id
#   rule {
#     object_ownership = "BucketOwnerPreferred"
#   }
# }

# # Explanation: TLS-only—Chewbacca growls at plaintext and throws it out an airlock.
# resource "aws_s3_bucket_policy" "armageddon-alb-logs-policy" {
#   count = var.enable_alb_access_logs ? 1 : 0

#   bucket = aws_s3_bucket.armageddon-alb-logs-bucket[0].id

#   # NOTE: This is a skeleton. Students may need to adjust for region/account specifics.
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Sid       = "DenyInsecureTransport"
#         Effect    = "Deny"
#         Principal = "*"
#         Action    = "s3:*"
#         Resource = [
#           aws_s3_bucket.armageddon-alb-logs-bucket[0].arn,
#           "${aws_s3_bucket.armageddon-alb-logs-bucket[0].arn}/*"
#         ]
#         Condition = {
#           Bool = { "aws:SecureTransport" = "false" }
#         }
#       },
#       {
#         Sid    = "AllowELBPutObject"
#         Effect = "Allow"
#         Principal = {
#           Service = "elasticloadbalancing.amazonaws.com"
#         }
#         Action   = "s3:PutObject"
#         Resource = "${aws_s3_bucket.armageddon-alb-logs-bucket[0].arn}/${var.alb_access_logs_prefix}/AWSLogs/${data.aws_caller_identity.self.account_id}/*"
#       }
#     ]
#   })
# }
