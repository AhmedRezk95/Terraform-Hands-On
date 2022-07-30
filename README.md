# CI/CD Nodejs Application using Terraform - Jenkins - Ansible
Terraform Task using AWS Services

### More about the project
* Tech Stack
  - Terraform for Infrastucture as code (IaC) in AWS Cloud
  - Jenkins for pipeline
  - Ansible for Configuration Management inside the infrastructure 

### Introduction 
Build an AWS architecture with terraform to run nodeJS application using CI/CD Jenkins Pipeline, the architecture has the following:
  * Provider: ( for the backend using s3 bucket to host tfstate file)
  * Network: ( One VPC with 2 public subnets and 2 private subnets, nat gateway, internet gateway, route tables with their associations)
  * EC2: (Bastion server and Private instance for application)
  * Security groups: ( Allowing the following ports: 22, 3000, 3306, 6379, 80 )
  * Private key for EC2 (using tls and key pair resources)
  * Secret Manager: (To save EC2 private key in secure place in for utilization purposes)
  * RDS: ( Application Database)
  * Elastic Cache: (IN-Memory database)
  * System Manager: (Host environment Variables for Redis and RDS)
  

### Steps to go live
1- Before Creating Pipeline you have to install the following:
  * AWS Steps : for aws credentials
  * Docker inside your Jenkins (Make sure that you have installed docker daemon )
  * Ansible inside Jenkins (i installed it inside the jenkins machine/container itself)   --> [link](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
  * Terraform inside Jenkins (i installed it inside the jenkins machine/container itself) --> [link](https://www.terraform.io/downloads)
  
2- Create your Jenkins pipeline, mention assigned repo:
  ![image](https://user-images.githubusercontent.com/30655799/181934660-c367a350-bc53-4eb9-8ac6-3d4c1b67efa2.png)
  
3- Build the pipeline to fetch Jenkinsfile and begin the stages installation
  ![image](https://user-images.githubusercontent.com/30655799/181935047-313db1a9-4730-4d2e-a08f-7f6c9e7f47a6.png)


### Configuration 
1- Create Ansible scripts for to configure Application EC2 (Private-EC2) 
2- configure ansible to run over private ips through bastion (~/.ssh/config):
  * In order to do this we used the Jumphost concept as we want to ssh from jenkins directly to private ec2 which in our archecture is locked from any device except bastion-ec2 so we have to find away to ssh from jenkins server directly to private-vm
  * So we create a config file inside /root/.ssh using terraform local_file resource
  Result:
  
  ![image](https://user-images.githubusercontent.com/30655799/181935328-33493bee-9378-425a-836a-6413d3b3f1cd.png)
