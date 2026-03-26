# EventBridge Scheduler
resource "aws_scheduler_schedule" "this" {
  name        = "${local.prefix_with_name}-schedule"
  description = "Triggers ${var.cronjob_name} on a schedule"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = var.schedule_expression

  target {
    arn      = aws_lambda_function.this.arn
    role_arn = aws_iam_role.scheduler.arn
  }
}

# IAM role for EventBridge Scheduler
resource "aws_iam_role" "scheduler" {
  name = "${local.prefix_with_name}-scheduler"
  tags = var.tags

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "scheduler.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

/*
# Allow EventBridge Scheduler to invoke Lambda
resource "aws_iam_role_policy" "scheduler_invoke" {
  name = "${local.prefix_with_name}-scheduler-invoke"
  role = aws_iam_role.scheduler.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "lambda:InvokeFunction"
        Resource = aws_lambda_function.this.arn
      }
    ]
  })
}
*/
