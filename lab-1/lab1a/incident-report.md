# Incident Report for February 9, 2026 

Incident Report for DB connection failure  

Credit to Xavier Miles @REBEL-INX for helping with lab 1b incident report


### Point of failure

EC2 RDS Notes application failed to connect to devrds01 database in us-east-1 AWS region



### Detection method 

Detected connection failure by getting notified by SNS Topic in combination with utilizing Cloudwatch Logs. SNS topic email subscription notification was sent out at approximately 7:29 EST notifying that the Cloudwatch Alarm for tracking DBConnectionsErrors had gone into the 'ALARM' state. 

### Root Cause
RDS database devrds01 was in the stopped state, causing app to throw Internal Service 500 errors.


### Time to Recovery
30 seconds to verify alarm state

5 minutes to parse logs and identify correct failure type

3 minutes to confirm correct Parameter Store Values

3 minutes to confirm Secrets Manager Values and check them against known good state

8 minutes to confirm Security Group rules were correctly assigned

6.5 minutes to check if RDS was in the stopped state 

6.5 minutes to restore access to RDS

##### In total 32 minutes 45 seconds to recover





### Proposal to reduce mean time to recovery
Confirm that RDS is in the running state, before checking security groups, Parameter Store Values, or Secrets Manager. RDS database takes a long time to start up after being turned off which can increase mean time to recovery.


### Proposal to prevent reccurence
Restrict IAM permissions users such that they do not have the rds:StopDBInstance permission or the rds:DescribeDBInstances permission, unless they are within a specified IAM group or organization

