resource "aws_lambda_function" "users_lambda" {
  function_name = "usersLambda"
  filename = "${path.module}/zip/userslambda.zip"
  source_code_hash = data.archive_file.python_lambda_package.output_base64sha256
  role = aws_iam_role.lambda_role.arn
  handler = "lambda_function.lambda_handler"
  runtime = "python3.9"
  timeout = 10
}

data "archive_file" "python_lambda_package" {
  type = "zip"
  source_file = "${path.module}/code/lambda_function.py"
  output_path = "${path.module}/zip/userslambda.zip"
}

resource "aws_lambda_permission" "api-gateway-invoke-lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.users_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the specified API Gateway.
  source_arn = "${aws_api_gateway_rest_api.default-api-gateway.execution_arn}/*/*"
}