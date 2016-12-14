resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "${var.vpc_name} Public Subnets"
  }
}

resource "aws_route" "public_to_internet" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.main.id}"
  route_table_id         = "${aws_route_table.public.id}"
}

resource "aws_subnet" "public" {
  vpc_id                  = "${aws_vpc.main.id}"
  count                   = "${length(var.public_subnet_cidrs)}"
  cidr_block              = "${element(var.public_subnet_cidrs, count.index)}"
  availability_zone       = "${element(var.azs, count.index)}"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.vpc_name} DMZ ${element(var.azs, count.index)} - ${element(var.public_subnet_cidrs, count.index)}"
  }
}

resource "aws_route_table_association" "public" {
  count          = "${length(var.public_subnet_cidrs)}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_network_acl" "public_to_internet" {
  vpc_id     = "${aws_vpc.main.id}"
  subnet_ids = ["${aws_subnet.public.*.id}"]

  tags {
    Name = "${var.vpc_name} Public NACL"
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  # internet can access
  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  # vpc can access
  ingress {
    protocol   = "-1"
    rule_no    = 200
    action     = "allow"
    cidr_block = "${var.vpc_cidr}"
    from_port  = 0
    to_port    = 0
  }
}
