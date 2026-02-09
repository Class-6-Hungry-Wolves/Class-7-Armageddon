Below is a **clean, copy-pasteable runbook** you can include directly in your lab documentation. It’s written in a **post-incident remediation** style (what broke, how we diagnosed, how we fixed), which is exactly what instructors and reviewers look for.

---

# 🛠️ Runbook: Remediating 500 Internal Server Error

**EC2 → Flask → AWS Secrets Manager → RDS (MySQL)**

## Incident Summary

A Flask application running on EC2 returned a **500 Internal Server Error** when accessing application endpoints (`/init`, `/add`, `/list`). The root cause was a **chain of AWS integration misconfigurations**, primarily involving IAM credentials, Secrets Manager, and systemd environment variables.

---

## Architecture Context

* **Compute**: EC2 (Amazon Linux)
* **App**: Flask (Python)
* **Secrets**: AWS Secrets Manager
* **Database**: Amazon RDS (MySQL)
* **Process manager**: systemd

---

## Step-by-Step Remediation

---

## 1️⃣ Identify the real cause of the 500 error

### Action

```bash
sudo journalctl -u rdsapp -n 120 --no-pager
```

### Why

* Flask’s browser error page does **not** show the root cause.
* The traceback in `journalctl` is the authoritative source.

### Finding

Initial failures included:

* `NoCredentialsError`
* DNS resolution errors
* `ResourceNotFoundException` (Secrets Manager)

---

## 2️⃣ Fix missing AWS credentials (IAM role + IMDS)

### Symptom

```
botocore.exceptions.NoCredentialsError: Unable to locate credentials
```

### Action

1. Attach an **IAM role** to the EC2 instance.
2. Ensure the role includes:

```json
{
  "Effect": "Allow",
  "Action": "secretsmanager:GetSecretValue",
  "Resource": "*"
}
```

3. Verify credentials are available **on the instance**:

```bash
sudo python3 - <<'PY'
import boto3
print(boto3.client("sts").get_caller_identity())
PY
```

### Why

* Flask runs under **systemd**, not your shell.
* Credentials must come from **EC2 Instance Metadata (IMDS)**, not local AWS CLI config.

---

## 3️⃣ Verify Instance Metadata Service (IMDS)

### Action

```bash
curl http://169.254.169.254/latest/meta-data/iam/info
```

### Expected

* JSON output showing instance profile info.

### Why

* boto3 retrieves credentials from IMDS.
* If IMDS is disabled or blocked, credentials cannot be resolved.

---

## 4️⃣ Resolve DNS and RDS endpoint issues

### Symptom

```
socket.gaierror: Name or service not known
```

### Action

```bash
nslookup <rds-endpoint>
```

### Fix

* Ensure the **correct RDS endpoint** is stored in Secrets Manager.
* Replace incorrect or stale hostnames.

### Why

* A resolvable hostname is required for MySQL connectivity.

---

## 5️⃣ Correct the secret name mismatch (systemd issue)

### Symptom

* Secret renamed, but app still referenced old name.

### Root Cause

systemd unit file still contained:

```ini
Environment=SECRET_ID=lab/rds/mysql
```

### Fix

Update to the new secret name:

```ini
Environment=SECRET_ID=class7-armageddon/rds/mysql
```

Apply changes:

```bash
sudo systemctl daemon-reload
sudo systemctl restart rdsapp
```

### Verify

```bash
sudo systemctl show rdsapp -p Environment
```

### Why

* systemd does **not** auto-reload environment variables.
* The app was requesting a secret that no longer existed.

---

## 6️⃣ Fix missing AWSCURRENT secret version (final blocker)

### Symptom

```
ResourceNotFoundException:
Secrets Manager can't find the specified secret value for staging label: AWSCURRENT
```

### Root Cause

* Secret existed, but **no value was marked as AWSCURRENT**.

### Fix

Create or update the secret value:

```bash
aws secretsmanager put-secret-value \
  --secret-id class7-armageddon/rds/mysql \
  --secret-string '{
    "username": "admin",
    "password": "REDACTED",
    "host": "<rds-endpoint>",
    "port": 3306,
    "dbname": "labdb"
  }'
```

### Why

* `GetSecretValue` defaults to the `AWSCURRENT` version stage.
* Without it, Secrets Manager rejects the request.

---

## 7️⃣ Initialize database successfully

### Action

```bash
curl http://127.0.0.1/init
```

### Result

```
Initialized labdb + notes table.
```

### Why

* Confirms end-to-end functionality:

  * IAM → Secrets Manager → DNS → RDS → MySQL schema creation

---

## Final Outcome

✅ Flask app no longer returns 500 errors
✅ Secrets Manager credentials retrieved successfully
✅ RDS connection established
✅ Database initialized
✅ Browser endpoints operational

---

## Lessons Learned

* **500 errors are symptoms, not diagnoses**
* systemd environment ≠ shell environment
* Secrets Manager requires:

  * Correct secret name
  * Correct IAM permissions
  * An `AWSCURRENT` version
* Always verify with:

```bash
journalctl -u <service>
```

---

If you want, I can also:

* Turn this into a **one-page troubleshooting flowchart**
* Rewrite it as a **formal incident post-mortem**
* Add a **pre-deployment checklist** to prevent recurrence

Just say the word.
