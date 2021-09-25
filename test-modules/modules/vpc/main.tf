resource "aws_vpc" "main" {
  cidr_block       = var.vpc_block
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "web-1a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-1a"

  tags = {
    Name = "web-1a"
  }
}

resource "aws_subnet" "app-1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "app-1a"
  }
}

resource "aws_subnet" "db-1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "db-1a"
  }
}

resource "aws_subnet" "web-1b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-1b"

  tags = {
    Name = "web-1b"
  }
}

resource "aws_subnet" "app-1b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "app-1b"
  }
}

resource "aws_subnet" "db-1b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "db-1b"
  }
}

// data "aws_ami" "ubuntu" {
//   name = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
// }
