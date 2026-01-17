# Completed Deliverables Lab1a  [[2026-01-15]]


**████████████████████████████████████████

![[Pasted image 20260115222754.png]]

![[Pasted image 20260115222714.png]]

![[Pasted image 20260115222648.png]]

# CLI
*┏━━━━━━━━━━━━━━━━━━━━━┓

AWS CLI:

List all security groups in a region

```
aws ec2 describe-security-groups \
  --region us-east-1 \
  --query "SecurityGroups[].{GroupId:GroupId,Name:GroupName,VpcId:VpcId}" \
  --output table
```
##### my result [[2026-01-15]]

```rb
[[2026-01-15]]
MacBook-Pro:~ nikosfarias$ aws ec2 describe-security-groups \
>   --region us-east-1 \
>   --query "SecurityGroups[].{GroupId:GroupId,Name:GroupName,VpcId:VpcId}" \
>   --output table
------------------------------------------------------------------------------
|                           DescribeSecurityGroups                           |
+----------------------+---------------------------+-------------------------+
|        GroupId       |           Name            |          VpcId          |
+----------------------+---------------------------+-------------------------+
|  sg-07d05092e1e02371b|  SG armageddon MySQL      |  vpc-022f0caf9b4dc5e7f  |
|  sg-0b44b9ef47fd6e0b6|  rds-ec2-1                |  vpc-022f0caf9b4dc5e7f  |
|  sg-09ce5d514f575c71e|  armageddon EC2 HTTP SSH  |  vpc-022f0caf9b4dc5e7f  |
|  sg-0f5f1a3c4272dc8e5|  ec2-rds-1                |  vpc-022f0caf9b4dc5e7f  |
|  sg-02a8d862ac4d1e821|  default                  |  vpc-0040e9c82b201d080  |
|  sg-09c26c81f671736a4|  default                  |  vpc-022f0caf9b4dc5e7f  |
+----------------------+---------------------------+-------------------------+
```

Inspect a specific security group (inbound & outbound rules)

```
aws ec2 describe-security-groups \
  --group-ids sg-09ce5d514f575c71e \
  --region us-east-1 \
  --output json
```

SG HTTP-SSH - sg-09ce5d514f575c71e

```rb

[[2026-01-16]]

"SecurityGroups": [
        {
            "GroupId": "sg-09ce5d514f575c71e",
            "IpPermissionsEgress": [
                {
                    "IpProtocol": "-1",
                    "UserIdGroupPairs": [],
                    "IpRanges": [
                        {
                            "CidrIp": "0.0.0.0/0"
                        }
                    ],
                    "Ipv6Ranges": [],
                    "PrefixListIds": []
                }
            ],
            "Tags": [
                {
                    "Key": "Name",
                    "Value": "armageddon EC2 HTTP SSH"
                }
            ],
            "VpcId": "vpc-022f0caf9b4dc5e7f",
            "SecurityGroupArn": "arn:aws:ec2:us-east-1:212809501772:security-group/sg-09ce5d514f575c71e",
            "OwnerId": "212809501772",
            "GroupName": "armageddon EC2 HTTP SSH",
            "Description": "armageddon EC2 HTTP SSH",
            "IpPermissions": [
                {
                    "IpProtocol": "tcp",
                    "FromPort": 80,
                    "ToPort": 80,
                    "UserIdGroupPairs": [],
                    "IpRanges": [
                        {
                            "Description": "armageddon EC2 HTTP SSH",
                            "CidrIp": "0.0.0.0/0"
                        }
                    ],
                    "Ipv6Ranges": [],
                    "PrefixListIds": []
                },
                {
                    "IpProtocol": "tcp",
                    "FromPort": 22,
                    "ToPort": 22,
                    "UserIdGroupPairs": [],
                    "IpRanges": [
                        {
                            "Description": "SG armageddon EC2 HTTP SSH",
                            "CidrIp": "0.0.0.0/0"
                        }
                    ],
                    "Ipv6Ranges": [],
                    "PrefixListIds": []
                }
            ]
        }
    ]
}
(END)
```

SG  MySQL

```rb
[[2026-01-16]]

MacBook-Pro:~ nikosfarias$ aws ec2 describe-security-groups \
>   --group-ids sg-07d05092e1e02371b \
>   --region us-east-1 \
>   --output json
{
    "SecurityGroups": [
        {
            "GroupId": "sg-07d05092e1e02371b",
            "IpPermissionsEgress": [
                {
                    "IpProtocol": "-1",
                    "UserIdGroupPairs": [],
                    "IpRanges": [
                        {
                            "CidrIp": "0.0.0.0/0"
                        }
                    ],
                    "Ipv6Ranges": [],
                    "PrefixListIds": []
                }
            ],
            "Tags": [
                {
                    "Key": "Name",
                    "Value": "armageddon MySQL"
                }
            ],
            "VpcId": "vpc-022f0caf9b4dc5e7f",
            "SecurityGroupArn": "arn:aws:ec2:us-east-1:212809501772:security-group/sg-07d05092e1e02371b",
            "OwnerId": "212809501772",
            "GroupName": "SG armageddon MySQL",
            "Description": "SG armageddon MySQL",
            "IpPermissions": [
                {
                    "IpProtocol": "tcp",
                    "FromPort": 3306,
                    "ToPort": 3306,
                    "UserIdGroupPairs": [
                        {
                            "Description": "SG armageddon MySQL",
                            "UserId": "212809501772",
                            "GroupId": "sg-09ce5d514f575c71e"
                        }
                    ],
                    "IpRanges": [],
                    "Ipv6Ranges": [],
                    "PrefixListIds": []
                }
            ]
        }
    ]
}
(END)
```

