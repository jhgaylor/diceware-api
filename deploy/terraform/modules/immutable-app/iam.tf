resource "aws_iam_role" "app" {
  name               = "${var.vpc_name}-${var.app_name}"
  assume_role_policy = "${data.terraform_remote_state.core.policy-assume-ec2}"
}

resource "aws_iam_role_policy" "app" {
  name   = "${var.vpc_name}-${var.app_name}"
  role   = "${aws_iam_role.app.id}"
  policy = "${data.terraform_remote_state.core.policy-read-sw-releases}"
}

resource "aws_iam_role_policy" "app-sns" {
  name   = "${var.vpc_name}-${var.app_name}-sns"
  role   = "${aws_iam_role.app.id}"
  policy = "${data.terraform_remote_state.core.policy-send-sms}"
}

resource "aws_iam_instance_profile" "app" {
  name  = "${var.vpc_name}-${var.app_name}"
  roles = ["${aws_iam_role.app.name}"]
}
