resource "aws_instance" "web" {
   ami = var.amazonlinux2_ami 
   instance_type = var.instance_type
   vpc_security_group_ids = [aws_security_group.instance.id]
   user_data = "/home/cloud_user/test-modules/modules/ec2/user_data.sh"
   tags = { 
     Name = "terraform-example" 
     } 
}

resource "aws_security_group" "instance" {
   name = "terraform-example-instance" 
   ingress { 
     from_port = 8080 
     to_port = 8080 
     protocol = "tcp" 
     cidr_blocks = ["0.0.0.0/0"] 
     } 
}


