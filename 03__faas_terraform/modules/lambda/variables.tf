variable "prefix" {
  description = "Unique text element to be added in resources."
}

variable "sqs_queue_id" {
  description = "Id of SQS query."
}

variable "sqs_name" {
  description = "Name of SQS query."
}

variable "region" {
  description = "AWS region to be deployed"
}

variable "account_id" {
  description = "Account ID of AWS"
}