Verify which resources are using the security group EC2 instances

```rb
❯ aws ec2 describe-instances \
  --filters Name=instance.group-id,Values=sg-09ce5d514f575c71e \
  --region us-east-1 \
  --query "Reservations[].Instances[].InstanceId" \
  --output table
-------------------------
|   DescribeInstances   |
+-----------------------+
|  i-01bcdb2d0925b4d28  |
+-----------------------+
```

SG HTTP-SSH - sg-09ce5d514f575c71e

```rb
aws ec2 describe-instances \
  --filters Name=instance.group-id,Values=sg-09ce5d514f575c71e \
  --region us-east-1 \
  --query "Reservations[].Instances[].InstanceId" \
  --output table
-------------------------
|   DescribeInstances   |
+-----------------------+
|  i-01bcdb2d0925b4d28  |
+-----------------------+
```

RDS instances

```rb
❯ aws rds describe-db-instances \
  --region us-east-1 \
  --query "DBInstances[?contains(VpcSecurityGroups[].VpcSecurityGroupId, 'sg-07d05092e1e02371b')].DBInstanceIdentifier" \
  --output table
---------------------
|DescribeDBInstances|
+-------------------+
|  labmysql         |
+-------------------+
```

List all RDS instances

```rb
aws rds describe-db-instances \
  --region us-east-1 \
  --query "DBInstances[].{DB:DBInstanceIdentifier,Engine:Engine,Public:PubliclyAccessible,Vpc:DBSubnetGroup.VpcId}" \
  --output table
-----------------------------------------------------------
|                   DescribeDBInstances                   |
+----------+---------+---------+--------------------------+
|    DB    | Engine  | Public  |           Vpc            |
+----------+---------+---------+--------------------------+
|  labmysql|  mysql  |  False  |  vpc-022f0caf9b4dc5e7f   |
+----------+---------+---------+--------------------------+
```

Inspect a specific RDS instance

```rb
aws rds describe-db-instances \
  --db-instance-identifier labmysql \
  --region us-east-1 \
  --output json
{
    "DBInstances": [
        {
            "DBInstanceIdentifier": "labmysql",
            "DBInstanceClass": "db.t4g.micro",
            "Engine": "mysql",
            "DBInstanceStatus": "available",
            "MasterUsername": "admin",
            "DBName": "labmysql",
            "Endpoint": {
                "Address": "labmysql.cmrys4aosktq.us-east-1.rds.amazonaws.com",
                "Port": 3306,
                "HostedZoneId": "Z2R2ITUGPM61AM"
            },
            "AllocatedStorage": 20,
            "InstanceCreateTime": "2026-01-15T08:34:46.111000+00:00",
            "PreferredBackupWindow": "05:23-05:53",
            "BackupRetentionPeriod": 1,
            "DBSecurityGroups": [],
            "VpcSecurityGroups": [
                {
                    "VpcSecurityGroupId": "sg-07d05092e1e02371b",
                    "Status": "active"
                },
                {
                    "VpcSecurityGroupId": "sg-0b44b9ef47fd6e0b6",
                    "Status": "active"
                }
            ],
            "DBParameterGroups": [
                {
                    "DBParameterGroupName": "default.mysql8.4",
                    "ParameterApplyStatus": "in-sync"
                }
            ],
            "AvailabilityZone": "us-east-1a",
            "DBSubnetGroup": {
                "DBSubnetGroupName": "rds-ec2-db-subnet-group-4",
                "DBSubnetGroupDescription": "Created from the RDS Management Console",
                "VpcId": "vpc-022f0caf9b4dc5e7f",
                "SubnetGroupStatus": "Complete",
                "Subnets": [
                    {
                        "SubnetIdentifier": "subnet-0c806cf839a0d4376",
                        "SubnetAvailabilityZone": {
                            "Name": "us-east-1a"
                        },
                        "SubnetOutpost": {},
                        "SubnetStatus": "Active"
                    },
                    {
                        "SubnetIdentifier": "subnet-05bd5a8378513920a",
                        "SubnetAvailabilityZone": {
                            "Name": "us-east-1c"
                        },
                        "SubnetOutpost": {},
                        "SubnetStatus": "Active"
                    },
                    {
                        "SubnetIdentifier": "subnet-067c04a040e83f51b",
                        "SubnetAvailabilityZone": {
                            "Name": "us-east-1b"
                        },
                        "SubnetOutpost": {},
                        "SubnetStatus": "Active"
                    },
                    {
                        "SubnetIdentifier": "subnet-09be08abf1f8ff60a",
                        "SubnetAvailabilityZone": {
                            "Name": "us-east-1e"
                        },
                        "SubnetOutpost": {},
                        "SubnetStatus": "Active"
                    },
                    {
                        "SubnetIdentifier": "subnet-0022acaa8686138f2",
                        "SubnetAvailabilityZone": {
                            "Name": "us-east-1f"
                        },
                        "SubnetOutpost": {},
                        "SubnetStatus": "Active"
                    }
                ]
            },
            "PreferredMaintenanceWindow": "thu:06:05-thu:06:35",
            "UpgradeRolloutOrder": "second",
            "PendingModifiedValues": {},
            "LatestRestorableTime": "2026-01-16T20:05:00+00:00",
            "MultiAZ": false,
            "EngineVersion": "8.4.7",
            "AutoMinorVersionUpgrade": true,
            "ReadReplicaDBInstanceIdentifiers": [],
            "LicenseModel": "general-public-license",
            "StorageThroughput": 0,
            "OptionGroupMemberships": [
                {
                    "OptionGroupName": "default:mysql-8-4",
                    "Status": "in-sync"
                }
            ],
            "PubliclyAccessible": false,
            "StorageType": "gp2",
            "DbInstancePort": 0,
            "StorageEncrypted": true,
            "KmsKeyId": "arn:aws:kms:us-east-1:212809501772:key/c6681d47-5fe9-4eea-ae5e-8124ffbe5d0b",
            "DbiResourceId": "db-L6HA3L5QSDYKSS7THEV7HTVUEQ",
            "CACertificateIdentifier": "rds-ca-rsa2048-g1",
            "DomainMemberships": [],
            "CopyTagsToSnapshot": true,
            "MonitoringInterval": 0,
            "DBInstanceArn": "arn:aws:rds:us-east-1:212809501772:db:labmysql",
            "IAMDatabaseAuthenticationEnabled": false,
            "DatabaseInsightsMode": "standard",
            "PerformanceInsightsEnabled": false,
            "DeletionProtection": false,
            "AssociatedRoles": [],
            "MaxAllocatedStorage": 1000,
            "TagList": [],
            "CustomerOwnedIpEnabled": false,
            "NetworkType": "IPV4",
            "ActivityStreamStatus": "stopped",
            "BackupTarget": "region",
            "CertificateDetails": {
                "CAIdentifier": "rds-ca-rsa2048-g1",
                "ValidTill": "2027-01-15T08:33:22+00:00"
            },
            "DedicatedLogVolume": false,
            "IsStorageConfigUpgradeAvailable": false,
            "EngineLifecycleSupport": "open-source-rds-extended-support-disabled"
        }
    ]
}
(END)
```

