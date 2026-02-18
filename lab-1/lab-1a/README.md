Flask Script:
1. Make sure to change the secret_id value in the flask userdata to what matches in the corresponding resource and variables blocks.
########################################################################################################################3
Make sure to set up the infrasture via ClickOps first to get better visual understanding on how to setup the infra later on Terraform.  

1. Create Security Groups for EC2 and RDS:
    * ec2-sg: 
      * Inbound: port 22 and 80
      * Outbound: All ports and IPs
    * rds-sg::
        * Inbound: port 3306 only from ec2-sg
        * Outbound: All ports and IPs

2. Create RDS MySQL database
    RDS Console → Create database
    Engine: MySQL
    Template: Free tier (or Dev/Test)
    DB instance identifier: lab-mysql
    Master username: admin
    Password: generate or set (keep it safe)
    Connectivity
    VPC: default (or class VPC)
    Public access: No
    VPC security group: create new sg-rds-lab
    Create DB
