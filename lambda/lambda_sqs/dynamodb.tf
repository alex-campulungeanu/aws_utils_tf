resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name = "table_for_sqs"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name        = "table_for_sqs"
    Environment = "Dev"
  }
}