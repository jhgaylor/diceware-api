resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "${var.vpc_name} Private Subnet ${element(var.azs, count.index)}"
  }
}

resource "aws_route" "private_to_internet" {
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.main.id}"
  route_table_id         = "${aws_route_table.private.id}"
}

resource "aws_subnet" "private" {
  vpc_id                  = "${aws_vpc.main.id}"
  count                   = "${length(var.private_subnet_cidrs)}"
  cidr_block              = "${element(var.private_subnet_cidrs, count.index)}"
  availability_zone       = "${element(var.azs, count.index)}"
  map_public_ip_on_launch = false

  tags {
    Name = "${var.vpc_name} Private ${element(var.azs, count.index)} - ${element(var.private_subnet_cidrs, count.index)}"
  }
}

resource "aws_route_table_association" "private" {
  count          = "${length(var.private_subnet_cidrs)}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${aws_route_table.private.id}"
}

resource "aws_network_acl" "private_to_internet" {
  vpc_id     = "${aws_vpc.main.id}"
  subnet_ids = ["${aws_subnet.private.*.id}"]

  tags {
    Name = "${var.vpc_name} Private NACL"
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  # internet can access ssh
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  # vpc can access everything
  ingress {
    protocol   = "-1"
    rule_no    = 200
    action     = "allow"
    cidr_block = "${var.vpc_cidr}"
    from_port  = 0
    to_port    = 0
  }
}
