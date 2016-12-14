resource "aws_instance" "app" {
  ami                  = "${var.ami_id}"
  count                = "${var.instance_count}"
  instance_type        = "${var.instance_type}"
  subnet_id            = "${element(var.public_subnet_ids, 1)}"
  iam_instance_profile = "${aws_iam_instance_profile.app.name}"
  key_name             = "${var.key_pair_name}"

  vpc_security_group_ids = ["${concat(aws_security_group.app.*.id, var.security_group_ids)}"]

  tags = "${merge(
    map("Name", "${lower(var.vpc_name)}-${var.app_name}"),
    map("App", var.app_name),
    var.instance_tags
  )}"
}
