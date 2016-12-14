output "app-public-dns" {
  value = ["${aws_instance.app.*.public_dns}"]
}

output "app-ssh-example" {
  value = "ssh ubuntu@${aws_instance.app.public_dns} -i ~/.ssh/${aws_instance.app.key_name}.pem"
}

output "app-app-url" {
  value = "${join(",", aws_route53_record.cname-app.*.fqdn)}"
}

output "app-sg-id" {
  value = "${aws_security_group.app.id}"
}

output "app-az" {
  value = "${aws_instance.app.availability_zone}"
}

output "app-instance-id" {
  value = "${aws_instance.app.id}"
}
