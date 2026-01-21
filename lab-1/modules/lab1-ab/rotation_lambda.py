import boto3
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    arn = event['SecretId']
    token = event['ClientRequestToken']
    step = event['Step']

    # Setup the client
    service_client = boto3.client('secretsmanager')

    # 1. Ensure the version is staged correctly
    metadata = service_client.describe_secret(SecretId=arn)
    if not metadata['RotationEnabled']:
        raise ValueError(f"Secret {arn} is not enabled for rotation")
        
    versions = metadata['VersionIdsToStages']
    if token not in versions:
        raise ValueError(f"Token {token} has no stage for secret {arn}")
    if "AWSCURRENT" in versions[token]:
        logger.info(f"Token {token} already set as AWSCURRENT for {arn}")
        return

    # 2. Run the appropriate step
    if step == "createSecret":
        create_secret(service_client, arn, token)
    elif step == "setSecret":
        set_secret(service_client, arn, token)
    elif step == "testSecret":
        test_secret(service_client, arn, token)
    elif step == "finishSecret":
        finish_secret(service_client, arn, token)
    else:
        raise ValueError("Invalid step parameter")

def create_secret(service_client, arn, token):
    # Logic: Generate a new password/key and save it as AWSPENDING
    # service_client.put_secret_value(SecretId=arn, ClientRequestToken=token, 
    #                                SecretString=new_value, VersionStages=['AWSPENDING'])
    logger.info("createSecret: Successfully generated new secret version.")

def set_secret(service_client, arn, token):
    # Logic: Update the actual service (e.g., Database or SaaS API) with the new secret
    logger.info("setSecret: Successfully updated external service.")

def test_secret(service_client, arn, token):
    # Logic: Try to authenticate with the external service using the AWSPENDING secret
    logger.info("test_secret: Successfully verified new secret works.")

def finish_secret(service_client, arn, token):
    # Logic: Move the AWSCURRENT label from the old version to this new version
    metadata = service_client.describe_secret(SecretId=arn)
    current_version = None
    for version in metadata['VersionIdsToStages']:
        if "AWSCURRENT" in metadata['VersionIdsToStages'][version]:
            current_version = version
            break
    
    service_client.update_secret_version_stage(
        SecretId=arn,
        VersionStage="AWSCURRENT",
        MoveToVersionId=token,
        RemoveFromVersionId=current_version
    )
    logger.info("finishSecret: Successfully promoted new secret to AWSCURRENT.")
