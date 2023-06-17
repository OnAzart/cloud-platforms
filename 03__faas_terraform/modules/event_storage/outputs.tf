output "sqs_queue_id" {
  value = aws_sqs_queue.terraform_queue.id
  sensitive = true
}

output "sqs_queue_name" {
  value = aws_sqs_queue.terraform_queue.name
  sensitive = true
}
