resource "aws_s3_bucket" "s3_static_bucket" {
  bucket_prefix = "staticweb-bucket-"
}

resource "aws_s3_bucket_website_configuration" "s3_static_bucket" {
    bucket = aws_s3_bucket.s3_static_bucket.id

    index_document {
        suffix = "index.html"
    }

    error_document {
        key = "error.html"
    }
}

# for some reason acl and policy is not working

# resource "aws_s3_bucket_acl" "s3_static_bucket" {
#     bucket = aws_s3_bucket.s3_static_bucket.id

#     acl = "public-read-write"
# }

# resource "aws_s3_bucket_policy" "s3_static_bucket" {
#     bucket = aws_s3_bucket.s3_static_bucket.id

#     policy = jsonencode({
#         Version = "2012-10-17"
#         Statement = [
#             {
#                 Sid = "PublicReadGetObject"
#                 Effect = "Allow"
#                 Principal = "*"
#                 Action = "s3:*"
#                 Resource = [
#                     "${aws_s3_bucket.s3_static_bucket.arn}/*",
#                 ]
#             },
#         ]
#     })
# }

resource "aws_s3_bucket_object" "object1" {
    for_each = fileset("${path.module}/s3files/", "*")
    bucket = aws_s3_bucket.s3_static_bucket.id
    key = each.value
    source = "${path.module}/s3files/${each.value}"
    etag = filemd5("${path.module}/s3files/${each.value}")
}