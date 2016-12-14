data "terraform_remote_state" "dev_vpc" {
  backend = "s3"

  config {
    region = "${var.aws_region}"
    bucket = "jhg-tf-remote-state"
    key    = "development/vpc.tfstate"
  }
}

data "terraform_remote_state" "core" {
  backend = "s3"

  config {
    region = "${var.aws_region}"
    bucket = "jhg-tf-remote-state"
    key    = "main/main.tfstate"
  }
}

data "aws_ami" "diceware-api" {
  most_recent = true

  filter {
    name   = "name"
    values = ["diceware-api*"]
  }

  owners = ["self"]
}

module "diceware-api" {
  source = "./modules/immutable-app"

  # things we need to know about the environment
  vpc_id            = "${data.terraform_remote_state.dev_vpc.vpc_id}"
  vpc_name          = "${data.terraform_remote_state.dev_vpc.vpc_name}"
  zone_id           = "${data.terraform_remote_state.core.main_zone_id}"
  public_subnet_ids = ["${data.terraform_remote_state.dev_vpc.public_subnet_ids}"]

  # things we need to know about the app
  app_name           = "${var.app_name}"
  ami_id             = "${data.aws_ami.diceware-api.image_id}"
  dns_names          = ["${var.subdomain}.opslab.xyz.", "api.${var.subdomain}.opslab.xyz."]
  instance_type      = "${var.instance_type}"
  instance_count     = "${var.instance_count}"
  security_group_ids = ["${data.terraform_remote_state.dev_vpc.base_security_group_id}"]
  key_pair_name      = "${var.key_pair_name}"

  instance_tags = {
    Env   = "${lower(data.terraform_remote_state.dev_vpc.vpc_name)}"
    Owner = "${var.owner}"
  }
}
