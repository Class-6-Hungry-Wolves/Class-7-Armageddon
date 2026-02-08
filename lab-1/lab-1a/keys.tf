######################################################
##-- Register the public key in AWS as a Key Pair --##
######################################################

# === Make sure that the key name argument is attached to the EC2!! === #
resource "aws_key_pair" "armageddon-key-pair" {
  key_name   = "armageddon-keys"
  public_key = tls_private_key.armageddon-keys.public_key_openssh
}

#########################################
##-- Creates an SSH key pair locally --##
#########################################
resource "tls_private_key" "armageddon-keys" { # Uses the TLS Terraform provider
  algorithm = "RSA"
  rsa_bits  = 4096
}

#############################################################
##-- Generate 2 keys: a public and private locally (0600)--##
#############################################################

# Creates a local file within the current directory -- appears and disappears after each 'apply' 'destroy' of the Terraform
resource "local_file" "ec2_private_key" {
  content         = tls_private_key.armageddon-keys.private_key_pem
  filename        = "${path.module}/armageddon-private.pem" # Tells you where the file name is and where it lives -- (path.module == current folder)
  file_permission = "0600"
}

# Creates a local file within the current directory -- appears and disappears after each 'apply' 'destroy' of the Terraform
resource "local_file" "ec2_public_key" {
  content         = tls_private_key.armageddon-keys.public_key_pem
  filename        = "${path.module}/armageddon-public.pem" # Tells you where the file name is and where it lives -- (path.module == current folder)
  file_permission = "0600"
}