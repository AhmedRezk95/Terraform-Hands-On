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

            stage('installing slave packages using ansible playbook ') {
                steps {
                    withAWS(credentials: 'aws', region: 'us-east-1'){
                    sh 'ansible-playbook slave-ansible.yaml '}
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