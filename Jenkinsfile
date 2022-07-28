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

            // stage('terraform destroy') {
            //     steps {
            //         withAWS(credentials: 'aws', region: 'us-east-1'){
            //         sh 'terraform destroy --auto-approve -no-color '}
            //         }
            // }
        }
        
    }