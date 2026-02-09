# LAB1-A: Objective & Walkthrough Results

---
## OBJECTIVE:
1. Deploy a simple web app on an EC2 instance that can:
   - Insert a note into RDS MySQL
   - List notes from the database

2. Requirements
   - RDS MySQL instance in a private subnet
   - EC2 instance running a Python Flask app
   - Security groups allowing EC2 → RDS on port 3306
   - Credentials stored in AWS Secrets Manager (recommended)

---
---

# WALKTHROUGH RESULTS
***NOTE: Lab1-A was originally completed in `sa-east-1` instead of us-east-1***
## Part A - SGs & RDS

> ### List all security groups in a region

![Security Groups (SG)](./artifacts/lab1a/01-SGs.png)

> ### Inspect a specific security group (inbound & outbound rules)

![SG Detail](./artifacts/lab1a/02-SG-Inspection.png)

> ### Verify which resources (EC2 instances) are using the security group

![EC2 Using SG](./artifacts/lab1a/03-SGtoEC2.png)

> ### RDS instances

![RDS Instance](./artifacts/lab1a/04-RDS.pngg)

> ### List all RDS instances

![RDS Instance Detail](./artifacts/lab1a/05-RDS-Detail.png)

> ### Inspect a specific RDS instance

![RDS Instance Insepection](./artifacts/lab1a/06-RDS-Inspect.png)
![RDS Instance Insepection](./artifacts/lab1a/06-RDS-Inspect2.png)
![RDS Instance Insepection](./artifacts/lab1a/06-RDS-Inspect3.png)

> ### Verify RDS security groups explicitly

![RDS SGs](./artifacts/lab1a/07-RDS-SGs.png)

> ### Verify RDS subnet placement

![RDS Subnets](./artifacts/lab1a/08-RDS-Subnet.png)

> ### Check if RDS is publicly reachable (quick flag)

![RDS Not Public](./artifacts/lab1a/09-RDS-Private-Check.png)

---
---

## Part B — Secret Manager and EC2 IAM Role

> ### Verify Secrets Manager (Existence, Metadata, Access)

![Secret Manager](./artifacts/lab1a/10-SecretMnger_v2.png)

> ### Describe a specific secret (NO value exposure)

![Secret Manager Detail](./artifacts/lab1a/11-Secret-Detail.png)

> ### Verify which IAM principals can access the secret

![IAM Pinciple](./artifacts/lab1a/12-Secret-Principle.png)

> ### Verify IAM Role Attached to an EC2 Instance
  1. #### Identify the EC2 instance

    aws ec2 describe-instances \
      --filters Name=tag:Name,Values=MyInstance \
      --region us-east-1 \
      --query "Reservations[].Instances[].InstanceId" \
      --output text

  2. #### Check the IAM role attached to the instance

  ![IAM Profile](./artifacts/lab1a/14-EC2-IAM.png)
  
  3. ##### Resolve instance profile → role name

  ![IAM Role Name](./artifacts/lab1a/15-IAM-RoleName.png)


> ### Verify IAM Role Permissions (Critical): List policies attached to the role

![IAM Role Policies](./artifacts/lab1a/16-IAM-Role-Policies_v2.png)

> ### List inline policies (often forgotten)

![IAM Role Policies](./artifacts/lab1a/16b-IAM-Inline-Policies.png)

> ### Inspect a specific managed policy

![IAM Secret Policy](./artifacts/lab1a/17-IAM-Role-SecretMgmPolicies.png)
![IAM Secret Policy](./artifacts/lab1a/17-IAM-Role-SecretMgmPolicies2.png)

What you’re verifying
    Least privilege
    Only secretsmanager:GetSecretValue if read-only
    No wildcard * unless justified

---
---

## Part C — EC2 → RDS Testing
> ### http://<EC2_PUBLIC_IP>/init

![EC2 Init](./artifacts/lab1a/18-EC2-Init.png)

> ### http://<EC2_PUBLIC_IP>/add?note=

![EC2 Add? Note=""](./artifacts/lab1a/19-EC2-Add.png)

> ### http://<EC2_PUBLIC_IP>/list

![EC@ List](./artifacts/lab1a/20-EC2-List.png)

> ### Verify EC2 → RDS access path (security-group–to–security-group)

![EC2 to RDS Access w/ EC2 SG](./artifacts/lab1a/21-EC2toRDS-Access.png)

> ### Verify That EC2 Can Actually Read the Secret (From the Instance); From inside the EC2 instance:

![EC2 Read Secret](./artifacts/lab1a/22-EC2-ReadSecret.png)

Expected:Arn: arn:aws:sts::123456789012:assumed-role/MyEC2Role/i-0123456789abcdef0

> ### Then test access:

![EC2 Test Access](./artifacts/lab1a/23-EC2-Test-Access.png)

If this works:
    IAM role is correctly attached
    Permissions are effective

---
---

## Part D - Student Deliverables
> ### Screenshot of:
  #### 1. RDS SG inbound rule using source = sg-ec2-lab
  
  ![RDS SG Snapshot](./artifacts/lab1a/24-RDS-SG-Snap.png)

  #### 2. EC2 Role 
  
  ![IAM Role Name](./artifacts/lab1a/25-EC2-Role-Snap.png)

  #### 3. /list output showing at least 3 notes

  ![IAM Role Name](./artifacts/lab1a/26-EC2-List-Snap.png)

> ### Short answers:
  #### 1. Why is DB inbound source restricted to the EC2 security group?
          - 
  #### 2. What port does MySQL use?
          - 
  #### 3. Why is Secrets Manager better than storing creds in code/user-data?
          - 

3) Evidence for Audits / Labs (Recommended Output)

      aws ec2 describe-security-groups --group-ids sg-0123456789abcdef0 > sg.json
      aws rds describe-db-instances --db-instance-identifier mydb01 > rds.json
      aws secretsmanager describe-secret --secret-id my-db-secret > secret.json
      aws ec2 describe-instances --instance-ids i-0123456789abcdef0 > instance.json
      aws iam list-attached-role-policies --role-name MyEC2Role > role-policies.json

Then Answer:
    Why each rule exists
    What would break if removed
    Why broader access is forbidden
    Why this role exists
    Why it can read this secret
    Why it cannot read others


