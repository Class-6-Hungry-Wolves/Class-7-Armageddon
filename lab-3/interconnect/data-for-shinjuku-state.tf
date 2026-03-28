data "terraform_remote_state" "shinjuku_state" {
  backend = "s3"
  config = {
    bucket = "tf-state-bucket-for-shinjuku-architecture"
    key    = "lab-3/32626.tfstate"
    region = "ap-northeast-1"
  }
}