resource "aws_lambda_function" "lambda_sqs_function" {
  function_name = "lambdasqs_fnc"
  filename = "${path.module}/zip_archive/lambdasqs_fnc.zip"
  source_code_hash = data.archive_file.python_lambda_package.output_base64sha256
  role = "${aws_iam_role.iam_for_lambda.arn}"
  handler = "lambda_function.lambda_handler"
  runtime = "python3.9"
  timeout = 10
}

data "archive_file" "python_lambda_package" {
  type = "zip"
  source_file = "${path.module}/code/lambda_function.py"
  output_path = "${path.module}/zip_archive/lambdasqs_fnc.zip"
}