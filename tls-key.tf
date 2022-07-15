# RSA key of size 4096 bits
resource "tls_private_key" "myprivatekey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


resource "aws_key_pair" "generated_key" {
 
  key_name   = "aws-key"
  public_key = tls_private_key.myprivatekey.public_key_openssh
}