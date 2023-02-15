resource "aws_s3_bucket" "bucket_resource" {
  bucket_prefix = "my-test-bucket-"
  # aws_s3_bucket_acl = "${var.acl_value}"
}