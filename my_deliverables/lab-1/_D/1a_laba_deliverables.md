# Student Deliverables:

1. Screenshot of: RDS SG inbound rule using source = sg-ec2-lab EC2 role attached /list output showing at least 3 notes:
- [x] ![[Pasted image 20260111021120.png]]
- [x] sg-0264ae211b9f1f161 - ec2-rds-2![[Screenshot 2026-01-11 at 2.13.09 AM 1.png]]
- [x] rds-ec2-2![[Pasted image 20260111112046.png]]

![[Pasted image 20260111193643.png]]

1. Short answers: A) Why is DB inbound source restricted to the EC2 security group? 
     _To severely limit access to the database, secure it from public access._
   B) What port does MySQL use? **3306**
    C) Why is Secrets Manager better than storing creds in code/user-data?

_┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓

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
_┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
 

2. Evidence for Audits / Labs (Recommended Output)
    
    aws ec2 describe-security-groups --group-ids sg-0123456789abcdef0 > sg.json aws rds describe-db-instances --db-instance-identifier mydb01 > rds.json aws secretsmanager describe-secret --secret-id my-db-secret > secret.json aws ec2 describe-instances --instance-ids i-0123456789abcdef0 > instance.json aws iam list-attached-role-policies --role-name MyEC2Role > role-policies.json

List all security groups in a region:
    aws ec2 describe-security-groups \
      --region us-east-1 \
      --query "SecurityGroups[].{GroupId:GroupId,Name:GroupName,VpcId:VpcId}" \
      --output table

```rb
[[2026-01-09]]
----------------------------------------------------------------
|                    DescribeSecurityGroups                    |
+-----------------------+------------+-------------------------+
|        GroupId        |   Name     |          VpcId          |
+-----------------------+------------+-------------------------+
|  sg-0c922901e07e75b54 |  ec2-rds-1 |  vpc-027b923656f52e398  |
|  sg-06260ba7b03c5daab |  lab1a-sg  |  vpc-027b923656f52e398  |
|  sg-02a8d862ac4d1e821 |  default   |  vpc-0040e9c82b201d080  |
|  sg-08f93ef65bb3e219a |  default   |  vpc-027b923656f52e398  |
|  sg-01c67e0b8b8788650 |  rds-ec2-1 |  vpc-027b923656f52e398  |
+-----------------------+------------+-------------------------+
```

```rb
[[2026-01-10]]
----------------------------------------------------------------
|                    DescribeSecurityGroups                    |
+-----------------------+------------+-------------------------+
|        GroupId        |   Name     |          VpcId          |
+-----------------------+------------+-------------------------+
|  sg-05c411d1de252c056 |  ec2-rds-3 |  vpc-027b923656f52e398  |
|  sg-0264ae211b9f1f161 |  ec2-rds-2 |  vpc-027b923656f52e398  |
|  sg-0959e615b88f9b55b |  rds-ec2-3 |  vpc-027b923656f52e398  |
|  sg-02a8d862ac4d1e821 |  default   |  vpc-0040e9c82b201d080  |
|  sg-0583d96eb31fd5000 |  rds-ec2-2 |  vpc-027b923656f52e398  |
|  sg-08f93ef65bb3e219a |  default   |  vpc-027b923656f52e398  |
+-----------------------+------------+-------------------------+
```

Inspect a specific security group (inbound & outbound rules)

    aws ec2 describe-security-groups \
      --group-ids sg-0123456789abcdef0 \
      --region us-east-1 \
      --output json

##### my results

```rb
[[2026-01-10]]
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

```

Verify EC2 → RDS access path (security-group–to–security-group)

