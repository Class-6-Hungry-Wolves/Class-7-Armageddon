# LAB1-A: Gate Scripts Results

---


## From your workstation (metadata checks; role attach + secret exists)

    chmod +x gate_secrets_and_role.sh
    REGION=us-east-1 INSTANCE_ID=<---> SECRET_ID=<---> ./gate_secrets_and_role.sh

![SEIR Gate - Secrets & Role Verification](./artifacts/lab1a/40-Gate-Secrets-RoleVerify.png)

## From inside the EC2 instance (prove the instance role can actually read the secret)

    CHECK_SECRET_VALUE_READ=true REGION=us-east-1 INSTANCE_ID=<---> SECRET_ID=<---> ./gate_secrets_and_role.sh

![SEIR Gate - EC2 Role Allows ReadSecret](./artifacts/lab1a/41-Gate-Secrets-ReadSecret.png)

## Strict mode: require rotation enabled

    REQUIRE_ROTATION=true REGION=us-east-1 INSTANCE_ID=<---> SECRET_ID=<---> ./gate_secrets_and_role.sh

![SEIR Gate - Secrets Rotation Enabled](./artifacts/lab1a/42-Gate-Secrets-RotationEnable.png)

## Basic: verify RDS isn’t public + SG-to-SG rule exists

    chmod +x gate_network_db.sh
    REGION=us-east-1 INSTANCE_ID=<---> DB_ID=<---> ./gate_network_db.sh

![SEIR Gate - RDS Private & SG Rule Verify](./artifacts/lab1a/43-Gate-Network-RDSPrivate.png)

## Strict: also verify DB subnets are private (no IGW route)

CHECK_PRIVATE_SUBNETS=true REGION=us-east-1 INSTANCE_ID=i-0123456789abcdef0 DB_ID=mydb01 ./gate_network_db.sh

![SEIR Gate - RDS Subnets Private](./artifacts/lab1a/44-Gate-Network-RDSPrivateSubnets.png)

## If endpoint port discovery fails, override it...

    chmod +x run_all_gates.sh
    REGION=us-east-1 \
    INSTANCE_ID=<---> \
    SECRET_ID=<---> \
    DB_ID=<---> \
    ./run_all_gates.sh
  
  ![SEIR Gate - Run All Gates](./artifacts/lab1a/45-Run-All-Gates01.png)

## Strict options (rotation + private subnet check)

    REQUIRE_ROTATION=true \
    CHECK_PRIVATE_SUBNETS=true \
    REGION=us-east-1 INSTANCE_ID=i-... SECRET_ID=... DB_ID=... \
    ./run_all_gates.sh
  
  ![SEIR Gate - Secrets Rotation True](./artifacts/lab1a/45-Run-All-Gates02.png)

If running ON the EC2 and you want to assert it can read the secret value

    CHECK_SECRET_VALUE_READ=true \
    REGION=us-east-1 INSTANCE_ID=i-... SECRET_ID=... DB_ID=... \
    ./run_all_gates.sh
  ![SEIR Gate - Secrets Rotation True](./artifacts/lab1a/46-Run-All-Gates03a.png)
  ![SEIR Gate - Secrets Rotation True](./artifacts/lab1a/46-Run-All-Gates03b.png)

## Expected Output:
### Files created:
        gate_secrets_and_role.json
        gate_network_db.json
        gate_result.json ✅ combined summary

![SEIR Gate - Secrets Rotation True](./artifacts/lab1a/47-Gates-Result-Snap.png)
