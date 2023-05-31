data "aws_iam_policy_document" "lambda_assum_role_policy" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda-lambdaRole-waf"
  assume_role_policy = data.aws_iam_policy_document.lambda_assum_role_policy.json
}

resource "aws_iam_role_policy" "dynamodb_read_log_policy" {
  name   = "lambda-dynamodb-log-policy"
  role   = aws_iam_role.lambda_role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Action": [ "logs:*" ],
        "Effect": "Allow",
        "Resource": [ "arn:aws:logs:*:*:*" ]
    },
    {
        "Action": [ "dynamodb:BatchGetItem",
                    "dynamodb:GetItem",
                    "dynamodb:GetRecords",
                    "dynamodb:Scan",
                    "dynamodb:Query",
                    "dynamodb:GetShardIterator" ],
        "Effect": "Allow",
        "Resource": [
          "${aws_dynamodb_table.users_table.arn}",
          "${aws_dynamodb_table.users_table.arn}/*"
        ]
    },
    {
        "Sid": "AllObjectActions",
        "Effect": "Allow",
        "Action": "s3:*Object",
        "Resource": [
            "arn:aws:s3:::*/*"
        ]
    }
  ]
}
EOF
}