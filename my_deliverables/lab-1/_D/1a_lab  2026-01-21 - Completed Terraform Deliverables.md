# [[2026-01-21]] Student Deliverables:

## My Values Reference

| Resource           | Value                       |
| ------------------ | --------------------------- |
| Region             | us-east-1                   |
| EC2 Instance ID    | i-01c7d93a21a56f052         |
| EC2 Security Group | sg-0f891b9dea92b2798        |
| RDS Security Group | sg-0976ce7e018f394dd        |
| RDS Instance ID    | vandelay-rds01              |
| Secret ID          | lab/rds/mysql               |
| IAM Role Name      | vandelay-ec2-role01         |
| Instance Profile   | vandelay-instance-profile01 |
| VPC ID             | vpc-0625ec8bdd4eedbd7       |

AWS CLI:

List all security groups in a region

```
aws ec2 describe-security-groups \
  --region us-east-1 \
  --query "SecurityGroups[].{GroupId:GroupId,Name:GroupName,VpcId:VpcId}" \
  --output table
```

```rb
aws ec2 describe-security-groups \
  --region us-east-1 \
  --query "SecurityGroups[].{GroupId:GroupId,Name:GroupName,VpcId:VpcId}" \
  --output table
----------------------------------------------------------------------------------
|                             DescribeSecurityGroups                             |
+----------------------+-------------------------------+-------------------------+
|        GroupId       |             Name              |          VpcId          |
+----------------------+-------------------------------+-------------------------+
|  sg-0bd9dc2d8b10589fe|  vandelay-rotation-lambda-sg  |  vpc-0625ec8bdd4eedbd7  |
|  sg-0e0374f8be3382a0f|  vandelay-vpce-sg             |  vpc-0625ec8bdd4eedbd7  |
|  sg-09ce5d514f575c71e|  armageddon EC2 HTTP SSH      |  vpc-022f0caf9b4dc5e7f  |
|  sg-05ac627503d630f7b|  rds-ec2-2                    |  vpc-022f0caf9b4dc5e7f  |
|  sg-0976ce7e018f394dd|  vandelay-rds-sg01            |  vpc-0625ec8bdd4eedbd7  |
|  sg-07d05092e1e02371b|  SG armageddon MySQL          |  vpc-022f0caf9b4dc5e7f  |
|  sg-0f891b9dea92b2798|  vandelay-ec2-sg01            |  vpc-0625ec8bdd4eedbd7  |
|  sg-0b44b9ef47fd6e0b6|  rds-ec2-1                    |  vpc-022f0caf9b4dc5e7f  |
|  sg-0ea7d16f3ff96681e|  default                      |  vpc-0625ec8bdd4eedbd7  |
|  sg-0f5f1a3c4272dc8e5|  ec2-rds-1                    |  vpc-022f0caf9b4dc5e7f  |
|  sg-0a0822346bd075ac8|  ec2-rds-2                    |  vpc-022f0caf9b4dc5e7f  |
|  sg-02a8d862ac4d1e821|  default                      |  vpc-0040e9c82b201d080  |
|  sg-09c26c81f671736a4|  default                      |  vpc-022f0caf9b4dc5e7f  |
+----------------------+-------------------------------+-------------------------+
```

Inspect a specific security group (inbound & outbound rules)

```
aws ec2 describe-security-groups \
  --group-ids sg-0123456789abcdef0 \
  --region us-east-1 \
  --output json
```

```rb
…/SEIR_Foundations/LAB1/python                                                                                                1s
❯ aws ec2 describe-security-groups \
  --group-ids sg-0f891b9dea92b2798 \
  --region us-east-1 \
  --output json
{
    "SecurityGroups": [
        {
            "GroupId": "sg-0f891b9dea92b2798",
            "IpPermissionsEgress": [
                {
                    "IpProtocol": "-1",
                    "UserIdGroupPairs": [],
                    "IpRanges": [
                        {
                            "Description": "Allow all outbound traffic",
                            "CidrIp": "0.0.0.0/0"
                        }                                                                                                                            ],
                    "Ipv6Ranges": [],
                    "PrefixListIds": []
                }
            ],
            "Tags": [
                {
                    "Key": "Lab",
                    "Value": "ec2-rds-integration"
                },
                {
                    "Key": "Name",
                    "Value": "vandelay-ec2-sg01"
                }
            ],
            "VpcId": "vpc-0625ec8bdd4eedbd7",
            "SecurityGroupArn": "arn:aws:ec2:us-east-1:212809501772:security-group/sg-0f891b9dea92b2798",
            "OwnerId": "212809501772",
            "GroupName": "vandelay-ec2-sg01",
            "Description": "EC2 app security group",
            "IpPermissions": [
                {
                    "IpProtocol": "tcp",
                    "FromPort": 80,
                    "ToPort": 80,
                    "UserIdGroupPairs": [],
                    "IpRanges": [
                        {
                            "Description": "Allow HTTP from anywhere",
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
                            "Description": "Allow SSH from admin IP",
                            "CidrIp": "71.196.152.12/30"
                        }
                    ],
                    "Ipv6Ranges": [],
                    "PrefixListIds": []
                }
            ]
        }
    ]
}

zsh: suspended  aws ec2 describe-security-groups --group-ids sg-0f891b9dea92b2798 --region
```

Inspect EC2 security group (inbound & outbound rules):

```rb
…/SEIR_Foundations/LAB1/python                                                                                                
❯ aws ec2 describe-security-groups \
  --group-ids sg-0976ce7e018f394dd \
  --region us-east-1 \
  --output json
{
    "SecurityGroups": [
        {
            "GroupId": "sg-0976ce7e018f394dd",
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
                    "Key": "Lab",
                    "Value": "ec2-rds-integration"
                },
                {
                    "Key": "Name",
                    "Value": "vandelay-rds-sg01"
                }
            ],
            "VpcId": "vpc-0625ec8bdd4eedbd7",
            "SecurityGroupArn": "arn:aws:ec2:us-east-1:212809501772:security-group/sg-0976ce7e018f394dd",
            "OwnerId": "212809501772",
            "GroupName": "vandelay-rds-sg01",
            "Description": "RDS security group - only allows EC2 app server",
            "IpPermissions": [
                {
                    "IpProtocol": "tcp",
                    "FromPort": 3306,
                    "ToPort": 3306,
                    "UserIdGroupPairs": [
                        {
                            "Description": "Allow MySQL from EC2 app server only",
                            "UserId": "212809501772",
                            "GroupId": "sg-0f891b9dea92b2798"
                        },
                        {
                            "Description": "Allow Lambda rotation function to connect to RDS",
                            "UserId": "212809501772",
                            "GroupId": "sg-0bd9dc2d8b10589fe"
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

zsh: suspended  aws ec2 describe-security-groups --group-ids sg-0976ce7e018f394dd --region
```

Verify which resources are using the security group EC2 instances

```
aws ec2 describe-instances \
  --filters Name=instance.group-id,Values=sg-0123456789abcdef0 \
  --region us-east-1 \
  --query "Reservations[].Instances[].InstanceId" \
  --output table
```

```rb
…/SEIR_Foundations/LAB1/python                                                                                                
❯ aws ec2 describe-instances \
  --filters Name=instance.group-id,Values=sg-0f891b9dea92b2798 \
  --region us-east-1 \
  --query "Reservations[].Instances[].InstanceId" \
  --output table
-------------------------
|   DescribeInstances   |
+-----------------------+
|  i-01c7d93a21a56f052  |
+-----------------------+
```

RDS instances

```
aws rds describe-db-instances \
  --region us-east-1 \
  --query "DBInstances[?contains(VpcSecurityGroups[].VpcSecurityGroupId, 'sg-0123456789abcdef0')].DBInstanceIdentifier" \
  --output table
```

