# note: only grab data. do not access resources from core
data "terraform_remote_state" "core" {
  backend = "s3"

  config {
    region = "${var.aws_region}"
    bucket = "jhg-tf-remote-state"
    key    = "main/main.tfstate"
  }
}
