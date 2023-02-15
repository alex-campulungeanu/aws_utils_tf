import json

import boto3

def lambda_handler(event, context):
    string = event
    decoded_event = json.dumps(string)
    encoded_string = decoded_event.encode("utf-8")

    bucket_name = "my-test-bucket-20230220113737436600000001"
    file_name = "hello.txt"
    s3_path = "100001/" + file_name

    s3 = boto3.resource("s3")
    s3.Bucket(bucket_name).put_object(Key=s3_path, Body=encoded_string)
    
    print('print event si context')
    print(event)
    print(context)
    
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps({
            "mesage": 'success put the file in the S3'
        })
    }