```rb
aws ec2 describe-security-groups \
  --group-ids sg-ec2-access \
  --region us-east-1 \
  --query "SecurityGroups[].IpPermissions"
```
##### my result
```rb
❯ aws ec2 describe-security-groups \
  --group-ids sg-0583d96eb31fd5000 \
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
                    "Description": "Rule to allow connections from EC2 instances with sg-0264ae211b9f1f161 attached",
                    "UserId": "***REDACTED_ACCOUNT_ID***",
                    "GroupId": "sg-0264ae211b9f1f161"
                }
            ],
            "IpRanges": [],
            "Ipv6Ranges": [],
            "PrefixListIds": []
        }
    ]
]

~/_M
```


Verify That EC2 Can Actually Read the Secret (From the Instance) From inside the EC2 instance:

```rb
aws sts get-caller-identity
```
##### my result
```rb
[[2026-01-11]]

❯ aws sts get-caller-identity
{
    "UserId": "AIDATDDDPJRGILF32Z4NV",
    "Account": "***REDACTED_ACCOUNT_ID***",
    "Arn": "arn:aws:iam::***REDACTED_ACCOUNT_ID***:user/AWSCLI"
}
```

Expected:Arn: arn:aws:sts::123456789012:assumed-role/MyEC2Role/i-0123456789abcdef0

Then test access:

```rb
aws secretsmanager describe-secret \
  --secret-id my-db-secret \
  --region us-east-1
```
##### my results
```rb
[[2026-01-11]]

❯ aws secretsmanager describe-secret \
  --secret-id  lab/rds/mysql \
  --region us-east-1
{
    "ARN": "arn:aws:secretsmanager:us-east-1:***REDACTED_ACCOUNT_ID***:secret:lab/rds/mysql-9PmKb9",
    "Name": "lab/rds/mysql",
    "LastChangedDate": "2026-01-11T01:15:16.425000-07:00",
    "Tags": [],
    "VersionIdsToStages": {
        "4c473e3a-2567-4f3d-965e-948373cc6279": [
            "AWSCURRENT"
        ]
    },
    "CreatedDate": "2026-01-11T01:15:16.364000-07:00"
}

~/_M                                                                           0s
❯
```


Then Answer: Why each rule exists What would break if removed Why broader access is forbidden Why this role exists Why it can read this secret Why it cannot read others


____

EC2 → RDS Integration Lab

Foundational Cloud Application Pattern

1) Project Overview (What You Are Building)
  In this lab, you will build a _classic cloud application architecture:_
  A compute layer running on an Amazon EC2 instance
  A managed relational database hosted on Amazon RDS
  Secure connectivity between the two using VPC networking and security groups
  Credential management using AWS Secrets Manager
  A simple application that writes and reads data from the database

The application itself is intentionally minimal.
The *learning value* is not the app, but the **cloud infrastructure pattern it demonstrates.**

This pattern appears in:
  Internal enterprise tools
  SaaS products
  Backend APIs
  Legacy modernization projects
  Lift-and-shift workloads
  Cloud security assessments

If you can build and verify this pattern, you understand the foundation of real AWS workloads.

2) Why This Lab Exists (Industry Context)
This Is ==One of the Most Common Interview Architectures==
Employers *routinely expect engineers to understand*:
   - **How EC2 communicates with RDS**
   - **How database access is restricted**
   - **Where credentials are stored**
   - **How connectivity is validated**
   - **How failures are debugged**

==You will encounter variations of this question in:==
  AWS Solutions Architect interviews
  Cloud Security roles
  DevOps and SRE interviews
  Incident response scenarios

If you cannot explain this pattern clearly, you will struggle in real cloud environments.

3) Why This Pattern Matters to the Workforce
What Employers Are Actually Testing
This lab evaluates whether you understand:

Skill	Why                 It Matters
Security Groups	          Primary AWS network security boundary
Least Privilege	          Prevents credential leakage & lateral movement
Managed Databases	        Operational responsibility vs infrastructure
IAM Roles	                Eliminates static credentials
Application-to-DB Trust	  Core of backend security

This is not a toy problem. This is how real systems are built.

