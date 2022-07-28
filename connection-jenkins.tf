resource "local_file" "pk" {
    # filename -> place where it will be set
    filename = "./aws-key.pem"
    file_permission = 0400
    # reference https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key
    content = <<EOF
    ${tls_private_key.myprivatekey.private_key_openssh}
    EOF
}

resource "local_file" "config-file" {
    # create this resource after private key is create
    depends_on = [
      local_file.pk
    ]
    # filename -> place where it will be set
    filename = "/root/.ssh/config"
    # filename = "/var/jenkins_home/.ssh/config"
    # this content should make ssh jump-host we will need it when we setup something in private vm 
    content = <<EOF
Host bastion-vm
    HostName ${aws_instance.bastion-server.public_ip}
    User ubuntu
    IdentityFile "./aws-key.pem"

Host ${aws_instance.application-server.private_ip}
    User ubuntu
    Port 22
    ProxyCommand ssh -o StrictHostKeyChecking=no -A -W %h:%p -q bastion-vm
    StrictHostKeyChecking no
    IdentityFile "./aws-key.pem"
    EOF
}

resource "local_file" "ansible-inventory" {
    # filename -> place where it will be set
    filename = "./hosts"
    content = <<EOF
[slave]
    ${aws_instance.application-server.private_ip}
    EOF
}