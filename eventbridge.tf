# EventBridge scheduled rule
resource "aws_cloudwatch_event_rule" "this" {
  name                = "${local.prefix_with_name}-schedule"
  description         = "Triggers ${var.cronjob_name} on a schedule"
  schedule_expression = var.schedule_expression
  tags                = var.tags
}

# EventBridge target — invoke Lambda
resource "aws_cloudwatch_event_target" "this" {
  rule      = aws_cloudwatch_event_rule.this.name
  target_id = aws_cloudwatch_event_rule.this.name
  arn       = aws_lambda_function.this.arn
}

# Allow EventBridge to invoke this Lambda
resource "aws_lambda_permission" "eventbridge" {
  statement_id  = "${local.prefix_with_name}-eventbridge-invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.this.arn
}
