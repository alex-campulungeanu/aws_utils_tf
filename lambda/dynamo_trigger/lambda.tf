resource "aws_lambda_function" "test_lambda_function" {
  function_name = "lambdaTest"
  filename = "${path.module}/zip/nametest.zip"
  source_code_hash = data.archive_file.python_lambda_package.output_base64sha256
  role = aws_iam_role.lambda_role.arn
  handler = "lambda_function.lambda_handler"
  runtime = "python3.9"
  timeout = 10
}

data "archive_file" "python_lambda_package" {
  type = "zip"
  source_file = "${path.module}/code/lambda_function.py"
  output_path = "${path.module}/zip/nametest.zip"
}

resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name = "test_table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "testId"
  stream_enabled = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "testId"
    type = "S"
  }

  tags = {
    Name        = "Dynamo-DB-Table"
    Environment = "Dev"
  }
}

resource "aws_lambda_event_source_mapping" "allow_dynamodb_table_to_trigger_lambda" {
  event_source_arn = aws_dynamodb_table.basic-dynamodb-table.stream_arn
  function_name = aws_lambda_function.test_lambda_function.arn
  starting_position = "LATEST"
}