4) Architectural Design (Conceptual)
Logical Flow
5. A user sends an HTTP request to an EC2 instance
6. The EC2 application:
    Retrieves database credentials from Secrets Manager
    Connects to the RDS MySQL endpoint
7. Data is written to or read from the database
8. Results are returned to the user

Security Model
  RDS is not publicly accessible
  RDS only allows inbound traffic from the EC2 security group
  EC2 retrieves credentials dynamically via IAM role
  No passwords are stored in code or AMIs

This is intentional friction — security is part of the design.

5) **Expected Deliverables (What You Must Produce)**
Each student must submit:

A. Infrastructure Proof
  1) EC2 instance running and reachable over HTTP
     ![[EC2 instance running and reachable over HTTP.png]]
  2) RDS MySQL instance in the same VPC
  3) Security group rule showing:
    RDS inbound TCP 3306
    Source = EC2 security group (not 0.0.0.0/0)
    ![[Pasted image 20260111202555.png]]
  IAM role attached to EC2 allowing Secrets Manager access

B. Application Proof
  1) Successful database initialization
  2) Ability to insert records into RDS
  3) Ability to read records from RDS

C. Verification Evidence
  1) CLI output proving connectivity and configuration
  2) Browser output showing database data

3. Technical Verification Using AWS CLI (Mandatory)
You are expected to prove your work using the CLI — not screenshots alone.

6.1 Verify EC2 Instance
aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=lab-ec2-app" \
  --query "Reservations[].Instances[].InstanceId"
Expected:
  Instance ID returned
  Instance state = running

6.2 Verify IAM Role Attached to EC2
aws ec2 describe-instances \
  --instance-ids <INSTANCE_ID> \
  --query "Reservations[].Instances[].IamInstanceProfile.Arn"

Expected:
  ARN of an IAM instance profile (not null)

6.3 Verify RDS Instance State
aws rds describe-db-instances \
  --db-instance-identifier lab-mysql \
  --query "DBInstances[].DBInstanceStatus"

Expected 
  Available

6.4 Verify RDS Endpoint (Connectivity Target)
aws rds describe-db-instances \
  --db-instance-identifier lab-mysql \
  --query "DBInstances[].Endpoint"

Expected:
  Endpoint address
  Port 3306

6.5 Verify Security Group Rules (Critical)
RDS Security Group Inbound Rules
aws ec2 describe-security-groups \
  --group-names sg-rds-lab \
  --query "SecurityGroups[].IpPermissions"

Expected:
  TCP port 3306
  Source referencing EC2 security group ID, not CIDR

6.6 Verify Secrets Manager Access (From EC2)
SSH into EC2 and run:
aws secretsmanager get-secret-value \
  --secret-id lab/rds/mysql

Expected:
  JSON containing:
    username
    password
    host
    port

If this fails, IAM is misconfigured.


 - [ ] _unable to do this probably tied to earlier steps I missed_
 6.7 Verify Database Connectivity (From EC2)
Install MySQL client (temporary validation):
sudo dnf install -y mysql

Connect:
mysql -h <RDS_ENDPOINT> -u admin -p

Expected:
  Successful login
  No timeout or connection refused errors

6.8 Verify Data Path End-to-End
From browser:
http://<EC2_PUBLIC_IP>/init
http://<EC2_PUBLIC_IP>/add?note=cloud_labs_are_real
http://<EC2_PUBLIC_IP>/list

Expected:
  Notes persist across refresh
  Data survives application restart

7. Common Failure Modes (And What They Teach)


Failure	                    Lesson
Connection timeout	        Security group or routing issue
Access denied	              IAM or Secrets Manager misconfiguration
App starts but DB fails	    Dependency order matters
Works once then breaks	    Stateless compute vs stateful DB

Every failure here mirrors real production outages.


8. What This Lab Proves About You
  If you complete this lab correctly, you can say:
  “I understand how real AWS applications securely connect compute to managed databases.”

That is a non-trivial claim in the job market.