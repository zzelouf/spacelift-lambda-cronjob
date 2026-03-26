variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "cronjob_name" {
  description = "Name for the Lambda cronjob"
  type        = string
  default     = "spacelift-demo-cronjob"
}

variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "sl-"
}

variable "comment_prefix" {
  description = "Prefix for resource descriptions"
  type        = string
  default     = "Lambda Cronjob: "
}

variable "schedule_expression" {
  description = "EventBridge schedule expression (e.g., \"rate(5 minutes)\" or \"cron(0 12 * * ? *)\")"
  type        = string
  default     = "rate(5 minutes)"
}

variable "function_zipfile" {
  description = "Path to the Lambda deployment ZIP file"
  type        = string
  default     = "lambda.zip"
}

variable "function_handler" {
  description = "Lambda function handler"
  type        = string
  default     = "index.handler"
}

variable "function_timeout" {
  description = "Lambda function timeout in seconds"
  type        = number
  default     = 3
}

variable "memory_size" {
  description = "Lambda function memory in MB"
  type        = number
  default     = 128
}

variable "function_runtime" {
  description = "Lambda runtime (e.g., nodejs18.x, nodejs20.x, python3.12)"
  type        = string
  default     = "nodejs18.x"
}

variable "function_env_vars" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
  default = {
    ENVIRONMENT = "demo"
  }
}

variable "lambda_logging_enabled" {
  description = "Enable CloudWatch logging for the Lambda function"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "demo"
    Project     = "spacelift"
    ManagedBy   = "terraform"
  }
}

locals {
  prefix_with_name = "${var.name_prefix}${replace(var.cronjob_name, "/[^a-z0-9-]+/", "-")}"
}
