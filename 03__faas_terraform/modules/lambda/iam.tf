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

data "aws_iam_policy_document" "log_group_policy" {
  statement {
    effect = "Allow"
    actions = ["logs:CreateLogGroup"]
    resources = ["arn:aws:logs:${var.region}:${var.account_id}:*"]
  }

  statement {
    effect = "Allow"
    actions = ["logs:CreateLogStream",
               "logs:PutLogEvents"]
    resources = ["arn:aws:logs:${var.region}:${var.account_id}:log-group:*:*"]
  }
}

data "aws_iam_policy_document" "sqs_policy" {
  statement {
    effect = "Allow"
    actions = ["sqs:SendMessage"]
    resources = [
      "arn:aws:sqs:${var.region}:${var.account_id}:${var.sqs_name}"
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
      "s3:PutObject"
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

  inline_policy {
    name   = "httplambda_${var.prefix}_logs_policy"
    policy = data.aws_iam_policy_document.log_group_policy.json
  }
}

resource "aws_iam_role" "iam_for_event_lambda" {
  name               = "event_to_s3_lambda_${var.prefix}_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  inline_policy {
    name   = "sqs_read_policy"
    policy = data.aws_iam_policy_document.sqs_read_policy.json
  }

  inline_policy {
    name   = "eventlambda_${var.prefix}_logs_policy"
    policy = data.aws_iam_policy_document.log_group_policy.json
  }
}

resource "aws_iam_policy" "log_group_policy" {
  name   = "lambda_${var.prefix}_logs_policy"
  policy = data.aws_iam_policy_document.log_group_policy.json
}

resource "aws_iam_role_policy_attachment" "http_attachment_logs" {
  role       = aws_iam_role.iam_for_http_lambda.name
  policy_arn = aws_iam_policy.log_group_policy.arn
}

resource "aws_iam_role_policy_attachment" "event_attachment_logs" {
  role       = aws_iam_role.iam_for_event_lambda.name
  policy_arn = aws_iam_policy.log_group_policy.arn
}
