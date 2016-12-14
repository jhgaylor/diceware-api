resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "${var.vpc_name} IGW"
  }
}

resource "aws_nat_gateway" "main" {
  allocation_id = "${aws_eip.nat_eip.id}"
  subnet_id     = "${aws_subnet.public.id}"

  # depends_on = ["${aws_internet_gateway.main}"]
}
