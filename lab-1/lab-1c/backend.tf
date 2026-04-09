#############################################################################
### NOTE: ONLY APPLIES TO BACKEND RESOURCEs: You MUST create an S3 bucket ###
### on the console FIRST before running 'INIT' and 'APPLY'                ###
#############################################################################

# Becuase this is part of a terrafrom block, it can be added here as in-line 
terraform {
  backend "s3" {
    bucket = "class7-armageddon-backend"
    key    = "state_files/022526/terraform.tfstate" # Path in S3 bucket -- NOTE: This is NOT a file path -- S3 is flat - an Object storage service
    region = "us-east-1"                            # NOTE: can be in a different region provider block below -- can also be in different account
  }
}
