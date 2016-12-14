provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_eip" "nat_eip" {
  count = 1
  vpc   = true
}
