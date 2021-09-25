resource "aws_instance" "web" {
  ami           = var.amazonlinux2_ami
  instance_type = var.instance_type

  tags = {
    Name = "HelloWorld"
  }
}

output "ec2_webserver" {
  value = aws_instance.web
}