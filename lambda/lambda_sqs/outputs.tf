output "sqs_url" {
  value = "${aws_sqs_queue.sqs_for_lambda}"
}