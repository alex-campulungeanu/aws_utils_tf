resource "aws_default_subnet" "default_az1" {
  availability_zone = "us-east-1a"
  tags = {
    Name = "Default subnet for us-west-2a"
  }
}

# data "aws_ami" "ubuntu" {
#   most_recent = true

#   filter {
#     name = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
#   }

#   filter {
#     name = "virtualization-type"
#     values = ["hvm"]
#   }
# }

data "aws_vpc" "default" {
  default = true
}

resource "aws_instance" "ec2_test" {
  instance_type = "t2.micro"
  count = 1
  subnet_id = aws_default_subnet.default_az1.id
  # ami = data.aws_ami.ubuntu.id
  ami = "ami-0557a15b87f6559cf"
}