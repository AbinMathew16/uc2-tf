provider "aws" {
    profile = "default"
    region = "us-east-1"
}

resource "aws_instance" "web_server_1" {
  ami           = "ami-0d7a109bf30624c99"  # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet_a.id  # Use public subnet a
  key_name      = "key-pair-tf-1"  # Key pair name
  vpc_security_group_ids = [aws_security_group.web_server_sg.id]  # Associate with security group
   associate_public_ip_address = true
   iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  tags = {
    Name = "web-server-1"
  }
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install aws-cli -y
              sudo amazon-linux-extras enable nginx1
              sudo yum install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              echo "Hello World from ip: $(hostname)" > svrip.html
              sudo cp svrip.html /usr/share/nginx/html
              sudo aws s3 cp s3://tf-uc2-bucket-a1/ /usr/share/nginx/html  --recursive
             EOF
}

resource "aws_instance" "web_server_2" {
  ami           = "ami-0d7a109bf30624c99"  # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet_b.id  # Use public subnet b
  key_name      = "key-pair-tf-1"  # Key pair name
  vpc_security_group_ids = [aws_security_group.web_server_sg.id]  # Associate with security group
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  tags = {
    Name = "web-server-2"
  }
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install aws-cli -y
              sudo amazon-linux-extras enable nginx1
              sudo yum install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              echo "Hello World from ip: $(hostname)" > svrip.html
              sudo cp svrip.html /usr/share/nginx/html
              sudo aws s3 cp s3://tf-uc2-bucket-a1/ /usr/share/nginx/html  --recursive
             EOF
}