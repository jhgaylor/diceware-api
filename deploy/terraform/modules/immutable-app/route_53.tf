resource "aws_route53_record" "cname-app" {
  zone_id = "${var.zone_id}"
  count   = "${length(var.dns_names)}"
  name    = "${element(var.dns_names, count.index)}"
  type    = "CNAME"
  ttl     = "30"
  records = ["${aws_instance.app.public_dns}"]
}
