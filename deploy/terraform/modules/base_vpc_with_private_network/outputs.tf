output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "public_subnet_ids" {
  value = ["${aws_subnet.public.*.id}"]
}

output "public_subnet_cidr_blocks" {
  value = ["${aws_subnet.public.*.cidr_block}"]
}

output "public_nacl_id" {
  value = "${aws_network_acl.public_to_internet.id}"
}

output "private_subnet_ids" {
  value = ["${aws_subnet.private.*.id}"]
}

output "private_subnet_cidr_blocks" {
  value = ["${aws_subnet.private.*.cidr_block}"]
}

output "private_nacl_id" {
  value = "${aws_network_acl.private_to_internet.id}"
}
