# module "dynamo_trigger" {
#   source = "./dynamo_trigger"
# }

# module "lambda_sqs" {
#   source = "./lambda_sqs"
# }

module "lambda_vpc" {
  source = "./lambda_parameter_store_vpc"
}