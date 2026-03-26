output "function_name" {
  description = "The name of the Lambda function"
  value       = aws_lambda_function.this.function_name
}

output "function_arn" {
  description = "The ARN of the Lambda function"
  value       = aws_lambda_function.this.arn
}

output "schedule_arn" {
  description = "The ARN of the EventBridge schedule"
  value       = aws_scheduler_schedule.this.arn
}

output "schedule_expression" {
  description = "The EventBridge schedule expression"
  value       = var.schedule_expression
}
