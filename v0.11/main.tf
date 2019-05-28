variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "main_address_space" {default = "10.0.0.0/16"}


provider "aws" {
   access_key= "${var.aws_access_key}"
   secret_key = "${var.aws_secret_key}"
   region = "us-east-1"
   version = "2.12.0"
}

resource "aws_vpc" "main_vpc" {
   cidr_block = "${var.main_address_space}"
}

resource "aws_subnet" "subnets" {
   count = 2

   vpc_id = "${aws_vpc.main_vpc.id}"
   cidr_block = "${cidrsubnet(var.main_address_space, 8 , count.index )}"
}


output "subnet_ids" {
   value = ["${aws_subnet.subnets.0.id}", "${aws_subnet.subnets.1.id}"]
}