```rb
…/SEIR_Foundations/LAB1/python                                                                                                
❯ aws rds describe-db-instances \
  --region us-east-1 \
  --query "DBInstances[?contains(VpcSecurityGroups[].VpcSecurityGroupId, 'sg-0976ce7e018f394dd')].DBInstanceIdentifier" \
  --output table
---------------------
|DescribeDBInstances|
+-------------------+
|  vandelay-rds01   |
+-------------------+
```

List all RDS instances

```
aws rds describe-db-instances \
  --region us-east-1 \
  --query "DBInstances[].{DB:DBInstanceIdentifier,Engine:Engine,Public:PubliclyAccessible,Vpc:DBSubnetGroup.VpcId}" \
  --output table
```

```rb
…/SEIR_Foundations/LAB1/python                                                                                                
❯ aws rds describe-db-instances \
  --region us-east-1 \
  --query "DBInstances[].{DB:DBInstanceIdentifier,Engine:Engine,Public:PubliclyAccessible,Vpc:DBSubnetGroup.VpcId}" \
  --output table
-----------------------------------------------------------------
|                      DescribeDBInstances                      |
+-----------------+---------+---------+-------------------------+
|       DB        | Engine  | Public  |           Vpc           |
+-----------------+---------+---------+-------------------------+
|  vandelay-rds01 |  mysql  |  False  |  vpc-0625ec8bdd4eedbd7  |
+-----------------+---------+---------+-------------------------+
```

Inspect a specific RDS instance

```
aws rds describe-db-instances \
  --db-instance-identifier mydb01 \
  --region us-east-1 \
  --output json
```

```rb
…/SEIR_Foundations/LAB1/python                                                                                                
❯ aws rds describe-db-instances \
  --db-instance-identifier vandelay-rds01 \
  --region us-east-1 \
  --output json
{
    "DBInstances": [
        {
            "DBInstanceIdentifier": "vandelay-rds01",
            "DBInstanceClass": "db.t3.micro",
            "Engine": "mysql",
            "DBInstanceStatus": "available",
            "MasterUsername": "admin",
            "DBName": "labmysql",
            "Endpoint": {
                "Address": "vandelay-rds01.cmrys4aosktq.us-east-1.rds.amazonaws.com",
                "Port": 3306,
                "HostedZoneId": "Z2R2ITUGPM61AM"
            },
            "AllocatedStorage": 20,
            "InstanceCreateTime": "2026-01-22T02:18:03.102000+00:00",
            "PreferredBackupWindow": "06:04-06:34",
            "BackupRetentionPeriod": 0,
            "DBSecurityGroups": [],
            "VpcSecurityGroups": [
                {
                    "VpcSecurityGroupId": "sg-0976ce7e018f394dd",
                    "Status": "active"
                }
            ],
            "DBParameterGroups": [
                {
                    "DBParameterGroupName": "default.mysql8.0",
                    "ParameterApplyStatus": "in-sync"
                }
            ],
            "AvailabilityZone": "us-east-1a",
            "DBSubnetGroup": {
                "DBSubnetGroupName": "vandelay-rds-subnet-group01",
                "DBSubnetGroupDescription": "Managed by Terraform",
                "VpcId": "vpc-0625ec8bdd4eedbd7",
                "SubnetGroupStatus": "Complete",
                "Subnets": [
                    {
                        "SubnetIdentifier": "subnet-0139ce0f173314061",
                        "SubnetAvailabilityZone": {
                            "Name": "us-east-1b"
                        },
                        "SubnetOutpost": {},
                        "SubnetStatus": "Active"
                    },
                    {
                        "SubnetIdentifier": "subnet-0b4610c2083825319",
                        "SubnetAvailabilityZone": {
                            "Name": "us-east-1a"
                        },
                        "SubnetOutpost": {},
                        "SubnetStatus": "Active"
                    }
                ]
            },
            "PreferredMaintenanceWindow": "tue:03:26-tue:03:56",
            "UpgradeRolloutOrder": "second",
            "PendingModifiedValues": {},
            "MultiAZ": false,
            "EngineVersion": "8.0.43",
            "AutoMinorVersionUpgrade": true,
            "ReadReplicaDBInstanceIdentifiers": [],
            "LicenseModel": "general-public-license",
            "StorageThroughput": 0,
            "OptionGroupMemberships": [
                {
                    "OptionGroupName": "default:mysql-8-0",
                    "Status": "in-sync"
                }
            ],
            "PubliclyAccessible": false,
            "StorageType": "gp2",
            "DbInstancePort": 0,
            "StorageEncrypted": false,
            "DbiResourceId": "db-EPLEIIV7QSSR2FIVYLVTAOGCZQ",
            "CACertificateIdentifier": "rds-ca-rsa2048-g1",
            "DomainMemberships": [],
            "CopyTagsToSnapshot": false,
            "MonitoringInterval": 0,
            "DBInstanceArn": "arn:aws:rds:us-east-1:212809501772:db:vandelay-rds01",
            "IAMDatabaseAuthenticationEnabled": false,
            "DatabaseInsightsMode": "standard",
            "PerformanceInsightsEnabled": false,
            "DeletionProtection": false,
            "AssociatedRoles": [],
            "TagList": [
                {
                    "Key": "Lab",
                    "Value": "ec2-rds-integration"
                },
                {
                    "Key": "Name",
                    "Value": "vandelay-rds01"
                }
            ],
            "CustomerOwnedIpEnabled": false,
            "NetworkType": "IPV4",
            "ActivityStreamStatus": "stopped",
            "BackupTarget": "region",
            "CertificateDetails": {
                "CAIdentifier": "rds-ca-rsa2048-g1",
                "ValidTill": "2027-01-22T02:16:39+00:00"
            },
            "DedicatedLogVolume": false,
            "IsStorageConfigUpgradeAvailable": false,
            "EngineLifecycleSupport": "open-source-rds-extended-support"
        }
    ]
}

zsh: suspended  aws rds describe-db-instances --db-instance-identifier vandelay-rds01 --regio
```

Critical checks "PubliclyAccessible": false Correct VPC Correct subnet group Correct security groups

Verify RDS security groups explicitly

```
aws rds describe-db-instances \
  --db-instance-identifier mydb01 \
  --region us-east-1 \
  --query "DBInstances[].VpcSecurityGroups[].VpcSecurityGroupId" \
  --output table
```

```rb
…/SEIR_Foundations/LAB1/python                                                                                                
❯ aws rds describe-db-instances \
  --db-instance-identifier vandelay-rds01 \
  --region us-east-1 \
  --query "DBInstances[].VpcSecurityGroups[].VpcSecurityGroupId" \
  --output table
--------------------------
|   DescribeDBInstances  |
+------------------------+
|  sg-0976ce7e018f394dd  |
+------------------------+
```

Verify RDS subnet placement

```
aws rds describe-db-subnet-groups \
  --region us-east-1 \
  --query "DBSubnetGroups[].{Name:DBSubnetGroupName,Vpc:VpcId,Subnets:Subnets[].SubnetIdentifier}" \
  --output table
```

