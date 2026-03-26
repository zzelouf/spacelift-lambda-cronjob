# Deploy Lambda function from local zipfile
resource "aws_lambda_function" "this" {
  filename         = var.function_zipfile
  source_code_hash = filebase64sha256(var.function_zipfile)

  description   = "${var.comment_prefix}${var.cronjob_name}"
  function_name = local.prefix_with_name
  handler       = var.function_handler
  runtime       = var.function_runtime
  timeout       = var.function_timeout
  memory_size   = var.memory_size
  role          = aws_iam_role.this.arn
  tags          = var.tags

  environment {
    variables = var.function_env_vars
  }
}