Critical checks "PubliclyAccessible": false Correct VPC Correct subnet group Correct security groups

Verify RDS security groups explicitly

```rb
aws rds describe-db-instances \
  --db-instance-identifier labmysql \
  --region us-east-1 \
  --query "DBInstances[].VpcSecurityGroups[].VpcSecurityGroupId" \
  --output table
--------------------------
|   DescribeDBInstances  |
+------------------------+
|  sg-07d05092e1e02371b  |
|  sg-0b44b9ef47fd6e0b6  |
+------------------------+
```

Verify RDS subnet placement

```rb
aws rds describe-db-instances \
  --db-instance-identifier labmysql \
  --region us-east-1 \
  --query "DBInstances[].VpcSecurityGroups[].VpcSecurityGroupId" \
  --output table
--------------------------
|   DescribeDBInstances  |
+------------------------+
|  sg-07d05092e1e02371b  |
|  sg-0b44b9ef47fd6e0b6  |
+------------------------+
```

What you’re verifying Private subnets only No IGW route Correct AZ spread

Verify Network Exposure (Fast Sanity Checks) Check if RDS is publicly reachable (quick flag)

```rb
aws rds describe-db-instances \
  --db-instance-identifier labmysql \
  --region us-east-1 \
  --query "DBInstances[].PubliclyAccessible" \
  --output text
False
```

Verify Secrets Manager (Existence, Metadata, Access)

```rb
aws secretsmanager list-secrets \
  --region us-east-1 \
  --query "SecretList[].{Name:Name,ARN:ARN,Rotation:RotationEnabled}" \
  --output table
------------------------------------------------------------------------------------------------------------
|                                                ListSecrets                                               |
+----------------------------------------------------------------------------+----------------+------------+
|                                     ARN                                    |     Name       | Rotation   |
+----------------------------------------------------------------------------+----------------+------------+
|  arn:aws:secretsmanager:us-east-1:212809501772:secret:lab/rds/mysql-WhQNNp |  lab/rds/mysql |  None      |
+----------------------------------------------------------------------------+----------------+------------+
```

What you’re verifying Secret exists Rotation state is known Naming is intentional

Describe a specific secret (NO value exposure)

```rb
aws secretsmanager describe-secret \
  --secret-id lab/rds/mysql \
  --region us-east-1 \
  --output json
{
    "ARN": "arn:aws:secretsmanager:us-east-1:212809501772:secret:lab/rds/mysql-WhQNNp",
    "Name": "lab/rds/mysql",
    "Description": "lab secret value",
    "LastChangedDate": "2026-01-15T22:03:07.620000-07:00",
    "LastAccessedDate": "2026-01-15T17:00:00-07:00",
    "Tags": [],
    "VersionIdsToStages": {
        "b517f63a-d3ab-4b10-8a10-045f759373f7": [
            "AWSPREVIOUS"
        ],
        "e6b62b55-5e20-486b-a5c8-78e48a739170": [
            "AWSCURRENT"
        ]
    },
    "CreatedDate": "2026-01-15T02:04:06.628000-07:00"
}
```

Key fields to check RotationEnabled KmsKeyId LastChangedDate LastAccessedDate

This command is always safe. It does not expose the secret value.

Create an IAM Role for EC2 to read the secret

1. IAM → Roles → Create role
2. Trusted entity: EC2
3. Add permission policy (tightest good enough for lab): SecretsManagerReadWrite is too broad (but easy). Better: create a small inline policy like below.

Inline policy (recommended) Replace , <ACCOUNT_ID>, and secret name if different: #Check inline_policy.json in this folder

4. Attach role to EC2: EC2 → Instance → Actions → Security → Modify IAM role → select your role

Verify which IAM principals can access the secret