```rb
…/SEIR_Foundations/LAB1/python                                                                                                
❯ aws rds describe-db-subnet-groups \
  --region us-east-1 \
  --query "DBSubnetGroups[].{Name:DBSubnetGroupName,Vpc:VpcId,Subnets:Subnets[].SubnetIdentifier}" \
  --output table
------------------------------------------------------------
|                  DescribeDBSubnetGroups                  |
+--------------------------------+-------------------------+
|              Name              |           Vpc           |
+--------------------------------+-------------------------+
|  default-vpc-01e6f8369cb334caa |  vpc-01e6f8369cb334caa  |
+--------------------------------+-------------------------+
||                         Subnets                        ||
|+--------------------------------------------------------+|
||  subnet-0050ec22c776b852b                              ||
||  subnet-069653934b34be8bd                              ||
||  subnet-0bcbec2d9dba23f2c                              ||
||  subnet-034983e605ab8ce12                              ||
|+--------------------------------------------------------+|
|                  DescribeDBSubnetGroups                  |
+------------------------------+---------------------------+
|             Name             |            Vpc            |
+------------------------------+---------------------------+
|  rds-ec2-db-subnet-group-1   |  vpc-027b923656f52e398    |
+------------------------------+---------------------------+
||                         Subnets                        ||
|+--------------------------------------------------------+|
||  subnet-060825bf7e464c7e7                              ||
||  subnet-05d75dbb0d429bd9c                              ||
||  subnet-02f61bd79c9aafc24                              ||
||  subnet-0265f2dd1817d8126                              ||
||  subnet-0fb4b2334ab7f679b                              ||
|+--------------------------------------------------------+|
|                  DescribeDBSubnetGroups                  |
+------------------------------+---------------------------+
|             Name             |            Vpc            |
+------------------------------+---------------------------+
|  rds-ec2-db-subnet-group-2   |  vpc-0040e9c82b201d080    |
+------------------------------+---------------------------+
||                         Subnets                        ||
|+--------------------------------------------------------+|
||  subnet-09a5cc006266a6b72                              ||
||  subnet-0e2d3a85688e30039                              ||
||  subnet-01c52ab8cc742d8d3                              ||
||  subnet-0aa4d18372a3b7c67                              ||
||  subnet-00aa003f11aa5fc7d                              ||
|+--------------------------------------------------------+|
|                  DescribeDBSubnetGroups                  |
+------------------------------+---------------------------+
|             Name             |            Vpc            |
+------------------------------+---------------------------+
|  rds-ec2-db-subnet-group-3   |  vpc-01e6f8369cb334caa    |
+------------------------------+---------------------------+
||                         Subnets                        ||
|+--------------------------------------------------------+|
||  subnet-06c8a525ff2ca1287                              ||
||  subnet-084034e485079be9f                              ||
||  subnet-05dc34a1a2e1eb723                              ||
||  subnet-01927dfab9792adaa                              ||
||  subnet-0d5f9fb24846eb9d1                              ||
|+--------------------------------------------------------+|
|                  DescribeDBSubnetGroups                  |
+------------------------------+---------------------------+
|             Name             |            Vpc            |
+------------------------------+---------------------------+
|  rds-ec2-db-subnet-group-4   |  vpc-022f0caf9b4dc5e7f    |
+------------------------------+---------------------------+
||                         Subnets                        ||
|+--------------------------------------------------------+|
||  subnet-0c806cf839a0d4376                              ||
||  subnet-05bd5a8378513920a                              ||
||  subnet-067c04a040e83f51b                              ||
||  subnet-09be08abf1f8ff60a                              ||
||  subnet-0022acaa8686138f2                              ||
|+--------------------------------------------------------+|
|                  DescribeDBSubnetGroups                  |
+-------------------------------+--------------------------+
|             Name              |           Vpc            |
+-------------------------------+--------------------------+
|  vandelay-rds-subnet-group01  |  vpc-0625ec8bdd4eedbd7   |
+-------------------------------+--------------------------+
||                         Subnets                        ||
|+--------------------------------------------------------+|
||  subnet-0139ce0f173314061                              ||
||  subnet-0b4610c2083825319                              ||
|+--------------------------------------------------------+|

zsh: suspended  aws rds describe-db-subnet-groups --region us-east-1 --query  --output table
```

What you’re verifying Private subnets only No IGW route Correct AZ spread

Verify Network Exposure (Fast Sanity Checks) Check if RDS is publicly reachable (quick flag)

```
aws rds describe-db-instances \
  --db-instance-identifier mydb01 \
  --region us-east-1 \
  --query "DBInstances[].PubliclyAccessible" \
  --output text
```

```rb
…/SEIR_Foundations/LAB1/python                                                                                                
❯ aws rds describe-db-instances \
  --db-instance-identifier vandelay-rds01 \
  --region us-east-1 \
  --query "DBInstances[].VpcSecurityGroups[].VpcSecurityGroupId" \
  --output table
--------------------------
|   DescribeDBInstances  |
+------------------------+
|  sg-0976ce7e018f394dd  |
+------------------------+
```

Verify Secrets Manager (Existence, Metadata, Access)

```
aws secretsmanager list-secrets \
  --region us-east-1 \
  --query "SecretList[].{Name:Name,ARN:ARN,Rotation:RotationEnabled}" \
  --output table
```

```rb
…/SEIR_Foundations/LAB1/python                                                                                                
❯ aws rds describe-db-subnet-groups \
  --region us-east-1 \
  --query "DBSubnetGroups[].{Name:DBSubnetGroupName,Vpc:VpcId,Subnets:Subnets[].SubnetIdentifier}" \
  --output table
------------------------------------------------------------
|                  DescribeDBSubnetGroups                  |
+--------------------------------+-------------------------+
|              Name              |           Vpc           |
+--------------------------------+-------------------------+
|  default-vpc-01e6f8369cb334caa |  vpc-01e6f8369cb334caa  |
+--------------------------------+-------------------------+
||                         Subnets                        ||
|+--------------------------------------------------------+|
||  subnet-0050ec22c776b852b                              ||
||  subnet-069653934b34be8bd                              ||
||  subnet-0bcbec2d9dba23f2c                              ||
||  subnet-034983e605ab8ce12                              ||
|+--------------------------------------------------------+|
|                  DescribeDBSubnetGroups                  |
+------------------------------+---------------------------+
|             Name             |            Vpc            |
+------------------------------+---------------------------+
|  rds-ec2-db-subnet-group-1   |  vpc-027b923656f52e398    |
+------------------------------+---------------------------+
||                         Subnets                        ||
|+--------------------------------------------------------+|
||  subnet-060825bf7e464c7e7                              ||
||  subnet-05d75dbb0d429bd9c                              ||
||  subnet-02f61bd79c9aafc24                              ||
||  subnet-0265f2dd1817d8126                              ||
||  subnet-0fb4b2334ab7f679b                              ||
|+--------------------------------------------------------+|
|                  DescribeDBSubnetGroups                  |
+------------------------------+---------------------------+
|             Name             |            Vpc            |
+------------------------------+---------------------------+
|  rds-ec2-db-subnet-group-2   |  vpc-0040e9c82b201d080    |
+------------------------------+---------------------------+
||                         Subnets                        ||
|+--------------------------------------------------------+|
||  subnet-09a5cc006266a6b72                              ||
||  subnet-0e2d3a85688e30039                              ||
||  subnet-01c52ab8cc742d8d3                              ||
||  subnet-0aa4d18372a3b7c67                              ||
||  subnet-00aa003f11aa5fc7d                              ||
|+--------------------------------------------------------+|
|                  DescribeDBSubnetGroups                  |
+------------------------------+---------------------------+
|             Name             |            Vpc            |
+------------------------------+---------------------------+
|  rds-ec2-db-subnet-group-3   |  vpc-01e6f8369cb334caa    |
+------------------------------+---------------------------+
||                         Subnets                        ||
|+--------------------------------------------------------+|
||  subnet-06c8a525ff2ca1287                              ||
||  subnet-084034e485079be9f                              ||
||  subnet-05dc34a1a2e1eb723                              ||
||  subnet-01927dfab9792adaa                              ||
||  subnet-0d5f9fb24846eb9d1                              ||
|+--------------------------------------------------------+|
|                  DescribeDBSubnetGroups                  |
+------------------------------+---------------------------+
|             Name             |            Vpc            |
+------------------------------+---------------------------+
|  rds-ec2-db-subnet-group-4   |  vpc-022f0caf9b4dc5e7f    |
+------------------------------+---------------------------+
||                         Subnets                        ||
|+--------------------------------------------------------+|
||  subnet-0c806cf839a0d4376                              ||
||  subnet-05bd5a8378513920a                              ||
||  subnet-067c04a040e83f51b                              ||
||  subnet-09be08abf1f8ff60a                              ||
||  subnet-0022acaa8686138f2                              ||
|+--------------------------------------------------------+|
|                  DescribeDBSubnetGroups                  |
+-------------------------------+--------------------------+
|             Name              |           Vpc            |
+-------------------------------+--------------------------+
|  vandelay-rds-subnet-group01  |  vpc-0625ec8bdd4eedbd7   |
+-------------------------------+--------------------------+
||                         Subnets                        ||
|+--------------------------------------------------------+|
||  subnet-0139ce0f173314061                              ||
||  subnet-0b4610c2083825319                              ||
|+--------------------------------------------------------+|

zsh: suspended  aws rds describe-db-subnet-groups --region us-east-1 --query  --output table
```

