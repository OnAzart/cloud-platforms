data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "sqs_policy" {
  statement {
    effect = "Allow"
    actions = ["sqs:SendMessage"]
    resources = [
      "arn:aws:sqs:${var.region}:${var.account_id}:${var.sqs_name}",
      "logs:CreateLogGroup"
    ]
  }
}

data "aws_iam_policy_document" "sqs_read_policy" {
  statement {
    effect = "Allow"
    actions = [
      "sqs:ChangeMessageVisibility",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes",
      "sqs:ReceiveMessage",
      "s3:PutObject",
      "logs:CreateLogGroup"
    ]
    resources = [
      "arn:aws:sqs:${var.region}:${var.account_id}:${var.sqs_name}",
      "arn:aws:s3:::uku-onazart/*"
    ]
  }
}

resource "aws_iam_role" "iam_for_http_lambda" {
  name               = "http_lambda_${var.prefix}_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  inline_policy {
    name   = "sqs_${var.prefix}_policy"
    policy = data.aws_iam_policy_document.sqs_policy.json
  }
}

resource "aws_iam_role" "iam_for_event_lambda" {
  name               = "event_to_s3_lambda_${var.prefix}_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  inline_policy {
    name   = "sqs_read_policy"
    policy = data.aws_iam_policy_document.sqs_read_policy.json
  }
}
