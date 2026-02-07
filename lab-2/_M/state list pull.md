/Class-7-Armageddon/lab-1/lab1 on  nikrdf-armageddon-branch ✘!?                   
❯ terraform state pull
{
  "version": 4,
  "terraform_version": "1.5.7",
  "serial": 258,
  "lineage": "60ed2879-a6a6-8cad-0ac4-3d4ae5609c1f",
  "outputs": {
    "app_urls": {
      "value": {
        "add": "http://34.239.0.106/add?note=hello_vandelay",
        "home": "http://34.239.0.106/",
        "init": "http://34.239.0.106/init",
        "list": "http://34.239.0.106/list"
      },
      "type": [
        "object",
        {
          "add": "string",
          "home": "string",
          "init": "string",
          "list": "string"
        }
      ]
    },
    "ec2_instance_id": {
      "value": "i-00afae72bb49040b6",
      "type": "string"
    },
    "ec2_public_dns": {
      "value": "ec2-34-239-0-106.compute-1.amazonaws.com",
      "type": "string"
    },
    "ec2_public_ip": {
      "value": "34.239.0.106",
      "type": "string"
    },
    "ec2_security_group_id": {
      "value": "sg-00aa1fb4c080b975b",
      "type": "string"
    },
    "gate_script_variables": {
      "value": {
        "DB_ID": "vandelay-rds01",
        "INSTANCE_ID": "i-00afae72bb49040b6",
        "REGION": "us-east-1",
        "SECRET_ID": "lab/rds/mysql"
      },
      "type": [
        "object",
        {
          "DB_ID": "string",
          "INSTANCE_ID": "string",
          "REGION": "string",
          "SECRET_ID": "string"
        }
      ]
    },
    "iam_role_name": {
      "value": "vandelay-ec2-role01",
      "type": "string"
    },
    "incident_reporter_arn": {
      "value": "arn:aws:lambda:us-east-1:212809501772:function:vandelay-incident-reporter",
      "type": "string"
    },
    "incident_reporter_function_name": {
      "value": "vandelay-incident-reporter",
      "type": "string"
    },
    "incident_reports_bucket": {
      "value": "vandelay-incident-reports-212809501772",
      "type": "string"
    },
    "instance_profile_name": {
      "value": "vandelay-instance-profile01",
      "type": "string"
    },
    "log_group_name": {
      "value": "/aws/ec2/vandelay-rds-app",
      "type": "string"
    },
    "private_subnet_ids": {
      "value": [
        "subnet-0afcb35783b14f2c7",
        "subnet-055b1de2d18737807"
      ],
      "type": [
        "tuple",
        [
          "string",
          "string"
        ]
      ]
    },
    "public_subnet_ids": {
      "value": [
        "subnet-07aca3968a20186e1",
        "subnet-023c3131fec823b62"
      ],
      "type": [
        "tuple",
        [
          "string",
          "string"
        ]
      ]
    },
    "rds_endpoint": {
      "value": "vandelay-rds01.cmrys4aosktq.us-east-1.rds.amazonaws.com",
      "type": "string"
    },
    "rds_identifier": {
      "value": "vandelay-rds01",
      "type": "string"
    },
    "rds_port": {
      "value": 3306,
      "type": "number"
    },
    "rds_security_group_id": {
      "value": "sg-0468006e629bcfee5",
      "type": "string"
    },
    "rotation_lambda_name": {
      "value": "vandelay-mysql-rotation-lambda",
      "type": "string"
    },
    "secret_arn": {
      "value": "arn:aws:secretsmanager:us-east-1:212809501772:secret:lab/rds/mysql-x7lYie",
      "type": "string"
    },
    "secret_name": {
      "value": "lab/rds/mysql",
      "type": "string"
    },
    "secret_rotation_enabled": {
      "value": true,
      "type": "bool"
    },
    "sns_topic_arn": {
      "value": "arn:aws:sns:us-east-1:212809501772:vandelay-db-incidents",
      "type": "string"
    },
    "vandelay_alb_logs_bucket": {
      "value": "vandelay-alb-logs-212809501772",
      "type": "string"
    },
    "vandelay_alb_logs_bucket_arn": {
      "value": "arn:aws:s3:::vandelay-alb-logs-212809501772",
      "type": "string"
    },
    "vandelay_ec2_instance_id": {
      "value": "i-00afae72bb49040b6",
      "type": "string"
    },
    "vandelay_ec2_private_instance_id": {
      "value": "i-03c11c546c8dfaf66",
      "type": "string"
    },
    "vandelay_log_group_name": {
      "value": "/aws/ec2/vandelay-rds-app",
      "type": "string"
    },
    "vandelay_private_subnet_ids": {
      "value": [
        "subnet-0afcb35783b14f2c7",
        "subnet-055b1de2d18737807"
      ],
      "type": [
        "tuple",
        [
          "string",
          "string"
        ]
      ]
    },
    "vandelay_public_subnet_ids": {
      "value": [
        "subnet-07aca3968a20186e1",
        "subnet-023c3131fec823b62"
      ],
      "type": [
        "tuple",
        [
          "string",
          "string"
        ]
      ]
    },
    "vandelay_rds_endpoint": {
      "value": "vandelay-rds01.cmrys4aosktq.us-east-1.rds.amazonaws.com",
      "type": "string"
    },
    "vandelay_sns_topic_arn": {
      "value": "arn:aws:sns:us-east-1:212809501772:vandelay-db-incidents",
      "type": "string"
    },
    "vandelay_vpc_id": {
      "value": "vpc-0d67f2118f804df1f",
      "type": "string"
    },
    "vandelay_vpce_monitoring_id": {
      "value": "vpce-02c2988cf2db83283",
      "type": "string"
    },
    "vandelay_waf_log_group_arn": {
      "value": "arn:aws:logs:us-east-1:212809501772:log-group:aws-waf-logs-vandelay-webacl",
      "type": "string"
    },
    "vandelay_waf_log_group_name": {
      "value": "aws-waf-logs-vandelay-webacl",
      "type": "string"
    },
    "vpc_id": {
      "value": "vpc-0d67f2118f804df1f",
      "type": "string"
    }
  },
  "resources": [
    {
      "mode": "data",
      "type": "archive_file",
      "name": "incident_reporter_zip",
      "provider": "provider[\"registry.terraform.io/hashicorp/archive\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "exclude_symlink_directories": null,
            "excludes": null,
            "id": "6f3e456d2312e38bbe87543f510d7cb6f9aaa9ec",
            "output_base64sha256": "ji+axdSjgmlLAkvXlbDXnFDb+yTc7ahog/OV1YvFm5A=",
            "output_base64sha512": "98kUHfTnIZ2L3blOT40LGVPzEOnsOwAidX7c3VuB6FHPLanzGEvJVOL08dBTQF85frxA8EhdXbLgOJBiXPhU1A==",
            "output_file_mode": null,
            "output_md5": "1058a2b1dafff1e905ba7a867c710e57",
            "output_path": "./lambda/incident_reporter.zip",
            "output_sha": "6f3e456d2312e38bbe87543f510d7cb6f9aaa9ec",
            "output_sha256": "8e2f9ac5d4a382694b024bd795b0d79c50dbfb24dceda86883f395d58bc59b90",
            "output_sha512": "f7c9141df4e7219d8bddb94e4f8d0b1953f310e9ec3b0022757edcdd5b81e851cf2da9f3184bc954e2f4f1d053405f397ebc40f0485d5db2e03890625cf854d4",
            "output_size": 10852,
            "source": [],
            "source_content": null,
            "source_content_filename": null,
            "source_dir": "./lambda",
            "source_file": null,
            "type": "zip"
          },
          "sensitive_attributes": []
        }
      ]
    },
    {
      "mode": "data",
      "type": "aws_caller_identity",
      "name": "current",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "account_id": "212809501772",
            "arn": "arn:aws:iam::212809501772:user/AWSCLI",
            "id": "212809501772",
            "user_id": "AIDATDDDPJRGILF32Z4NV"
          },
          "sensitive_attributes": []
        }
      ]
    },
    {
      "mode": "data",
      "type": "aws_caller_identity",
      "name": "vandelay_self01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "account_id": "212809501772",
            "arn": "arn:aws:iam::212809501772:user/AWSCLI",
            "id": "212809501772",
            "user_id": "AIDATDDDPJRGILF32Z4NV"
          },
          "sensitive_attributes": []
        }
      ]
    },
    {
      "mode": "data",
      "type": "aws_region",
      "name": "vandelay_region01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "description": "US East (N. Virginia)",
            "endpoint": "ec2.us-east-1.amazonaws.com",
            "id": "us-east-1",
            "name": "us-east-1"
          },
          "sensitive_attributes": []
        }
      ]
    },
    {
      "mode": "data",
      "type": "aws_route53_zone",
      "name": "vandelay_zone",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:route53:::hostedzone/Z07421622AG1WUIDW7VC3",
            "caller_reference": "RISWorkflow-RD:b944b4fe-99c0-4a66-b232-bb8179d3af98",
            "comment": "HostedZone created by Route53 Registrar",
            "id": "Z07421622AG1WUIDW7VC3",
            "linked_service_description": null,
            "linked_service_principal": null,
            "name": "keepuneat.click",
            "name_servers": [
              "ns-352.awsdns-44.com",
              "ns-986.awsdns-59.net",
              "ns-1886.awsdns-43.co.uk",
              "ns-1101.awsdns-09.org"
            ],
            "primary_name_server": "ns-352.awsdns-44.com",
            "private_zone": false,
            "resource_record_set_count": 6,
            "tags": {},
            "vpc_id": null,
            "zone_id": "Z07421622AG1WUIDW7VC3"
          },
          "sensitive_attributes": []
        }
      ]
    },
    {
      "mode": "data",
      "type": "aws_secretsmanager_secret",
      "name": "vandelay_db_secret01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:secretsmanager:us-east-1:212809501772:secret:lab/rds/mysql-x7lYie",
            "created_date": "2026-01-21T22:11:13Z",
            "description": "",
            "id": "arn:aws:secretsmanager:us-east-1:212809501772:secret:lab/rds/mysql-x7lYie",
            "kms_key_id": "",
            "last_changed_date": "2026-01-30T23:33:55Z",
            "name": "lab/rds/mysql",
            "policy": "",
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-db-secret01"
            }
          },
          "sensitive_attributes": []
        }
      ]
    },
    {
      "mode": "data",
      "type": "aws_secretsmanager_secret_version",
      "name": "vandelay_db_secret_version01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:secretsmanager:us-east-1:212809501772:secret:lab/rds/mysql-x7lYie",
            "created_date": "2026-01-30T14:56:13Z",
            "id": "arn:aws:secretsmanager:us-east-1:212809501772:secret:lab/rds/mysql-x7lYie|AWSCURRENT",
            "secret_binary": "",
            "secret_id": "arn:aws:secretsmanager:us-east-1:212809501772:secret:lab/rds/mysql-x7lYie",
            "secret_string": "{\"username\": \"admin\", \"password\": \"jNhnA2DFcGrxmMtIo4EvfkQPbsxK4v8\", \"host\": \"vandelay-rds01.cmrys4aosktq.us-east-1.rds.amazonaws.com\", \"port\": \"3306\", \"dbname\": \"labmysql\"}\n",
            "version_id": "7710288d-fc8b-4186-acd1-6dd2d00b03ce",
            "version_stage": "AWSCURRENT",
            "version_stages": [
              "AWSCURRENT"
            ]
          },
          "sensitive_attributes": []
        }
      ]
    },
    {
      "mode": "data",
      "type": "aws_serverlessapplicationrepository_application",
      "name": "secrets_manager_rotation",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "application_id": "arn:aws:serverlessrepo:us-east-1:297356227824:applications/SecretsManagerRDSMySQLRotationSingleUser",
            "id": "arn:aws:serverlessrepo:us-east-1:297356227824:applications/SecretsManagerRDSMySQLRotationSingleUser",
            "name": "SecretsManagerRDSMySQLRotationSingleUser",
            "required_capabilities": [
              "CAPABILITY_IAM",
              "CAPABILITY_RESOURCE_POLICY"
            ],
            "semantic_version": "1.1.632",
            "source_code_url": "https://github.com/aws-samples/aws-secrets-manager-rotation-lambdas",
            "template_url": "https://awsserverlessrepo-applications-eji6x7x4bodi.s3.us-east-1.amazonaws.com/297356227824/SecretsManagerRDSMySQLRotationSingleUser/1.1.632/transformed-template.yaml?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEOT%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJGMEQCIAQ5lqmI4DN06GFYUYN3Mc6RjVkr98XuR1mIOFCn%2Br2IAiAVndRi1PQuQNxHcsLX9IKZrPw1PTLOB8eRxhoPg2SqtiqwAwis%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F8BEAIaDDA2NjI0MjQ2ODY1NCIMrbKNkqI2MeeP%2Fx3VKoQDsTzhIfLJydt8hdh8LzbIfRgE57eDJRKQr2d7eDP8YD0R3TPP2jprfl7W2ZsKkl5Hg%2Bx%2FWdbv8CYZWbjeKOyNCh%2BpmWZ08Q8H3GiWyO3SqSQrKDyMY%2BvL0ByW3AiEo1mp0G%2B0WNYBQUQLEhrEmCihTMV4KNXfUijYsqHdnQKLAvJ%2F9Oz0%2FWDoxwIerAekbsr9ulj2fayTRsLyhpLiaDJNuZwrV7JjEI%2BaI0tGU%2FLYAm2V%2BfcB0DWmuLWO7LzV231uVT5FTh3DHTDFMP0vQZT36fROudCeR3lC1f%2Bd0eqgdhKlu8ynOlj%2FNZzagFEgjMpT4XgcTQ244Yib%2FZ9Ps8DQ18VBbkEtpgF1Parnd9r7WaP0mTRKsR1gud0O%2BA3H%2FBWUKOAPo%2BGLypfBf6l7FhbHeNK48wy8BPmySWD7WwYzA8zRVbVYKtcY2aXlKUHyDlI8AdPLs%2BUJBwtn9inGKA3TD6rDWx5k%2FPk7ZnjJG0B2nDlzmgBy196SljflWEcbmUK3UfJIHjC25PXLBjqeAWggcRkNG6dlWzO0N289uL5FRavOguZXiTCI0dNCABslsL5WdrpK9gPNY7EbI69RHTvBv2GZfrEE2Wtb58ja5938VFO4sgGJT8GZCEoxG%2FcJ4fLbOaPZVCveThpL6eYpJCP8hf6cvvSb9m4YOfypPlAq6kkgZ%2FIAToPOD2tZk%2BSfMSJ6X%2Fm0163ARHBvK4%2BPVRTcbMyE3eSDQkV6NIak\u0026X-Amz-Algorithm=AWS4-HMAC-SHA256\u0026X-Amz-Date=20260131T032711Z\u0026X-Amz-SignedHeaders=host\u0026X-Amz-Expires=1800\u0026X-Amz-Credential=ASIAQ63C33MXMFYS32AS%2F20260131%2Fus-east-1%2Fs3%2Faws4_request\u0026X-Amz-Signature=241a16fdae4d54f7c6f26882dd7973f9e0e6a87141c5b90d18e7f480b390e594"
          },
          "sensitive_attributes": []
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_acm_certificate",
      "name": "vandelay_cert",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:acm:us-east-1:212809501772:certificate/8424738a-8e66-4f04-9839-0561c2b26576",
            "certificate_authority_arn": "",
            "certificate_body": null,
            "certificate_chain": null,
            "domain_name": "app.keepuneat.click",
            "domain_validation_options": [
              {
                "domain_name": "*.keepuneat.click",
                "resource_record_name": "_8a9b7dc35375689165ec9fcefdd02cde.keepuneat.click.",
                "resource_record_type": "CNAME",
                "resource_record_value": "_088f01000e858fa995789ad336279261.jkddzztszm.acm-validations.aws."
              },
              {
                "domain_name": "app.keepuneat.click",
                "resource_record_name": "_a1830e57280623936855a533b94fd09c.app.keepuneat.click.",
                "resource_record_type": "CNAME",
                "resource_record_value": "_34e31432c7121f8090c754e09f66fb52.jkddzztszm.acm-validations.aws."
              }
            ],
            "early_renewal_duration": "",
            "id": "arn:aws:acm:us-east-1:212809501772:certificate/8424738a-8e66-4f04-9839-0561c2b26576",
            "key_algorithm": "RSA_2048",
            "not_after": "2027-02-28T23:59:59Z",
            "not_before": "2026-01-30T00:00:00Z",
            "options": [
              {
                "certificate_transparency_logging_preference": "ENABLED"
              }
            ],
            "pending_renewal": false,
            "private_key": null,
            "renewal_eligibility": "ELIGIBLE",
            "renewal_summary": [],
            "status": "ISSUED",
            "subject_alternative_names": [
              "*.keepuneat.click",
              "app.keepuneat.click"
            ],
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-acm-cert"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-acm-cert"
            },
            "type": "AMAZON_ISSUED",
            "validation_emails": [],
            "validation_method": "DNS",
            "validation_option": []
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "create_before_destroy": true
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_acm_certificate_validation",
      "name": "vandelay_cert_validated",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "certificate_arn": "arn:aws:acm:us-east-1:212809501772:certificate/8424738a-8e66-4f04-9839-0561c2b26576",
            "id": "2026-01-30 23:29:33.378 +0000 UTC",
            "timeouts": {
              "create": "5m"
            },
            "validation_record_fqdns": [
              "_8a9b7dc35375689165ec9fcefdd02cde.keepuneat.click",
              "_a1830e57280623936855a533b94fd09c.app.keepuneat.click"
            ]
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjozMDAwMDAwMDAwMDB9fQ==",
          "dependencies": [
            "aws_acm_certificate.vandelay_cert",
            "aws_route53_record.vandelay_cert_validation",
            "data.aws_route53_zone.vandelay_zone"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_cloudwatch_dashboard",
      "name": "vandelay_dashboard01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "dashboard_arn": "arn:aws:cloudwatch::212809501772:dashboard/vandelay-dashboard01",
            "dashboard_body": "{\"widgets\":[{\"height\":6,\"properties\":{\"metrics\":[[\"AWS/ApplicationELB\",\"RequestCount\",\"LoadBalancer\",\"app/vandelay-alb01/946e933d1e5bbcbf\"]],\"period\":300,\"region\":\"us-east-1\",\"stat\":\"Sum\",\"title\":\"ALB Request Count\"},\"type\":\"metric\",\"width\":12,\"x\":0,\"y\":0},{\"height\":6,\"properties\":{\"metrics\":[[\"AWS/ApplicationELB\",\"HTTPCode_ELB_5XX_Count\",\"LoadBalancer\",\"app/vandelay-alb01/946e933d1e5bbcbf\"],[\"AWS/ApplicationELB\",\"HTTPCode_Target_5XX_Count\",\"LoadBalancer\",\"app/vandelay-alb01/946e933d1e5bbcbf\"]],\"period\":300,\"region\":\"us-east-1\",\"stat\":\"Sum\",\"title\":\"ALB HTTP 5xx Errors\"},\"type\":\"metric\",\"width\":12,\"x\":12,\"y\":0},{\"height\":6,\"properties\":{\"metrics\":[[\"AWS/ApplicationELB\",\"TargetResponseTime\",\"LoadBalancer\",\"app/vandelay-alb01/946e933d1e5bbcbf\"]],\"period\":300,\"region\":\"us-east-1\",\"stat\":\"Average\",\"title\":\"Target Response Time\"},\"type\":\"metric\",\"width\":12,\"x\":0,\"y\":6},{\"height\":6,\"properties\":{\"metrics\":[[\"AWS/ApplicationELB\",\"HealthyHostCount\",\"TargetGroup\",\"targetgroup/vandelay-tg01/021c5839299908d8\",\"LoadBalancer\",\"app/vandelay-alb01/946e933d1e5bbcbf\"]],\"period\":300,\"region\":\"us-east-1\",\"stat\":\"Average\",\"title\":\"Healthy Host Count\"},\"type\":\"metric\",\"width\":12,\"x\":12,\"y\":6}]}",
            "dashboard_name": "vandelay-dashboard01",
            "id": "vandelay-dashboard01"
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_lb.vandelay_alb01",
            "aws_lb_target_group.vandelay_tg01",
            "aws_s3_bucket.vandelay_alb_logs",
            "aws_security_group.vandelay_alb_sg01",
            "aws_subnet.vandelay_public_subnets",
            "aws_vpc.vandelay_vpc01",
            "data.aws_caller_identity.current"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_cloudwatch_log_group",
      "name": "vandelay_log_group01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:logs:us-east-1:212809501772:log-group:/aws/ec2/vandelay-rds-app",
            "id": "/aws/ec2/vandelay-rds-app",
            "kms_key_id": "",
            "log_group_class": "STANDARD",
            "name": "/aws/ec2/vandelay-rds-app",
            "name_prefix": "",
            "retention_in_days": 7,
            "skip_destroy": false,
            "tags": {
              "Name": "vandelay-log-group01"
            },
            "tags_all": {
              "Name": "vandelay-log-group01"
            }
          },
          "sensitive_attributes": [],
          "private": "bnVsbA=="
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_cloudwatch_log_group",
      "name": "vandelay_waf_logs",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:logs:us-east-1:212809501772:log-group:aws-waf-logs-vandelay-webacl",
            "id": "aws-waf-logs-vandelay-webacl",
            "kms_key_id": "",
            "log_group_class": "STANDARD",
            "name": "aws-waf-logs-vandelay-webacl",
            "name_prefix": "",
            "retention_in_days": 30,
            "skip_destroy": false,
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-waf-logs"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-waf-logs"
            }
          },
          "sensitive_attributes": [],
          "private": "bnVsbA=="
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_cloudwatch_metric_alarm",
      "name": "vandelay_alb_5xx_alarm",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 1,
          "attributes": {
            "actions_enabled": true,
            "alarm_actions": [
              "arn:aws:sns:us-east-1:212809501772:vandelay-db-incidents"
            ],
            "alarm_description": "ALB 5xx errors exceeded threshold",
            "alarm_name": "vandelay-alb-5xx-alarm",
            "arn": "arn:aws:cloudwatch:us-east-1:212809501772:alarm:vandelay-alb-5xx-alarm",
            "comparison_operator": "GreaterThanThreshold",
            "datapoints_to_alarm": 0,
            "dimensions": {
              "LoadBalancer": "app/vandelay-alb01/946e933d1e5bbcbf"
            },
            "evaluate_low_sample_count_percentiles": "",
            "evaluation_periods": 2,
            "extended_statistic": "",
            "id": "vandelay-alb-5xx-alarm",
            "insufficient_data_actions": [],
            "metric_name": "HTTPCode_ELB_5XX_Count",
            "metric_query": [],
            "namespace": "AWS/ApplicationELB",
            "ok_actions": [
              "arn:aws:sns:us-east-1:212809501772:vandelay-db-incidents"
            ],
            "period": 300,
            "statistic": "Sum",
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-alb-5xx-alarm"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-alb-5xx-alarm"
            },
            "threshold": 10,
            "threshold_metric_id": "",
            "treat_missing_data": "notBreaching",
            "unit": ""
          },
          "sensitive_attributes": [],
          "private": "eyJzY2hlbWFfdmVyc2lvbiI6IjEifQ==",
          "dependencies": [
            "aws_lb.vandelay_alb01",
            "aws_s3_bucket.vandelay_alb_logs",
            "aws_security_group.vandelay_alb_sg01",
            "aws_sns_topic.vandelay_sns_topic01",
            "aws_subnet.vandelay_public_subnets",
            "aws_vpc.vandelay_vpc01",
            "data.aws_caller_identity.current"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_cloudwatch_metric_alarm",
      "name": "vandelay_db_alarm01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 1,
          "attributes": {
            "actions_enabled": true,
            "alarm_actions": [
              "arn:aws:sns:us-east-1:212809501772:vandelay-db-incidents"
            ],
            "alarm_description": "",
            "alarm_name": "vandelay-db-connection-failure",
            "arn": "arn:aws:cloudwatch:us-east-1:212809501772:alarm:vandelay-db-connection-failure",
            "comparison_operator": "GreaterThanOrEqualToThreshold",
            "datapoints_to_alarm": 0,
            "dimensions": {},
            "evaluate_low_sample_count_percentiles": "",
            "evaluation_periods": 1,
            "extended_statistic": "",
            "id": "vandelay-db-connection-failure",
            "insufficient_data_actions": [],
            "metric_name": "DBConnectionErrors",
            "metric_query": [],
            "namespace": "Lab/RDSApp",
            "ok_actions": [
              "arn:aws:sns:us-east-1:212809501772:vandelay-db-incidents"
            ],
            "period": 300,
            "statistic": "Sum",
            "tags": {
              "Name": "vandelay-alarm-db-fail"
            },
            "tags_all": {
              "Name": "vandelay-alarm-db-fail"
            },
            "threshold": 3,
            "threshold_metric_id": "",
            "treat_missing_data": "missing",
            "unit": ""
          },
          "sensitive_attributes": [],
          "private": "eyJzY2hlbWFfdmVyc2lvbiI6IjEifQ==",
          "dependencies": [
            "aws_sns_topic.vandelay_sns_topic01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_db_instance",
      "name": "vandelay_rds01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 2,
          "attributes": {
            "address": "vandelay-rds01.cmrys4aosktq.us-east-1.rds.amazonaws.com",
            "allocated_storage": 20,
            "allow_major_version_upgrade": null,
            "apply_immediately": false,
            "arn": "arn:aws:rds:us-east-1:212809501772:db:vandelay-rds01",
            "auto_minor_version_upgrade": true,
            "availability_zone": "us-east-1a",
            "backup_retention_period": 0,
            "backup_target": "region",
            "backup_window": "05:40-06:10",
            "blue_green_update": [],
            "ca_cert_identifier": "rds-ca-rsa2048-g1",
            "character_set_name": "",
            "copy_tags_to_snapshot": false,
            "custom_iam_instance_profile": "",
            "customer_owned_ip_enabled": false,
            "database_insights_mode": "standard",
            "db_name": "labmysql",
            "db_subnet_group_name": "vandelay-rds-subnet-group01",
            "dedicated_log_volume": false,
            "delete_automated_backups": true,
            "deletion_protection": false,
            "domain": "",
            "domain_auth_secret_arn": "",
            "domain_dns_ips": [],
            "domain_fqdn": "",
            "domain_iam_role_name": "",
            "domain_ou": "",
            "enabled_cloudwatch_logs_exports": [],
            "endpoint": "vandelay-rds01.cmrys4aosktq.us-east-1.rds.amazonaws.com:3306",
            "engine": "mysql",
            "engine_lifecycle_support": "open-source-rds-extended-support",
            "engine_version": "8.4.7",
            "engine_version_actual": "8.4.7",
            "final_snapshot_identifier": null,
            "hosted_zone_id": "Z2R2ITUGPM61AM",
            "iam_database_authentication_enabled": false,
            "id": "db-EXB67AKHNPP6ITKQ2OYPRPYKPA",
            "identifier": "vandelay-rds01",
            "identifier_prefix": "",
            "instance_class": "db.t3.micro",
            "iops": 0,
            "kms_key_id": "",
            "latest_restorable_time": "",
            "license_model": "general-public-license",
            "listener_endpoint": [],
            "maintenance_window": "sat:08:57-sat:09:27",
            "manage_master_user_password": null,
            "master_user_secret": [],
            "master_user_secret_kms_key_id": null,
            "max_allocated_storage": 0,
            "monitoring_interval": 0,
            "monitoring_role_arn": "",
            "multi_az": false,
            "nchar_character_set_name": "",
            "network_type": "IPV4",
            "option_group_name": "default:mysql-8-4",
            "parameter_group_name": "default.mysql8.4",
            "password": "jNhnA2DFcGrxmMtIo4EvfkQPbsxK4v8",
            "password_wo": null,
            "password_wo_version": null,
            "performance_insights_enabled": false,
            "performance_insights_kms_key_id": "",
            "performance_insights_retention_period": 0,
            "port": 3306,
            "publicly_accessible": false,
            "replica_mode": "",
            "replicas": [],
            "replicate_source_db": "",
            "resource_id": "db-EXB67AKHNPP6ITKQ2OYPRPYKPA",
            "restore_to_point_in_time": [],
            "s3_import": [],
            "skip_final_snapshot": true,
            "snapshot_identifier": null,
            "status": "available",
            "storage_encrypted": false,
            "storage_throughput": 0,
            "storage_type": "gp2",
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-rds01"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-rds01"
            },
            "timeouts": null,
            "timezone": "",
            "upgrade_storage_config": null,
            "username": "admin",
            "vpc_security_group_ids": [
              "sg-0468006e629bcfee5"
            ]
          },
          "sensitive_attributes": [
            [
              {
                "type": "get_attr",
                "value": "password"
              }
            ]
          ],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjozMDAwMDAwMDAwMDAwLCJkZWxldGUiOjM2MDAwMDAwMDAwMDAsInVwZGF0ZSI6NDgwMDAwMDAwMDAwMH0sInNjaGVtYV92ZXJzaW9uIjoiMiJ9",
          "dependencies": [
            "aws_db_subnet_group.vandelay_rds_subnet_group01",
            "aws_security_group.rotation_lambda_sg",
            "aws_security_group.vandelay_alb_sg01",
            "aws_security_group.vandelay_ec2_sg01",
            "aws_security_group.vandelay_rds_sg01",
            "aws_subnet.vandelay_private_subnets",
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_db_subnet_group",
      "name": "vandelay_rds_subnet_group01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:rds:us-east-1:212809501772:subgrp:vandelay-rds-subnet-group01",
            "description": "Managed by Terraform",
            "id": "vandelay-rds-subnet-group01",
            "name": "vandelay-rds-subnet-group01",
            "name_prefix": "",
            "subnet_ids": [
              "subnet-055b1de2d18737807",
              "subnet-0afcb35783b14f2c7"
            ],
            "supported_network_types": [
              "IPV4"
            ],
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-db-subnet-group01"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-db-subnet-group01"
            },
            "vpc_id": "vpc-0d67f2118f804df1f"
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_subnet.vandelay_private_subnets",
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_eip",
      "name": "vandelay_nat_eip01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "address": null,
            "allocation_id": "eipalloc-02b4dfa7e285d613c",
            "arn": "arn:aws:ec2:us-east-1:212809501772:elastic-ip/eipalloc-02b4dfa7e285d613c",
            "associate_with_private_ip": null,
            "association_id": "eipassoc-0f070928ce5ea99d7",
            "carrier_ip": "",
            "customer_owned_ip": "",
            "customer_owned_ipv4_pool": "",
            "domain": "vpc",
            "id": "eipalloc-02b4dfa7e285d613c",
            "instance": "",
            "ipam_pool_id": null,
            "network_border_group": "us-east-1",
            "network_interface": "eni-0bd6a080cf9099174",
            "private_dns": "ip-10-75-1-218.ec2.internal",
            "private_ip": "10.75.1.218",
            "ptr_record": "",
            "public_dns": "ec2-3-208-196-119.compute-1.amazonaws.com",
            "public_ip": "3.208.196.119",
            "public_ipv4_pool": "amazon",
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-nat-eip01"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-nat-eip01"
            },
            "timeouts": null,
            "vpc": true
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiZGVsZXRlIjoxODAwMDAwMDAwMDAsInJlYWQiOjkwMDAwMDAwMDAwMCwidXBkYXRlIjozMDAwMDAwMDAwMDB9fQ=="
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_iam_instance_profile",
      "name": "vandelay_instance_profile01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:iam::212809501772:instance-profile/vandelay-instance-profile01",
            "create_date": "2026-01-30T23:29:16Z",
            "id": "vandelay-instance-profile01",
            "name": "vandelay-instance-profile01",
            "name_prefix": "",
            "path": "/",
            "role": "vandelay-ec2-role01",
            "tags": {},
            "tags_all": {},
            "unique_id": "AIPATDDDPJRGIM4TTB6GI"
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_iam_role.vandelay_ec2_role01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_iam_policy",
      "name": "vandelay_leastpriv_cwlogs01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:iam::212809501772:policy/vandelay-lp-cwlogs01",
            "attachment_count": 1,
            "description": "Least-privilege CloudWatch Logs write for the app log group",
            "id": "arn:aws:iam::212809501772:policy/vandelay-lp-cwlogs01",
            "name": "vandelay-lp-cwlogs01",
            "name_prefix": "",
            "path": "/",
            "policy": "{\"Statement\":[{\"Action\":[\"logs:CreateLogStream\",\"logs:PutLogEvents\",\"logs:DescribeLogStreams\"],\"Effect\":\"Allow\",\"Resource\":[\"arn:aws:logs:us-east-1:212809501772:log-group:/aws/ec2/vandelay-rds-app:*\"],\"Sid\":\"WriteLogs\"}],\"Version\":\"2012-10-17\"}",
            "policy_id": "ANPATDDDPJRGAKUGPGVZD",
            "tags": {},
            "tags_all": {}
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_cloudwatch_log_group.vandelay_log_group01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_iam_policy",
      "name": "vandelay_leastpriv_read_params01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:iam::212809501772:policy/vandelay-lp-ssm-read01",
            "attachment_count": 1,
            "description": "Least-privilege read for SSM Parameter Store under /lab/db/*",
            "id": "arn:aws:iam::212809501772:policy/vandelay-lp-ssm-read01",
            "name": "vandelay-lp-ssm-read01",
            "name_prefix": "",
            "path": "/",
            "policy": "{\"Statement\":[{\"Action\":[\"ssm:GetParameter\",\"ssm:GetParameters\",\"ssm:GetParametersByPath\"],\"Effect\":\"Allow\",\"Resource\":[\"arn:aws:ssm:us-east-1:212809501772:parameter/lab/db/*\"],\"Sid\":\"ReadLabDbParams\"}],\"Version\":\"2012-10-17\"}",
            "policy_id": "ANPATDDDPJRGNOIVJKTN3",
            "tags": {},
            "tags_all": {}
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "data.aws_caller_identity.vandelay_self01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_iam_policy",
      "name": "vandelay_leastpriv_read_secret01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:iam::212809501772:policy/vandelay-lp-secrets-read01",
            "attachment_count": 1,
            "description": "Least-privilege read for the lab DB secret",
            "id": "arn:aws:iam::212809501772:policy/vandelay-lp-secrets-read01",
            "name": "vandelay-lp-secrets-read01",
            "name_prefix": "",
            "path": "/",
            "policy": "{\"Statement\":[{\"Action\":[\"secretsmanager:GetSecretValue\",\"secretsmanager:DescribeSecret\"],\"Effect\":\"Allow\",\"Resource\":\"arn:aws:secretsmanager:us-east-1:212809501772:secret:lab/rds/mysql-x7lYie*\",\"Sid\":\"ReadOnlyLabSecret\"}],\"Version\":\"2012-10-17\"}",
            "policy_id": "ANPATDDDPJRGDNAZIMB5A",
            "tags": {},
            "tags_all": {}
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "data.aws_secretsmanager_secret.vandelay_db_secret01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_iam_role",
      "name": "incident_reporter_role",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:iam::212809501772:role/vandelay-incident-reporter-role",
            "assume_role_policy": "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"lambda.amazonaws.com\"}}],\"Version\":\"2012-10-17\"}",
            "create_date": "2026-01-30T23:29:15Z",
            "description": "",
            "force_detach_policies": false,
            "id": "vandelay-incident-reporter-role",
            "inline_policy": [
              {
                "name": "vandelay-incident-reporter-bedrock",
                "policy": "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Action\":[\"bedrock:InvokeModel\",\"bedrock:InvokeModelWithResponseStream\"],\"Effect\":\"Allow\",\"Resource\":[\"arn:aws:bedrock:us-east-1::foundation-model/anthropic.claude-3-haiku-20240307-v1:0\",\"arn:aws:bedrock:us-east-1::foundation-model/anthropic.claude-3-sonnet-20240229-v1:0\",\"arn:aws:bedrock:us-east-1::foundation-model/anthropic.claude-instant-v1\"],\"Sid\":\"BedrockInvoke\"}]}"
              },
              {
                "name": "vandelay-incident-reporter-logs",
                "policy": "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Action\":[\"logs:StartQuery\",\"logs:GetQueryResults\",\"logs:DescribeLogGroups\",\"logs:DescribeLogStreams\",\"logs:GetLogEvents\"],\"Effect\":\"Allow\",\"Resource\":\"*\",\"Sid\":\"LogsInsightsQuery\"}]}"
              },
              {
                "name": "vandelay-incident-reporter-s3",
                "policy": "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Action\":[\"s3:PutObject\",\"s3:GetObject\",\"s3:ListBucket\"],\"Effect\":\"Allow\",\"Resource\":[\"arn:aws:s3:::vandelay-incident-reports-212809501772\",\"arn:aws:s3:::vandelay-incident-reports-212809501772/*\"],\"Sid\":\"S3WriteReports\"}]}"
              },
              {
                "name": "vandelay-incident-reporter-secrets",
                "policy": "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Action\":[\"secretsmanager:GetSecretValue\",\"secretsmanager:DescribeSecret\"],\"Effect\":\"Allow\",\"Resource\":\"arn:aws:secretsmanager:us-east-1:212809501772:secret:lab/rds/mysql-x7lYie\",\"Sid\":\"SecretsRead\"}]}"
              },
              {
                "name": "vandelay-incident-reporter-sns",
                "policy": "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Action\":\"sns:Publish\",\"Effect\":\"Allow\",\"Resource\":\"arn:aws:sns:us-east-1:212809501772:vandelay-db-incidents\",\"Sid\":\"SNSPublish\"}]}"
              },
              {
                "name": "vandelay-incident-reporter-ssm",
                "policy": "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Action\":[\"ssm:GetParameter\",\"ssm:GetParameters\",\"ssm:GetParametersByPath\"],\"Effect\":\"Allow\",\"Resource\":\"arn:aws:ssm:us-east-1:212809501772:parameter/lab/*\",\"Sid\":\"SSMReadParams\"}]}"
              }
            ],
            "managed_policy_arns": [
              "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
            ],
            "max_session_duration": 3600,
            "name": "vandelay-incident-reporter-role",
            "name_prefix": "",
            "path": "/",
            "permissions_boundary": "",
            "tags": {
              "Lab": "ec2-rds-integration"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration"
            },
            "unique_id": "AROATDDDPJRGM5WNJUT7A"
          },
          "sensitive_attributes": [],
          "private": "bnVsbA=="
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_iam_role",
      "name": "rotation_lambda_role",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:iam::212809501772:role/vandelay-rotation-lambda-role",
            "assume_role_policy": "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"lambda.amazonaws.com\"}}],\"Version\":\"2012-10-17\"}",
            "create_date": "2026-01-30T23:29:15Z",
            "description": "",
            "force_detach_policies": false,
            "id": "vandelay-rotation-lambda-role",
            "inline_policy": [
              {
                "name": "vandelay-rotation-lambda-policy",
                "policy": "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Action\":[\"secretsmanager:DescribeSecret\",\"secretsmanager:GetSecretValue\",\"secretsmanager:PutSecretValue\",\"secretsmanager:UpdateSecretVersionStage\"],\"Effect\":\"Allow\",\"Resource\":\"arn:aws:secretsmanager:us-east-1:212809501772:secret:lab/rds/mysql-x7lYie\"},{\"Action\":[\"secretsmanager:GetRandomPassword\"],\"Effect\":\"Allow\",\"Resource\":\"*\"},{\"Action\":[\"rds:DescribeDBInstances\",\"rds:DescribeDBClusters\"],\"Effect\":\"Allow\",\"Resource\":\"*\"}]}"
              }
            ],
            "managed_policy_arns": [
              "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
              "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
            ],
            "max_session_duration": 3600,
            "name": "vandelay-rotation-lambda-role",
            "name_prefix": "",
            "path": "/",
            "permissions_boundary": "",
            "tags": {
              "Lab": "ec2-rds-integration"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration"
            },
            "unique_id": "AROATDDDPJRGIU4I6JG4Q"
          },
          "sensitive_attributes": [],
          "private": "bnVsbA=="
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_iam_role",
      "name": "vandelay_ec2_role01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:iam::212809501772:role/vandelay-ec2-role01",
            "assume_role_policy": "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"ec2.amazonaws.com\"}}],\"Version\":\"2012-10-17\"}",
            "create_date": "2026-01-30T23:29:15Z",
            "description": "",
            "force_detach_policies": false,
            "id": "vandelay-ec2-role01",
            "inline_policy": [
              {
                "name": "vandelay-ec2-read-secret-policy",
                "policy": "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Action\":[\"secretsmanager:GetSecretValue\"],\"Effect\":\"Allow\",\"Resource\":\"arn:aws:secretsmanager:us-east-1:212809501772:secret:lab/rds/mysql-x7lYie*\",\"Sid\":\"ReadSpecificSecret\"}]}"
              }
            ],
            "managed_policy_arns": [
              "arn:aws:iam::212809501772:policy/vandelay-lp-cwlogs01",
              "arn:aws:iam::212809501772:policy/vandelay-lp-secrets-read01",
              "arn:aws:iam::212809501772:policy/vandelay-lp-ssm-read01",
              "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
              "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
            ],
            "max_session_duration": 3600,
            "name": "vandelay-ec2-role01",
            "name_prefix": "",
            "path": "/",
            "permissions_boundary": "",
            "tags": {},
            "tags_all": {},
            "unique_id": "AROATDDDPJRGENCGEDBPL"
          },
          "sensitive_attributes": [],
          "private": "bnVsbA=="
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_iam_role_policy",
      "name": "incident_reporter_bedrock",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "id": "vandelay-incident-reporter-role:vandelay-incident-reporter-bedrock",
            "name": "vandelay-incident-reporter-bedrock",
            "name_prefix": "",
            "policy": "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Action\":[\"bedrock:InvokeModel\",\"bedrock:InvokeModelWithResponseStream\"],\"Effect\":\"Allow\",\"Resource\":[\"arn:aws:bedrock:us-east-1::foundation-model/anthropic.claude-3-haiku-20240307-v1:0\",\"arn:aws:bedrock:us-east-1::foundation-model/anthropic.claude-3-sonnet-20240229-v1:0\",\"arn:aws:bedrock:us-east-1::foundation-model/anthropic.claude-instant-v1\"],\"Sid\":\"BedrockInvoke\"}]}",
            "role": "vandelay-incident-reporter-role"
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_iam_role.incident_reporter_role"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_iam_role_policy",
      "name": "incident_reporter_logs",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "id": "vandelay-incident-reporter-role:vandelay-incident-reporter-logs",
            "name": "vandelay-incident-reporter-logs",
            "name_prefix": "",
            "policy": "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Action\":[\"logs:StartQuery\",\"logs:GetQueryResults\",\"logs:DescribeLogGroups\",\"logs:DescribeLogStreams\",\"logs:GetLogEvents\"],\"Effect\":\"Allow\",\"Resource\":\"*\",\"Sid\":\"LogsInsightsQuery\"}]}",
            "role": "vandelay-incident-reporter-role"
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_iam_role.incident_reporter_role"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_iam_role_policy",
      "name": "incident_reporter_s3",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "id": "vandelay-incident-reporter-role:vandelay-incident-reporter-s3",
            "name": "vandelay-incident-reporter-s3",
            "name_prefix": "",
            "policy": "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Action\":[\"s3:PutObject\",\"s3:GetObject\",\"s3:ListBucket\"],\"Effect\":\"Allow\",\"Resource\":[\"arn:aws:s3:::vandelay-incident-reports-212809501772\",\"arn:aws:s3:::vandelay-incident-reports-212809501772/*\"],\"Sid\":\"S3WriteReports\"}]}",
            "role": "vandelay-incident-reporter-role"
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_iam_role.incident_reporter_role",
            "aws_s3_bucket.incident_reports",
            "data.aws_caller_identity.current"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_iam_role_policy",
      "name": "incident_reporter_secrets",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "id": "vandelay-incident-reporter-role:vandelay-incident-reporter-secrets",
            "name": "vandelay-incident-reporter-secrets",
            "name_prefix": "",
            "policy": "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Action\":[\"secretsmanager:GetSecretValue\",\"secretsmanager:DescribeSecret\"],\"Effect\":\"Allow\",\"Resource\":\"arn:aws:secretsmanager:us-east-1:212809501772:secret:lab/rds/mysql-x7lYie\",\"Sid\":\"SecretsRead\"}]}",
            "role": "vandelay-incident-reporter-role"
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_iam_role.incident_reporter_role",
            "data.aws_secretsmanager_secret.vandelay_db_secret01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_iam_role_policy",
      "name": "incident_reporter_sns",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "id": "vandelay-incident-reporter-role:vandelay-incident-reporter-sns",
            "name": "vandelay-incident-reporter-sns",
            "name_prefix": "",
            "policy": "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Action\":\"sns:Publish\",\"Effect\":\"Allow\",\"Resource\":\"arn:aws:sns:us-east-1:212809501772:vandelay-db-incidents\",\"Sid\":\"SNSPublish\"}]}",
            "role": "vandelay-incident-reporter-role"
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_iam_role.incident_reporter_role",
            "aws_sns_topic.vandelay_sns_topic01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_iam_role_policy",
      "name": "incident_reporter_ssm",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "id": "vandelay-incident-reporter-role:vandelay-incident-reporter-ssm",
            "name": "vandelay-incident-reporter-ssm",
            "name_prefix": "",
            "policy": "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Action\":[\"ssm:GetParameter\",\"ssm:GetParameters\",\"ssm:GetParametersByPath\"],\"Effect\":\"Allow\",\"Resource\":\"arn:aws:ssm:us-east-1:212809501772:parameter/lab/*\",\"Sid\":\"SSMReadParams\"}]}",
            "role": "vandelay-incident-reporter-role"
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_iam_role.incident_reporter_role",
            "data.aws_caller_identity.current"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_iam_role_policy",
      "name": "rotation_lambda_policy",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "id": "vandelay-rotation-lambda-role:vandelay-rotation-lambda-policy",
            "name": "vandelay-rotation-lambda-policy",
            "name_prefix": "",
            "policy": "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Action\":[\"secretsmanager:DescribeSecret\",\"secretsmanager:GetSecretValue\",\"secretsmanager:PutSecretValue\",\"secretsmanager:UpdateSecretVersionStage\"],\"Effect\":\"Allow\",\"Resource\":\"arn:aws:secretsmanager:us-east-1:212809501772:secret:lab/rds/mysql-x7lYie\"},{\"Action\":[\"secretsmanager:GetRandomPassword\"],\"Effect\":\"Allow\",\"Resource\":\"*\"},{\"Action\":[\"rds:DescribeDBInstances\",\"rds:DescribeDBClusters\"],\"Effect\":\"Allow\",\"Resource\":\"*\"}]}",
            "role": "vandelay-rotation-lambda-role"
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_iam_role.rotation_lambda_role",
            "data.aws_secretsmanager_secret.vandelay_db_secret01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_iam_role_policy",
      "name": "vandelay_ec2_read_secret",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "id": "vandelay-ec2-role01:vandelay-ec2-read-secret-policy",
            "name": "vandelay-ec2-read-secret-policy",
            "name_prefix": "",
            "policy": "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Action\":[\"secretsmanager:GetSecretValue\"],\"Effect\":\"Allow\",\"Resource\":\"arn:aws:secretsmanager:us-east-1:212809501772:secret:lab/rds/mysql-x7lYie*\",\"Sid\":\"ReadSpecificSecret\"}]}",
            "role": "vandelay-ec2-role01"
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_iam_role.vandelay_ec2_role01",
            "data.aws_secretsmanager_secret.vandelay_db_secret01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_iam_role_policy_attachment",
      "name": "incident_reporter_basic",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "id": "vandelay-incident-reporter-role-20260130232916625100000005",
            "policy_arn": "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
            "role": "vandelay-incident-reporter-role"
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_iam_role.incident_reporter_role"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_iam_role_policy_attachment",
      "name": "rotation_lambda_basic",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "id": "vandelay-rotation-lambda-role-20260130232916880800000007",
            "policy_arn": "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
            "role": "vandelay-rotation-lambda-role"
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_iam_role.rotation_lambda_role"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_iam_role_policy_attachment",
      "name": "rotation_lambda_vpc",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "id": "vandelay-rotation-lambda-role-20260130232916876500000006",
            "policy_arn": "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
            "role": "vandelay-rotation-lambda-role"
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_iam_role.rotation_lambda_role"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_iam_role_policy_attachment",
      "name": "vandelay_attach_lp_cwlogs01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "id": "vandelay-ec2-role01-20260130232917689700000009",
            "policy_arn": "arn:aws:iam::212809501772:policy/vandelay-lp-cwlogs01",
            "role": "vandelay-ec2-role01"
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_cloudwatch_log_group.vandelay_log_group01",
            "aws_iam_policy.vandelay_leastpriv_cwlogs01",
            "aws_iam_role.vandelay_ec2_role01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_iam_role_policy_attachment",
      "name": "vandelay_attach_lp_params01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "id": "vandelay-ec2-role01-20260130232917147100000008",
            "policy_arn": "arn:aws:iam::212809501772:policy/vandelay-lp-ssm-read01",
            "role": "vandelay-ec2-role01"
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_iam_policy.vandelay_leastpriv_read_params01",
            "aws_iam_role.vandelay_ec2_role01",
            "data.aws_caller_identity.vandelay_self01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_iam_role_policy_attachment",
      "name": "vandelay_attach_lp_secret01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "id": "vandelay-ec2-role01-20260130232916123000000002",
            "policy_arn": "arn:aws:iam::212809501772:policy/vandelay-lp-secrets-read01",
            "role": "vandelay-ec2-role01"
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_iam_policy.vandelay_leastpriv_read_secret01",
            "aws_iam_role.vandelay_ec2_role01",
            "data.aws_secretsmanager_secret.vandelay_db_secret01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_iam_role_policy_attachment",
      "name": "vandelay_ec2_cw_attach",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "id": "vandelay-ec2-role01-20260130232916344800000004",
            "policy_arn": "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy",
            "role": "vandelay-ec2-role01"
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_iam_role.vandelay_ec2_role01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_iam_role_policy_attachment",
      "name": "vandelay_ec2_ssm_attach",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "id": "vandelay-ec2-role01-20260130232916335600000003",
            "policy_arn": "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
            "role": "vandelay-ec2-role01"
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_iam_role.vandelay_ec2_role01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_instance",
      "name": "vandelay_ec201",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 1,
          "attributes": {
            "ami": "ami-0532be01f26a3de55",
            "arn": "arn:aws:ec2:us-east-1:212809501772:instance/i-00afae72bb49040b6",
            "associate_public_ip_address": true,
            "availability_zone": "us-east-1a",
            "capacity_reservation_specification": [
              {
                "capacity_reservation_preference": "open",
                "capacity_reservation_target": []
              }
            ],
            "cpu_core_count": 1,
            "cpu_options": [
              {
                "amd_sev_snp": "",
                "core_count": 1,
                "threads_per_core": 2
              }
            ],
            "cpu_threads_per_core": 2,
            "credit_specification": [
              {
                "cpu_credits": "unlimited"
              }
            ],
            "disable_api_stop": false,
            "disable_api_termination": false,
            "ebs_block_device": [],
            "ebs_optimized": false,
            "enable_primary_ipv6": null,
            "enclave_options": [
              {
                "enabled": false
              }
            ],
            "ephemeral_block_device": [],
            "get_password_data": false,
            "hibernation": false,
            "host_id": "",
            "host_resource_group_arn": null,
            "iam_instance_profile": "vandelay-instance-profile01",
            "id": "i-00afae72bb49040b6",
            "instance_initiated_shutdown_behavior": "stop",
            "instance_lifecycle": "",
            "instance_market_options": [],
            "instance_state": "running",
            "instance_type": "t3.micro",
            "ipv6_address_count": 0,
            "ipv6_addresses": [],
            "key_name": "",
            "launch_template": [],
            "maintenance_options": [
              {
                "auto_recovery": "default"
              }
            ],
            "metadata_options": [
              {
                "http_endpoint": "enabled",
                "http_protocol_ipv6": "disabled",
                "http_put_response_hop_limit": 2,
                "http_tokens": "required",
                "instance_metadata_tags": "disabled"
              }
            ],
            "monitoring": false,
            "network_interface": [],
            "outpost_arn": "",
            "password_data": "",
            "placement_group": "",
            "placement_partition_number": 0,
            "primary_network_interface_id": "eni-02d349767e3196e30",
            "private_dns": "ip-10-75-1-110.ec2.internal",
            "private_dns_name_options": [
              {
                "enable_resource_name_dns_a_record": false,
                "enable_resource_name_dns_aaaa_record": false,
                "hostname_type": "ip-name"
              }
            ],
            "private_ip": "10.75.1.110",
            "public_dns": "ec2-34-239-0-106.compute-1.amazonaws.com",
            "public_ip": "34.239.0.106",
            "root_block_device": [
              {
                "delete_on_termination": true,
                "device_name": "/dev/xvda",
                "encrypted": false,
                "iops": 3000,
                "kms_key_id": "",
                "tags": {},
                "tags_all": {},
                "throughput": 125,
                "volume_id": "vol-061bcd21ffb39948c",
                "volume_size": 8,
                "volume_type": "gp3"
              }
            ],
            "secondary_private_ips": [],
            "security_groups": [],
            "source_dest_check": true,
            "spot_instance_request_id": "",
            "subnet_id": "subnet-07aca3968a20186e1",
            "tags": {
              "Name": "vandelay-ec201"
            },
            "tags_all": {
              "Name": "vandelay-ec201"
            },
            "tenancy": "default",
            "timeouts": null,
            "user_data": "5526a75ad02e59abe3ed747d20060b1a63b04d64",
            "user_data_base64": null,
            "user_data_replace_on_change": false,
            "volume_tags": null,
            "vpc_security_group_ids": [
              "sg-00aa1fb4c080b975b"
            ]
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6MTIwMDAwMDAwMDAwMCwicmVhZCI6OTAwMDAwMDAwMDAwLCJ1cGRhdGUiOjYwMDAwMDAwMDAwMH0sInNjaGVtYV92ZXJzaW9uIjoiMSJ9",
          "dependencies": [
            "aws_iam_instance_profile.vandelay_instance_profile01",
            "aws_iam_role.vandelay_ec2_role01",
            "aws_security_group.vandelay_alb_sg01",
            "aws_security_group.vandelay_ec2_sg01",
            "aws_subnet.vandelay_public_subnets",
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_instance",
      "name": "vandelay_ec201_private_bonus",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 1,
          "attributes": {
            "ami": "ami-0532be01f26a3de55",
            "arn": "arn:aws:ec2:us-east-1:212809501772:instance/i-03c11c546c8dfaf66",
            "associate_public_ip_address": false,
            "availability_zone": "us-east-1a",
            "capacity_reservation_specification": [
              {
                "capacity_reservation_preference": "open",
                "capacity_reservation_target": []
              }
            ],
            "cpu_core_count": 1,
            "cpu_options": [
              {
                "amd_sev_snp": "",
                "core_count": 1,
                "threads_per_core": 2
              }
            ],
            "cpu_threads_per_core": 2,
            "credit_specification": [
              {
                "cpu_credits": "unlimited"
              }
            ],
            "disable_api_stop": false,
            "disable_api_termination": false,
            "ebs_block_device": [],
            "ebs_optimized": false,
            "enable_primary_ipv6": null,
            "enclave_options": [
              {
                "enabled": false
              }
            ],
            "ephemeral_block_device": [],
            "get_password_data": false,
            "hibernation": false,
            "host_id": "",
            "host_resource_group_arn": null,
            "iam_instance_profile": "vandelay-instance-profile01",
            "id": "i-03c11c546c8dfaf66",
            "instance_initiated_shutdown_behavior": "stop",
            "instance_lifecycle": "",
            "instance_market_options": [],
            "instance_state": "running",
            "instance_type": "t3.micro",
            "ipv6_address_count": 0,
            "ipv6_addresses": [],
            "key_name": "",
            "launch_template": [],
            "maintenance_options": [
              {
                "auto_recovery": "default"
              }
            ],
            "metadata_options": [
              {
                "http_endpoint": "enabled",
                "http_protocol_ipv6": "disabled",
                "http_put_response_hop_limit": 2,
                "http_tokens": "required",
                "instance_metadata_tags": "disabled"
              }
            ],
            "monitoring": false,
            "network_interface": [],
            "outpost_arn": "",
            "password_data": "",
            "placement_group": "",
            "placement_partition_number": 0,
            "primary_network_interface_id": "eni-0898202721237113e",
            "private_dns": "ip-10-75-101-85.ec2.internal",
            "private_dns_name_options": [
              {
                "enable_resource_name_dns_a_record": false,
                "enable_resource_name_dns_aaaa_record": false,
                "hostname_type": "ip-name"
              }
            ],
            "private_ip": "10.75.101.85",
            "public_dns": "",
            "public_ip": "",
            "root_block_device": [
              {
                "delete_on_termination": true,
                "device_name": "/dev/xvda",
                "encrypted": false,
                "iops": 3000,
                "kms_key_id": "",
                "tags": {},
                "tags_all": {},
                "throughput": 125,
                "volume_id": "vol-088acf1d14e9fd63e",
                "volume_size": 8,
                "volume_type": "gp3"
              }
            ],
            "secondary_private_ips": [],
            "security_groups": [],
            "source_dest_check": true,
            "spot_instance_request_id": "",
            "subnet_id": "subnet-0afcb35783b14f2c7",
            "tags": {
              "Name": "vandelay-ec201-private"
            },
            "tags_all": {
              "Name": "vandelay-ec201-private"
            },
            "tenancy": "default",
            "timeouts": null,
            "user_data": "5526a75ad02e59abe3ed747d20060b1a63b04d64",
            "user_data_base64": null,
            "user_data_replace_on_change": false,
            "volume_tags": null,
            "vpc_security_group_ids": [
              "sg-00aa1fb4c080b975b"
            ]
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6MTIwMDAwMDAwMDAwMCwicmVhZCI6OTAwMDAwMDAwMDAwLCJ1cGRhdGUiOjYwMDAwMDAwMDAwMH0sInNjaGVtYV92ZXJzaW9uIjoiMSJ9",
          "dependencies": [
            "aws_iam_instance_profile.vandelay_instance_profile01",
            "aws_iam_role.vandelay_ec2_role01",
            "aws_security_group.vandelay_alb_sg01",
            "aws_security_group.vandelay_ec2_sg01",
            "aws_subnet.vandelay_private_subnets",
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_internet_gateway",
      "name": "vandelay_igw01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:ec2:us-east-1:212809501772:internet-gateway/igw-03e260271fcb8c9a7",
            "id": "igw-03e260271fcb8c9a7",
            "owner_id": "212809501772",
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-igw"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-igw"
            },
            "timeouts": null,
            "vpc_id": "vpc-0d67f2118f804df1f"
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInVwZGF0ZSI6MTIwMDAwMDAwMDAwMH19",
          "dependencies": [
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_lambda_function",
      "name": "incident_reporter",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "architectures": [
              "x86_64"
            ],
            "arn": "arn:aws:lambda:us-east-1:212809501772:function:vandelay-incident-reporter",
            "code_sha256": "ji+axdSjgmlLAkvXlbDXnFDb+yTc7ahog/OV1YvFm5A=",
            "code_signing_config_arn": "",
            "dead_letter_config": [],
            "description": "",
            "environment": [
              {
                "variables": {
                  "APP_LOG_GROUP": "/aws/ec2/vandelay-rds-app",
                  "BEDROCK_MODEL_ID": "anthropic.claude-3-haiku-20240307-v1:0",
                  "REPORT_BUCKET": "vandelay-incident-reports-212809501772",
                  "SECRET_ID": "lab/rds/mysql",
                  "SNS_TOPIC_ARN": "arn:aws:sns:us-east-1:212809501772:vandelay-db-incidents",
                  "SSM_PARAM_PATH": "/lab/db",
                  "WAF_LOG_GROUP": ""
                }
              }
            ],
            "ephemeral_storage": [
              {
                "size": 512
              }
            ],
            "file_system_config": [],
            "filename": "./lambda/incident_reporter.zip",
            "function_name": "vandelay-incident-reporter",
            "handler": "handler.lambda_handler",
            "id": "vandelay-incident-reporter",
            "image_config": [],
            "image_uri": "",
            "invoke_arn": "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:212809501772:function:vandelay-incident-reporter/invocations",
            "kms_key_arn": "",
            "last_modified": "2026-01-30T23:29:27.040+0000",
            "layers": [],
            "logging_config": [
              {
                "application_log_level": "",
                "log_format": "Text",
                "log_group": "/aws/lambda/vandelay-incident-reporter",
                "system_log_level": ""
              }
            ],
            "memory_size": 256,
            "package_type": "Zip",
            "publish": false,
            "qualified_arn": "arn:aws:lambda:us-east-1:212809501772:function:vandelay-incident-reporter:$LATEST",
            "qualified_invoke_arn": "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:212809501772:function:vandelay-incident-reporter:$LATEST/invocations",
            "replace_security_groups_on_destroy": null,
            "replacement_security_group_ids": null,
            "reserved_concurrent_executions": -1,
            "role": "arn:aws:iam::212809501772:role/vandelay-incident-reporter-role",
            "runtime": "python3.11",
            "s3_bucket": null,
            "s3_key": null,
            "s3_object_version": null,
            "signing_job_arn": "",
            "signing_profile_version_arn": "",
            "skip_destroy": false,
            "snap_start": [],
            "source_code_hash": "ji+axdSjgmlLAkvXlbDXnFDb+yTc7ahog/OV1YvFm5A=",
            "source_code_size": 10852,
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-incident-reporter"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-incident-reporter"
            },
            "timeout": 120,
            "timeouts": null,
            "tracing_config": [
              {
                "mode": "PassThrough"
              }
            ],
            "version": "$LATEST",
            "vpc_config": []
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6NjAwMDAwMDAwMDAwLCJ1cGRhdGUiOjYwMDAwMDAwMDAwMH19",
          "dependencies": [
            "aws_cloudwatch_log_group.vandelay_log_group01",
            "aws_iam_role.incident_reporter_role",
            "aws_s3_bucket.incident_reports",
            "aws_sns_topic.vandelay_sns_topic01",
            "data.archive_file.incident_reporter_zip",
            "data.aws_caller_identity.current"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_lambda_permission",
      "name": "incident_reporter_sns",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "action": "lambda:InvokeFunction",
            "event_source_token": null,
            "function_name": "vandelay-incident-reporter",
            "function_url_auth_type": null,
            "id": "AllowSNSInvoke",
            "principal": "sns.amazonaws.com",
            "principal_org_id": null,
            "qualifier": "",
            "source_account": null,
            "source_arn": "arn:aws:sns:us-east-1:212809501772:vandelay-db-incidents",
            "statement_id": "AllowSNSInvoke",
            "statement_id_prefix": ""
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_cloudwatch_log_group.vandelay_log_group01",
            "aws_iam_role.incident_reporter_role",
            "aws_lambda_function.incident_reporter",
            "aws_s3_bucket.incident_reports",
            "aws_sns_topic.vandelay_sns_topic01",
            "data.archive_file.incident_reporter_zip",
            "data.aws_caller_identity.current"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_lambda_permission",
      "name": "secrets_manager_rotation",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "action": "lambda:InvokeFunction",
            "event_source_token": null,
            "function_name": "vandelay-mysql-rotation-lambda",
            "function_url_auth_type": null,
            "id": "AllowSecretsManagerInvocation",
            "principal": "secretsmanager.amazonaws.com",
            "principal_org_id": null,
            "qualifier": "",
            "source_account": null,
            "source_arn": null,
            "statement_id": "AllowSecretsManagerInvocation",
            "statement_id_prefix": ""
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_security_group.rotation_lambda_sg",
            "aws_serverlessapplicationrepository_cloudformation_stack.rotation_lambda",
            "aws_subnet.vandelay_private_subnets",
            "aws_vpc.vandelay_vpc01",
            "data.aws_serverlessapplicationrepository_application.secrets_manager_rotation"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_lb",
      "name": "vandelay_alb01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "access_logs": [
              {
                "bucket": "vandelay-alb-logs-212809501772",
                "enabled": true,
                "prefix": "alb-logs"
              }
            ],
            "arn": "arn:aws:elasticloadbalancing:us-east-1:212809501772:loadbalancer/app/vandelay-alb01/946e933d1e5bbcbf",
            "arn_suffix": "app/vandelay-alb01/946e933d1e5bbcbf",
            "client_keep_alive": 3600,
            "connection_logs": [
              {
                "bucket": "",
                "enabled": false,
                "prefix": ""
              }
            ],
            "customer_owned_ipv4_pool": "",
            "desync_mitigation_mode": "defensive",
            "dns_name": "vandelay-alb01-398570023.us-east-1.elb.amazonaws.com",
            "dns_record_client_routing_policy": null,
            "drop_invalid_header_fields": false,
            "enable_cross_zone_load_balancing": true,
            "enable_deletion_protection": false,
            "enable_http2": true,
            "enable_tls_version_and_cipher_suite_headers": false,
            "enable_waf_fail_open": false,
            "enable_xff_client_port": false,
            "enable_zonal_shift": false,
            "enforce_security_group_inbound_rules_on_private_link_traffic": "",
            "id": "arn:aws:elasticloadbalancing:us-east-1:212809501772:loadbalancer/app/vandelay-alb01/946e933d1e5bbcbf",
            "idle_timeout": 60,
            "internal": false,
            "ip_address_type": "ipv4",
            "ipam_pools": [],
            "load_balancer_type": "application",
            "minimum_load_balancer_capacity": [],
            "name": "vandelay-alb01",
            "name_prefix": "",
            "preserve_host_header": false,
            "security_groups": [
              "sg-072d57058808b322b"
            ],
            "subnet_mapping": [
              {
                "allocation_id": "",
                "ipv6_address": "",
                "outpost_id": "",
                "private_ipv4_address": "",
                "subnet_id": "subnet-023c3131fec823b62"
              },
              {
                "allocation_id": "",
                "ipv6_address": "",
                "outpost_id": "",
                "private_ipv4_address": "",
                "subnet_id": "subnet-07aca3968a20186e1"
              }
            ],
            "subnets": [
              "subnet-023c3131fec823b62",
              "subnet-07aca3968a20186e1"
            ],
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-alb01"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-alb01"
            },
            "timeouts": null,
            "vpc_id": "vpc-0d67f2118f804df1f",
            "xff_header_processing_mode": "append",
            "zone_id": "Z35SXDOTRQ7X7K"
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6NjAwMDAwMDAwMDAwLCJ1cGRhdGUiOjYwMDAwMDAwMDAwMH19",
          "dependencies": [
            "aws_s3_bucket.vandelay_alb_logs",
            "aws_security_group.vandelay_alb_sg01",
            "aws_subnet.vandelay_public_subnets"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_lb_listener",
      "name": "vandelay_http_listener",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "alpn_policy": null,
            "arn": "arn:aws:elasticloadbalancing:us-east-1:212809501772:listener/app/vandelay-alb01/946e933d1e5bbcbf/bcfa1f0f7f3b5ef3",
            "certificate_arn": null,
            "default_action": [
              {
                "authenticate_cognito": [],
                "authenticate_oidc": [],
                "fixed_response": [],
                "forward": [],
                "order": 1,
                "redirect": [
                  {
                    "host": "#{host}",
                    "path": "/#{path}",
                    "port": "443",
                    "protocol": "HTTPS",
                    "query": "#{query}",
                    "status_code": "HTTP_301"
                  }
                ],
                "target_group_arn": "",
                "type": "redirect"
              }
            ],
            "id": "arn:aws:elasticloadbalancing:us-east-1:212809501772:listener/app/vandelay-alb01/946e933d1e5bbcbf/bcfa1f0f7f3b5ef3",
            "load_balancer_arn": "arn:aws:elasticloadbalancing:us-east-1:212809501772:loadbalancer/app/vandelay-alb01/946e933d1e5bbcbf",
            "mutual_authentication": [],
            "port": 80,
            "protocol": "HTTP",
            "routing_http_request_x_amzn_mtls_clientcert_header_name": null,
            "routing_http_request_x_amzn_mtls_clientcert_issuer_header_name": null,
            "routing_http_request_x_amzn_mtls_clientcert_leaf_header_name": null,
            "routing_http_request_x_amzn_mtls_clientcert_serial_number_header_name": null,
            "routing_http_request_x_amzn_mtls_clientcert_subject_header_name": null,
            "routing_http_request_x_amzn_mtls_clientcert_validity_header_name": null,
            "routing_http_request_x_amzn_tls_cipher_suite_header_name": null,
            "routing_http_request_x_amzn_tls_version_header_name": null,
            "routing_http_response_access_control_allow_credentials_header_value": "",
            "routing_http_response_access_control_allow_headers_header_value": "",
            "routing_http_response_access_control_allow_methods_header_value": "",
            "routing_http_response_access_control_allow_origin_header_value": "",
            "routing_http_response_access_control_expose_headers_header_value": "",
            "routing_http_response_access_control_max_age_header_value": "",
            "routing_http_response_content_security_policy_header_value": "",
            "routing_http_response_server_enabled": true,
            "routing_http_response_strict_transport_security_header_value": "",
            "routing_http_response_x_content_type_options_header_value": "",
            "routing_http_response_x_frame_options_header_value": "",
            "ssl_policy": "",
            "tags": {},
            "tags_all": {},
            "tcp_idle_timeout_seconds": null,
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjozMDAwMDAwMDAwMDAsInVwZGF0ZSI6MzAwMDAwMDAwMDAwfX0=",
          "dependencies": [
            "aws_lb.vandelay_alb01",
            "aws_s3_bucket.vandelay_alb_logs",
            "aws_security_group.vandelay_alb_sg01",
            "aws_subnet.vandelay_public_subnets",
            "aws_vpc.vandelay_vpc01",
            "data.aws_caller_identity.current"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_lb_listener",
      "name": "vandelay_https_listener",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "alpn_policy": null,
            "arn": "arn:aws:elasticloadbalancing:us-east-1:212809501772:listener/app/vandelay-alb01/946e933d1e5bbcbf/91797d8a9b1598be",
            "certificate_arn": "arn:aws:acm:us-east-1:212809501772:certificate/8424738a-8e66-4f04-9839-0561c2b26576",
            "default_action": [
              {
                "authenticate_cognito": [],
                "authenticate_oidc": [],
                "fixed_response": [],
                "forward": [],
                "order": 1,
                "redirect": [],
                "target_group_arn": "arn:aws:elasticloadbalancing:us-east-1:212809501772:targetgroup/vandelay-tg01/021c5839299908d8",
                "type": "forward"
              }
            ],
            "id": "arn:aws:elasticloadbalancing:us-east-1:212809501772:listener/app/vandelay-alb01/946e933d1e5bbcbf/91797d8a9b1598be",
            "load_balancer_arn": "arn:aws:elasticloadbalancing:us-east-1:212809501772:loadbalancer/app/vandelay-alb01/946e933d1e5bbcbf",
            "mutual_authentication": [
              {
                "advertise_trust_store_ca_names": "",
                "ignore_client_certificate_expiry": false,
                "mode": "off",
                "trust_store_arn": ""
              }
            ],
            "port": 443,
            "protocol": "HTTPS",
            "routing_http_request_x_amzn_mtls_clientcert_header_name": "",
            "routing_http_request_x_amzn_mtls_clientcert_issuer_header_name": "",
            "routing_http_request_x_amzn_mtls_clientcert_leaf_header_name": "",
            "routing_http_request_x_amzn_mtls_clientcert_serial_number_header_name": "",
            "routing_http_request_x_amzn_mtls_clientcert_subject_header_name": "",
            "routing_http_request_x_amzn_mtls_clientcert_validity_header_name": "",
            "routing_http_request_x_amzn_tls_cipher_suite_header_name": "",
            "routing_http_request_x_amzn_tls_version_header_name": "",
            "routing_http_response_access_control_allow_credentials_header_value": "",
            "routing_http_response_access_control_allow_headers_header_value": "",
            "routing_http_response_access_control_allow_methods_header_value": "",
            "routing_http_response_access_control_allow_origin_header_value": "",
            "routing_http_response_access_control_expose_headers_header_value": "",
            "routing_http_response_access_control_max_age_header_value": "",
            "routing_http_response_content_security_policy_header_value": "",
            "routing_http_response_server_enabled": true,
            "routing_http_response_strict_transport_security_header_value": "",
            "routing_http_response_x_content_type_options_header_value": "",
            "routing_http_response_x_frame_options_header_value": "",
            "ssl_policy": "ELBSecurityPolicy-TLS13-1-2-2021-06",
            "tags": {},
            "tags_all": {},
            "tcp_idle_timeout_seconds": null,
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjozMDAwMDAwMDAwMDAsInVwZGF0ZSI6MzAwMDAwMDAwMDAwfX0=",
          "dependencies": [
            "aws_acm_certificate.vandelay_cert",
            "aws_acm_certificate_validation.vandelay_cert_validated",
            "aws_lb.vandelay_alb01",
            "aws_lb_target_group.vandelay_tg01",
            "aws_route53_record.vandelay_cert_validation",
            "aws_s3_bucket.vandelay_alb_logs",
            "aws_security_group.vandelay_alb_sg01",
            "aws_subnet.vandelay_public_subnets",
            "aws_vpc.vandelay_vpc01",
            "data.aws_caller_identity.current",
            "data.aws_route53_zone.vandelay_zone"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_lb_target_group",
      "name": "vandelay_tg01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:elasticloadbalancing:us-east-1:212809501772:targetgroup/vandelay-tg01/021c5839299908d8",
            "arn_suffix": "targetgroup/vandelay-tg01/021c5839299908d8",
            "connection_termination": null,
            "deregistration_delay": "300",
            "health_check": [
              {
                "enabled": true,
                "healthy_threshold": 2,
                "interval": 30,
                "matcher": "200",
                "path": "/",
                "port": "traffic-port",
                "protocol": "HTTP",
                "timeout": 5,
                "unhealthy_threshold": 2
              }
            ],
            "id": "arn:aws:elasticloadbalancing:us-east-1:212809501772:targetgroup/vandelay-tg01/021c5839299908d8",
            "ip_address_type": "ipv4",
            "lambda_multi_value_headers_enabled": false,
            "load_balancer_arns": [
              "arn:aws:elasticloadbalancing:us-east-1:212809501772:loadbalancer/app/vandelay-alb01/946e933d1e5bbcbf"
            ],
            "load_balancing_algorithm_type": "round_robin",
            "load_balancing_anomaly_mitigation": "off",
            "load_balancing_cross_zone_enabled": "use_load_balancer_configuration",
            "name": "vandelay-tg01",
            "name_prefix": "",
            "port": 80,
            "preserve_client_ip": null,
            "protocol": "HTTP",
            "protocol_version": "HTTP1",
            "proxy_protocol_v2": false,
            "slow_start": 0,
            "stickiness": [
              {
                "cookie_duration": 86400,
                "cookie_name": "",
                "enabled": false,
                "type": "lb_cookie"
              }
            ],
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-tg01"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-tg01"
            },
            "target_failover": [
              {
                "on_deregistration": null,
                "on_unhealthy": null
              }
            ],
            "target_group_health": [
              {
                "dns_failover": [
                  {
                    "minimum_healthy_targets_count": "1",
                    "minimum_healthy_targets_percentage": "off"
                  }
                ],
                "unhealthy_state_routing": [
                  {
                    "minimum_healthy_targets_count": 1,
                    "minimum_healthy_targets_percentage": "off"
                  }
                ]
              }
            ],
            "target_health_state": [
              {
                "enable_unhealthy_connection_termination": null,
                "unhealthy_draining_interval": null
              }
            ],
            "target_type": "instance",
            "vpc_id": "vpc-0d67f2118f804df1f"
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_lb_target_group_attachment",
      "name": "vandelay_tg_attachment01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "availability_zone": null,
            "id": "arn:aws:elasticloadbalancing:us-east-1:212809501772:targetgroup/vandelay-tg01/021c5839299908d8-20260130233011085800000017",
            "port": 80,
            "target_group_arn": "arn:aws:elasticloadbalancing:us-east-1:212809501772:targetgroup/vandelay-tg01/021c5839299908d8",
            "target_id": "i-00afae72bb49040b6"
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_iam_instance_profile.vandelay_instance_profile01",
            "aws_iam_role.vandelay_ec2_role01",
            "aws_instance.vandelay_ec201",
            "aws_lb_target_group.vandelay_tg01",
            "aws_security_group.vandelay_alb_sg01",
            "aws_security_group.vandelay_ec2_sg01",
            "aws_subnet.vandelay_public_subnets",
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_nat_gateway",
      "name": "vandelay_nat01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "allocation_id": "eipalloc-02b4dfa7e285d613c",
            "association_id": "eipassoc-0f070928ce5ea99d7",
            "connectivity_type": "public",
            "id": "nat-0c15cfd91be87ceaf",
            "network_interface_id": "eni-0bd6a080cf9099174",
            "private_ip": "10.75.1.218",
            "public_ip": "3.208.196.119",
            "secondary_allocation_ids": [],
            "secondary_private_ip_address_count": 0,
            "secondary_private_ip_addresses": [],
            "subnet_id": "subnet-07aca3968a20186e1",
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-nat01"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-nat01"
            },
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6MTgwMDAwMDAwMDAwMCwidXBkYXRlIjo2MDAwMDAwMDAwMDB9fQ==",
          "dependencies": [
            "aws_eip.vandelay_nat_eip01",
            "aws_internet_gateway.vandelay_igw01",
            "aws_subnet.vandelay_public_subnets",
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_route",
      "name": "vandelay_private_default_route",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "carrier_gateway_id": "",
            "core_network_arn": "",
            "destination_cidr_block": "0.0.0.0/0",
            "destination_ipv6_cidr_block": "",
            "destination_prefix_list_id": "",
            "egress_only_gateway_id": "",
            "gateway_id": "",
            "id": "r-rtb-09fbe667f708a8eef1080289494",
            "instance_id": "",
            "instance_owner_id": "",
            "local_gateway_id": "",
            "nat_gateway_id": "nat-0c15cfd91be87ceaf",
            "network_interface_id": "",
            "origin": "CreateRoute",
            "route_table_id": "rtb-09fbe667f708a8eef",
            "state": "active",
            "timeouts": null,
            "transit_gateway_id": "",
            "vpc_endpoint_id": "",
            "vpc_peering_connection_id": ""
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjozMDAwMDAwMDAwMDAsImRlbGV0ZSI6MzAwMDAwMDAwMDAwLCJ1cGRhdGUiOjEyMDAwMDAwMDAwMH19",
          "dependencies": [
            "aws_eip.vandelay_nat_eip01",
            "aws_internet_gateway.vandelay_igw01",
            "aws_nat_gateway.vandelay_nat01",
            "aws_route_table.vandelay_private_rt01",
            "aws_subnet.vandelay_public_subnets",
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_route",
      "name": "vandelay_public_default_route",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "carrier_gateway_id": "",
            "core_network_arn": "",
            "destination_cidr_block": "0.0.0.0/0",
            "destination_ipv6_cidr_block": "",
            "destination_prefix_list_id": "",
            "egress_only_gateway_id": "",
            "gateway_id": "igw-03e260271fcb8c9a7",
            "id": "r-rtb-0bee55efb0930c1551080289494",
            "instance_id": "",
            "instance_owner_id": "",
            "local_gateway_id": "",
            "nat_gateway_id": "",
            "network_interface_id": "",
            "origin": "CreateRoute",
            "route_table_id": "rtb-0bee55efb0930c155",
            "state": "active",
            "timeouts": null,
            "transit_gateway_id": "",
            "vpc_endpoint_id": "",
            "vpc_peering_connection_id": ""
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjozMDAwMDAwMDAwMDAsImRlbGV0ZSI6MzAwMDAwMDAwMDAwLCJ1cGRhdGUiOjEyMDAwMDAwMDAwMH19",
          "dependencies": [
            "aws_internet_gateway.vandelay_igw01",
            "aws_route_table.vandelay_public_rt01",
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_route53_record",
      "name": "vandelay_apex_alias",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 2,
          "attributes": {
            "alias": [
              {
                "evaluate_target_health": true,
                "name": "vandelay-alb01-398570023.us-east-1.elb.amazonaws.com",
                "zone_id": "Z35SXDOTRQ7X7K"
              }
            ],
            "allow_overwrite": null,
            "cidr_routing_policy": [],
            "failover_routing_policy": [],
            "fqdn": "keepuneat.click",
            "geolocation_routing_policy": [],
            "geoproximity_routing_policy": [],
            "health_check_id": "",
            "id": "Z07421622AG1WUIDW7VC3_keepuneat.click_A",
            "latency_routing_policy": [],
            "multivalue_answer_routing_policy": false,
            "name": "keepuneat.click",
            "records": null,
            "set_identifier": "",
            "timeouts": null,
            "ttl": 0,
            "type": "A",
            "weighted_routing_policy": [],
            "zone_id": "Z07421622AG1WUIDW7VC3"
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxODAwMDAwMDAwMDAwLCJkZWxldGUiOjE4MDAwMDAwMDAwMDAsInVwZGF0ZSI6MTgwMDAwMDAwMDAwMH0sInNjaGVtYV92ZXJzaW9uIjoiMiJ9",
          "dependencies": [
            "aws_lb.vandelay_alb01",
            "aws_s3_bucket.vandelay_alb_logs",
            "aws_security_group.vandelay_alb_sg01",
            "aws_subnet.vandelay_public_subnets",
            "data.aws_route53_zone.vandelay_zone"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_route53_record",
      "name": "vandelay_app_alias01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 2,
          "attributes": {
            "alias": [
              {
                "evaluate_target_health": true,
                "name": "vandelay-alb01-398570023.us-east-1.elb.amazonaws.com",
                "zone_id": "Z35SXDOTRQ7X7K"
              }
            ],
            "allow_overwrite": null,
            "cidr_routing_policy": [],
            "failover_routing_policy": [],
            "fqdn": "app.keepuneat.click",
            "geolocation_routing_policy": [],
            "geoproximity_routing_policy": [],
            "health_check_id": "",
            "id": "Z07421622AG1WUIDW7VC3_app.keepuneat.click_A",
            "latency_routing_policy": [],
            "multivalue_answer_routing_policy": false,
            "name": "app.keepuneat.click",
            "records": [],
            "set_identifier": "",
            "timeouts": null,
            "ttl": 0,
            "type": "A",
            "weighted_routing_policy": [],
            "zone_id": "Z07421622AG1WUIDW7VC3"
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxODAwMDAwMDAwMDAwLCJkZWxldGUiOjE4MDAwMDAwMDAwMDAsInVwZGF0ZSI6MTgwMDAwMDAwMDAwMH0sInNjaGVtYV92ZXJzaW9uIjoiMiJ9",
          "dependencies": [
            "aws_lb.vandelay_alb01",
            "aws_s3_bucket.vandelay_alb_logs",
            "aws_security_group.vandelay_alb_sg01",
            "aws_subnet.vandelay_public_subnets",
            "aws_vpc.vandelay_vpc01",
            "data.aws_caller_identity.current",
            "data.aws_route53_zone.vandelay_zone"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_route53_record",
      "name": "vandelay_cert_validation",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "index_key": "*.keepuneat.click",
          "schema_version": 2,
          "attributes": {
            "alias": [],
            "allow_overwrite": true,
            "cidr_routing_policy": [],
            "failover_routing_policy": [],
            "fqdn": "_8a9b7dc35375689165ec9fcefdd02cde.keepuneat.click",
            "geolocation_routing_policy": [],
            "geoproximity_routing_policy": [],
            "health_check_id": "",
            "id": "Z07421622AG1WUIDW7VC3__8a9b7dc35375689165ec9fcefdd02cde.keepuneat.click._CNAME",
            "latency_routing_policy": [],
            "multivalue_answer_routing_policy": false,
            "name": "_8a9b7dc35375689165ec9fcefdd02cde.keepuneat.click",
            "records": [
              "_088f01000e858fa995789ad336279261.jkddzztszm.acm-validations.aws."
            ],
            "set_identifier": "",
            "timeouts": null,
            "ttl": 60,
            "type": "CNAME",
            "weighted_routing_policy": [],
            "zone_id": "Z07421622AG1WUIDW7VC3"
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxODAwMDAwMDAwMDAwLCJkZWxldGUiOjE4MDAwMDAwMDAwMDAsInVwZGF0ZSI6MTgwMDAwMDAwMDAwMH0sInNjaGVtYV92ZXJzaW9uIjoiMiJ9",
          "dependencies": [
            "aws_acm_certificate.vandelay_cert",
            "data.aws_route53_zone.vandelay_zone"
          ]
        },
        {
          "index_key": "app.keepuneat.click",
          "schema_version": 2,
          "attributes": {
            "alias": [],
            "allow_overwrite": true,
            "cidr_routing_policy": [],
            "failover_routing_policy": [],
            "fqdn": "_a1830e57280623936855a533b94fd09c.app.keepuneat.click",
            "geolocation_routing_policy": [],
            "geoproximity_routing_policy": [],
            "health_check_id": "",
            "id": "Z07421622AG1WUIDW7VC3__a1830e57280623936855a533b94fd09c.app.keepuneat.click._CNAME",
            "latency_routing_policy": [],
            "multivalue_answer_routing_policy": false,
            "name": "_a1830e57280623936855a533b94fd09c.app.keepuneat.click",
            "records": [
              "_34e31432c7121f8090c754e09f66fb52.jkddzztszm.acm-validations.aws."
            ],
            "set_identifier": "",
            "timeouts": null,
            "ttl": 60,
            "type": "CNAME",
            "weighted_routing_policy": [],
            "zone_id": "Z07421622AG1WUIDW7VC3"
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxODAwMDAwMDAwMDAwLCJkZWxldGUiOjE4MDAwMDAwMDAwMDAsInVwZGF0ZSI6MTgwMDAwMDAwMDAwMH0sInNjaGVtYV92ZXJzaW9uIjoiMiJ9",
          "dependencies": [
            "aws_acm_certificate.vandelay_cert",
            "data.aws_route53_zone.vandelay_zone"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_route_table",
      "name": "vandelay_private_rt01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:ec2:us-east-1:212809501772:route-table/rtb-09fbe667f708a8eef",
            "id": "rtb-09fbe667f708a8eef",
            "owner_id": "212809501772",
            "propagating_vgws": [],
            "route": [
              {
                "carrier_gateway_id": "",
                "cidr_block": "0.0.0.0/0",
                "core_network_arn": "",
                "destination_prefix_list_id": "",
                "egress_only_gateway_id": "",
                "gateway_id": "",
                "ipv6_cidr_block": "",
                "local_gateway_id": "",
                "nat_gateway_id": "nat-0c15cfd91be87ceaf",
                "network_interface_id": "",
                "transit_gateway_id": "",
                "vpc_endpoint_id": "",
                "vpc_peering_connection_id": ""
              }
            ],
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-private-rt01"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-private-rt01"
            },
            "timeouts": null,
            "vpc_id": "vpc-0d67f2118f804df1f"
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjozMDAwMDAwMDAwMDAsImRlbGV0ZSI6MzAwMDAwMDAwMDAwLCJ1cGRhdGUiOjEyMDAwMDAwMDAwMH19",
          "dependencies": [
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_route_table",
      "name": "vandelay_public_rt01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:ec2:us-east-1:212809501772:route-table/rtb-0bee55efb0930c155",
            "id": "rtb-0bee55efb0930c155",
            "owner_id": "212809501772",
            "propagating_vgws": [],
            "route": [
              {
                "carrier_gateway_id": "",
                "cidr_block": "0.0.0.0/0",
                "core_network_arn": "",
                "destination_prefix_list_id": "",
                "egress_only_gateway_id": "",
                "gateway_id": "igw-03e260271fcb8c9a7",
                "ipv6_cidr_block": "",
                "local_gateway_id": "",
                "nat_gateway_id": "",
                "network_interface_id": "",
                "transit_gateway_id": "",
                "vpc_endpoint_id": "",
                "vpc_peering_connection_id": ""
              }
            ],
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-public-rt01"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-public-rt01"
            },
            "timeouts": null,
            "vpc_id": "vpc-0d67f2118f804df1f"
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjozMDAwMDAwMDAwMDAsImRlbGV0ZSI6MzAwMDAwMDAwMDAwLCJ1cGRhdGUiOjEyMDAwMDAwMDAwMH19",
          "dependencies": [
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_route_table_association",
      "name": "vandelay_private_rta",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "index_key": 0,
          "schema_version": 0,
          "attributes": {
            "gateway_id": "",
            "id": "rtbassoc-038eee29b83bcc8e5",
            "route_table_id": "rtb-09fbe667f708a8eef",
            "subnet_id": "subnet-0afcb35783b14f2c7",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjozMDAwMDAwMDAwMDAsImRlbGV0ZSI6MzAwMDAwMDAwMDAwLCJ1cGRhdGUiOjEyMDAwMDAwMDAwMH19",
          "dependencies": [
            "aws_route_table.vandelay_private_rt01",
            "aws_subnet.vandelay_private_subnets",
            "aws_vpc.vandelay_vpc01"
          ]
        },
        {
          "index_key": 1,
          "schema_version": 0,
          "attributes": {
            "gateway_id": "",
            "id": "rtbassoc-0570c4a7a6592d45f",
            "route_table_id": "rtb-09fbe667f708a8eef",
            "subnet_id": "subnet-055b1de2d18737807",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjozMDAwMDAwMDAwMDAsImRlbGV0ZSI6MzAwMDAwMDAwMDAwLCJ1cGRhdGUiOjEyMDAwMDAwMDAwMH19",
          "dependencies": [
            "aws_route_table.vandelay_private_rt01",
            "aws_subnet.vandelay_private_subnets",
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_route_table_association",
      "name": "vandelay_public_rta",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "index_key": 0,
          "schema_version": 0,
          "attributes": {
            "gateway_id": "",
            "id": "rtbassoc-00a5e5c785f8d118a",
            "route_table_id": "rtb-0bee55efb0930c155",
            "subnet_id": "subnet-07aca3968a20186e1",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjozMDAwMDAwMDAwMDAsImRlbGV0ZSI6MzAwMDAwMDAwMDAwLCJ1cGRhdGUiOjEyMDAwMDAwMDAwMH19",
          "dependencies": [
            "aws_route_table.vandelay_public_rt01",
            "aws_subnet.vandelay_public_subnets",
            "aws_vpc.vandelay_vpc01"
          ]
        },
        {
          "index_key": 1,
          "schema_version": 0,
          "attributes": {
            "gateway_id": "",
            "id": "rtbassoc-0a63f71fb33afad56",
            "route_table_id": "rtb-0bee55efb0930c155",
            "subnet_id": "subnet-023c3131fec823b62",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjozMDAwMDAwMDAwMDAsImRlbGV0ZSI6MzAwMDAwMDAwMDAwLCJ1cGRhdGUiOjEyMDAwMDAwMDAwMH19",
          "dependencies": [
            "aws_route_table.vandelay_public_rt01",
            "aws_subnet.vandelay_public_subnets",
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_s3_bucket",
      "name": "incident_reports",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "acceleration_status": "",
            "acl": null,
            "arn": "arn:aws:s3:::vandelay-incident-reports-212809501772",
            "bucket": "vandelay-incident-reports-212809501772",
            "bucket_domain_name": "vandelay-incident-reports-212809501772.s3.amazonaws.com",
            "bucket_prefix": "",
            "bucket_regional_domain_name": "vandelay-incident-reports-212809501772.s3.us-east-1.amazonaws.com",
            "cors_rule": [],
            "force_destroy": false,
            "grant": [
              {
                "id": "fc0f6b5565ce5d8ef040ba6d95d4699f45d96fcf3e2b3aea1ef79c6c5cf7f1ea",
                "permissions": [
                  "FULL_CONTROL"
                ],
                "type": "CanonicalUser",
                "uri": ""
              }
            ],
            "hosted_zone_id": "Z3AQBSTGFYJSTF",
            "id": "vandelay-incident-reports-212809501772",
            "lifecycle_rule": [],
            "logging": [],
            "object_lock_configuration": [],
            "object_lock_enabled": false,
            "policy": "",
            "region": "us-east-1",
            "replication_configuration": [],
            "request_payer": "BucketOwner",
            "server_side_encryption_configuration": [
              {
                "rule": [
                  {
                    "apply_server_side_encryption_by_default": [
                      {
                        "kms_master_key_id": "",
                        "sse_algorithm": "AES256"
                      }
                    ],
                    "bucket_key_enabled": false
                  }
                ]
              }
            ],
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-incident-reports"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-incident-reports"
            },
            "timeouts": null,
            "versioning": [
              {
                "enabled": true,
                "mfa_delete": false
              }
            ],
            "website": [],
            "website_domain": null,
            "website_endpoint": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjM2MDAwMDAwMDAwMDAsInJlYWQiOjEyMDAwMDAwMDAwMDAsInVwZGF0ZSI6MTIwMDAwMDAwMDAwMH19",
          "dependencies": [
            "data.aws_caller_identity.current"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_s3_bucket",
      "name": "vandelay_alb_logs",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "index_key": 0,
          "schema_version": 0,
          "attributes": {
            "acceleration_status": "",
            "acl": null,
            "arn": "arn:aws:s3:::vandelay-alb-logs-212809501772",
            "bucket": "vandelay-alb-logs-212809501772",
            "bucket_domain_name": "vandelay-alb-logs-212809501772.s3.amazonaws.com",
            "bucket_prefix": "",
            "bucket_regional_domain_name": "vandelay-alb-logs-212809501772.s3.us-east-1.amazonaws.com",
            "cors_rule": [],
            "force_destroy": false,
            "grant": [
              {
                "id": "fc0f6b5565ce5d8ef040ba6d95d4699f45d96fcf3e2b3aea1ef79c6c5cf7f1ea",
                "permissions": [
                  "FULL_CONTROL"
                ],
                "type": "CanonicalUser",
                "uri": ""
              }
            ],
            "hosted_zone_id": "Z3AQBSTGFYJSTF",
            "id": "vandelay-alb-logs-212809501772",
            "lifecycle_rule": [
              {
                "abort_incomplete_multipart_upload_days": 0,
                "enabled": true,
                "expiration": [
                  {
                    "date": "",
                    "days": 90,
                    "expired_object_delete_marker": false
                  }
                ],
                "id": "expire-old-logs",
                "noncurrent_version_expiration": [
                  {
                    "days": 30
                  }
                ],
                "noncurrent_version_transition": [],
                "prefix": "",
                "tags": {},
                "transition": []
              }
            ],
            "logging": [],
            "object_lock_configuration": [],
            "object_lock_enabled": false,
            "policy": "{\"Statement\":[{\"Action\":\"s3:*\",\"Condition\":{\"Bool\":{\"aws:SecureTransport\":\"false\"}},\"Effect\":\"Deny\",\"Principal\":\"*\",\"Resource\":[\"arn:aws:s3:::vandelay-alb-logs-212809501772\",\"arn:aws:s3:::vandelay-alb-logs-212809501772/*\"],\"Sid\":\"DenyInsecureTransport\"},{\"Action\":\"s3:PutObject\",\"Effect\":\"Allow\",\"Principal\":{\"AWS\":\"arn:aws:iam::127311923021:root\"},\"Resource\":\"arn:aws:s3:::vandelay-alb-logs-212809501772/alb-logs/AWSLogs/212809501772/*\",\"Sid\":\"AllowELBRootAcl\"},{\"Action\":\"s3:PutObject\",\"Condition\":{\"StringEquals\":{\"s3:x-amz-acl\":\"bucket-owner-full-control\"}},\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"delivery.logs.amazonaws.com\"},\"Resource\":\"arn:aws:s3:::vandelay-alb-logs-212809501772/alb-logs/AWSLogs/212809501772/*\",\"Sid\":\"AllowELBLogDelivery\"},{\"Action\":\"s3:GetBucketAcl\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"delivery.logs.amazonaws.com\"},\"Resource\":\"arn:aws:s3:::vandelay-alb-logs-212809501772\",\"Sid\":\"AllowELBLogDeliveryAcl\"}],\"Version\":\"2012-10-17\"}",
            "region": "us-east-1",
            "replication_configuration": [],
            "request_payer": "BucketOwner",
            "server_side_encryption_configuration": [
              {
                "rule": [
                  {
                    "apply_server_side_encryption_by_default": [
                      {
                        "kms_master_key_id": "",
                        "sse_algorithm": "AES256"
                      }
                    ],
                    "bucket_key_enabled": false
                  }
                ]
              }
            ],
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-alb-logs"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-alb-logs"
            },
            "timeouts": null,
            "versioning": [
              {
                "enabled": true,
                "mfa_delete": false
              }
            ],
            "website": [],
            "website_domain": null,
            "website_endpoint": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjM2MDAwMDAwMDAwMDAsInJlYWQiOjEyMDAwMDAwMDAwMDAsInVwZGF0ZSI6MTIwMDAwMDAwMDAwMH19",
          "dependencies": [
            "data.aws_caller_identity.current"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_s3_bucket_lifecycle_configuration",
      "name": "vandelay_alb_logs_lifecycle",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "index_key": 0,
          "schema_version": 1,
          "attributes": {
            "bucket": "vandelay-alb-logs-212809501772",
            "expected_bucket_owner": "",
            "id": "vandelay-alb-logs-212809501772",
            "rule": [
              {
                "abort_incomplete_multipart_upload": [],
                "expiration": [
                  {
                    "date": null,
                    "days": 90,
                    "expired_object_delete_marker": false
                  }
                ],
                "filter": [
                  {
                    "and": [],
                    "object_size_greater_than": null,
                    "object_size_less_than": null,
                    "prefix": "",
                    "tag": []
                  }
                ],
                "id": "expire-old-logs",
                "noncurrent_version_expiration": [
                  {
                    "newer_noncurrent_versions": null,
                    "noncurrent_days": 30
                  }
                ],
                "noncurrent_version_transition": [],
                "prefix": "",
                "status": "Enabled",
                "transition": []
              }
            ],
            "timeouts": null,
            "transition_default_minimum_object_size": "all_storage_classes_128K"
          },
          "sensitive_attributes": [],
          "dependencies": [
            "aws_s3_bucket.vandelay_alb_logs",
            "data.aws_caller_identity.current"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_s3_bucket_ownership_controls",
      "name": "vandelay_alb_logs_owner",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "index_key": 0,
          "schema_version": 0,
          "attributes": {
            "bucket": "vandelay-alb-logs-212809501772",
            "id": "vandelay-alb-logs-212809501772",
            "rule": [
              {
                "object_ownership": "BucketOwnerPreferred"
              }
            ]
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_s3_bucket.vandelay_alb_logs",
            "data.aws_caller_identity.current"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_s3_bucket_policy",
      "name": "vandelay_alb_logs_policy",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "index_key": 0,
          "schema_version": 0,
          "attributes": {
            "bucket": "vandelay-alb-logs-212809501772",
            "id": "vandelay-alb-logs-212809501772",
            "policy": "{\"Statement\":[{\"Action\":\"s3:*\",\"Condition\":{\"Bool\":{\"aws:SecureTransport\":\"false\"}},\"Effect\":\"Deny\",\"Principal\":\"*\",\"Resource\":[\"arn:aws:s3:::vandelay-alb-logs-212809501772\",\"arn:aws:s3:::vandelay-alb-logs-212809501772/*\"],\"Sid\":\"DenyInsecureTransport\"},{\"Action\":\"s3:PutObject\",\"Effect\":\"Allow\",\"Principal\":{\"AWS\":\"arn:aws:iam::127311923021:root\"},\"Resource\":\"arn:aws:s3:::vandelay-alb-logs-212809501772/alb-logs/AWSLogs/212809501772/*\",\"Sid\":\"AllowELBRootAcl\"},{\"Action\":\"s3:PutObject\",\"Condition\":{\"StringEquals\":{\"s3:x-amz-acl\":\"bucket-owner-full-control\"}},\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"delivery.logs.amazonaws.com\"},\"Resource\":\"arn:aws:s3:::vandelay-alb-logs-212809501772/alb-logs/AWSLogs/212809501772/*\",\"Sid\":\"AllowELBLogDelivery\"},{\"Action\":\"s3:GetBucketAcl\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"delivery.logs.amazonaws.com\"},\"Resource\":\"arn:aws:s3:::vandelay-alb-logs-212809501772\",\"Sid\":\"AllowELBLogDeliveryAcl\"}],\"Version\":\"2012-10-17\"}"
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_s3_bucket.vandelay_alb_logs",
            "aws_s3_bucket_public_access_block.vandelay_alb_logs_pab",
            "data.aws_caller_identity.current"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_s3_bucket_public_access_block",
      "name": "incident_reports",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "block_public_acls": true,
            "block_public_policy": true,
            "bucket": "vandelay-incident-reports-212809501772",
            "id": "vandelay-incident-reports-212809501772",
            "ignore_public_acls": true,
            "restrict_public_buckets": true
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_s3_bucket.incident_reports",
            "data.aws_caller_identity.current"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_s3_bucket_public_access_block",
      "name": "vandelay_alb_logs_pab",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "index_key": 0,
          "schema_version": 0,
          "attributes": {
            "block_public_acls": true,
            "block_public_policy": true,
            "bucket": "vandelay-alb-logs-212809501772",
            "id": "vandelay-alb-logs-212809501772",
            "ignore_public_acls": true,
            "restrict_public_buckets": true
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_s3_bucket.vandelay_alb_logs",
            "data.aws_caller_identity.current"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_s3_bucket_server_side_encryption_configuration",
      "name": "incident_reports",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "bucket": "vandelay-incident-reports-212809501772",
            "expected_bucket_owner": "",
            "id": "vandelay-incident-reports-212809501772",
            "rule": [
              {
                "apply_server_side_encryption_by_default": [
                  {
                    "kms_master_key_id": "",
                    "sse_algorithm": "AES256"
                  }
                ],
                "bucket_key_enabled": false
              }
            ]
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_s3_bucket.incident_reports",
            "data.aws_caller_identity.current"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_s3_bucket_server_side_encryption_configuration",
      "name": "vandelay_alb_logs_sse",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "index_key": 0,
          "schema_version": 0,
          "attributes": {
            "bucket": "vandelay-alb-logs-212809501772",
            "expected_bucket_owner": "",
            "id": "vandelay-alb-logs-212809501772",
            "rule": [
              {
                "apply_server_side_encryption_by_default": [
                  {
                    "kms_master_key_id": "",
                    "sse_algorithm": "AES256"
                  }
                ],
                "bucket_key_enabled": false
              }
            ]
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_s3_bucket.vandelay_alb_logs",
            "data.aws_caller_identity.current"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_s3_bucket_versioning",
      "name": "incident_reports",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "bucket": "vandelay-incident-reports-212809501772",
            "expected_bucket_owner": "",
            "id": "vandelay-incident-reports-212809501772",
            "mfa": null,
            "versioning_configuration": [
              {
                "mfa_delete": "",
                "status": "Enabled"
              }
            ]
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_s3_bucket.incident_reports",
            "data.aws_caller_identity.current"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_s3_bucket_versioning",
      "name": "vandelay_alb_logs_versioning",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "index_key": 0,
          "schema_version": 0,
          "attributes": {
            "bucket": "vandelay-alb-logs-212809501772",
            "expected_bucket_owner": "",
            "id": "vandelay-alb-logs-212809501772",
            "mfa": null,
            "versioning_configuration": [
              {
                "mfa_delete": "",
                "status": "Enabled"
              }
            ]
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_s3_bucket.vandelay_alb_logs",
            "data.aws_caller_identity.current"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_secretsmanager_secret_rotation",
      "name": "vandelay_db_rotation",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 1,
          "attributes": {
            "id": "arn:aws:secretsmanager:us-east-1:212809501772:secret:lab/rds/mysql-x7lYie",
            "rotate_immediately": true,
            "rotation_enabled": true,
            "rotation_lambda_arn": "arn:aws:lambda:us-east-1:212809501772:function:vandelay-mysql-rotation-lambda",
            "rotation_rules": [
              {
                "automatically_after_days": 30,
                "duration": "",
                "schedule_expression": ""
              }
            ],
            "secret_id": "arn:aws:secretsmanager:us-east-1:212809501772:secret:lab/rds/mysql-x7lYie"
          },
          "sensitive_attributes": [],
          "private": "eyJzY2hlbWFfdmVyc2lvbiI6IjEifQ==",
          "dependencies": [
            "aws_lambda_permission.secrets_manager_rotation",
            "aws_security_group.rotation_lambda_sg",
            "aws_serverlessapplicationrepository_cloudformation_stack.rotation_lambda",
            "aws_subnet.vandelay_private_subnets",
            "aws_vpc.vandelay_vpc01",
            "data.aws_caller_identity.current",
            "data.aws_secretsmanager_secret.vandelay_db_secret01",
            "data.aws_serverlessapplicationrepository_application.secrets_manager_rotation"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_security_group",
      "name": "rotation_lambda_sg",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 1,
          "attributes": {
            "arn": "arn:aws:ec2:us-east-1:212809501772:security-group/sg-020566014ef934e64",
            "description": "Security group for secret rotation Lambda",
            "egress": [
              {
                "cidr_blocks": [
                  "0.0.0.0/0"
                ],
                "description": "",
                "from_port": 0,
                "ipv6_cidr_blocks": [],
                "prefix_list_ids": [],
                "protocol": "-1",
                "security_groups": [],
                "self": false,
                "to_port": 0
              }
            ],
            "id": "sg-020566014ef934e64",
            "ingress": [],
            "name": "vandelay-rotation-lambda-sg",
            "name_prefix": "",
            "owner_id": "212809501772",
            "revoke_rules_on_delete": false,
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-rotation-lambda-sg"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-rotation-lambda-sg"
            },
            "timeouts": null,
            "vpc_id": "vpc-0d67f2118f804df1f"
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6OTAwMDAwMDAwMDAwfSwic2NoZW1hX3ZlcnNpb24iOiIxIn0=",
          "dependencies": [
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_security_group",
      "name": "vandelay_alb_sg01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 1,
          "attributes": {
            "arn": "arn:aws:ec2:us-east-1:212809501772:security-group/sg-072d57058808b322b",
            "description": "Security group for Application Load Balancer",
            "egress": [
              {
                "cidr_blocks": [
                  "0.0.0.0/0"
                ],
                "description": "Allow all outbound",
                "from_port": 0,
                "ipv6_cidr_blocks": [],
                "prefix_list_ids": [],
                "protocol": "-1",
                "security_groups": [],
                "self": false,
                "to_port": 0
              }
            ],
            "id": "sg-072d57058808b322b",
            "ingress": [
              {
                "cidr_blocks": [
                  "0.0.0.0/0"
                ],
                "description": "Allow HTTP from internet",
                "from_port": 80,
                "ipv6_cidr_blocks": [],
                "prefix_list_ids": [],
                "protocol": "tcp",
                "security_groups": [],
                "self": false,
                "to_port": 80
              },
              {
                "cidr_blocks": [
                  "0.0.0.0/0"
                ],
                "description": "Allow HTTPS from internet",
                "from_port": 443,
                "ipv6_cidr_blocks": [],
                "prefix_list_ids": [],
                "protocol": "tcp",
                "security_groups": [],
                "self": false,
                "to_port": 443
              }
            ],
            "name": "vandelay-alb-sg01",
            "name_prefix": "",
            "owner_id": "212809501772",
            "revoke_rules_on_delete": false,
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-alb-sg01"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-alb-sg01"
            },
            "timeouts": null,
            "vpc_id": "vpc-0d67f2118f804df1f"
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6OTAwMDAwMDAwMDAwfSwic2NoZW1hX3ZlcnNpb24iOiIxIn0=",
          "dependencies": [
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_security_group",
      "name": "vandelay_ec2_sg01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 1,
          "attributes": {
            "arn": "arn:aws:ec2:us-east-1:212809501772:security-group/sg-00aa1fb4c080b975b",
            "description": "EC2 app security group",
            "egress": [
              {
                "cidr_blocks": [
                  "0.0.0.0/0"
                ],
                "description": "Allow all outbound traffic",
                "from_port": 0,
                "ipv6_cidr_blocks": [],
                "prefix_list_ids": [],
                "protocol": "-1",
                "security_groups": [],
                "self": false,
                "to_port": 0
              }
            ],
            "id": "sg-00aa1fb4c080b975b",
            "ingress": [
              {
                "cidr_blocks": [
                  "0.0.0.0/0"
                ],
                "description": "Allow HTTP from anywhere",
                "from_port": 80,
                "ipv6_cidr_blocks": [],
                "prefix_list_ids": [],
                "protocol": "tcp",
                "security_groups": [],
                "self": false,
                "to_port": 80
              },
              {
                "cidr_blocks": [
                  "73.153.200.49/32"
                ],
                "description": "Allow SSH from admin IP",
                "from_port": 22,
                "ipv6_cidr_blocks": [],
                "prefix_list_ids": [],
                "protocol": "tcp",
                "security_groups": [],
                "self": false,
                "to_port": 22
              },
              {
                "cidr_blocks": [],
                "description": "Allow HTTP from ALB to EC2",
                "from_port": 80,
                "ipv6_cidr_blocks": [],
                "prefix_list_ids": [],
                "protocol": "tcp",
                "security_groups": [
                  "sg-072d57058808b322b"
                ],
                "self": false,
                "to_port": 80
              }
            ],
            "name": "vandelay-ec2-sg01",
            "name_prefix": "",
            "owner_id": "212809501772",
            "revoke_rules_on_delete": false,
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-ec2-sg01"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-ec2-sg01"
            },
            "timeouts": null,
            "vpc_id": "vpc-0d67f2118f804df1f"
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6OTAwMDAwMDAwMDAwfSwic2NoZW1hX3ZlcnNpb24iOiIxIn0=",
          "dependencies": [
            "aws_security_group.vandelay_alb_sg01",
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_security_group",
      "name": "vandelay_rds_sg01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 1,
          "attributes": {
            "arn": "arn:aws:ec2:us-east-1:212809501772:security-group/sg-0468006e629bcfee5",
            "description": "RDS security group - only allows EC2 app server",
            "egress": [
              {
                "cidr_blocks": [
                  "0.0.0.0/0"
                ],
                "description": "",
                "from_port": 0,
                "ipv6_cidr_blocks": [],
                "prefix_list_ids": [],
                "protocol": "-1",
                "security_groups": [],
                "self": false,
                "to_port": 0
              }
            ],
            "id": "sg-0468006e629bcfee5",
            "ingress": [
              {
                "cidr_blocks": [],
                "description": "Allow Lambda rotation function to connect to RDS",
                "from_port": 3306,
                "ipv6_cidr_blocks": [],
                "prefix_list_ids": [],
                "protocol": "tcp",
                "security_groups": [
                  "sg-020566014ef934e64"
                ],
                "self": false,
                "to_port": 3306
              },
              {
                "cidr_blocks": [],
                "description": "Allow MySQL from EC2 app server only",
                "from_port": 3306,
                "ipv6_cidr_blocks": [],
                "prefix_list_ids": [],
                "protocol": "tcp",
                "security_groups": [
                  "sg-00aa1fb4c080b975b"
                ],
                "self": false,
                "to_port": 3306
              }
            ],
            "name": "vandelay-rds-sg01",
            "name_prefix": "",
            "owner_id": "212809501772",
            "revoke_rules_on_delete": false,
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-rds-sg01"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-rds-sg01"
            },
            "timeouts": null,
            "vpc_id": "vpc-0d67f2118f804df1f"
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6OTAwMDAwMDAwMDAwfSwic2NoZW1hX3ZlcnNpb24iOiIxIn0=",
          "dependencies": [
            "aws_security_group.rotation_lambda_sg",
            "aws_security_group.vandelay_alb_sg01",
            "aws_security_group.vandelay_ec2_sg01",
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_security_group",
      "name": "vandelay_vpce_sg01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 1,
          "attributes": {
            "arn": "arn:aws:ec2:us-east-1:212809501772:security-group/sg-0878afa15c3c3ee83",
            "description": "SG for VPC Interface Endpoints",
            "egress": [
              {
                "cidr_blocks": [
                  "0.0.0.0/0"
                ],
                "description": "",
                "from_port": 0,
                "ipv6_cidr_blocks": [],
                "prefix_list_ids": [],
                "protocol": "-1",
                "security_groups": [],
                "self": false,
                "to_port": 0
              }
            ],
            "id": "sg-0878afa15c3c3ee83",
            "ingress": [
              {
                "cidr_blocks": [],
                "description": "Allow HTTPS from EC2 and Lambda",
                "from_port": 443,
                "ipv6_cidr_blocks": [],
                "prefix_list_ids": [],
                "protocol": "tcp",
                "security_groups": [
                  "sg-00aa1fb4c080b975b",
                  "sg-020566014ef934e64"
                ],
                "self": false,
                "to_port": 443
              }
            ],
            "name": "vandelay-vpce-sg01",
            "name_prefix": "",
            "owner_id": "212809501772",
            "revoke_rules_on_delete": false,
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-vpce-sg01"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-vpce-sg01"
            },
            "timeouts": null,
            "vpc_id": "vpc-0d67f2118f804df1f"
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6OTAwMDAwMDAwMDAwfSwic2NoZW1hX3ZlcnNpb24iOiIxIn0=",
          "dependencies": [
            "aws_security_group.rotation_lambda_sg",
            "aws_security_group.vandelay_alb_sg01",
            "aws_security_group.vandelay_ec2_sg01",
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_security_group",
      "name": "vpce_sg",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 1,
          "attributes": {
            "arn": "arn:aws:ec2:us-east-1:212809501772:security-group/sg-0573bfaf9a7d4fc94",
            "description": "Security group for VPC endpoints",
            "egress": [],
            "id": "sg-0573bfaf9a7d4fc94",
            "ingress": [
              {
                "cidr_blocks": [],
                "description": "Allow HTTPS from Lambda and EC2",
                "from_port": 443,
                "ipv6_cidr_blocks": [],
                "prefix_list_ids": [],
                "protocol": "tcp",
                "security_groups": [
                  "sg-00aa1fb4c080b975b",
                  "sg-020566014ef934e64"
                ],
                "self": false,
                "to_port": 443
              }
            ],
            "name": "vandelay-vpce-sg",
            "name_prefix": "",
            "owner_id": "212809501772",
            "revoke_rules_on_delete": false,
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-vpce-sg"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-vpce-sg"
            },
            "timeouts": null,
            "vpc_id": "vpc-0d67f2118f804df1f"
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6OTAwMDAwMDAwMDAwfSwic2NoZW1hX3ZlcnNpb24iOiIxIn0=",
          "dependencies": [
            "aws_security_group.rotation_lambda_sg",
            "aws_security_group.vandelay_alb_sg01",
            "aws_security_group.vandelay_ec2_sg01",
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_serverlessapplicationrepository_cloudformation_stack",
      "name": "rotation_lambda",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "application_id": "arn:aws:serverlessrepo:us-east-1:297356227824:applications/SecretsManagerRDSMySQLRotationSingleUser",
            "capabilities": [
              "CAPABILITY_IAM",
              "CAPABILITY_RESOURCE_POLICY"
            ],
            "id": "arn:aws:cloudformation:us-east-1:212809501772:stack/serverlessrepo-vandelay-mysql-rotation/87e081b0-fe33-11f0-b5b6-0e6c7ba13d69",
            "name": "vandelay-mysql-rotation",
            "outputs": {
              "RotationLambdaARN": "arn:aws:lambda:us-east-1:212809501772:function:vandelay-mysql-rotation-lambda"
            },
            "parameters": {
              "endpoint": "https://secretsmanager.us-east-1.amazonaws.com",
              "functionName": "vandelay-mysql-rotation-lambda",
              "vpcSecurityGroupIds": "sg-020566014ef934e64",
              "vpcSubnetIds": "subnet-0afcb35783b14f2c7,subnet-055b1de2d18737807"
            },
            "semantic_version": "1.1.632",
            "tags": {
              "Lab": "ec2-rds-integration"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration"
            },
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxODAwMDAwMDAwMDAwLCJkZWxldGUiOjE4MDAwMDAwMDAwMDAsInVwZGF0ZSI6MTgwMDAwMDAwMDAwMH19",
          "dependencies": [
            "aws_security_group.rotation_lambda_sg",
            "aws_subnet.vandelay_private_subnets",
            "aws_vpc.vandelay_vpc01",
            "data.aws_serverlessapplicationrepository_application.secrets_manager_rotation"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_sns_topic",
      "name": "vandelay_sns_topic01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "application_failure_feedback_role_arn": "",
            "application_success_feedback_role_arn": "",
            "application_success_feedback_sample_rate": 0,
            "archive_policy": "",
            "arn": "arn:aws:sns:us-east-1:212809501772:vandelay-db-incidents",
            "beginning_archive_time": "",
            "content_based_deduplication": false,
            "delivery_policy": "",
            "display_name": "",
            "fifo_throughput_scope": "",
            "fifo_topic": false,
            "firehose_failure_feedback_role_arn": "",
            "firehose_success_feedback_role_arn": "",
            "firehose_success_feedback_sample_rate": 0,
            "http_failure_feedback_role_arn": "",
            "http_success_feedback_role_arn": "",
            "http_success_feedback_sample_rate": 0,
            "id": "arn:aws:sns:us-east-1:212809501772:vandelay-db-incidents",
            "kms_master_key_id": "",
            "lambda_failure_feedback_role_arn": "",
            "lambda_success_feedback_role_arn": "",
            "lambda_success_feedback_sample_rate": 0,
            "name": "vandelay-db-incidents",
            "name_prefix": "",
            "owner": "212809501772",
            "policy": "{\"Id\":\"__default_policy_ID\",\"Statement\":[{\"Action\":[\"SNS:GetTopicAttributes\",\"SNS:SetTopicAttributes\",\"SNS:AddPermission\",\"SNS:RemovePermission\",\"SNS:DeleteTopic\",\"SNS:Subscribe\",\"SNS:ListSubscriptionsByTopic\",\"SNS:Publish\"],\"Condition\":{\"StringEquals\":{\"AWS:SourceOwner\":\"212809501772\"}},\"Effect\":\"Allow\",\"Principal\":{\"AWS\":\"*\"},\"Resource\":\"arn:aws:sns:us-east-1:212809501772:vandelay-db-incidents\",\"Sid\":\"__default_statement_ID\"}],\"Version\":\"2008-10-17\"}",
            "signature_version": 0,
            "sqs_failure_feedback_role_arn": "",
            "sqs_success_feedback_role_arn": "",
            "sqs_success_feedback_sample_rate": 0,
            "tags": {},
            "tags_all": {},
            "tracing_config": ""
          },
          "sensitive_attributes": [],
          "private": "bnVsbA=="
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_sns_topic_subscription",
      "name": "incident_reporter_sub",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:sns:us-east-1:212809501772:vandelay-db-incidents:e483a9e3-91b3-4aba-a6ae-aa35b1169d66",
            "confirmation_timeout_in_minutes": 1,
            "confirmation_was_authenticated": true,
            "delivery_policy": "",
            "endpoint": "arn:aws:lambda:us-east-1:212809501772:function:vandelay-incident-reporter",
            "endpoint_auto_confirms": false,
            "filter_policy": "",
            "filter_policy_scope": "",
            "id": "arn:aws:sns:us-east-1:212809501772:vandelay-db-incidents:e483a9e3-91b3-4aba-a6ae-aa35b1169d66",
            "owner_id": "212809501772",
            "pending_confirmation": false,
            "protocol": "lambda",
            "raw_message_delivery": false,
            "redrive_policy": "",
            "replay_policy": "",
            "subscription_role_arn": "",
            "topic_arn": "arn:aws:sns:us-east-1:212809501772:vandelay-db-incidents"
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_cloudwatch_log_group.vandelay_log_group01",
            "aws_iam_role.incident_reporter_role",
            "aws_lambda_function.incident_reporter",
            "aws_s3_bucket.incident_reports",
            "aws_sns_topic.vandelay_sns_topic01",
            "data.archive_file.incident_reporter_zip",
            "data.aws_caller_identity.current"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_sns_topic_subscription",
      "name": "vandelay_sns_sub01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:sns:us-east-1:212809501772:vandelay-db-incidents:6eab657d-f95c-41e8-be76-5b9341414035",
            "confirmation_timeout_in_minutes": 1,
            "confirmation_was_authenticated": false,
            "delivery_policy": "",
            "endpoint": "gaijinmzungu@gmail.com",
            "endpoint_auto_confirms": false,
            "filter_policy": "",
            "filter_policy_scope": "",
            "id": "arn:aws:sns:us-east-1:212809501772:vandelay-db-incidents:6eab657d-f95c-41e8-be76-5b9341414035",
            "owner_id": "212809501772",
            "pending_confirmation": false,
            "protocol": "email",
            "raw_message_delivery": false,
            "redrive_policy": "",
            "replay_policy": "",
            "subscription_role_arn": "",
            "topic_arn": "arn:aws:sns:us-east-1:212809501772:vandelay-db-incidents"
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_sns_topic.vandelay_sns_topic01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_ssm_parameter",
      "name": "vandelay_db_endpoint",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "allowed_pattern": "",
            "arn": "arn:aws:ssm:us-east-1:212809501772:parameter/vandelay/db/endpoint",
            "data_type": "text",
            "description": "",
            "has_value_wo": null,
            "id": "/vandelay/db/endpoint",
            "insecure_value": null,
            "key_id": "",
            "name": "/vandelay/db/endpoint",
            "overwrite": null,
            "tags": {
              "Name": "vandelay-param-db-endpoint"
            },
            "tags_all": {
              "Name": "vandelay-param-db-endpoint"
            },
            "tier": "Standard",
            "type": "String",
            "value": "vandelay-rds01.cmrys4aosktq.us-east-1.rds.amazonaws.com",
            "value_wo": null,
            "value_wo_version": null,
            "version": 1
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_db_instance.vandelay_rds01",
            "aws_db_subnet_group.vandelay_rds_subnet_group01",
            "aws_security_group.rotation_lambda_sg",
            "aws_security_group.vandelay_alb_sg01",
            "aws_security_group.vandelay_ec2_sg01",
            "aws_security_group.vandelay_rds_sg01",
            "aws_subnet.vandelay_private_subnets",
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_ssm_parameter",
      "name": "vandelay_db_endpoint_param",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "allowed_pattern": "",
            "arn": "arn:aws:ssm:us-east-1:212809501772:parameter/lab/db/endpoint",
            "data_type": "text",
            "description": "",
            "has_value_wo": null,
            "id": "/lab/db/endpoint",
            "insecure_value": null,
            "key_id": "",
            "name": "/lab/db/endpoint",
            "overwrite": null,
            "tags": {
              "Name": "vandelay-param-db-endpoint"
            },
            "tags_all": {
              "Name": "vandelay-param-db-endpoint"
            },
            "tier": "Standard",
            "type": "String",
            "value": "vandelay-rds01.cmrys4aosktq.us-east-1.rds.amazonaws.com",
            "value_wo": null,
            "value_wo_version": null,
            "version": 1
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_db_instance.vandelay_rds01",
            "aws_db_subnet_group.vandelay_rds_subnet_group01",
            "aws_security_group.rotation_lambda_sg",
            "aws_security_group.vandelay_alb_sg01",
            "aws_security_group.vandelay_ec2_sg01",
            "aws_security_group.vandelay_rds_sg01",
            "aws_subnet.vandelay_private_subnets",
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_ssm_parameter",
      "name": "vandelay_db_name",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "allowed_pattern": "",
            "arn": "arn:aws:ssm:us-east-1:212809501772:parameter/vandelay/db/name",
            "data_type": "text",
            "description": "",
            "has_value_wo": null,
            "id": "/vandelay/db/name",
            "insecure_value": null,
            "key_id": "",
            "name": "/vandelay/db/name",
            "overwrite": null,
            "tags": {
              "Name": "vandelay-param-db-name"
            },
            "tags_all": {
              "Name": "vandelay-param-db-name"
            },
            "tier": "Standard",
            "type": "String",
            "value": "labmysql",
            "value_wo": null,
            "value_wo_version": null,
            "version": 1
          },
          "sensitive_attributes": [],
          "private": "bnVsbA=="
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_ssm_parameter",
      "name": "vandelay_db_name_param",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "allowed_pattern": "",
            "arn": "arn:aws:ssm:us-east-1:212809501772:parameter/lab/db/name",
            "data_type": "text",
            "description": "",
            "has_value_wo": null,
            "id": "/lab/db/name",
            "insecure_value": null,
            "key_id": "",
            "name": "/lab/db/name",
            "overwrite": null,
            "tags": {
              "Name": "vandelay-param-db-name"
            },
            "tags_all": {
              "Name": "vandelay-param-db-name"
            },
            "tier": "Standard",
            "type": "String",
            "value": "labmysql",
            "value_wo": null,
            "value_wo_version": null,
            "version": 1
          },
          "sensitive_attributes": [],
          "private": "bnVsbA=="
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_ssm_parameter",
      "name": "vandelay_db_port",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "allowed_pattern": "",
            "arn": "arn:aws:ssm:us-east-1:212809501772:parameter/vandelay/db/port",
            "data_type": "text",
            "description": "",
            "has_value_wo": null,
            "id": "/vandelay/db/port",
            "insecure_value": null,
            "key_id": "",
            "name": "/vandelay/db/port",
            "overwrite": null,
            "tags": {
              "Name": "vandelay-param-db-port"
            },
            "tags_all": {
              "Name": "vandelay-param-db-port"
            },
            "tier": "Standard",
            "type": "String",
            "value": "3306",
            "value_wo": null,
            "value_wo_version": null,
            "version": 1
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_db_instance.vandelay_rds01",
            "aws_db_subnet_group.vandelay_rds_subnet_group01",
            "aws_security_group.rotation_lambda_sg",
            "aws_security_group.vandelay_alb_sg01",
            "aws_security_group.vandelay_ec2_sg01",
            "aws_security_group.vandelay_rds_sg01",
            "aws_subnet.vandelay_private_subnets",
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_ssm_parameter",
      "name": "vandelay_db_port_param",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "allowed_pattern": "",
            "arn": "arn:aws:ssm:us-east-1:212809501772:parameter/lab/db/port",
            "data_type": "text",
            "description": "",
            "has_value_wo": null,
            "id": "/lab/db/port",
            "insecure_value": null,
            "key_id": "",
            "name": "/lab/db/port",
            "overwrite": null,
            "tags": {
              "Name": "vandelay-param-db-port"
            },
            "tags_all": {
              "Name": "vandelay-param-db-port"
            },
            "tier": "Standard",
            "type": "String",
            "value": "3306",
            "value_wo": null,
            "value_wo_version": null,
            "version": 1
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_db_instance.vandelay_rds01",
            "aws_db_subnet_group.vandelay_rds_subnet_group01",
            "aws_security_group.rotation_lambda_sg",
            "aws_security_group.vandelay_alb_sg01",
            "aws_security_group.vandelay_ec2_sg01",
            "aws_security_group.vandelay_rds_sg01",
            "aws_subnet.vandelay_private_subnets",
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_subnet",
      "name": "vandelay_private_subnets",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "index_key": 0,
          "schema_version": 1,
          "attributes": {
            "arn": "arn:aws:ec2:us-east-1:212809501772:subnet/subnet-0afcb35783b14f2c7",
            "assign_ipv6_address_on_creation": false,
            "availability_zone": "us-east-1a",
            "availability_zone_id": "use1-az2",
            "cidr_block": "10.75.101.0/24",
            "customer_owned_ipv4_pool": "",
            "enable_dns64": false,
            "enable_lni_at_device_index": 0,
            "enable_resource_name_dns_a_record_on_launch": false,
            "enable_resource_name_dns_aaaa_record_on_launch": false,
            "id": "subnet-0afcb35783b14f2c7",
            "ipv6_cidr_block": "",
            "ipv6_cidr_block_association_id": "",
            "ipv6_native": false,
            "map_customer_owned_ip_on_launch": false,
            "map_public_ip_on_launch": false,
            "outpost_arn": "",
            "owner_id": "212809501772",
            "private_dns_hostname_type_on_launch": "ip-name",
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-private-subnet-1",
              "Tier": "private"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-private-subnet-1",
              "Tier": "private"
            },
            "timeouts": null,
            "vpc_id": "vpc-0d67f2118f804df1f"
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6MTIwMDAwMDAwMDAwMH0sInNjaGVtYV92ZXJzaW9uIjoiMSJ9",
          "dependencies": [
            "aws_vpc.vandelay_vpc01"
          ]
        },
        {
          "index_key": 1,
          "schema_version": 1,
          "attributes": {
            "arn": "arn:aws:ec2:us-east-1:212809501772:subnet/subnet-055b1de2d18737807",
            "assign_ipv6_address_on_creation": false,
            "availability_zone": "us-east-1b",
            "availability_zone_id": "use1-az4",
            "cidr_block": "10.75.128.0/24",
            "customer_owned_ipv4_pool": "",
            "enable_dns64": false,
            "enable_lni_at_device_index": 0,
            "enable_resource_name_dns_a_record_on_launch": false,
            "enable_resource_name_dns_aaaa_record_on_launch": false,
            "id": "subnet-055b1de2d18737807",
            "ipv6_cidr_block": "",
            "ipv6_cidr_block_association_id": "",
            "ipv6_native": false,
            "map_customer_owned_ip_on_launch": false,
            "map_public_ip_on_launch": false,
            "outpost_arn": "",
            "owner_id": "212809501772",
            "private_dns_hostname_type_on_launch": "ip-name",
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-private-subnet-2",
              "Tier": "private"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-private-subnet-2",
              "Tier": "private"
            },
            "timeouts": null,
            "vpc_id": "vpc-0d67f2118f804df1f"
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6MTIwMDAwMDAwMDAwMH0sInNjaGVtYV92ZXJzaW9uIjoiMSJ9",
          "dependencies": [
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_subnet",
      "name": "vandelay_public_subnets",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "index_key": 0,
          "schema_version": 1,
          "attributes": {
            "arn": "arn:aws:ec2:us-east-1:212809501772:subnet/subnet-07aca3968a20186e1",
            "assign_ipv6_address_on_creation": false,
            "availability_zone": "us-east-1a",
            "availability_zone_id": "use1-az2",
            "cidr_block": "10.75.1.0/24",
            "customer_owned_ipv4_pool": "",
            "enable_dns64": false,
            "enable_lni_at_device_index": 0,
            "enable_resource_name_dns_a_record_on_launch": false,
            "enable_resource_name_dns_aaaa_record_on_launch": false,
            "id": "subnet-07aca3968a20186e1",
            "ipv6_cidr_block": "",
            "ipv6_cidr_block_association_id": "",
            "ipv6_native": false,
            "map_customer_owned_ip_on_launch": false,
            "map_public_ip_on_launch": true,
            "outpost_arn": "",
            "owner_id": "212809501772",
            "private_dns_hostname_type_on_launch": "ip-name",
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-public-subnet-1",
              "Tier": "public"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-public-subnet-1",
              "Tier": "public"
            },
            "timeouts": null,
            "vpc_id": "vpc-0d67f2118f804df1f"
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6MTIwMDAwMDAwMDAwMH0sInNjaGVtYV92ZXJzaW9uIjoiMSJ9",
          "dependencies": [
            "aws_vpc.vandelay_vpc01"
          ]
        },
        {
          "index_key": 1,
          "schema_version": 1,
          "attributes": {
            "arn": "arn:aws:ec2:us-east-1:212809501772:subnet/subnet-023c3131fec823b62",
            "assign_ipv6_address_on_creation": false,
            "availability_zone": "us-east-1b",
            "availability_zone_id": "use1-az4",
            "cidr_block": "10.75.11.0/24",
            "customer_owned_ipv4_pool": "",
            "enable_dns64": false,
            "enable_lni_at_device_index": 0,
            "enable_resource_name_dns_a_record_on_launch": false,
            "enable_resource_name_dns_aaaa_record_on_launch": false,
            "id": "subnet-023c3131fec823b62",
            "ipv6_cidr_block": "",
            "ipv6_cidr_block_association_id": "",
            "ipv6_native": false,
            "map_customer_owned_ip_on_launch": false,
            "map_public_ip_on_launch": true,
            "outpost_arn": "",
            "owner_id": "212809501772",
            "private_dns_hostname_type_on_launch": "ip-name",
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-public-subnet-2",
              "Tier": "public"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-public-subnet-2",
              "Tier": "public"
            },
            "timeouts": null,
            "vpc_id": "vpc-0d67f2118f804df1f"
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6MTIwMDAwMDAwMDAwMH0sInNjaGVtYV92ZXJzaW9uIjoiMSJ9",
          "dependencies": [
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_vpc",
      "name": "vandelay_vpc01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 1,
          "attributes": {
            "arn": "arn:aws:ec2:us-east-1:212809501772:vpc/vpc-0d67f2118f804df1f",
            "assign_generated_ipv6_cidr_block": false,
            "cidr_block": "10.75.0.0/16",
            "default_network_acl_id": "acl-070d27972d5bfb2e1",
            "default_route_table_id": "rtb-0eae7e9f1ec88e899",
            "default_security_group_id": "sg-0823ff5cd598e219c",
            "dhcp_options_id": "dopt-09868a49a5fc616ad",
            "enable_dns_hostnames": true,
            "enable_dns_support": true,
            "enable_network_address_usage_metrics": false,
            "id": "vpc-0d67f2118f804df1f",
            "instance_tenancy": "default",
            "ipv4_ipam_pool_id": null,
            "ipv4_netmask_length": null,
            "ipv6_association_id": "",
            "ipv6_cidr_block": "",
            "ipv6_cidr_block_network_border_group": "",
            "ipv6_ipam_pool_id": "",
            "ipv6_netmask_length": 0,
            "main_route_table_id": "rtb-0eae7e9f1ec88e899",
            "owner_id": "212809501772",
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-vpc01"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-vpc01"
            }
          },
          "sensitive_attributes": [],
          "private": "eyJzY2hlbWFfdmVyc2lvbiI6IjEifQ=="
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_vpc_endpoint",
      "name": "secretsmanager",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:ec2:us-east-1:212809501772:vpc-endpoint/vpce-0369b76e60dc89892",
            "auto_accept": null,
            "cidr_blocks": [],
            "dns_entry": [
              {
                "dns_name": "vpce-0369b76e60dc89892-6zomvseq.secretsmanager.us-east-1.vpce.amazonaws.com",
                "hosted_zone_id": "Z7HUB22UULQXV"
              },
              {
                "dns_name": "vpce-0369b76e60dc89892-6zomvseq-us-east-1b.secretsmanager.us-east-1.vpce.amazonaws.com",
                "hosted_zone_id": "Z7HUB22UULQXV"
              },
              {
                "dns_name": "vpce-0369b76e60dc89892-6zomvseq-us-east-1a.secretsmanager.us-east-1.vpce.amazonaws.com",
                "hosted_zone_id": "Z7HUB22UULQXV"
              },
              {
                "dns_name": "secretsmanager.us-east-1.amazonaws.com",
                "hosted_zone_id": "Z001852611ZT9HYD9DMLC"
              }
            ],
            "dns_options": [
              {
                "dns_record_ip_type": "ipv4",
                "private_dns_only_for_inbound_resolver_endpoint": false
              }
            ],
            "id": "vpce-0369b76e60dc89892",
            "ip_address_type": "ipv4",
            "network_interface_ids": [
              "eni-09961ee1c84b06d22",
              "eni-0c23583ee0bb891ab"
            ],
            "owner_id": "212809501772",
            "policy": "{\"Statement\":[{\"Action\":\"*\",\"Effect\":\"Allow\",\"Principal\":\"*\",\"Resource\":\"*\"}]}",
            "prefix_list_id": null,
            "private_dns_enabled": true,
            "requester_managed": false,
            "resource_configuration_arn": "",
            "route_table_ids": [],
            "security_group_ids": [
              "sg-0573bfaf9a7d4fc94"
            ],
            "service_name": "com.amazonaws.us-east-1.secretsmanager",
            "service_network_arn": "",
            "service_region": "us-east-1",
            "state": "available",
            "subnet_configuration": [
              {
                "ipv4": "10.75.101.34",
                "ipv6": "",
                "subnet_id": "subnet-0afcb35783b14f2c7"
              },
              {
                "ipv4": "10.75.128.145",
                "ipv6": "",
                "subnet_id": "subnet-055b1de2d18737807"
              }
            ],
            "subnet_ids": [
              "subnet-055b1de2d18737807",
              "subnet-0afcb35783b14f2c7"
            ],
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-secretsmanager-vpce"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-secretsmanager-vpce"
            },
            "timeouts": null,
            "vpc_endpoint_type": "Interface",
            "vpc_id": "vpc-0d67f2118f804df1f"
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6NjAwMDAwMDAwMDAwLCJ1cGRhdGUiOjYwMDAwMDAwMDAwMH19",
          "dependencies": [
            "aws_security_group.rotation_lambda_sg",
            "aws_security_group.vandelay_alb_sg01",
            "aws_security_group.vandelay_ec2_sg01",
            "aws_security_group.vpce_sg",
            "aws_subnet.vandelay_private_subnets",
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_vpc_endpoint",
      "name": "vandelay_vpce_ec2messages01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:ec2:us-east-1:212809501772:vpc-endpoint/vpce-08b6c9ba3fe180c6a",
            "auto_accept": null,
            "cidr_blocks": [],
            "dns_entry": [
              {
                "dns_name": "vpce-08b6c9ba3fe180c6a-ctk01jja.ec2messages.us-east-1.vpce.amazonaws.com",
                "hosted_zone_id": "Z7HUB22UULQXV"
              },
              {
                "dns_name": "vpce-08b6c9ba3fe180c6a-ctk01jja-us-east-1b.ec2messages.us-east-1.vpce.amazonaws.com",
                "hosted_zone_id": "Z7HUB22UULQXV"
              },
              {
                "dns_name": "vpce-08b6c9ba3fe180c6a-ctk01jja-us-east-1a.ec2messages.us-east-1.vpce.amazonaws.com",
                "hosted_zone_id": "Z7HUB22UULQXV"
              },
              {
                "dns_name": "ec2messages.us-east-1.amazonaws.com",
                "hosted_zone_id": "Z02220792689G3FRTPFOZ"
              }
            ],
            "dns_options": [
              {
                "dns_record_ip_type": "ipv4",
                "private_dns_only_for_inbound_resolver_endpoint": false
              }
            ],
            "id": "vpce-08b6c9ba3fe180c6a",
            "ip_address_type": "ipv4",
            "network_interface_ids": [
              "eni-05d5ec933c5c67fe9",
              "eni-0b8627fb05aa3e532"
            ],
            "owner_id": "212809501772",
            "policy": "{\"Statement\":[{\"Action\":\"*\",\"Effect\":\"Allow\",\"Principal\":\"*\",\"Resource\":\"*\"}]}",
            "prefix_list_id": null,
            "private_dns_enabled": true,
            "requester_managed": false,
            "resource_configuration_arn": "",
            "route_table_ids": [],
            "security_group_ids": [
              "sg-0878afa15c3c3ee83"
            ],
            "service_name": "com.amazonaws.us-east-1.ec2messages",
            "service_network_arn": "",
            "service_region": "us-east-1",
            "state": "available",
            "subnet_configuration": [
              {
                "ipv4": "10.75.101.13",
                "ipv6": "",
                "subnet_id": "subnet-0afcb35783b14f2c7"
              },
              {
                "ipv4": "10.75.128.232",
                "ipv6": "",
                "subnet_id": "subnet-055b1de2d18737807"
              }
            ],
            "subnet_ids": [
              "subnet-055b1de2d18737807",
              "subnet-0afcb35783b14f2c7"
            ],
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-vpce-ec2messages01"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-vpce-ec2messages01"
            },
            "timeouts": null,
            "vpc_endpoint_type": "Interface",
            "vpc_id": "vpc-0d67f2118f804df1f"
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6NjAwMDAwMDAwMDAwLCJ1cGRhdGUiOjYwMDAwMDAwMDAwMH19",
          "dependencies": [
            "aws_security_group.rotation_lambda_sg",
            "aws_security_group.vandelay_alb_sg01",
            "aws_security_group.vandelay_ec2_sg01",
            "aws_security_group.vandelay_vpce_sg01",
            "aws_subnet.vandelay_private_subnets",
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_vpc_endpoint",
      "name": "vandelay_vpce_kms01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:ec2:us-east-1:212809501772:vpc-endpoint/vpce-0ffabd7940d616afd",
            "auto_accept": null,
            "cidr_blocks": [],
            "dns_entry": [
              {
                "dns_name": "vpce-0ffabd7940d616afd-z55irct1.kms.us-east-1.vpce.amazonaws.com",
                "hosted_zone_id": "Z7HUB22UULQXV"
              },
              {
                "dns_name": "vpce-0ffabd7940d616afd-z55irct1-us-east-1b.kms.us-east-1.vpce.amazonaws.com",
                "hosted_zone_id": "Z7HUB22UULQXV"
              },
              {
                "dns_name": "vpce-0ffabd7940d616afd-z55irct1-us-east-1a.kms.us-east-1.vpce.amazonaws.com",
                "hosted_zone_id": "Z7HUB22UULQXV"
              },
              {
                "dns_name": "kms.us-east-1.amazonaws.com",
                "hosted_zone_id": "Z0018551HP3YASWCCEQV"
              },
              {
                "dns_name": "kms.us-east-1.api.aws",
                "hosted_zone_id": "Z02224862ZE7YXCDG2ZK9"
              }
            ],
            "dns_options": [
              {
                "dns_record_ip_type": "ipv4",
                "private_dns_only_for_inbound_resolver_endpoint": false
              }
            ],
            "id": "vpce-0ffabd7940d616afd",
            "ip_address_type": "ipv4",
            "network_interface_ids": [
              "eni-04051aed15c7b6c05",
              "eni-056cb19da6e90faaa"
            ],
            "owner_id": "212809501772",
            "policy": "{\"Statement\":[{\"Action\":\"*\",\"Effect\":\"Allow\",\"Principal\":\"*\",\"Resource\":\"*\"}]}",
            "prefix_list_id": null,
            "private_dns_enabled": true,
            "requester_managed": false,
            "resource_configuration_arn": "",
            "route_table_ids": [],
            "security_group_ids": [
              "sg-0878afa15c3c3ee83"
            ],
            "service_name": "com.amazonaws.us-east-1.kms",
            "service_network_arn": "",
            "service_region": "us-east-1",
            "state": "available",
            "subnet_configuration": [
              {
                "ipv4": "10.75.101.207",
                "ipv6": "",
                "subnet_id": "subnet-0afcb35783b14f2c7"
              },
              {
                "ipv4": "10.75.128.16",
                "ipv6": "",
                "subnet_id": "subnet-055b1de2d18737807"
              }
            ],
            "subnet_ids": [
              "subnet-055b1de2d18737807",
              "subnet-0afcb35783b14f2c7"
            ],
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-vpce-kms01"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-vpce-kms01"
            },
            "timeouts": null,
            "vpc_endpoint_type": "Interface",
            "vpc_id": "vpc-0d67f2118f804df1f"
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6NjAwMDAwMDAwMDAwLCJ1cGRhdGUiOjYwMDAwMDAwMDAwMH19",
          "dependencies": [
            "aws_security_group.rotation_lambda_sg",
            "aws_security_group.vandelay_alb_sg01",
            "aws_security_group.vandelay_ec2_sg01",
            "aws_security_group.vandelay_vpce_sg01",
            "aws_subnet.vandelay_private_subnets",
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_vpc_endpoint",
      "name": "vandelay_vpce_logs01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:ec2:us-east-1:212809501772:vpc-endpoint/vpce-005aebbe3eca66fc0",
            "auto_accept": null,
            "cidr_blocks": [],
            "dns_entry": [
              {
                "dns_name": "vpce-005aebbe3eca66fc0-asliqtz3.logs.us-east-1.vpce.amazonaws.com",
                "hosted_zone_id": "Z7HUB22UULQXV"
              },
              {
                "dns_name": "vpce-005aebbe3eca66fc0-asliqtz3-us-east-1a.logs.us-east-1.vpce.amazonaws.com",
                "hosted_zone_id": "Z7HUB22UULQXV"
              },
              {
                "dns_name": "vpce-005aebbe3eca66fc0-asliqtz3-us-east-1b.logs.us-east-1.vpce.amazonaws.com",
                "hosted_zone_id": "Z7HUB22UULQXV"
              },
              {
                "dns_name": "logs.us-east-1.amazonaws.com",
                "hosted_zone_id": "Z00178113V7LMPHO804T"
              },
              {
                "dns_name": "streaming-logs.us-east-1.amazonaws.com",
                "hosted_zone_id": "Z0018022BA2ZPUATGPFJ"
              },
              {
                "dns_name": "streaming-logs.us-east-1.api.aws",
                "hosted_zone_id": "Z00180211LJRJZLXH3T0J"
              },
              {
                "dns_name": "logs.us-east-1.api.aws",
                "hosted_zone_id": "Z02287451AZGO1Q9RCUCU"
              }
            ],
            "dns_options": [
              {
                "dns_record_ip_type": "ipv4",
                "private_dns_only_for_inbound_resolver_endpoint": false
              }
            ],
            "id": "vpce-005aebbe3eca66fc0",
            "ip_address_type": "ipv4",
            "network_interface_ids": [
              "eni-0aeb0cdf6b92ebb29",
              "eni-0d52eec5e81ff09e2"
            ],
            "owner_id": "212809501772",
            "policy": "{\"Statement\":[{\"Action\":\"*\",\"Effect\":\"Allow\",\"Principal\":\"*\",\"Resource\":\"*\"}]}",
            "prefix_list_id": null,
            "private_dns_enabled": true,
            "requester_managed": false,
            "resource_configuration_arn": "",
            "route_table_ids": [],
            "security_group_ids": [
              "sg-0878afa15c3c3ee83"
            ],
            "service_name": "com.amazonaws.us-east-1.logs",
            "service_network_arn": "",
            "service_region": "us-east-1",
            "state": "available",
            "subnet_configuration": [
              {
                "ipv4": "10.75.101.51",
                "ipv6": "",
                "subnet_id": "subnet-0afcb35783b14f2c7"
              },
              {
                "ipv4": "10.75.128.113",
                "ipv6": "",
                "subnet_id": "subnet-055b1de2d18737807"
              }
            ],
            "subnet_ids": [
              "subnet-055b1de2d18737807",
              "subnet-0afcb35783b14f2c7"
            ],
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-vpce-logs01"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-vpce-logs01"
            },
            "timeouts": null,
            "vpc_endpoint_type": "Interface",
            "vpc_id": "vpc-0d67f2118f804df1f"
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6NjAwMDAwMDAwMDAwLCJ1cGRhdGUiOjYwMDAwMDAwMDAwMH19",
          "dependencies": [
            "aws_security_group.rotation_lambda_sg",
            "aws_security_group.vandelay_alb_sg01",
            "aws_security_group.vandelay_ec2_sg01",
            "aws_security_group.vandelay_vpce_sg01",
            "aws_subnet.vandelay_private_subnets",
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_vpc_endpoint",
      "name": "vandelay_vpce_monitoring",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:ec2:us-east-1:212809501772:vpc-endpoint/vpce-02c2988cf2db83283",
            "auto_accept": null,
            "cidr_blocks": [],
            "dns_entry": [
              {
                "dns_name": "vpce-02c2988cf2db83283-66d5c0ls.monitoring.us-east-1.vpce.amazonaws.com",
                "hosted_zone_id": "Z7HUB22UULQXV"
              },
              {
                "dns_name": "vpce-02c2988cf2db83283-66d5c0ls-us-east-1a.monitoring.us-east-1.vpce.amazonaws.com",
                "hosted_zone_id": "Z7HUB22UULQXV"
              },
              {
                "dns_name": "vpce-02c2988cf2db83283-66d5c0ls-us-east-1b.monitoring.us-east-1.vpce.amazonaws.com",
                "hosted_zone_id": "Z7HUB22UULQXV"
              },
              {
                "dns_name": "monitoring.us-east-1.amazonaws.com",
                "hosted_zone_id": "Z02154812K5Q8WJSRRQVL"
              },
              {
                "dns_name": "monitoring.us-east-1.api.aws",
                "hosted_zone_id": "Z06297922H3YCRJVFSJIW"
              },
              {
                "dns_name": "monitoring-fips.us-east-1.amazonaws.com",
                "hosted_zone_id": "Z0215480Q4EYKC2JWE2S"
              },
              {
                "dns_name": "monitoring-fips.us-east-1.api.aws",
                "hosted_zone_id": "Z094114028XJ41AW2DLYM"
              }
            ],
            "dns_options": [
              {
                "dns_record_ip_type": "ipv4",
                "private_dns_only_for_inbound_resolver_endpoint": false
              }
            ],
            "id": "vpce-02c2988cf2db83283",
            "ip_address_type": "ipv4",
            "network_interface_ids": [
              "eni-05bb4ce9a4dc8f4e5",
              "eni-0d343aaead9b7d7d7"
            ],
            "owner_id": "212809501772",
            "policy": "{\"Statement\":[{\"Action\":\"*\",\"Effect\":\"Allow\",\"Principal\":\"*\",\"Resource\":\"*\"}]}",
            "prefix_list_id": null,
            "private_dns_enabled": true,
            "requester_managed": false,
            "resource_configuration_arn": "",
            "route_table_ids": [],
            "security_group_ids": [
              "sg-0573bfaf9a7d4fc94"
            ],
            "service_name": "com.amazonaws.us-east-1.monitoring",
            "service_network_arn": "",
            "service_region": "us-east-1",
            "state": "available",
            "subnet_configuration": [
              {
                "ipv4": "10.75.101.35",
                "ipv6": "",
                "subnet_id": "subnet-0afcb35783b14f2c7"
              },
              {
                "ipv4": "10.75.128.43",
                "ipv6": "",
                "subnet_id": "subnet-055b1de2d18737807"
              }
            ],
            "subnet_ids": [
              "subnet-055b1de2d18737807",
              "subnet-0afcb35783b14f2c7"
            ],
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-vpce-monitoring"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-vpce-monitoring"
            },
            "timeouts": null,
            "vpc_endpoint_type": "Interface",
            "vpc_id": "vpc-0d67f2118f804df1f"
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6NjAwMDAwMDAwMDAwLCJ1cGRhdGUiOjYwMDAwMDAwMDAwMH19",
          "dependencies": [
            "aws_security_group.rotation_lambda_sg",
            "aws_security_group.vandelay_alb_sg01",
            "aws_security_group.vandelay_ec2_sg01",
            "aws_security_group.vpce_sg",
            "aws_subnet.vandelay_private_subnets",
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_vpc_endpoint",
      "name": "vandelay_vpce_s3_gw01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:ec2:us-east-1:212809501772:vpc-endpoint/vpce-06639a5ef7a87b32f",
            "auto_accept": null,
            "cidr_blocks": [
              "16.15.176.0/20",
              "16.182.0.0/16",
              "18.34.0.0/19",
              "52.216.0.0/15",
              "54.231.0.0/16",
              "3.5.0.0/19",
              "18.34.232.0/21",
              "16.15.192.0/18"
            ],
            "dns_entry": [],
            "dns_options": [
              {
                "dns_record_ip_type": "service-defined",
                "private_dns_only_for_inbound_resolver_endpoint": false
              }
            ],
            "id": "vpce-06639a5ef7a87b32f",
            "ip_address_type": "ipv4",
            "network_interface_ids": [],
            "owner_id": "212809501772",
            "policy": "{\"Statement\":[{\"Action\":\"*\",\"Effect\":\"Allow\",\"Principal\":\"*\",\"Resource\":\"*\"}],\"Version\":\"2008-10-17\"}",
            "prefix_list_id": "pl-63a5400a",
            "private_dns_enabled": false,
            "requester_managed": false,
            "resource_configuration_arn": "",
            "route_table_ids": [
              "rtb-09fbe667f708a8eef"
            ],
            "security_group_ids": [],
            "service_name": "com.amazonaws.us-east-1.s3",
            "service_network_arn": "",
            "service_region": "us-east-1",
            "state": "available",
            "subnet_configuration": [],
            "subnet_ids": [],
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-vpce-s3-gw01"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-vpce-s3-gw01"
            },
            "timeouts": null,
            "vpc_endpoint_type": "Gateway",
            "vpc_id": "vpc-0d67f2118f804df1f"
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6NjAwMDAwMDAwMDAwLCJ1cGRhdGUiOjYwMDAwMDAwMDAwMH19",
          "dependencies": [
            "aws_route_table.vandelay_private_rt01",
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_vpc_endpoint",
      "name": "vandelay_vpce_ssm01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:ec2:us-east-1:212809501772:vpc-endpoint/vpce-03e3f9347caa1a521",
            "auto_accept": null,
            "cidr_blocks": [],
            "dns_entry": [
              {
                "dns_name": "vpce-03e3f9347caa1a521-giwb6pgl.ssm.us-east-1.vpce.amazonaws.com",
                "hosted_zone_id": "Z7HUB22UULQXV"
              },
              {
                "dns_name": "vpce-03e3f9347caa1a521-giwb6pgl-us-east-1b.ssm.us-east-1.vpce.amazonaws.com",
                "hosted_zone_id": "Z7HUB22UULQXV"
              },
              {
                "dns_name": "vpce-03e3f9347caa1a521-giwb6pgl-us-east-1a.ssm.us-east-1.vpce.amazonaws.com",
                "hosted_zone_id": "Z7HUB22UULQXV"
              },
              {
                "dns_name": "ssm.us-east-1.amazonaws.com",
                "hosted_zone_id": "Z096197561Z1EGKE27RS"
              },
              {
                "dns_name": "ssm.us-east-1.api.aws",
                "hosted_zone_id": "Z0961970MOY40O7MRAML"
              }
            ],
            "dns_options": [
              {
                "dns_record_ip_type": "ipv4",
                "private_dns_only_for_inbound_resolver_endpoint": false
              }
            ],
            "id": "vpce-03e3f9347caa1a521",
            "ip_address_type": "ipv4",
            "network_interface_ids": [
              "eni-08cac8f90ff57c3ac",
              "eni-0a737b34aadf3d7d6"
            ],
            "owner_id": "212809501772",
            "policy": "{\"Statement\":[{\"Action\":\"*\",\"Effect\":\"Allow\",\"Principal\":\"*\",\"Resource\":\"*\"}]}",
            "prefix_list_id": null,
            "private_dns_enabled": true,
            "requester_managed": false,
            "resource_configuration_arn": "",
            "route_table_ids": [],
            "security_group_ids": [
              "sg-0878afa15c3c3ee83"
            ],
            "service_name": "com.amazonaws.us-east-1.ssm",
            "service_network_arn": "",
            "service_region": "us-east-1",
            "state": "available",
            "subnet_configuration": [
              {
                "ipv4": "10.75.101.42",
                "ipv6": "",
                "subnet_id": "subnet-0afcb35783b14f2c7"
              },
              {
                "ipv4": "10.75.128.56",
                "ipv6": "",
                "subnet_id": "subnet-055b1de2d18737807"
              }
            ],
            "subnet_ids": [
              "subnet-055b1de2d18737807",
              "subnet-0afcb35783b14f2c7"
            ],
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-vpce-ssm01"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-vpce-ssm01"
            },
            "timeouts": null,
            "vpc_endpoint_type": "Interface",
            "vpc_id": "vpc-0d67f2118f804df1f"
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6NjAwMDAwMDAwMDAwLCJ1cGRhdGUiOjYwMDAwMDAwMDAwMH19",
          "dependencies": [
            "aws_security_group.rotation_lambda_sg",
            "aws_security_group.vandelay_alb_sg01",
            "aws_security_group.vandelay_ec2_sg01",
            "aws_security_group.vandelay_vpce_sg01",
            "aws_subnet.vandelay_private_subnets",
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_vpc_endpoint",
      "name": "vandelay_vpce_ssmmessages01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:ec2:us-east-1:212809501772:vpc-endpoint/vpce-0590e65771cc8979c",
            "auto_accept": null,
            "cidr_blocks": [],
            "dns_entry": [
              {
                "dns_name": "vpce-0590e65771cc8979c-sv4jql80.ssmmessages.us-east-1.vpce.amazonaws.com",
                "hosted_zone_id": "Z7HUB22UULQXV"
              },
              {
                "dns_name": "vpce-0590e65771cc8979c-sv4jql80-us-east-1a.ssmmessages.us-east-1.vpce.amazonaws.com",
                "hosted_zone_id": "Z7HUB22UULQXV"
              },
              {
                "dns_name": "vpce-0590e65771cc8979c-sv4jql80-us-east-1b.ssmmessages.us-east-1.vpce.amazonaws.com",
                "hosted_zone_id": "Z7HUB22UULQXV"
              },
              {
                "dns_name": "ssmmessages.us-east-1.amazonaws.com",
                "hosted_zone_id": "Z022929524N4QLKSRODRH"
              },
              {
                "dns_name": "ssmmessages.us-east-1.api.aws",
                "hosted_zone_id": "Z022929412HB56VUJNVJX"
              }
            ],
            "dns_options": [
              {
                "dns_record_ip_type": "ipv4",
                "private_dns_only_for_inbound_resolver_endpoint": false
              }
            ],
            "id": "vpce-0590e65771cc8979c",
            "ip_address_type": "ipv4",
            "network_interface_ids": [
              "eni-02802fda86647deeb",
              "eni-0f0da3c0f83b7388d"
            ],
            "owner_id": "212809501772",
            "policy": "{\"Statement\":[{\"Action\":\"*\",\"Effect\":\"Allow\",\"Principal\":\"*\",\"Resource\":\"*\"}]}",
            "prefix_list_id": null,
            "private_dns_enabled": true,
            "requester_managed": false,
            "resource_configuration_arn": "",
            "route_table_ids": [],
            "security_group_ids": [
              "sg-0878afa15c3c3ee83"
            ],
            "service_name": "com.amazonaws.us-east-1.ssmmessages",
            "service_network_arn": "",
            "service_region": "us-east-1",
            "state": "available",
            "subnet_configuration": [
              {
                "ipv4": "10.75.101.151",
                "ipv6": "",
                "subnet_id": "subnet-0afcb35783b14f2c7"
              },
              {
                "ipv4": "10.75.128.70",
                "ipv6": "",
                "subnet_id": "subnet-055b1de2d18737807"
              }
            ],
            "subnet_ids": [
              "subnet-055b1de2d18737807",
              "subnet-0afcb35783b14f2c7"
            ],
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-vpce-ssmmessages01"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-vpce-ssmmessages01"
            },
            "timeouts": null,
            "vpc_endpoint_type": "Interface",
            "vpc_id": "vpc-0d67f2118f804df1f"
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6NjAwMDAwMDAwMDAwLCJ1cGRhdGUiOjYwMDAwMDAwMDAwMH19",
          "dependencies": [
            "aws_security_group.rotation_lambda_sg",
            "aws_security_group.vandelay_alb_sg01",
            "aws_security_group.vandelay_ec2_sg01",
            "aws_security_group.vandelay_vpce_sg01",
            "aws_subnet.vandelay_private_subnets",
            "aws_vpc.vandelay_vpc01"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_wafv2_web_acl",
      "name": "vandelay_waf01",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "application_integration_url": "",
            "arn": "arn:aws:wafv2:us-east-1:212809501772:regional/webacl/vandelay-waf01/b1346939-02cc-4fd1-8650-674d4ab1d43e",
            "association_config": [],
            "capacity": 1125,
            "captcha_config": [],
            "challenge_config": [],
            "custom_response_body": [],
            "data_protection_config": [],
            "default_action": [
              {
                "allow": [
                  {
                    "custom_request_handling": []
                  }
                ],
                "block": []
              }
            ],
            "description": "WAF for Vandelay ALB",
            "id": "b1346939-02cc-4fd1-8650-674d4ab1d43e",
            "lock_token": "0a3d441b-5d3c-4057-83ed-f6cc7d596d30",
            "name": "vandelay-waf01",
            "name_prefix": "",
            "rule": [
              {
                "action": [],
                "captcha_config": [],
                "challenge_config": [],
                "name": "AWS-AWSManagedRulesAmazonIpReputationList",
                "override_action": [
                  {
                    "count": [],
                    "none": [
                      {}
                    ]
                  }
                ],
                "priority": 0,
                "rule_label": [],
                "statement": [
                  {
                    "and_statement": [],
                    "asn_match_statement": [],
                    "byte_match_statement": [],
                    "geo_match_statement": [],
                    "ip_set_reference_statement": [],
                    "label_match_statement": [],
                    "managed_rule_group_statement": [
                      {
                        "managed_rule_group_configs": [],
                        "name": "AWSManagedRulesAmazonIpReputationList",
                        "rule_action_override": [],
                        "scope_down_statement": [],
                        "vendor_name": "AWS",
                        "version": ""
                      }
                    ],
                    "not_statement": [],
                    "or_statement": [],
                    "rate_based_statement": [],
                    "regex_match_statement": [],
                    "regex_pattern_set_reference_statement": [],
                    "rule_group_reference_statement": [],
                    "size_constraint_statement": [],
                    "sqli_match_statement": [],
                    "xss_match_statement": []
                  }
                ],
                "visibility_config": [
                  {
                    "cloudwatch_metrics_enabled": true,
                    "metric_name": "vandelay-ip-reputation",
                    "sampled_requests_enabled": true
                  }
                ]
              },
              {
                "action": [],
                "captcha_config": [],
                "challenge_config": [],
                "name": "AWS-AWSManagedRulesCommonRuleSet",
                "override_action": [
                  {
                    "count": [],
                    "none": [
                      {}
                    ]
                  }
                ],
                "priority": 1,
                "rule_label": [],
                "statement": [
                  {
                    "and_statement": [],
                    "asn_match_statement": [],
                    "byte_match_statement": [],
                    "geo_match_statement": [],
                    "ip_set_reference_statement": [],
                    "label_match_statement": [],
                    "managed_rule_group_statement": [
                      {
                        "managed_rule_group_configs": [],
                        "name": "AWSManagedRulesCommonRuleSet",
                        "rule_action_override": [],
                        "scope_down_statement": [],
                        "vendor_name": "AWS",
                        "version": ""
                      }
                    ],
                    "not_statement": [],
                    "or_statement": [],
                    "rate_based_statement": [],
                    "regex_match_statement": [],
                    "regex_pattern_set_reference_statement": [],
                    "rule_group_reference_statement": [],
                    "size_constraint_statement": [],
                    "sqli_match_statement": [],
                    "xss_match_statement": []
                  }
                ],
                "visibility_config": [
                  {
                    "cloudwatch_metrics_enabled": true,
                    "metric_name": "vandelay-common-rules",
                    "sampled_requests_enabled": true
                  }
                ]
              },
              {
                "action": [],
                "captcha_config": [],
                "challenge_config": [],
                "name": "AWS-AWSManagedRulesKnownBadInputsRuleSet",
                "override_action": [
                  {
                    "count": [],
                    "none": [
                      {}
                    ]
                  }
                ],
                "priority": 2,
                "rule_label": [],
                "statement": [
                  {
                    "and_statement": [],
                    "asn_match_statement": [],
                    "byte_match_statement": [],
                    "geo_match_statement": [],
                    "ip_set_reference_statement": [],
                    "label_match_statement": [],
                    "managed_rule_group_statement": [
                      {
                        "managed_rule_group_configs": [],
                        "name": "AWSManagedRulesKnownBadInputsRuleSet",
                        "rule_action_override": [],
                        "scope_down_statement": [],
                        "vendor_name": "AWS",
                        "version": ""
                      }
                    ],
                    "not_statement": [],
                    "or_statement": [],
                    "rate_based_statement": [],
                    "regex_match_statement": [],
                    "regex_pattern_set_reference_statement": [],
                    "rule_group_reference_statement": [],
                    "size_constraint_statement": [],
                    "sqli_match_statement": [],
                    "xss_match_statement": []
                  }
                ],
                "visibility_config": [
                  {
                    "cloudwatch_metrics_enabled": true,
                    "metric_name": "vandelay-bad-inputs",
                    "sampled_requests_enabled": true
                  }
                ]
              },
              {
                "action": [],
                "captcha_config": [],
                "challenge_config": [],
                "name": "AWS-AWSManagedRulesSQLiRuleSet",
                "override_action": [
                  {
                    "count": [],
                    "none": [
                      {}
                    ]
                  }
                ],
                "priority": 3,
                "rule_label": [],
                "statement": [
                  {
                    "and_statement": [],
                    "asn_match_statement": [],
                    "byte_match_statement": [],
                    "geo_match_statement": [],
                    "ip_set_reference_statement": [],
                    "label_match_statement": [],
                    "managed_rule_group_statement": [
                      {
                        "managed_rule_group_configs": [],
                        "name": "AWSManagedRulesSQLiRuleSet",
                        "rule_action_override": [],
                        "scope_down_statement": [],
                        "vendor_name": "AWS",
                        "version": ""
                      }
                    ],
                    "not_statement": [],
                    "or_statement": [],
                    "rate_based_statement": [],
                    "regex_match_statement": [],
                    "regex_pattern_set_reference_statement": [],
                    "rule_group_reference_statement": [],
                    "size_constraint_statement": [],
                    "sqli_match_statement": [],
                    "xss_match_statement": []
                  }
                ],
                "visibility_config": [
                  {
                    "cloudwatch_metrics_enabled": true,
                    "metric_name": "vandelay-sqli-rules",
                    "sampled_requests_enabled": true
                  }
                ]
              }
            ],
            "rule_json": null,
            "scope": "REGIONAL",
            "tags": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-waf01"
            },
            "tags_all": {
              "Lab": "ec2-rds-integration",
              "Name": "vandelay-waf01"
            },
            "token_domains": [],
            "visibility_config": [
              {
                "cloudwatch_metrics_enabled": true,
                "metric_name": "vandelay-waf",
                "sampled_requests_enabled": true
              }
            ]
          },
          "sensitive_attributes": [],
          "private": "bnVsbA=="
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_wafv2_web_acl_association",
      "name": "vandelay_waf_alb_assoc",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "id": "arn:aws:wafv2:us-east-1:212809501772:regional/webacl/vandelay-waf01/b1346939-02cc-4fd1-8650-674d4ab1d43e,arn:aws:elasticloadbalancing:us-east-1:212809501772:loadbalancer/app/vandelay-alb01/946e933d1e5bbcbf",
            "resource_arn": "arn:aws:elasticloadbalancing:us-east-1:212809501772:loadbalancer/app/vandelay-alb01/946e933d1e5bbcbf",
            "timeouts": null,
            "web_acl_arn": "arn:aws:wafv2:us-east-1:212809501772:regional/webacl/vandelay-waf01/b1346939-02cc-4fd1-8650-674d4ab1d43e"
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDB9fQ==",
          "dependencies": [
            "aws_lb.vandelay_alb01",
            "aws_s3_bucket.vandelay_alb_logs",
            "aws_security_group.vandelay_alb_sg01",
            "aws_subnet.vandelay_public_subnets",
            "aws_vpc.vandelay_vpc01",
            "aws_wafv2_web_acl.vandelay_waf01",
            "data.aws_caller_identity.current"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_wafv2_web_acl_logging_configuration",
      "name": "vandelay_waf_logging",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "id": "arn:aws:wafv2:us-east-1:212809501772:regional/webacl/vandelay-waf01/b1346939-02cc-4fd1-8650-674d4ab1d43e",
            "log_destination_configs": [
              "arn:aws:logs:us-east-1:212809501772:log-group:aws-waf-logs-vandelay-webacl"
            ],
            "logging_filter": [],
            "redacted_fields": [],
            "resource_arn": "arn:aws:wafv2:us-east-1:212809501772:regional/webacl/vandelay-waf01/b1346939-02cc-4fd1-8650-674d4ab1d43e"
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "aws_cloudwatch_log_group.vandelay_waf_logs",
            "aws_wafv2_web_acl.vandelay_waf01"
          ]
        }
      ]
    }
  ],
  "check_results": null
}