data "terraform_remote_state" "liberdade_state" {
  backend = "s3"
  config = {
    bucket = "tf-state-bucket-for-liberdade-architecture"
    key    = "lab-3/32626.tfstate"
    region = "sa-east-1"
  }
}