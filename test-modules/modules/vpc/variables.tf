variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "vpc_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "amazonlinux2_ami" {
  type    = string
  default = "ami-082105f875acab993"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}