```rb
aws secretsmanager get-resource-policy \
  --secret-id lab/rds/mysql \
  --region us-east-1 \
  --output json
{
    "ARN": "arn:aws:secretsmanager:us-east-1:212809501772:secret:lab/rds/mysql-WhQNNp",
    "Name": "lab/rds/mysql"
```

What you’re verifying Only expected roles are listed No wildcard principals No cross-account access unless justified

Verify IAM Role Attached to an EC2 Instance Step 1: Identify the EC2 instance

```rb
aws ec2 describe-instances \
  --filters Name=tag:Name,Values=Lab_Armageddon \
  --region us-east-1 \
  --query "Reservations[].Instances[].InstanceId" \
  --output text
i-03f20143986511fa7
```

Step 2: Check the IAM role attached to the instance

```rb
aws ec2 describe-instances \
  --instance-ids i-03f20143986511fa7 \
  --region us-east-1 \
  --query "Reservations[].Instances[].IamInstanceProfile.Arn" \
  --output text
arn:aws:iam::212809501772:instance-profile/1a_inline_policy.json
```

Expected: arn:aws:iam::123456789012:instance-profile/MyEC2Role

If empty → no role attached (this is a finding).

Step 3: Resolve instance profile → role name

```rb
aws iam get-instance-profile \
  --instance-profile-name 1a_inline_policy.json \
  --query "InstanceProfile.Roles[].RoleName" \
  --output text
1a_inline_policy.json
```

Verify IAM Role Permissions (Critical) List policies attached to the role

```rb
❯ aws iam list-attached-role-policies \
  --role-name 1a_inline_policy.json \
  --output table
--------------------------
|ListAttachedRolePolicies|
+------------------------+
```

List inline policies (often forgotten)

```rb
aws iam list-role-policies \
  --role-name 1a_inline_policy.json \
  --output table
------------------------
|   ListRolePolicies   |
+----------------------+
||     PolicyNames    ||
|+--------------------+|
||  1a_inline_policy  ||
|+--------------------+|
```

Inspect a specific managed policy

```rb
aws iam get-policy-version \
  --policy-arn arn:aws:iam::aws:policy/SecretsManagerReadWrite \
  --version-id v1 \
  --output json
{
    "PolicyVersion": {
        "Document": {
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Action": [
                        "secretsmanager:*",
                        "cloudformation:CreateChangeSet",
                        "cloudformation:DescribeChangeSet",
                        "cloudformation:DescribeStackResource",
                        "cloudformation:DescribeStacks",
                        "cloudformation:ExecuteChangeSet",
                        "ec2:DescribeSecurityGroups",
                        "ec2:DescribeSubnets",
                        "ec2:DescribeVpcs",
                        "kms:DescribeKey",
                        "kms:ListAliases",
                        "kms:ListKeys",
                        "lambda:ListFunctions",
                        "rds:DescribeDBInstances",
                        "tag:GetResources"
                    ],
                    "Effect": "Allow",
                    "Resource": "*"
                },
                {
                    "Action": [
                        "lambda:AddPermission",
                        "lambda:CreateFunction",
                        "lambda:GetFunction",
                        "lambda:InvokeFunction",
                        "lambda:UpdateFunctionConfiguration"
                    ],
                    "Effect": "Allow",
                    "Resource": "arn:aws:lambda:*:*:function:SecretsManager*"
                },
                {
                    "Action": [
                        "serverlessrepo:CreateCloudFormationChangeSet"
                    ],
                    "Effect": "Allow",
                    "Resource": "arn:aws:serverlessrepo:*:*:applications/SecretsManager*"
                },
                {
                    "Action": [
                        "s3:GetObject"
                    ],
                    "Effect": "Allow",
                    "Resource": "arn:aws:s3:::awsserverlessrepo-changesets*"
                }
            ]
        },
        "VersionId": "v1",
        "IsDefaultVersion": false,
        "CreateDate": "2018-04-04T18:05:29+00:00"
```

What you’re verifying Least privilege Only secretsmanager:GetSecretValue if read-only No wildcard * unless justified

Part 4 — Bootstrap the EC2 app (User Data) In EC2 launch, you can paste this in User data (or run manually after SSH). Important: Replace SECRET_ID if you used a different name. #user.data.sh

Part 5 — Test

1. In RDS console, copy the endpoint (you won’t paste it into app because Secrets Manager provides host)
2. Open browser: http://<EC2_PUBLIC_IP>/init http://<EC2_PUBLIC_IP>/add?note=first_note http://<EC2_PUBLIC_IP>/list If /init hangs or errors, it’s almost always: RDS SG inbound not allowing from EC2 SG on 3306 RDS not in same VPC/subnets routing-wise EC2 role missing secretsmanager:GetSecretValue Secret doesn’t contain host / username / password fields (fix by storing as “Credentials for RDS database”)

Verify EC2 → RDS access path (security-group–to–security-group)

```rb
aws ec2 describe-security-groups \
  --group-ids sg-07d05092e1e02371b \
  --region us-east-1 \
  --query "SecurityGroups[].IpPermissions"
[
    [
        {
            "IpProtocol": "tcp",
            "FromPort": 3306,
            "ToPort": 3306,
            "UserIdGroupPairs": [
                {
                    "Description": "SG armageddon MySQL",
                    "UserId": "212809501772",
                    "GroupId": "sg-09ce5d514f575c71e"
                }
            ],
            "IpRanges": [],
            "Ipv6Ranges": [],
            "PrefixListIds": []
        }
    ]
]

~                                                                                                                                         0s
❯ aws ec2 describe-security-groups \
  --group-ids sg-07d05092e1e02371b \
  --region us-east-1 \
  --query "SecurityGroups[].IpPermissions"
[
    [
        {
            "IpProtocol": "tcp",
            "FromPort": 3306,
            "ToPort": 3306,
            "UserIdGroupPairs": [
                {
                    "Description": "SG armageddon MySQL",
                    "UserId": "212809501772",
                    "GroupId": "sg-09ce5d514f575c71e"
                }
            ],
            "IpRanges": [],
            "Ipv6Ranges": [],
            "PrefixListIds": []
        }
    ]
]
```

