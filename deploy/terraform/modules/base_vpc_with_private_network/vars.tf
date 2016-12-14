variable "aws_region" {
  default = "us-west-2"
}

variable "vpc_cidr" {
  description = "The CIDR for this vpc"
}

variable "vpc_name" {
  description = "The name of this vpc"
}

variable "public_subnet_cidrs" {
  type        = "list"
  description = "The list of cidrs of the public subnet to build."
}

variable "private_subnet_cidrs" {
  type        = "list"
  description = "The list of cidrs of the private subnet to build."
}

variable "azs" {
  type        = "list"
  description = "The availability zones of the subnets to build."
}

variable "enable_dns_support" {
  default     = true
  description = "give access to dns resolution & private names?"
}

variable "enable_dns_hostnames" {
  default     = false
  description = "give instances a public hostname by default?"
}
