############################################
# Lambda Function used for Secrets Rotation
############################################

resource "aws_lambda_function" "lambda_rotator" {
  filename      = "${path.module}/rotation_lambda.zip" # My rotation code
  function_name = "${local.name_prefix}-secret-rotator"
  role          = aws_iam_role.lambda_rotator_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.11"
}

#Explanation: Permiting Secrets Manager to invoke the Lambda function
resource "aws_lambda_permission" "allow_secretsmanager" {
  statement_id  = "AllowExecutionFromSecretsManager"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_rotator.function_name
  principal     = "secretsmanager.amazonaws.com"
  source_arn    = aws_secretsmanager_secret.chewbacca_db_secret01.arn
}
