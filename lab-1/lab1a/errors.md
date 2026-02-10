Perfect. Here’s a **“Lessons Learned / Troubleshooting”** section you can drop straight into your lab documentation (written in that clean “postmortem / ops note” style).

---

## Lessons Learned / Troubleshooting Notes

This section documents the major failures encountered during deployment and the remediations applied. The goal is to capture *root cause + fix + how to verify* so the environment can be rebuilt quickly and reliably.

---

### 1) Internal Service 500 on `/init`

#### **Symptoms**

* Hitting `/init` returned **Internal Server Error (500)**
* Flask logs showed:

```
botocore.errorfactory.ResourceNotFoundException:
Secrets Manager can't find the specified secret value for staging label: AWSCURRENT
```

#### **Root Cause**

The app was configured to fetch a secret name that **no longer existed**, due to a secret rename.

* Secret renamed to: `class7-armageddon/rds/mysql` (later `armageddon/rds/mysql`)
* But systemd service still set:

```ini
Environment=SECRET_ID=lab/rds/mysql
```

So the app was calling:

```python
secrets.get_secret_value(SecretId=SECRET_ID)
```

…using the old secret ID.

AWS returns a ResourceNotFoundException and the Flask request fails.

#### **Fix**

Updated systemd service environment variable to match the correct secret name:

```ini
Environment=SECRET_ID=armageddon/rds/mysql
```

Then restarted service:

```bash
sudo systemctl daemon-reload
sudo systemctl restart rdsapp
```

#### **Verification**

Run:

```bash
curl -s http://localhost/init
sudo tail -n 50 /var/log/rdsapp.err
```

Expected: `/init` returns 200 and the error disappears.

---

### 2) `/init` worked but `/add` and `/list` failed

#### **Symptoms**

* `/init` returned OK
* `/add` and `/list` returned errors or unexpected behavior

#### **Root Cause**

`/init` connects to MySQL **without specifying a database**, then creates it:

```python
conn = pymysql.connect(host=host, user=user, password=password, port=port)
cur.execute("CREATE DATABASE IF NOT EXISTS rds01;")
```

But `/add` and `/list` connect using:

```python
database=c.get("dbname", "rds01")
```

If the secret does **not include `dbname`** (or includes the wrong one), `/add` and `/list` may try to connect to a DB that doesn’t exist or isn't the expected one.

#### **Fix**

Ensure the secret JSON includes:

```json
"dbname": "rds01"
```

Or align the fallback:

```python
db = c.get("dbname", "rds01")
```

#### **Verification**

Run:

```bash
curl "http://<ec2-ip>/add?note=test"
curl "http://<ec2-ip>/list"
```

---

### 3) Gate script falsely reported “no instance profile attached”

#### **Symptoms**

Gate script output showed:

```
FAIL: instance has NO IAM instance profile attached (i-...).
```

Even though EC2 clearly had an instance profile attached in console/terraform.

#### **Root Cause**

The gate script uses the AWS CLI call:

```bash
aws ec2 describe-instances ...
```

If the EC2 role lacks **`ec2:DescribeInstances`**, the call fails and the script assumes “no profile.”

So the failure was not a missing role — it was **missing permission**.

#### **Fix**

Added the action to the EC2 IAM policy:

```hcl
statement {
  sid       = "DescribeInstances"
  effect    = "Allow"
  actions   = ["ec2:DescribeInstances"]
  resources = ["*"]
}
```

#### **Verification**

Run on EC2:

```bash
aws ec2 describe-instances --instance-ids <id> --region us-east-1
```

Gate should now PASS.

---

### 4) `iam:GetInstanceProfile` required to resolve role name

#### **Symptoms**

Gate output:

```
FAIL: could not resolve role name from instance profile (lab1-dev-ec2-instance-profile).
```

#### **Root Cause**

Script resolves:

Instance Profile → Role name using:

```bash
aws iam get-instance-profile ...
```

That requires:

* `iam:GetInstanceProfile`

Even if the instance can assume the role, IAM APIs still require explicit permission.

#### **Fix**

Added:

```hcl
statement {
  sid     = "GetInstanceProfile"
  effect  = "Allow"
  actions = ["iam:GetInstanceProfile"]
  resources = [
    "arn:aws:iam::<account-id>:instance-profile/lab1-dev-ec2-instance-profile"
  ]
}
```

---

### 5) Rotation stuck: “A previous rotation isn't complete”

#### **Symptoms**

Running:

```bash
aws secretsmanager rotate-secret --secret-id armageddon/rds/mysql
```

returned:

```
InvalidRequestException: A previous rotation isn't complete. That rotation will be reattempted.
```

#### **Root Cause**

Secrets Manager rotation operates as a workflow across stages:

* createSecret
* setSecret
* testSecret
* finishSecret

A rotation gets “stuck” if Lambda fails in any step, leaving `AWSPENDING` in place.

#### **Fix**

* Confirm Lambda connectivity (VPC/subnets/SG)
* Confirm RDS inbound allows Lambda SG on 3306
* Fix Lambda permissions and retry

#### **Verification**

Describe the secret:

```bash
aws secretsmanager describe-secret --secret-id armageddon/rds/mysql --region us-east-1
```

Expected: AWSPENDING eventually promotes to AWSCURRENT

---

### 6) CloudWatch Agent failing: “No json config files found”

#### **Symptoms**

Agent failed repeatedly:

```
Cannot translate JSON, ERROR is exit status 1
No json config files found, use the default one
```

#### **Root Cause**

CloudWatch agent runs a translator that expects a JSON input file at:

```
/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
```

But the config deployed was YAML and/or not fetched properly.

#### **Fix**

Use the official control utility to fetch and start agent with correct config:

```bash
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config -m ec2 \
  -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.yaml \
  -s
```

#### **Verification**

1. Service running:

```bash
sudo systemctl status amazon-cloudwatch-agent --no-pager
```

2. Log streams exist:

```bash
aws logs describe-log-streams --log-group-name "/aws/ec2/armageddon-rds-app" --region us-east-1
```

---

## Key Takeaways

* **Hardcoding secret IDs** breaks environments when secret names change. Use consistent naming and/or Parameter Store.
* If `/init` works but `/add` and `/list` fail, suspect **database context (`dbname`)** or **table existence**.
* Validation scripts often fail due to **missing IAM read permissions**, not missing resources.
* Secret rotation requires app-side resilience (retries + re-fetch secret values).
* CloudWatch Agent config should always be deployed via `amazon-cloudwatch-agent-ctl`, not by manually dropping random config formats.

---

