import json
import boto3
import os

sqs = boto3.client('sqs')

# Specify the URL of your SQS queue
queue_url = os.getenv("SQS_URL")


def send_to_sqs_on_http_trigger(event, context):
    value = event.get('id', None)
    value_from_query = event.get('queryStringParameters', None)
    if value_from_query:
        value = value_from_query.get('id', None)
        response = sqs.send_message(
                QueueUrl=queue_url,
                MessageBody=str(value)
            )
    return {
        'statusCode': 200,
        'body': json.dumps(f'Hello from Lambda! {value}')
    }