Verify That EC2 Can Actually Read the Secret (From the Instance) From inside the EC2 instance:

```rb
❯ aws sts get-caller-identity
{
    "UserId": "AIDATDDDPJRGILF32Z4NV",
    "Account": "212809501772",
    "Arn": "arn:aws:iam::212809501772:user/AWSCLI"
```

Expected:Arn: arn:aws:sts::123456789012:assumed-role/MyEC2Role/i-0123456789abcdef0

Then test access:

```rb
aws secretsmanager describe-secret \
  --secret-id lab/rds/mysql \
  --region us-east-1
{
    "ARN": "arn:aws:secretsmanager:us-east-1:212809501772:secret:lab/rds/mysql-WhQNNp",
    "Name": "lab/rds/mysql",
    "Description": "lab secret value",
    "LastChangedDate": "2026-01-15T22:03:07.620000-07:00",
    "LastAccessedDate": "2026-01-15T17:00:00-07:00",
    "Tags": [],
    "VersionIdsToStages": {
        "b517f63a-d3ab-4b10-8a10-045f759373f7": [
            "AWSPREVIOUS"
        ],
        "e6b62b55-5e20-486b-a5c8-78e48a739170": [
            "AWSCURRENT"
        ]
    },
    "CreatedDate": "2026-01-15T02:04:06.628000-07:00"
}
```

If this works: IAM role is correctly attached Permissions are effective

Student Deliverables:

1. Screenshot of: RDS SG inbound rule using source = sg-ec2-lab EC2 role attached /list output showing at least 3 notes
![[sg-07d05092e1e02371b.png]]
   
![[Pasted image 20260116154317.png]]


	
2. Short answers: A) Why is DB inbound source restricted to the EC2 security group? B) What port does MySQL use? C) Why is Secrets Manager better than storing creds in code/user-data?

Excellent question! This is a **critical security concept** for the exam and real-world AWS! Let me break down why Secrets Manager (and similar solutions) are infinitely better than hardcoding credentials. 🔐

## The Horror of Hardcoded Credentials 😱

### What NOT to Do - Hardcoded in Code

```python
# ❌ TERRIBLE PRACTICE - DON'T DO THIS!
import psycopg2

# Hardcoded credentials in source code
db_connection = psycopg2.connect(
    host="mydb.cluster-xyz.us-east-1.rds.amazonaws.com",
    database="production",
    user="admin",
    password="SuperSecret123!"  # 🚨 DANGER!
)
```

### What NOT to Do - EC2 User Data

```rb
#!/bin/bash
# ❌ ALSO TERRIBLE - EC2 User Data Script

# Hardcoded database credentials
DB_USER="admin"
DB_PASS="SuperSecret123!"  # 🚨 Visible in console!

mysql -u $DB_USER -p$DB_PASS -h mydb.amazonaws.com -e "SELECT * FROM users"
```

## Why These Approaches Are Disasters 💥

```rb
┌──────────────────────────────────────────────────────────┐
│         PROBLEMS WITH HARDCODED CREDENTIALS              │
├──────────────────────────────────────────────────────────┤
│                                                           │
│  1️⃣  💻 Version Control Exposure                        │
│      • Credentials pushed to GitHub/GitLab               │
│      • Visible in commit history FOREVER                 │
│      • Accessible to anyone with repo access             │
│      • Bots scan GitHub for credentials constantly!      │
│                                                           │
│  2️⃣  👥 Too Many People Have Access                     │
│      • Every developer sees production passwords         │
│      • Former employees still have access                │
│      • Contractors, interns, everyone!                   │
│                                                           │
│  3️⃣  🔄 Rotation Nightmare                              │
│      • Change password = update ALL code                 │
│      • Must redeploy every application                   │
│      • High risk of breaking things                      │
│      • Often leads to "never rotating" passwords         │
│                                                           │
│  4️⃣  📋 No Audit Trail                                  │
│      • Who accessed the database? Unknown!               │
│      • When was it accessed? No idea!                    │
│      • Can't track unauthorized usage                    │
│                                                           │
│  5️⃣  🔍 EC2 User Data is Visible                        │
│      • Anyone with EC2 console access can see it         │
│      • Stored in plain text in metadata                  │
│      • curl http://169.254.169.254/latest/user-data      │
│                                                           │
│  6️⃣  💰 Compliance Violations                           │
│      • Fails PCI-DSS, HIPAA, SOC 2, etc.                │
│      • Can result in fines or failed audits              │
│                                                           │
│  7️⃣  🎯 Single Point of Compromise                      │
│      • One leaked password = entire system at risk       │
│      • No way to revoke without code changes             │
└──────────────────────────────────────────────────────────┘
```

## Real-World Horror Story 🔥

