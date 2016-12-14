resource "aws_security_group" "app" {
  name        = "${var.vpc_name}-${var.app_name}"
  description = "${var.app_name} instances"
  vpc_id      = "${var.vpc_id}"
}
