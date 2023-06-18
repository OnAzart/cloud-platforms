provider "aws" {
  region  = "${var.region}"
}

resource "aws_sqs_queue" "terraform_queue" {
  name                      = "queue-${var.prefix}"
  delay_seconds             = 10
  max_message_size          = 2048
  message_retention_seconds = 8640
  receive_wait_time_seconds = 8
  sqs_managed_sse_enabled = true
}