```rb
┌────────────────────────────────────────────────────────┐
│           WHAT ACTUALLY HAPPENS                        │
│                                                         │
│  Day 1: Developer commits code with DB password       │
│          ↓                                             │
│  Day 2: Code pushed to GitHub                         │
│          ↓                                             │
│  Day 3: Bot scrapes GitHub, finds credentials         │
│          ↓                                             │
│  Day 4: Attacker accesses database                    │
│          ↓                                             │
│  Day 5: 10 million user records stolen                │
│          ↓                                             │
│  Day 6: Company makes headline news                   │
│          "Major Data Breach - Customer Data Exposed"   │
│          ↓                                             │
│  Result: $50M fine + reputation destroyed              │
│                                                         │
│  ⏱️ Average time for bots to find exposed credentials: │
│     Less than 5 minutes after pushing to GitHub!       │
└────────────────────────────────────────────────────────┘
```

## AWS Secrets Manager - The Right Way ✅

### How Secrets Manager Works

```rb
┌──────────────────────────────────────────────────────────┐
│                  AWS SECRETS MANAGER                      │
│                                                           │
│  🔐 Encrypted Storage (KMS)                              │
│  🔄 Automatic Rotation                                   │
│  📊 Full Audit Trail (CloudTrail)                        │
│  🔑 Fine-grained Access Control (IAM)                    │
│  💰 Pay per secret (~$0.40/month + API calls)            │
└──────────────────────────────────────────────────────────┘

                         ↓

┌────────────────────────────────────────────────────────┐
│              HOW IT WORKS - FLOW DIAGRAM               │
│                                                         │
│  Step 1: Store Secret                                  │
│  ┌──────────┐                                          │
│  │  Admin   │ ─────→ "Store DB password in            │
│  └──────────┘         Secrets Manager"                 │
│                              ↓                          │
│                    ┌─────────────────┐                 │
│                    │ Secrets Manager │                 │
│                    │  [Encrypted]    │                 │
│                    │  with KMS       │                 │
│                    └─────────────────┘                 │
│                                                         │
│  Step 2: Application Requests Secret                   │
│  ┌──────────┐         API Call                        │
│  │   EC2    │ ──→ GetSecretValue("prod/db/password")  │
│  │ Instance │         ↓                                │
│  └──────────┘    ┌─────────────────┐                  │
│                  │ Secrets Manager │                   │
│                  │ Checks IAM Role │ ← IAM Policy      │
│                  └────────┬────────┘                   │
│                           │                             │
│                           │ If authorized, decrypt      │
│                           │ and return secret           │
│                           ↓                             │
│  ┌──────────┐      {"password": "SuperSecret123!"}    │
│  │   EC2    │ ←─────────────────────────────          │
│  │ Instance │      (Only in memory, never hardcoded!) │
│  └──────────┘                                          │
│       │                                                 │
│       │ Uses password to connect to DB                 │
│       ↓                                                 │
│  ┌──────────┐                                          │
│  │   RDS    │                                          │
│  └──────────┘                                          │
└────────────────────────────────────────────────────────┘
```

## Code Comparison: Wrong vs Right 🔄

### ❌ The Wrong Way (Hardcoded)

```python
# Hardcoded - NEVER DO THIS!
import psycopg2

connection = psycopg2.connect(
    host="mydb.cluster.us-east-1.rds.amazonaws.com",
    database="production",
    user="admin",
    password="SuperSecret123!"  # ← In version control! 😱
)
```

### ✅ The Right Way (Secrets Manager)

```python
import boto3
import json
import psycopg2

def get_secret():
    # Create Secrets Manager client
    client = boto3.client('secretsmanager', region_name='us-east-1')
    
    # Retrieve secret
    response = client.get_secret_value(SecretId='prod/db/credentials')
    
    # Parse secret
    secret = json.loads(response['SecretString'])
    return secret

# Get credentials from Secrets Manager
secret = get_secret()

# Connect using retrieved credentials
connection = psycopg2.connect(
    host=secret['host'],
    database=secret['database'],
    user=secret['username'],
    password=secret['password']  # ← Retrieved at runtime! ✅
)

# No hardcoded credentials anywhere in code! 🎉
```

## Secrets Manager vs Systems Manager Parameter Store

```rb
┌────────────────────────────────────────────────────────────┐
│          SECRETS MANAGER vs PARAMETER STORE                │
├────────────────────────────────────────────────────────────┤
│                                                             │
│  Feature               │ Secrets Manager │ Parameter Store│
│  ──────────────────────┼─────────────────┼────────────────│
│  Cost                  │ ~$0.40/secret   │ Free (standard)│
│                        │ + API calls     │ $0.05 advanced │
│  ──────────────────────┼─────────────────┼────────────────│
│  Automatic Rotation    │ ✅ Built-in     │ ❌ Manual only │
│  ──────────────────────┼─────────────────┼────────────────│
│  RDS Integration       │ ✅ Native       │ ❌ No          │
│  ──────────────────────┼─────────────────┼────────────────│
│  Cross-region replica  │ ✅ Yes          │ ❌ No          │
│  ──────────────────────┼─────────────────┼────────────────│
│  KMS Encryption        │ ✅ Mandatory    │ ✅ Optional    │
│  ──────────────────────┼─────────────────┼────────────────│
│  Max Size              │ 64 KB           │ 4 KB (std)     │
│                        │                 │ 8 KB (advanced)│
│  ──────────────────────┼─────────────────┼────────────────│
│  Best For              │ DB passwords    │ Config values  │
│                        │ API keys        │ App settings   │
│                        │ Credentials     │ Feature flags  │
└────────────────────────────────────────────────────────────┘

🎯 EXAM TIP: 
   "Automatic rotation" = Secrets Manager
   "Cost optimization for config" = Parameter Store
```

