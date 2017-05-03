#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-2df66d3b
#
# Your subnet ID is:
#
#     subnet-75a08610
#
# Your security group ID is:
#
#     sg-4cc10432
#
# Your Identity is:
#
#     testing-seahorse
#

terraform {
  backend "atlas" {
    name = "jaloare/training"
  }
}

variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "aws_region" {
  default = "us-east-1"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

rresource "aws_instance" "web" {
  count                  = "3"
  ami                    = "ami-2df66d3b"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-75a08610"
  vpc_security_group_ids = ["sg-4cc10432"]

  tags {
    Name     = "web ${count.index}/x"
    Identity = "testing-seahorse"
    key      = "value"
    testing  = "seahorse"
  }
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}
