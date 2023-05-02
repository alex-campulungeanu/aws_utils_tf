resource "aws_lambda_event_source_mapping" "lambda_sqs_mapping" {
  batch_size = 1
  event_source_arn = aws_sqs_queue.sqs_for_lambda.arn
  enabled = true
  function_name = aws_lambda_function.lambda_sqs_function.arn
}