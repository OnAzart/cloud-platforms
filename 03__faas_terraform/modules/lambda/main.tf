provider "aws" {
  region  = "${var.region}"
}


data "archive_file" "http_lambda_arch" {
  type        = "zip"
  # [QUESTION] how to make relative path active from both cases:
  # 1. launch terraform from this directory
  # 2. launch terraform from main directory (general)
  source_file = "../02__faas/HttpFunction/HttpFunc.py"
  output_path = "HttpFunc.zip"
}


data "archive_file" "event_lambda_arch" {
  type        = "zip"
  source_file = "../02__faas/EventToS3Function/EventToS3.py"
  output_path = "EventToS3.zip"
}


resource "aws_lambda_function" "http_lambda" {
  filename      = "HttpFunc.zip"
  function_name = "http_lambda_${var.prefix}"
  role          = aws_iam_role.iam_for_http_lambda.arn
  handler       = "HttpFunc.send_to_sqs_on_http_trigger"
  reserved_concurrent_executions = 2

  runtime = "python3.10"

  environment {
    variables = {
      SQS_URL = var.sqs_queue_id
    }
  }
}

resource "aws_lambda_function_url" "http_lambda_function_url" {
  function_name      = aws_lambda_function.http_lambda.function_name
  authorization_type = "NONE"
}


resource "aws_lambda_function" "event_to_s3_lambda" {
  filename      = "EventToS3.zip"
  function_name = "event_to_s3_lambda_${var.prefix}"
  role          = aws_iam_role.iam_for_event_lambda.arn
  handler       = "EventToS3.sqs_to_s3"
  reserved_concurrent_executions = 2

  runtime = "python3.10"
}

resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  batch_size        = 1
  event_source_arn  = "arn:aws:sqs:${var.region}:${var.account_id}:${var.sqs_name}"
  enabled           = true
  function_name     = aws_lambda_function.event_to_s3_lambda.function_name
}
