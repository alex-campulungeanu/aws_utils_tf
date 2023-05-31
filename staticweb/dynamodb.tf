resource "aws_dynamodb_table" "users_table" {
  name = "users_table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "userid"

  attribute {
    name = "userid"
    type = "S"
  }

  tags = {
    Name        = "users_table"
    Environment = "Dev"
  }
}