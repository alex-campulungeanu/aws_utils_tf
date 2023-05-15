resource "aws_iam_role" "iam_for_lambda_vpc" {
  name = "iam_for_lambda_vpc"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


resource "aws_iam_role_policy_attachment" "lambda_vpc" {
  policy_arn = "${aws_iam_policy.lambda_vpc.arn}"
  role = "${aws_iam_role.iam_for_lambda_vpc.name}"
}

resource "aws_iam_policy" "lambda_vpc" {
  policy = "${data.aws_iam_policy_document.lambda_vpc.json}"
}

data "aws_iam_policy_document" "lambda_vpc" {
  statement {
    sid       = "AllowVPCPermissionsLambda"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ec2:DescribeNetworkInterfaces",
      "ec2:CreateNetworkInterface",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeInstances",
      "ec2:AttachNetworkInterface"
    ]
  }
}