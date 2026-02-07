############################################
# Lab 3: Tokyo RDS Instance (MySQL)
# APPI Compliance: All PHI stored exclusively in Tokyo
############################################

resource "aws_db_instance" "chewbacca_rds01" {
  identifier        = "${local.tokyo_prefix}-rds01"
  engine            = var.db_engine
  engine_version    = "8.0"
  instance_class    = var.db_instance_class
  allocated_storage = 20
  db_name           = var.db_name
  username          = var.db_username
  password          = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.chewbacca_rds_subnet_group01.name
  vpc_security_group_ids = [aws_security_group.chewbacca_rds_sg01.id]

  publicly_accessible = false
  skip_final_snapshot = true

  # Ignore password changes - Secrets Manager rotation manages the password
  lifecycle {
    ignore_changes = [password]
  }

  tags = merge(local.tokyo_tags, {
    Name       = "${local.tokyo_prefix}-rds01"
    Compliance = "APPI"
  })
}

############################################
# SSM Parameter Store for RDS Config
############################################

resource "aws_ssm_parameter" "chewbacca_db_endpoint_param" {
  name  = "/chewbacca/db/endpoint"
  type  = "String"
  value = aws_db_instance.chewbacca_rds01.address

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-param-db-endpoint"
  })
}

resource "aws_ssm_parameter" "chewbacca_db_port_param" {
  name  = "/chewbacca/db/port"
  type  = "String"
  value = tostring(aws_db_instance.chewbacca_rds01.port)

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-param-db-port"
  })
}

resource "aws_ssm_parameter" "chewbacca_db_name_param" {
  name  = "/chewbacca/db/name"
  type  = "String"
  value = var.db_name

  tags = merge(local.tokyo_tags, {
    Name = "${local.tokyo_prefix}-param-db-name"
  })
}
