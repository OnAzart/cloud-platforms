import json
import boto3

sqs = boto3.client('sqs')

# Specify the URL of your SQS queue
queue_url = 'https://sqs.us-east-2.amazonaws.com/846446690345/test_queue'  # replace with your queue URL


def lambda_handler(event, context):
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
