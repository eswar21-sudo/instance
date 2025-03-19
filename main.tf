provider "aws" {
  region = "us-east-2" # Change this to your preferred region
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2-security-group"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allowing all IPs for demo purposes (Not recommended for production)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_instance" {
  ami             = "ami-08b5b3a93ed654d19" # Update this with the correct AMI ID for your region
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.ec2_sg.name]

  tags = {
    Name = "Terraform-EC2"
  }
}

output "instance_public_ip" {
  value = aws_instance.ec2_instance.public_ip
}