Check if RDS is publicly accessible (should be False)

```rb
…/SEIR_Foundations/LAB1/python                                                                                                
❯ aws rds describe-db-instances \
  --db-instance-identifier vandelay-rds01 \
  --region us-east-1 \
  --query "DBInstances[].PubliclyAccessible" \
  --output text
False
```

What you’re verifying Secret exists Rotation state is known Naming is intentional

Describe a specific secret (NO value exposure)

```
aws secretsmanager describe-secret \
  --secret-id deez-db-secret-nuts \
  --region us-east-1 \
  --output json
```

```rb
…/SEIR_Foundations/LAB1/python                                                                                               1s
❯ aws secretsmanager list-secrets \
  --region us-east-1 \
  --query "SecretList[].{Name:Name,ARN:ARN,Rotation:RotationEnabled}" \
  --output table
------------------------------------------------------------------------------------------------------------
|                                                ListSecrets                                               |
+----------------------------------------------------------------------------+----------------+------------+
|                                     ARN                                    |     Name       | Rotation   |
+----------------------------------------------------------------------------+----------------+------------+
|  arn:aws:secretsmanager:us-east-1:212809501772:secret:lab/rds/mysql-x7lYie |  lab/rds/mysql |  True      |
+----------------------------------------------------------------------------+----------------+------------+
```

Verify which IAM principals can access the secret

```
aws secretsmanager get-resource-policy \
  --secret-id my-db-secret \
  --region us-east-1 \
  --output json
```

```rb
…/SEIR_Foundations/LAB1/python                                                                                                
❯ aws secretsmanager get-resource-policy \
  --secret-id lab/rds/mysql \
  --region us-east-1 \
  --output json
{
    "ARN": "arn:aws:secretsmanager:us-east-1:212809501772:secret:lab/rds/mysql-x7lYie",
    "Name": "lab/rds/mysql"
}
```

What you’re verifying Only expected roles are listed No wildcard principals No cross-account access unless justified

Verify IAM Role Attached to an EC2 Instance Step 1: Identify the EC2 instance

```
aws ec2 describe-instances \
  --filters Name=tag:Name,Values=MyInstance \
  --region us-east-1 \
  --query "Reservations[].Instances[].InstanceId" \
  --output text
```

```rb
…/SEIR_Foundations/LAB1/python                                                                                                
❯ aws ec2 describe-instances \
  --filters Name=tag:Name,Values=vandelay-ec201 \
  --region us-east-1 \
  --query "Reservations[].Instances[].InstanceId" \
  --output text
i-01c7d93a21a56f052
```

Step 2: Check the IAM role attached to the instance

```
aws ec2 describe-instances \
  --instance-ids i-0123456789abcdef0 \
  --region us-east-1 \
  --query "Reservations[].Instances[].IamInstanceProfile.Arn" \
  --output text
```

```rb
…/SEIR_Foundations/LAB1/python                                                                                                
❯ aws ec2 describe-instances \
  --instance-ids i-01c7d93a21a56f052 \
  --region us-east-1 \
  --query "Reservations[].Instances[].IamInstanceProfile.Arn" \
  --output text
arn:aws:iam::212809501772:instance-profile/vandelay-instance-profile01
```

Step 3: Resolve instance profile → role name

```
aws iam get-instance-profile \
  --instance-profile-name MyEC2Role \
  --query "InstanceProfile.Roles[].RoleName" \
  --output text
```

```rb
❯ aws iam get-instance-profile \
  --instance-profile-name vandelay-instance-profile01 \
  --query "InstanceProfile.Roles[].RoleName" \
  --output text
vandelay-ec2-role01
```

Verify IAM Role Permissions (Critical) List policies attached to the role

```
aws iam list-attached-role-policies \
  --role-name MyEC2Role \
  --output table
```

```rb
…/SEIR_Foundations/LAB1/python                                                                                                
❯ aws iam list-attached-role-policies \
  --role-name vandelay-ec2-role01 \
  --output table
--------------------------------------------------------------------------------------------
|                                 ListAttachedRolePolicies                                 |
+------------------------------------------------------------------------------------------+
||                                    AttachedPolicies                                    ||
|+-------------------------------------------------------+--------------------------------+|
||                       PolicyArn                       |          PolicyName            ||
|+-------------------------------------------------------+--------------------------------+|
||  arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy  |  CloudWatchAgentServerPolicy   ||
||  arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore |  AmazonSSMManagedInstanceCore  ||
|+-------------------------------------------------------+--------------------------------+|
```

List inline policies (often forgotten)

```
aws iam list-role-policies \
  --role-name MyEC2Role \
  --output table
```

```rb
…/SEIR_Foundations/LAB1/python                                                                                                
❯ aws ec2 describe-instances \
  --instance-ids i-01c7d93a21a56f052 \
  --region us-east-1 \
  --query "Reservations[].Instances[].IamInstanceProfile.Arn" \
  --output text
arn:aws:iam::212809501772:instance-profile/vandelay-instance-profile01
```

Inspect a specific managed policy

```
aws iam get-policy-version \
  --policy-arn arn:aws:iam::aws:policy/SecretsManagerReadWrite \
  --version-id v1 \
  --output json
```

```rb
…/SEIR_Foundations/LAB1/python                                                                                               1s
❯ aws iam get-policy-version \
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
    }
}

zsh: suspended  aws iam get-policy-version --policy-arn  --version-id v1 --output json
```

Verify EC2 → RDS access path (security-group–to–security-group)

```
aws ec2 describe-security-groups \
  --group-ids sg-ec2-access \
  --region us-east-1 \
  --query "SecurityGroups[].IpPermissions"
```

```rb
…/SEIR_Foundations/LAB1/python                                                                                                
❯ aws ec2 describe-security-groups \
  --group-ids sg-0976ce7e018f394dd \
  --region us-east-1 \
  --query "SecurityGroups[].IpPermissions" \
  --output json
[
    [
        {
            "IpProtocol": "tcp",
            "FromPort": 3306,
            "ToPort": 3306,
            "UserIdGroupPairs": [
                {
                    "Description": "Allow MySQL from EC2 app server only",
                    "UserId": "212809501772",
                    "GroupId": "sg-0f891b9dea92b2798"
                },
                {
                    "Description": "Allow Lambda rotation function to connect to RDS",
                    "UserId": "212809501772",
                    "GroupId": "sg-0bd9dc2d8b10589fe"
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

```
aws sts get-caller-identity
```

Expected:Arn: arn:aws:sts::123456789012:assumed-role/MyEC2Role/i-0123456789abcdef0

```rb
❯ aws sts get-caller-identity
{
    "UserId": "AIDATDDDPJRGILF32Z4NV",
    "Account": "212809501772",
    "Arn": "arn:aws:iam::212809501772:user/AWSCLI"
}
```

Then test access:

```
aws secretsmanager describe-secret \
  --secret-id my-db-secret \
  --region us-east-1
