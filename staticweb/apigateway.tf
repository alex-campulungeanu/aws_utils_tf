resource "aws_api_gateway_rest_api" "default-api-gateway" {
  name           = "DefaultRESTAPI"
  description    = "Demo API to Default API"
  # api_key_source = "HEADER"
  body           = "${data.template_file.helloworld.rendered}"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

data "template_file" "helloworld" {
  template = "${file("${path.module}/helloworld.yaml")}"


  vars = {
    get_lambda_arn          = "${aws_lambda_function.users_lambda.arn}"
    aws_region              = "us-east-1"
    lambda_identity_timeout = 1000
  }

}

resource "aws_api_gateway_stage" "sayhellostage" {
  deployment_id = aws_api_gateway_deployment.sayhellodeployment.id
  rest_api_id   = aws_api_gateway_rest_api.default-api-gateway.id
  stage_name    = "stage1"
}

resource "aws_api_gateway_deployment" "sayhellodeployment" {
  rest_api_id = aws_api_gateway_rest_api.default-api-gateway.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.default-api-gateway.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}



output "url" {
  value = "${aws_api_gateway_deployment.sayhellodeployment.invoke_url}/"
}