import json

import boto3

def lambda_handler(event, context):
    print(event)
    records = event['Records']
    for record in records:
        body = record['body']
        print(body)
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps({
            "mesage": 'success put the file in the S3'
        })
    }