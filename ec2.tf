# ec2 bastion 
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "bastion-server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  associate_public_ip_address = true
  subnet_id = aws_subnet.public-1.id
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  key_name = aws_key_pair.generated_key.key_name

  tags = {
    Name = "bastion-server"
  }
}

//  Ec2
resource "aws_instance" "application-server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.private-1.id
  vpc_security_group_ids = [aws_security_group.allow-ssh.id,aws_security_group.allow-3000.id]
  key_name = aws_key_pair.generated_key.key_name

  tags = {
    Name = "application"
  }
}