```

```rb
❯ aws secretsmanager describe-secret \
  --secret-id lab/rds/mysql \
  --region us-east-1
{
    "ARN": "arn:aws:secretsmanager:us-east-1:212809501772:secret:lab/rds/mysql-x7lYie",
    "Name": "lab/rds/mysql",
    "RotationEnabled": true,
    "RotationLambdaARN": "arn:aws:lambda:us-east-1:212809501772:function:vandelay-mysql-rotation-lambda",
    "RotationRules": {
        "AutomaticallyAfterDays": 30
    },
    "LastRotatedDate": "2026-01-21T23:42:22.340000-07:00",
    "LastChangedDate": "2026-01-21T23:42:22.294000-07:00",
    "LastAccessedDate": "2026-01-21T17:00:00-07:00",
    "NextRotationDate": "2026-02-21T16:59:59-07:00",
    "Tags": [
        {
            "Key": "Lab",
            "Value": "ec2-rds-integration"
        },
        {
            "Key": "Name",
            "Value": "vandelay-db-secret01"
        }
    ],
    "VersionIdsToStages": {
        "terraform-20260122031246442400000001": [
            "AWSPREVIOUS"
        ],
        "terraform-20260122045848689200000001": [
            "AWSCURRENT",
            "AWSPENDING"
        ]
    },
    "CreatedDate": "2026-01-21T15:11:13.491000-07:00"
}
```

```rb
…/SEIR_Foundations/LAB1/python                                                                                                
❯ aws secretsmanager get-secret-value \
  --secret-id lab/rds/mysql \
  --region us-east-1
{
    "ARN": "arn:aws:secretsmanager:us-east-1:212809501772:secret:lab/rds/mysql-x7lYie",
    "Name": "lab/rds/mysql",
    "VersionId": "terraform-20260122045848689200000001",
    "SecretString": "{\"dbname\": \"labmysql\", \"engine\": \"mysql\", \"host\": \"vandelay-rds01.cmrys4aosktq.us-east-1.rds.amazonaws.com\", \"masterarn\": \"arn:aws:secretsmanager:us-east-1:212809501772:secret:lab/rds/mysql-x7lYie\", \"password\": \"buy7Q8n$;|AYcSdq9Fd*><&wQ+O`3<1A\", \"port\": 3306, \"username\": \"admin\"}",
    "VersionStages": [
        "AWSCURRENT",
        "AWSPENDING"
    ],
    "CreatedDate": "2026-01-21T21:58:51.877000-07:00"
}
```

Quick all-in-one verification Script run to verify key security settings

```rb
…/SEIR_Foundations/LAB1/python                                                                                                
❯ echo "=== EC2 Security Group ===" && \
aws ec2 describe-security-groups --group-ids sg-0f891b9dea92b2798 --region us-east-1 --query "SecurityGroups[].{Name:GroupName,Ingress:IpPermissions,Egress:IpPermissionsEgress}" --output json && \
echo "" && \
echo "=== RDS Security Group ===" && \
aws ec2 describe-security-groups --group-ids sg-0976ce7e018f394dd --region us-east-1 --query "SecurityGroups[].{Name:GroupName,Ingress:IpPermissions}" --output json && \
echo "" && \
echo "=== RDS Public Access Check ===" && \
aws rds describe-db-instances --db-instance-identifier vandelay-rds01 --region us-east-1 --query "DBInstances[].{Public:PubliclyAccessible,SecurityGroups:VpcSecurityGroups[].VpcSecurityGroupId}" --output table && \
echo "" && \
echo "=== Secret Rotation Status ===" && \
aws secretsmanager describe-secret --secret-id lab/rds/mysql --region us-east-1 --query "{Name:Name,RotationEnabled:RotationEnabled}" --output table && \
echo "" && \
echo "=== EC2 IAM Role ===" && \
aws ec2 describe-instances --instance-ids i-01c7d93a21a56f052 --region us-east-1 --query "Reservations[].Instances[].IamInstanceProfile.Arn" --output text
=== EC2 Security Group ===
[
    {
        "Name": "vandelay-ec2-sg01",
        "Ingress": [
            {
                "IpProtocol": "tcp",
                "FromPort": 80,
                "ToPort": 80,
                "UserIdGroupPairs": [],
                "IpRanges": [
                    {
                        "Description": "Allow HTTP from anywhere",
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
                        "Description": "Allow SSH from admin IP",
                        "CidrIp": "71.196.152.12/30"
                    }
                ],
                "Ipv6Ranges": [],
                "PrefixListIds": []
            }
        ],
        "Egress": [
            {
                "IpProtocol": "-1",
                "UserIdGroupPairs": [],
                "IpRanges": [
                    {
                        "Description": "Allow all outbound traffic",
                        "CidrIp": "0.0.0.0/0"
                    }
                ],
                "Ipv6Ranges": [],
                "PrefixListIds": []
            }
        ]
    }
]

zsh: suspended  aws ec2 describe-security-groups --group-ids sg-0f891b9dea92b2798 --region
```

---

**████████████████████████████████████████

______________
# SEIR_Foundations/LAB1/1a_final_check.txt

To check Lab 1a, run the following:

1) From your workstation (metadata checks; role attach + secret exists)

```rb
chmod +x run_all_gates.sh

REGION=us-east-1 \
INSTANCE_ID=i-01c7d93a21a56f052 \
SECRET_ID=lab/rds/mysql \
DB_ID=vandelay-rds01 \
./run_all_gates.sh
```
##### my results:

```python
MacBook-Pro: nikosfarias$ chmod +x run_all_gates.sh
MacBook-Pro: nikosf                    arias$
MacBook-Pro: nikosfarias$ REGION=us-east-1 \
> INSTANCE_ID=i-01c7d93a21a56f052 \
> SECRET_ID=lab/rds/mysql \
> DB_ID=vandelay-rds01 \
> ./run_all_gates.sh
=== Running Gate 1/2: secrets_and_role ===

=== SEIR Gate: Secrets + EC2 Role Verification ===
Timestamp (UTC): 2026-01-22T07:20:59Z
Region:          us-east-1
Instance ID:     i-01c7d93a21a56f052
Secret ID:       lab/rds/mysql
Resolved Role:   vandelay-ec2-role01
Caller ARN:      arn:aws:iam::212809501772:user/AWSCLI
-----------------------------------------------
PASS: aws sts get-caller-identity succeeded (credentials OK).
PASS: secret exists and is describable (lab/rds/mysql).
INFO: rotation requirement disabled (REQUIRE_ROTATION=false).
PASS: no resource policy found (OK) or not applicable (lab/rds/mysql).
PASS: instance has IAM instance profile attached (i-01c7d93a21a56f052).
PASS: resolved instance profile -> role (vandelay-instance-profile01 -> vandelay-ec2-role01).
INFO: EXPECTED_ROLE_NAME not set; using resolved role (vandelay-ec2-role01).
INFO: on-instance checks skipped (not running as expected role on EC2).

Warnings:
  - WARN: current caller ARN is not assumed-role/vandelay-ec2-role01 (you may be running off-instance).

RESULT: PASS
===============================================

sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
Wrote: gate_result.json
=== Running Gate 2/2: network_db ===

