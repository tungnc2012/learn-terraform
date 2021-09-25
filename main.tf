provider "aws" {
  region = var.main_region
}

provider "aws" {
  alias = "useast1"
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
  region = var.main_region
}

module "ec2" {
  source = "./modules/ec2"
  count = 2
  region = var.main_region
}
























// resource "aws_elb" "ssh22" {
//   instances = module.ec2.instance.id
//   listener {
//     instance_port     = 22
//     instance_protocol = "tcp"
//     lb_port           = 22
//     lb_protocol       = "tcp"
//   }
// }