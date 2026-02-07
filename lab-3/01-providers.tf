############################################
# Lab 3: Multi-Region Provider Configuration
# Tokyo (default) + São Paulo + US-East-1
############################################

# Tokyo provider (default) - Primary region for data sovereignty (APPI)
provider "aws" {
  region = "ap-northeast-1"

  default_tags {
    tags = {
      Managedby   = "Terraform"
      Lab         = "lab3-multi-region"
      Environment = "development"
    }
  }
}

# São Paulo provider - Secondary compute region (stateless)
provider "aws" {
  alias  = "saopaulo"
  region = "sa-east-1"

  default_tags {
    tags = {
      Managedby   = "Terraform"
      Lab         = "lab3-multi-region"
      Environment = "development"
    }
  }
}

# US-East-1 provider - Required for CloudFront ACM certificates
provider "aws" {
  alias  = "useast1"
  region = "us-east-1"

  default_tags {
    tags = {
      Managedby   = "Terraform"
      Lab         = "lab3-multi-region"
      Environment = "development"
    }
  }
}
