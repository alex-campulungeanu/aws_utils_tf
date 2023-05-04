import json

import boto3
import json
import uuid

#dynamo_client = boto3.client('dynamodb')
dynamo_client = boto3.resource('dynamodb')
table = dynamo_client.Table('table_for_sqs')

def lambda_handler(event, context):
    print(event)
    records = event['Records']
    for record in records:
        payload = record['body']
        id_db = uuid.uuid4()
        table.put_item( 
            Item={
                "id": str(id_db),
                "name": payload
            }
        )
        body = record['body']
        print(body)
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps({
            "mesage": 'SQS event successfully from tf '
        })
    }