=== SEIR Gate: Network + RDS Verification ===
Timestamp (UTC): 2026-01-22T07:21:11Z
Region:          us-east-1
EC2 Instance:    i-01c7d93a21a56f052
RDS Instance:    vandelay-rds01
Engine:          mysql
DB Port:         3306
Caller ARN:      arn:aws:iam::212809501772:user/AWSCLI
-------------------------------------------
PASS: aws sts get-caller-identity succeeded (credentials OK).
PASS: RDS instance exists (vandelay-rds01).
PASS: RDS is not publicly accessible (PubliclyAccessible=False).
PASS: discovered DB port = 3306 (engine=mysql).
PASS: EC2 security groups resolved (i-01c7d93a21a56f052): sg-0f891b9dea92b2798
PASS: RDS security groups resolved (vandelay-rds01): sg-0976ce7e018f394dd
PASS: RDS SG allows DB port 3306 from EC2 SG (SG-to-SG ingress present).
INFO: private subnet check disabled (CHECK_PRIVATE_SUBNETS=false).

RESULT: PASS
===========================================

sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
Wrote: gate_result.json
```

From inside the EC2 instance (prove the instance role can actually read the secret)

```rb
REQUIRE_ROTATION=true \
CHECK_PRIVATE_SUBNETS=true \
REGION=us-east-1 \
INSTANCE_ID=i-01c7d93a21a56f052 \
SECRET_ID=lab/rds/mysql \
DB_ID=vandelay-rds01 \
./run_all_gates.sh
```

##### my results:

```python
Format: "png

export do=--dry-run=client" not recognized. Use one of: bmp canon cgimage cmap cmapx cmapx_np dot dot_json eps exr fig gd gd2 gif gv icns ico imap imap_np ismap jp2 jpe jpeg jpg json json0 kitty kittyz pct pdf pic pict plain plain-ext png pov ps ps2 psd sgi svg svg_inline svgz tga tif tiff tk vrml vt vt-24bit vt-4up vt-6up vt-8up wbmp webp xdot xdot1.2 xdot1.4 xdot_json

…/SEIR_Foundations/LAB1/python                                     
❯ REQUIRE_ROTATION=true \
CHECK_PRIVATE_SUBNETS=true \
REGION=us-east-1 \
INSTANCE_ID=i-01c7d93a21a56f052 \
SECRET_ID=lab/rds/mysql \
DB_ID=vandelay-rds01 \
./run_all_gates.sh
=== Running Gate 1/2: secrets_and_role ===

=== SEIR Gate: Secrets + EC2 Role Verification ===
Timestamp (UTC): 2026-01-22T07:31:52Z
Region:          us-east-1
Instance ID:     i-01c7d93a21a56f052
Secret ID:       lab/rds/mysql
Resolved Role:   vandelay-ec2-role01
Caller ARN:      arn:aws:iam::212809501772:user/AWSCLI
-----------------------------------------------
PASS: aws sts get-caller-identity succeeded (credentials OK).
PASS: secret exists and is describable (lab/rds/mysql).
PASS: secret rotation enabled (lab/rds/mysql).
PASS: no resource policy found (OK) or not applicable (lab/rds/mysql).
PASS: instance has IAM instance profile attached (i-01c7d93a21a56f052).
PASS: resolved instance profile -> role (vandelay-instance-profile01 -> vandelay-ec2-role01).
INFO: EXPECTED_ROLE_NAME not set; using resolved role (vandelay-ec2-role01).
INFO: on-instance checks skipped (not running as expected role on EC2).

Warnings:
  - WARN: current caller ARN is not assumed-role/vandelay-ec2-role01 (you may be running off-instance).

RESULT: PASS
===============================================

sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
Wrote: gate_result.json
=== Running Gate 2/2: network_db ===

=== SEIR Gate: Network + RDS Verification ===
Timestamp (UTC): 2026-01-22T07:32:11Z
Region:          us-east-1
EC2 Instance:    i-01c7d93a21a56f052
RDS Instance:    vandelay-rds01
Engine:          mysql
DB Port:         3306
Caller ARN:      arn:aws:iam::212809501772:user/AWSCLI
-------------------------------------------
PASS: aws sts get-caller-identity succeeded (credentials OK).
PASS: RDS instance exists (vandelay-rds01).
PASS: RDS is not publicly accessible (PubliclyAccessible=False).
PASS: discovered DB port = 3306 (engine=mysql).
PASS: EC2 security groups resolved (i-01c7d93a21a56f052): sg-0f891b9dea92b2798
PASS: RDS security groups resolved (vandelay-rds01): sg-0976ce7e018f394dd
PASS: RDS SG allows DB port 3306 from EC2 SG (SG-to-SG ingress present).
INFO: DB subnet group (vandelay-rds-subnet-group01) subnets: subnet-0139ce0f173314061        subnet-0b4610c2083825319
PASS: subnet subnet-0139ce0f173314061 shows no IGW route (private check OK).
PASS: subnet subnet-0b4610c2083825319 shows no IGW route (private check OK).

RESULT: PASS
===========================================

sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
Wrote: gate_result.json
```

```python
…/SEIR_Foundations/LAB1/python                                                                                                                    
❯ chmod +x gate_secrets_and_role.sh

REGION=us-east-1 \
INSTANCE_ID=i-01c7d93a21a56f052 \
SECRET_ID=lab/rds/mysql \
./gate_secrets_and_role.sh

=== SEIR Gate: Secrets + EC2 Role Verification ===
Timestamp (UTC): 2026-01-22T07:37:42Z
Region:          us-east-1
Instance ID:     i-01c7d93a21a56f052
Secret ID:       lab/rds/mysql
Resolved Role:   vandelay-ec2-role01
Caller ARN:      arn:aws:iam::212809501772:user/AWSCLI
-----------------------------------------------
PASS: aws sts get-caller-identity succeeded (credentials OK).
PASS: secret exists and is describable (lab/rds/mysql).
INFO: rotation requirement disabled (REQUIRE_ROTATION=false).
PASS: no resource policy found (OK) or not applicable (lab/rds/mysql).
PASS: instance has IAM instance profile attached (i-01c7d93a21a56f052).
PASS: resolved instance profile -> role (vandelay-instance-profile01 -> vandelay-ec2-role01).
INFO: EXPECTED_ROLE_NAME not set; using resolved role (vandelay-ec2-role01).
INFO: on-instance checks skipped (not running as expected role on EC2).

Warnings:
  - WARN: current caller ARN is not assumed-role/vandelay-ec2-role01 (you may be running off-instance).

RESULT: PASS
===============================================

sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
Wrote: gate_result.json
```

Strict mode: require rotation enabled

```python
REQUIRE_ROTATION=true \
REGION=us-east-1 \
INSTANCE_ID=i-01c7d93a21a56f052 \
SECRET_ID=lab/rds/mysql \
./gate_secrets_and_role.sh
```

```python
…/SEIR_Foundations/LAB1/python                                                                                                                    
❯ REQUIRE_ROTATION=true \
REGION=us-east-1 \
INSTANCE_ID=i-01c7d93a21a56f052 \
SECRET_ID=lab/rds/mysql \
./gate_secrets_and_role.sh

=== SEIR Gate: Secrets + EC2 Role Verification ===
Timestamp (UTC): 2026-01-22T07:40:17Z
Region:          us-east-1
Instance ID:     i-01c7d93a21a56f052
Secret ID:       lab/rds/mysql
Resolved Role:   vandelay-ec2-role01
Caller ARN:      arn:aws:iam::212809501772:user/AWSCLI
-----------------------------------------------
PASS: aws sts get-caller-identity succeeded (credentials OK).
PASS: secret exists and is describable (lab/rds/mysql).
PASS: secret rotation enabled (lab/rds/mysql).
PASS: no resource policy found (OK) or not applicable (lab/rds/mysql).
PASS: instance has IAM instance profile attached (i-01c7d93a21a56f052).
PASS: resolved instance profile -> role (vandelay-instance-profile01 -> vandelay-ec2-role01).
INFO: EXPECTED_ROLE_NAME not set; using resolved role (vandelay-ec2-role01).
INFO: on-instance checks skipped (not running as expected role on EC2).

