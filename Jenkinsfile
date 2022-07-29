pipeline {
    agent any

        stages {

            stage('terraform init') {
                steps {
                    withAWS(credentials: 'aws', region: 'us-east-1'){
                    sh 'terraform init '}
                }
            }

            stage('terraform apply') {
                steps {
                    withAWS(credentials: 'aws', region: 'us-east-1'){
                    sh 'terraform apply --auto-approve -no-color '}
                    }
            }

            stage('installing slave packages using ansible') {
                steps {
                    withAWS(credentials: 'aws', region: 'us-east-1'){
                    sh 'ansible-playbook -i /var/jenkins_home/hosts slave-ansible.yaml'}
                    }
            }


            stage('installing docker inside the slave using ansible') {
                steps {
                    withAWS(credentials: 'aws', region: 'us-east-1'){
                    sh 'ansible-playbook -i /var/jenkins_home/hosts docker-ansible.yaml'}
                    }
            }

            stage('copy jar file for slave communication') {
                steps {
                    withAWS(credentials: 'aws', region: 'us-east-1'){
                    sh 'ansible-playbook -i /var/jenkins_home/hosts jar.yaml'}
                    }
            }


            stage('clone the app inside EC2 slave') {
                agent { node { label 'terraform-slave'} }
                steps {
                    git url:'https://github.com/mahmoud254/jenkins_nodejs_example.git' , branch: 'rds_redis'
                    }
            }

            stage('build docker image') {
                agent { node { label 'terraform-slave'} }
                steps {
                    withAWS(credentials: 'aws', region: 'us-east-1'){
                    sh 'docker build . -f dockerfile -t app-image'}
                    }
            }


            stage('run container based created docker image') {
                agent { node { label 'terraform-slave'} }
                steps {
                    withAWS(credentials: 'aws', region: 'us-east-1'){
                    sh 'docker run -d --name node-app app-image'}
                    }
            }

            // stage('terraform destroy') {
            //     steps {
            //         withAWS(credentials: 'aws', region: 'us-east-1'){
            //         sh 'terraform destroy --auto-approve -no-color '}
            //         }
            // }
        }
        
    }