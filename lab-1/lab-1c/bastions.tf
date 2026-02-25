# #############################################
# #### Security Group For Bastion Jump Box ####
# #############################################

# resource "aws_security_group" "bastion-sg01" {
#   name        = "bastion-sg01"
#   description = "Allow all inbound RDP to Backend"
#   vpc_id      = aws_vpc.armageddon-vpc.id

#   tags = {
#     Name    = "bastion-sg01"
#     Env     = "Test"
#     Service = "Network"
#   }
# }

# # Allow ingress traffic via RDP
# resource "aws_vpc_security_group_ingress_rule" "bastion-rdp-ingress" {
#   security_group_id = aws_security_group.bastion-sg01.id
#   cidr_ipv4         = "0.0.0.0/0"
#   #from_port         = 3389
#   ip_protocol       = "-1"
#   #to_port           = 3389

#   tags = {
#     Name = "Allow RDP from anywhere"
#   }
# }

# # Allow Outbound Traffic to Backend Server
# # resource "aws_vpc_security_group_egress_rule" "bastion-ssh-egress" {
# #   security_group_id            = aws_security_group.bastion-sg01.id      # Attaches this rule to bastion-g01
# #   referenced_security_group_id = aws_security_group.armageddon-ec2-sg.id # Allows traffic to backend-sg02
# #   from_port                    = 22
# #   ip_protocol                  = "tcp"
# #   to_port                      = 22

# #   tags = {
# #     Name = "Allow all SSH traffic to Backend Server"
# #   }
# # }

# # Allow Outbound Traffic to Backend Server
# resource "aws_vpc_security_group_egress_rule" "bastion-http-egress" {
#   security_group_id = aws_security_group.bastion-sg01.id # Attaches this rule to bastion-g01
#   cidr_ipv4         = "0.0.0.0/0"
#   #referenced_security_group_id = aws_security_group.armageddon-ec2-sg.id # Allows traffic to backend-sg02
#   #from_port   = 80
#   ip_protocol = "-1"
#   #to_port     = 80

#   tags = {
#     Name = "Allow all outbound HTTP traffic to Backend Server"
#   }
# }

# #################################################################################################
# #### ================================= Ubuntu Bastion Host ================================= ####
# #################################################################################################

# # AMI Daat Block to make code more resuable instade of hard-coded

# data "aws_ami" "ubuntu" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
#   }

#   owners = ["099720109477"] # Canonical
# }

# # Explanation: This is your “Han Solo box”—it talks to RDS and complains loudly when the DB is down.
# resource "aws_instance" "armageddon-bastion" {
#   ami                         = data.aws_ami.ubuntu.id
#   instance_type               = var.ec2_instance_type
#   subnet_id                   = aws_subnet.armageddon-public-subnets[0].id
#   vpc_security_group_ids      = [aws_security_group.armageddon-ec2-sg.id]
#   associate_public_ip_address = true

#   # user_data for ubuntu jummpbox
#   user_data = <<EOF
# #!/bin/bash
# # Install SSH client
# if command -v yum >/dev/null 2>&1; then
#   yum install -y openssh-clients
# elif command -v apt-get >/dev/null 2>&1; then
#   apt-get update -y && apt-get install -y openssh-client
# fi

# # Create .ssh directory and add private key
# mkdir -p /home/ubuntu/.ssh
# cat << 'KEYEOF' > /home/ubuntu/.ssh/id_rsa
# ${tls_private_key.armageddon-keys.private_key_pem}
# KEYEOF

# # Set correct permissions and ownership
# chmod 600 /home/ubuntu/.ssh/id_rsa
# chown ubuntu:ubuntu /home/ubuntu/.ssh/id_rsa
# EOF

#   key_name = aws_key_pair.armageddon-key-pair.id

#   lifecycle {
#     create_before_destroy = true
#   }

#   tags = {
#     Name = "${local.name_prefix}-ubuntu-bastion"
#   }
# }

# ######################
# ### Bastion Server ###
# ######################

# # AMI Data block to make code more resuable instead of being hard-coded
# # The Data block is found under the the CPU options in the aws_instance subsection in the Terrafrom Registry
# data "aws_ami" "ms-win-2025-base" {
#   most_recent = true       # Use the most recent AMI
#   owners      = ["amazon"] # Make sure to keep it as 'amazon' -- always get 'query returned no results' error when using MS owned account ID

#   filter {
#     name   = "name"
#     values = ["Windows_Server-2025-English-Full-Base-*"] # The value is found in the AMI catalog or running instance in instance details section in the  console
#   }                                                      # Retuns a broader range of AMIs with * wildcard. 
# }

# resource "aws_instance" "epstein-bestie" {
#   ami                         = data.aws_ami.ms-win-2025-base.id # Used to reference AMI data block
#   associate_public_ip_address = true
#   instance_type               = "t3.micro"
#   subnet_id                   = aws_subnet.armageddon-public-subnets[0].id
#   vpc_security_group_ids      = [aws_security_group.bastion-sg01.id]
#   key_name                    = aws_key_pair.armageddon-key-pair.key_name # Pairs key name to RDP into Windows

#   user_data = <<EOF
# <powershell>
# $ErrorActionPreference = "Stop"

# # Install OpenSSH Client if missing (Windows Server 2019/2022)
# $capName = "OpenSSH.Client~~~~0.0.1.0"
# $cap = Get-WindowsCapability -Online | Where-Object { $_.Name -eq $capName }

# if ($cap -and $cap.State -ne "Installed") {
#   Add-WindowsCapability -Online -Name $capName | Out-Null
# }

# # Create .ssh directory
# $sshDir = "C:\\Users\\Administrator\\.ssh"
# New-Item -ItemType Directory -Force -Path $sshDir | Out-Null

# # Write private key (PEM) to id_rsa
# $keyPath = Join-Path $sshDir "id_rsa"

# $privateKeyPem = @'
# ${tls_private_key.armageddon-keys.private_key_pem}
# '@

# # Write as ASCII to avoid BOM/unicode issues
# [System.IO.File]::WriteAllText($keyPath, $privateKeyPem, [System.Text.Encoding]::ASCII)

# # Lock down permissions (OpenSSH is picky)
# icacls $keyPath /inheritance:r | Out-Null
# icacls $keyPath /grant:r "Administrator:F" | Out-Null

# Write-Output "OpenSSH client ready; private key written to $keyPath"
# </powershell>
# EOF


#   lifecycle {
#     create_before_destroy = true
#   }

#   tags = {
#     Name = "${local.name_prefix}-epstein-bestie-jumpbox"
#   }
# }