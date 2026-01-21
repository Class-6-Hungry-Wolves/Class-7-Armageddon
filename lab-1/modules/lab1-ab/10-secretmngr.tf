############################################
# Secrets Manager (DB Credentials)
############################################

# Explanation: Secrets Manager is Chewbacca’s locked holster—credentials go here, not in code.
resource "aws_secretsmanager_secret" "chewbacca_db_secret01" {
  name = "${local.name_prefix}/rds/mysql"
  recovery_window_in_days = 0
}

# Explanation: Secret payload—students should align this structure with their app (and support rotation later).
resource "aws_secretsmanager_secret_version" "chewbacca_db_secret_version01" {
  secret_id = aws_secretsmanager_secret.chewbacca_db_secret01.id

  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
    host     = aws_db_instance.chewbacca_rds01.address
    port     = aws_db_instance.chewbacca_rds01.port
    dbname   = var.db_name
  })
}

resource "aws_secretsmanager_secret_rotation" "chewbacca_db_secret_rotate" {
  secret_id           = aws_secretsmanager_secret.chewbacca_db_secret01.id
  rotation_lambda_arn = aws_lambda_function.lambda_rotator.arn

  rotation_rules {
    automatically_after_days = 30
  }
}