## Automatic Rotation - The Killer Feature 🔄

```rb
┌──────────────────────────────────────────────────────────┐
│           AUTOMATIC PASSWORD ROTATION                     │
│                                                           │
│  Without Secrets Manager (Manual):                       │
│  ────────────────────────────────────────                │
│  1. Change password in database           ⏱️ 30 min     │
│  2. Update password in all code files     ⏱️ 2 hours    │
│  3. Redeploy all applications             ⏱️ 3 hours    │
│  4. Test everything works                 ⏱️ 1 hour     │
│  5. Fix broken apps                       ⏱️ 2 hours    │
│  Total: ~8 hours + high risk of outage! 😰               │
│                                                           │
│  With Secrets Manager (Automatic):                       │
│  ────────────────────────────────────────                │
│  1. Enable rotation (30/60/90 days)       ⏱️ 5 min      │
│  2. Lambda automatically rotates          ⏱️ Automatic   │
│  3. Apps automatically get new password   ⏱️ Automatic   │
│  Total: Set it and forget it! ✅                         │
└──────────────────────────────────────────────────────────┘
```

### How Automatic Rotation Works

```rb
Day 0: Current password = "OldPass123"
   │
   │ Rotation Schedule = Every 30 days
   ↓
Day 30: Rotation Triggered!
   │
   ├──→ Step 1: Lambda creates new password
   │              New = "NewPass456"
   │
   ├──→ Step 2: Set new password in database
   │              (Both old and new work temporarily)
   │
   ├──→ Step 3: Test new password works
   │              ✅ Success!
   │
   ├──→ Step 4: Update secret in Secrets Manager
   │              Current = "NewPass456"
   │
   └──→ Step 5: Deprecate old password
                 "OldPass123" no longer works

Result: Zero downtime, fully automated! 🎉

┌────────────────────────────────────────────┐
│  Supported Automatic Rotation:             │
│  • RDS MySQL                               │
│  • RDS PostgreSQL                          │
│  • RDS Oracle                              │
│  • RDS SQL Server                          │
│  • Amazon DocumentDB                       │
│  • Amazon Redshift                         │
│  • Custom (your own Lambda function)       │
└────────────────────────────────────────────┘
```

## Access Control & Audit Trail 🔒

### IAM Policy Control

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "secretsmanager:GetSecretValue"
      ],
      "Resource": "arn:aws:secretsmanager:us-east-1:123456:secret:prod/db/*"
    }
  ]
}

Benefits:
✅ Only specific roles can access secrets
✅ Developers can't see production passwords
✅ Temporary credentials via IAM roles
✅ No shared passwords
```

### CloudTrail Logging

```rb
┌────────────────────────────────────────────────────┐
│          Every Access is Logged!                   │
│                                                     │
│  Event: GetSecretValue                             │
│  Who: arn:aws:iam::123456:role/web-app-role       │
│  When: 2026-01-11T14:23:45Z                       │
│  Secret: prod/db/credentials                       │
│  Source IP: 10.0.1.50                             │
│  User Agent: aws-sdk-python/2.0                   │
│  Result: Success                                   │
└────────────────────────────────────────────────────┘

Use Cases:
• "Who accessed production DB password last week?"
• "Was there unauthorized access?"
• "Compliance audit trail"
• "Detect suspicious patterns"
```

## Real Architecture Example 🏗️

### Before: Insecure Architecture ❌

```rb
┌─────────────────────────────────────────────────────┐
│                    GitHub Repo                      │
│                                                      │
│  app.py: password = "hardcoded123"  😱              │
│  (Visible to all developers + in git history)       │
└───────────────────────┬─────────────────────────────┘
                        │
                        │ Deploy
                        ↓
              ┌──────────────────┐
              │   EC2 Instance   │
              │                  │
              │ Uses hardcoded   │
              │ password         │
              └────────┬─────────┘
                       │
                       │ Connect with hardcoded password
                       ↓
              ┌──────────────────┐
              │   RDS Database   │
              │                  │
              │ Password never   │
              │ changes          │
              └──────────────────┘

Problems:
🚨 Password in version control
🚨 All devs know production password
🚨 Can't rotate without code changes
🚨 No audit trail
🚨 Former employees still know it
```

### After: Secure Architecture ✅

```rb
┌─────────────────────────────────────────────────────┐
│                    GitHub Repo                      │
│                                                      │
│  app.py: get_secret('prod/db/creds')  ✅            │
│  (No credentials in code!)                          │
└───────────────────────┬─────────────────────────────┘
                        │
                        │ Deploy
                        ↓
              ┌──────────────────┐
              │   EC2 Instance   │
              │   (IAM Role)     │◄──── IAM Policy
              └────────┬─────────┘      (allows GetSecretValue)
                       │
                       │ API Call: GetSecretValue
                       ↓
              ┌──────────────────────────┐
              │  AWS Secrets Manager     │
              │  ┌────────────────────┐  │
              │  │ prod/db/creds      │  │
              │  │ (Encrypted w/ KMS) │  │
              │  │ Auto-rotate: 30d   │  │
              │  └────────────────────┘  │
              └───────────┬──────────────┘
                          │
                          │ Managed rotation
                          ↓
              ┌──────────────────┐
              │   RDS Database   │
              │                  │
              │ Password rotates │
              │ automatically    │
              └──────────────────┘