Warnings:
  - WARN: current caller ARN is not assumed-role/vandelay-ec2-role01 (you may be running off-instance).

RESULT: PASS
===============================================

sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
Wrote: gate_result.json
```

```rb
…/SEIR_Foundations/LAB1/python                                                                                                                    
❯ CHECK_SECRET_VALUE_READ=true \
REGION=us-east-1 \
INSTANCE_ID=i-01c7d93a21a56f052 \
SECRET_ID=lab/rds/mysql \
./gate_secrets_and_role.sh

=== SEIR Gate: Secrets + EC2 Role Verification ===
Timestamp (UTC): 2026-01-22T07:47:13Z
Region:          us-east-1
Instance ID:     i-01c7d93a21a56f052
Secret ID:       lab/rds/mysql
Resolved Role:   vandelay-ec2-role01
Caller ARN:      arn:aws:iam::212809501772:user/AWSCLI
-----------------------------------------------
PASS: aws sts get-caller-identity succeeded (credentials OK).
PASS: secret exists and is describable (lab/rds/mysql).
INFO: rotation requirement disabled (REQUIRE_ROTATION=false).
PASS: no resource policy found (OK) or not applicable (lab/rds/mysql).
PASS: instance has IAM instance profile attached (i-01c7d93a21a56f052).
PASS: resolved instance profile -> role (vandelay-instance-profile01 -> vandelay-ec2-role01).
INFO: EXPECTED_ROLE_NAME not set; using resolved role (vandelay-ec2-role01).
INFO: on-instance checks skipped (not running as expected role on EC2).

Warnings:
  - WARN: current caller ARN is not assumed-role/vandelay-ec2-role01 (you may be running off-instance).

RESULT: PASS
===============================================

sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
Wrote: gate_result.json
```


2) Basic: verify RDS isn’t public + SG-to-SG rule exists

```rb
chmod +x gate_network_db.sh

REGION=us-east-1 \
INSTANCE_ID=i-01c7d93a21a56f052 \
DB_ID=vandelay-rds01 \
./gate_network_db.sh
```

##### my results:

```rb
…/SEIR_Foundations/LAB1/python                                                                                                                    
❯ chmod +x gate_network_db.sh

REGION=us-east-1 \
INSTANCE_ID=i-01c7d93a21a56f052 \
DB_ID=vandelay-rds01 \
./gate_network_db.sh

=== SEIR Gate: Network + RDS Verification ===
Timestamp (UTC): 2026-01-22T07:49:17Z
Region:          us-east-1
EC2 Instance:    i-01c7d93a21a56f052
RDS Instance:    vandelay-rds01
Engine:          mysql
DB Port:         3306
Caller ARN:      arn:aws:iam::212809501772:user/AWSCLI
-------------------------------------------
PASS: aws sts get-caller-identity succeeded (credentials OK).
PASS: RDS instance exists (vandelay-rds01).
PASS: RDS is not publicly accessible (PubliclyAccessible=False).
PASS: discovered DB port = 3306 (engine=mysql).
PASS: EC2 security groups resolved (i-01c7d93a21a56f052): sg-0f891b9dea92b2798
PASS: RDS security groups resolved (vandelay-rds01): sg-0976ce7e018f394dd
PASS: RDS SG allows DB port 3306 from EC2 SG (SG-to-SG ingress present).
INFO: private subnet check disabled (CHECK_PRIVATE_SUBNETS=false).

RESULT: PASS
===========================================

sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
Wrote: gate_result.json
```


Strict: also verify DB subnets are private (no IGW route)

```rb
CHECK_PRIVATE_SUBNETS=true \
REGION=us-east-1 \
INSTANCE_ID=i-01c7d93a21a56f052 \
DB_ID=vandelay-rds01 \
./gate_network_db.sh
```

##### my results:

```rb
…/SEIR_Foundations/LAB1/python                                                                                                                    
❯ CHECK_PRIVATE_SUBNETS=true \
REGION=us-east-1 \
INSTANCE_ID=i-01c7d93a21a56f052 \
DB_ID=vandelay-rds01 \
./gate_network_db.sh

=== SEIR Gate: Network + RDS Verification ===
Timestamp (UTC): 2026-01-22T07:54:57Z
Region:          us-east-1
EC2 Instance:    i-01c7d93a21a56f052
RDS Instance:    vandelay-rds01
Engine:          mysql
DB Port:         3306
Caller ARN:      arn:aws:iam::212809501772:user/AWSCLI
-------------------------------------------
PASS: aws sts get-caller-identity succeeded (credentials OK).
PASS: RDS instance exists (vandelay-rds01).
PASS: RDS is not publicly accessible (PubliclyAccessible=False).
PASS: discovered DB port = 3306 (engine=mysql).
PASS: EC2 security groups resolved (i-01c7d93a21a56f052): sg-0f891b9dea92b2798
PASS: RDS security groups resolved (vandelay-rds01): sg-0976ce7e018f394dd
PASS: RDS SG allows DB port 3306 from EC2 SG (SG-to-SG ingress present).
INFO: DB subnet group (vandelay-rds-subnet-group01) subnets: subnet-0139ce0f173314061   subnet-0b4610c2083825319
PASS: subnet subnet-0139ce0f173314061 shows no IGW route (private check OK).
PASS: subnet subnet-0b4610c2083825319 shows no IGW route (private check OK).

RESULT: PASS
===========================================

sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
Wrote: gate_result.json
```

If endpoint port discovery fails, override it

DB_PORT=5432 REGION=us-east-1 INSTANCE_ID=i-0123456789abcdef0 DB_ID=mydb01 ./gate_network_db.sh
##### my results:

Or.... all in 1

```rb
chmod +x run_all_gates.sh
REGION=us-east-1 \
INSTANCE_ID=i-0123456789abcdef0 \
SECRET_ID=my-db-secret \
DB_ID=mydb01 \
./run_all_gates.sh

Strict options (rotation + private subnet check)

REQUIRE_ROTATION=true \
CHECK_PRIVATE_SUBNETS=true \
REGION=us-east-1 INSTANCE_ID=i-... SECRET_ID=... DB_ID=... \
./run_all_gates.sh

If running ON the EC2 and you want to assert it can read the secret value

CHECK_SECRET_VALUE_READ=true \
REGION=us-east-1 INSTANCE_ID=i-... SECRET_ID=... DB_ID=... \
./run_all_gates.sh


Expected Output:
Files created:
        gate_secrets_and_role.json
        gate_network_db.json
        gate_result.json ✅ combined summary

Exit code:
        0 = ready to merge / ready to grade
        2 = fail (exact reasons provided)
        1 = error (missing env/tools/scripts)
```

##### my results:

```rb
…/SEIR_Foundations/LAB1/python                                                                                                 
❯ REQUIRE_ROTATION=true \
CHECK_PRIVATE_SUBNETS=true \
CHECK_SECRET_VALUE_READ=true \
REGION=us-east-1 \
INSTANCE_ID=i-01c7d93a21a56f052 \
SECRET_ID=lab/rds/mysql \
DB_ID=vandelay-rds01 \
./run_all_gates.sh
```

---

## Expected Success Output
```rb
Files created:
    gate_secrets_and_role.json
    gate_network_db.json
    gate_result.json ✅ combined summary
Exit code: 0
=== Running Gate 1/2: secrets_and_role ===

