provider "aws" {
  region = "us-east-2"
}

resource "tls_private_key" "key" {
  algorithm = "RSA"
}

resource "local_file" "private_key" {
  filename          = "${path.module}/ansible-key.pem"
  sensitive_content = tls_private_key.key.private_key_pem
  file_permission   = "0400"
}
resource "aws_key_pair" "key_pair" {
  key_name   = "ansible_key"
  public_key = tls_private_key.key.public_key_openssh
}

resource "aws_security_group" "allow_ssh" {
  vpc_id = "vpc-059cf66c3327f90ad"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
  tags = {
    Name = "Ansible Group"
  }
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ansible_server" {
  ami                    = "ami-0fb653ca2d3203ac1"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name               = aws_key_pair.key_pair.key_name
  tags = {
    Name = "Ansible Server"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y software-properties-common",
      "sudo apt-add-repository --yes --update ppa:ansible/ansible",
      "sudo apt install -y ansible",
      "sudo apt install -y apache2",
      "sudo systemctl enable --now apache2",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = self.public_ip
      private_key = tls_private_key.key.private_key_pem
    }
  }

  provisioner "local-exec" {
    command = "ping -n 10 ${aws_instance.ansible_server.public_ip}"
  }


}




output "PrivateIP" {
  value = aws_instance.ansible_server.private_ip
}

output "PublicIP" {
  value = aws_instance.ansible_server.public_ip
}

output "connect" {
  value = "ssh -i ansible-key.pem ubuntu@${aws_instance.ansible_server.public_ip}"
}