Benefits:
✅ No credentials in code
✅ Devs never see production passwords
✅ Automatic rotation every 30 days
✅ Full CloudTrail audit log
✅ Revoke access by changing IAM policy
✅ Different passwords per environment
```

## Cost Comparison 💰

```rb
┌─────────────────────────────────────────────────────┐
│              COST ANALYSIS                          │
│                                                      │
│  Secrets Manager:                                   │
│  • $0.40 per secret per month                       │
│  • $0.05 per 10,000 API calls                       │
│                                                      │
│  Example: 5 secrets, 1M calls/month                 │
│  = (5 × $0.40) + (100 × $0.05)                      │
│  = $2.00 + $5.00 = $7/month                         │
│                                                      │
│  Cost of ONE data breach:                           │
│  • Average: $4.45 million                           │
│  • Fines: Up to $50 million (GDPR)                  │
│  • Reputation damage: Priceless                     │
│                                                      │
│  ROI: $7/month to avoid $4.45M loss = 📈📈📈        │
└─────────────────────────────────────────────────────┘
```

## Parameter Store Alternative (Free Tier)

```rb
┌────────────────────────────────────────────────────┐
│         When to Use Parameter Store                │
│                                                     │
│  Good For:                                         │
│  ✅ Application configuration                      │
│  ✅ Feature flags                                  │
│  ✅ Non-sensitive settings                         │
│  ✅ Cost-sensitive projects                        │
│                                                     │
│  Example:                                          │
│  /myapp/dev/api_endpoint                          │
│  /myapp/dev/max_connections                       │
│  /myapp/dev/log_level                             │
│                                                     │
│  NOT Good For:                                     │
│  ❌ Database passwords (use Secrets Manager)       │
│  ❌ API keys that need rotation                    │
│  ❌ Anything requiring automatic rotation          │
└────────────────────────────────────────────────────┘
```

## Exam Scenarios 🎯

### Scenario 1

**Q:** Application needs database credentials. Must rotate every 90 days. What's the best solution?

**A:** AWS Secrets Manager with automatic rotation enabled ✅

**Why not hardcode?** No rotation capability, security risk

---

### Scenario 2

**Q:** Need to store API keys for 3rd party service. Must audit all access. Low cost.

**A:** Systems Manager Parameter Store (SecureString) with CloudTrail ✅

**Why not Secrets Manager?** No rotation needed, cost optimization

---

### Scenario 3

**Q:** RDS password must rotate automatically. Zero downtime required.

**A:** Secrets Manager with RDS automatic rotation ✅

**Why not manual?** Requires downtime and code changes

---

### Scenario 4

**Q:** Developer accidentally committed AWS access keys to GitHub. What now?

**A:**

1. Immediately delete the keys in IAM ⚡
2. Rotate any compromised credentials
3. Review CloudTrail for unauthorized usage
4. Implement Secrets Manager going forward
5. Use git-secrets or AWS CodeGuru to prevent future commits

---

### Scenario 5

**Q:** Need different database passwords for dev, staging, and production environments.

**A:** Secrets Manager with separate secrets per environment:

- `dev/db/credentials`
- `staging/db/credentials`
- `prod/db/credentials`

Each with different IAM access policies ✅

## Key Exam Tips 📝

**Secrets Manager is better because:**

✅ **No hardcoded credentials** - Never in code or version control ✅ **Automatic rotation** - Zero-touch password changes ✅ **Encryption at rest** - KMS integration ✅ **Fine-grained access** - IAM policies control who sees what ✅ **Full audit trail** - CloudTrail logs every access ✅ **RDS integration** - Native support for database rotation ✅ **Cross-region replication** - High availability ✅ **Versioning** - Rollback if needed ✅ **Compliance ready** - Meets PCI-DSS, HIPAA, SOC 2

**Hardcoded credentials are bad because:**

❌ **Version control exposure** - Forever in git history ❌ **Too many people know** - Can't revoke easily ❌ **No rotation** - Password never changes ❌ **No audit trail** - Don't know who accessed what ❌ **EC2 User Data visible** - Anyone with console access ❌ **Compliance violations** - Fails most security standards ❌ **Single point of failure** - One leak compromises everything

**Quick Decision Tree:**

```rb
Need to store credentials?
    │
    ├─ Database passwords + rotation? ──→ Secrets Manager
    │
    ├─ App config, no rotation needed? ──→ Parameter Store
    │
    └─ Never ever ever ──→ Hardcode in code/user data ❌
```

Does this make the difference crystal clear? Want to explore another security service or concept? 🔐

3. Evidence for Audits / Labs (Recommended Output)
    
    aws ec2 describe-security-groups --group-ids sg-0123456789abcdef0 > sg.json aws rds describe-db-instances --db-instance-identifier mydb01 > rds.json aws secretsmanager describe-secret --secret-id my-db-secret > secret.json aws ec2 describe-instances --instance-ids i-0123456789abcdef0 > instance.json aws iam list-attached-role-policies --role-name MyEC2Role > role-policies.json
    

Then Answer: 
 - Why each rule exists? _To allow HTTP access to the VPC.   Security group MySQL allowing EC2 → RDS on port 3306  
 - What would break if removed? _The ability to access the database from the internet
 - Why broader access is forbidden _To lImit access to sensitive data, medical db, profile info (IE: hackers getting into TeaApp unsecured DB)_
 - Why this role exists  _IAM Role for EC2 to read the stored secret for access to db_
 - Why it can read this secret _Can access rotating secrets that is not hardcoded features IAM policy control and trail logging.
 - Why it cannot read others _IAM Role restrics access _

*┗━━━━━━━━━━━━━━━━━━━━━┛

