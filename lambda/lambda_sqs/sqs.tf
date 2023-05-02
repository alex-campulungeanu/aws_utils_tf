resource "aws_sqs_queue" "sqs_for_lambda" {
  name = "sqs_for_lambda"
}