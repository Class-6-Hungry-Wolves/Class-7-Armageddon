resource "random_password" "cf_origin_secret" {
  length  = 32
  special = false
}
