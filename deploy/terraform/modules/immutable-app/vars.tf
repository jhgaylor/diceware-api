provider "aws" {
  region = "${var.aws_region}"
}

variable "aws_region" {
  default = "us-west-2"
}

variable "key_pair_name" {
  description = "The name of the aws key pair to use"
}

variable "ami_id" {
  description = "The ami of the app to deploy."
}

variable "instance_type" {
  description = "The type of instance to deploy"
}

variable "instance_count" {
  description = "The number of instances to deploy"
}

variable "dns_names" {
  description = "The route53 name to give it"
  type        = "list"
}

variable "vpc_id" {}

variable "vpc_name" {}

variable "app_name" {}

variable "zone_id" {}

variable "public_subnet_ids" {
  type = "list"
}

variable "security_group_ids" {
  type = "list"
}

variable "instance_tags" {
  type = "map"
}
