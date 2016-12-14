output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "public_subnet_ids" {
  value = ["${aws_subnet.public.*.id}"]
}

output "public_subnet_azs" {
  value = ["${aws_subnet.public.*.availability_zone}"]
}

output "public_subnet_cidr_blocks" {
  value = ["${aws_subnet.public.*.cidr_block}"]
}

output "public_nacl_id" {
  value = "${aws_network_acl.public_to_internet.id}"
}
