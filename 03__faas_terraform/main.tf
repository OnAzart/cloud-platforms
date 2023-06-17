terraform{
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~>4.16"
      }
    }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-2"
}

resource "random_string" "random" {
  length           = 4
  special          = false
}

module "event_storage" {
  source = "./modules/event_storage"
  region = var.region
  prefix = random_string.random.result
}

module "lambda" {
  source = "./modules/lambda"
  prefix = random_string.random.result

  region = var.region
  account_id = var.account_id

  sqs_queue_id = module.event_storage.sqs_queue_id
  sqs_name = module.event_storage.sqs_queue_name
}

