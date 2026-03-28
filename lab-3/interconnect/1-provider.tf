provider "aws" {
  region = var.aws_region
}

provider "aws" {
  alias  = "saopaulo"
  region = var.alternate_region
}