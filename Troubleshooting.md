# Troubleshooting Guide – Lab 2a

This file documents common troubleshooting steps for working with the Lab 2a infrastructure.

---

## 1. SSH Access to EC2 Instances (Optional)

### Why SSH Might Be Needed
In some cases, you may want to SSH into the EC2 application instances to:

- Verify that the application is running
- Inspect logs
- Test connectivity to RDS
- Debug IAM / SSM agent issues

By default, this lab does **NOT** enable SSH publicly for security reasons.

---

## 2. Why SSH Is Disabled By Default

The infrastructure uses **private subnets** for EC2 and RDS.

This means:

- EC2 instances **do not have public IPs**
- They are **not reachable directly from the internet**
- The recommended access method is **SSM Session Manager**, not SSH

Exposing SSH publicly would require:

1. A public IP
2. A security group allowing port `22`
3. An inbound CIDR range

All of that breaks the security model of Lab 2a.

---

## 3. Optional SSH Access for Debugging

If SSH access is **temporarily** required, the following ingress block can be used:

```hcl
ingress {
  description = "Allow SSH from my IP"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["YOUR.IP.HERE/32"]
}

Replace YOUR.IP.HERE

Find your IP via:

curl ifconfig.me
Example:

cidr_blocks = ["203.0.113.47/32"]
Important Notes
Use /32 to allow only one IP

Never allow 0.0.0.0/0 on port 22

Remove or comment out the block when finished