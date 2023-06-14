import json
import boto3


def lambda_handler(event, context):
    # Create an S3 client
    s3 = boto3.client('s3')
    # The name of your bucket
    bucket_name = 'uku-onazart'

    for record in event['Records']:
        file_content = json.dumps(record)

        key = f'cloud_platforms/manual_flow/{record["body"]}.json'

        # Write the file to S3
        s3.put_object(Body=file_content, Bucket=bucket_name, Key=key)

    return {
        'statusCode': 200,
        'body': 'Data written to S3'
    }