=== SEIR Gate: Secrets + EC2 Role Verification ===
Timestamp (UTC): 2026-01-22T08:01:27Z
Region:          us-east-1
Instance ID:     i-01c7d93a21a56f052
Secret ID:       lab/rds/mysql
Resolved Role:   vandelay-ec2-role01
Caller ARN:      arn:aws:iam::212809501772:user/AWSCLI
-----------------------------------------------
PASS: aws sts get-caller-identity succeeded (credentials OK).
PASS: secret exists and is describable (lab/rds/mysql).
PASS: secret rotation enabled (lab/rds/mysql).
PASS: no resource policy found (OK) or not applicable (lab/rds/mysql).
PASS: instance has IAM instance profile attached (i-01c7d93a21a56f052).
PASS: resolved instance profile -> role (vandelay-instance-profile01 -> vandelay-ec2-role01).
INFO: EXPECTED_ROLE_NAME not set; using resolved role (vandelay-ec2-role01).
INFO: on-instance checks skipped (not running as expected role on EC2).

Warnings:
  - WARN: current caller ARN is not assumed-role/vandelay-ec2-role01 (you may be running off-instance).

RESULT: PASS                                                                                                                     ===============================================

sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
Wrote: gate_result.json
=== Running Gate 2/2: network_db ===

=== SEIR Gate: Network + RDS Verification ===
Timestamp (UTC): 2026-01-22T08:01:43Z
Region:          us-east-1
EC2 Instance:    i-01c7d93a21a56f052
RDS Instance:    vandelay-rds01
Engine:          mysql
DB Port:         3306
Caller ARN:      arn:aws:iam::212809501772:user/AWSCLI
-------------------------------------------
PASS: aws sts get-caller-identity succeeded (credentials OK).
PASS: RDS instance exists (vandelay-rds01).
PASS: RDS is not publicly accessible (PubliclyAccessible=False).
PASS: discovered DB port = 3306 (engine=mysql).
PASS: EC2 security groups resolved (i-01c7d93a21a56f052): sg-0f891b9dea92b2798
PASS: RDS security groups resolved (vandelay-rds01): sg-0976ce7e018f394dd
PASS: RDS SG allows DB port 3306 from EC2 SG (SG-to-SG ingress present).
INFO: DB subnet group (vandelay-rds-subnet-group01) subnets: subnet-0139ce0f173314061   subnet-0b4610c2083825319
PASS: subnet subnet-0139ce0f173314061 shows no IGW route (private check OK).
PASS: subnet subnet-0b4610c2083825319 shows no IGW route (private check OK).

RESULT: PASS
===========================================

sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
sed: 2: ":a;N;$!ba;s/\n/\\n/g
": unused label 'a;N;$!ba;s/\n/\\n/g'
Wrote: gate_result.json
zsh: command not found: ---
zsh: command not found: ##
zsh: command not found: Files
zsh: command not found: gate_secrets_and_role.json
zsh: command not found: gate_network_db.json
zsh: command not found: gate_result.json
zsh: command not found: Exit
```


# END Final state

ran terraform state:

```rb
MacBook-Pro:lab1 nikosfarias$ terraform state list
data.aws_caller_identity.current
data.aws_serverlessapplicationrepository_application.secrets_manager_rotation
aws_cloudwatch_log_group.vandelay_log_group01
aws_cloudwatch_metric_alarm.vandelay_db_alarm01
aws_db_instance.vandelay_rds01
aws_db_subnet_group.vandelay_rds_subnet_group01
aws_eip.vandelay_nat_eip01
aws_iam_instance_profile.vandelay_instance_profile01
aws_iam_role.rotation_lambda_role
aws_iam_role.vandelay_ec2_role01
aws_iam_role_policy_attachment.rotation_lambda_basic
aws_iam_role_policy_attachment.rotation_lambda_vpc
aws_iam_role_policy_attachment.vandelay_ec2_cw_attach
aws_iam_role_policy_attachment.vandelay_ec2_ssm_attach
aws_instance.vandelay_ec201
aws_internet_gateway.vandelay_igw01
aws_lambda_permission.secrets_manager_rotation
aws_nat_gateway.vandelay_nat01
aws_route.vandelay_private_default_route
aws_route.vandelay_public_default_route
aws_route_table.vandelay_private_rt01
aws_route_table.vandelay_public_rt01
aws_route_table_association.vandelay_private_rta[0]
aws_route_table_association.vandelay_private_rta[1]
aws_route_table_association.vandelay_public_rta[0]
aws_route_table_association.vandelay_public_rta[1]
aws_security_group.rotation_lambda_sg
aws_security_group.vandelay_ec2_sg01
aws_security_group.vandelay_rds_sg01
aws_security_group.vpce_sg
aws_security_group_rule.rds_from_lambda
aws_serverlessapplicationrepository_cloudformation_stack.rotation_lambda
aws_sns_topic.vandelay_sns_topic01
aws_sns_topic_subscription.vandelay_sns_sub01
aws_ssm_parameter.vandelay_db_endpoint_param
aws_ssm_parameter.vandelay_db_name_param
aws_ssm_parameter.vandelay_db_port_param
aws_subnet.vandelay_private_subnets[0]
aws_subnet.vandelay_private_subnets[1]
aws_subnet.vandelay_public_subnets[0]
aws_subnet.vandelay_public_subnets[1]
aws_vpc.vandelay_vpc01
aws_vpc_endpoint.secretsmanager
```

### State List after successfully removed creating and deleting secret from the stack 

```rb
MacBook-Pro:lab1 nikosfarias$ terraform state list
data.aws_caller_identity.current
data.aws_secretsmanager_secret.vandelay_db_secret01
data.aws_secretsmanager_secret_version.vandelay_db_secret_version01
data.aws_serverlessapplicationrepository_application.secrets_manager_rotation
aws_cloudwatch_log_group.vandelay_log_group01
aws_cloudwatch_metric_alarm.vandelay_db_alarm01
aws_db_instance.vandelay_rds01
aws_db_subnet_group.vandelay_rds_subnet_group01
aws_eip.vandelay_nat_eip01
aws_iam_instance_profile.vandelay_instance_profile01
aws_iam_role.rotation_lambda_role
aws_iam_role.vandelay_ec2_role01
aws_iam_role_policy.rotation_lambda_policy
aws_iam_role_policy.vandelay_ec2_read_secret
aws_iam_role_policy_attachment.rotation_lambda_basic
aws_iam_role_policy_attachment.rotation_lambda_vpc
aws_iam_role_policy_attachment.vandelay_ec2_cw_attach
aws_iam_role_policy_attachment.vandelay_ec2_ssm_attach
aws_instance.vandelay_ec201
aws_internet_gateway.vandelay_igw01
aws_lambda_permission.secrets_manager_rotation
aws_nat_gateway.vandelay_nat01
aws_route.vandelay_private_default_route
aws_route.vandelay_public_default_route
aws_route_table.vandelay_private_rt01
aws_route_table.vandelay_public_rt01
aws_route_table_association.vandelay_private_rta[0]
aws_route_table_association.vandelay_private_rta[1]
aws_route_table_association.vandelay_public_rta[0]
aws_route_table_association.vandelay_public_rta[1]
aws_secretsmanager_secret_rotation.vandelay_db_rotation
aws_security_group.rotation_lambda_sg
aws_security_group.vandelay_ec2_sg01
aws_security_group.vandelay_rds_sg01
aws_security_group.vpce_sg
aws_security_group_rule.rds_from_lambda
aws_serverlessapplicationrepository_cloudformation_stack.rotation_lambda
aws_sns_topic.vandelay_sns_topic01
aws_sns_topic_subscription.vandelay_sns_sub01
aws_ssm_parameter.vandelay_db_endpoint_param
aws_ssm_parameter.vandelay_db_name_param
aws_ssm_parameter.vandelay_db_port_param
aws_subnet.vandelay_private_subnets[0]
aws_subnet.vandelay_private_subnets[1]
aws_subnet.vandelay_public_subnets[0]
aws_subnet.vandelay_public_subnets[1]
aws_vpc.vandelay_vpc01
aws_vpc_endpoint.secretsmanager
```

