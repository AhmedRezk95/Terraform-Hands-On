pipeline {
    agent any

        stages {

            stage('terraform init') {
                steps {
                    withAWS(credentials: 'aws', region: 'us-east-1'){
                    sh 'terraform init '}
                }
            }

            // stage('terraform apply') {
            //     steps {
            //         withAWS(credentials: 'aws', region: 'us-east-1'){
            //         sh 'terraform apply --auto-approve -no-color '}
            //         }
            // }

            // stage('installing slave packages using ansible') {
            //     steps {
            //         withAWS(credentials: 'aws', region: 'us-east-1'){
            //         sh 'ansible-playbook -i /var/jenkins_home/hosts slave-ansible.yaml'}
            //         }
            // }


            // stage('installing docker inside the slave using ansible') {
            //     steps {
            //         withAWS(credentials: 'aws', region: 'us-east-1'){
            //         sh 'ansible-playbook -i /var/jenkins_home/hosts docker-ansible.yaml'}
            //         }
            // }

            // stage('copy jar file for slave communication') {
            //     steps {
            //         withAWS(credentials: 'aws', region: 'us-east-1'){
            //         sh 'ansible-playbook -i /var/jenkins_home/hosts jar.yaml'}
            //         }
            // }

            // stage('clone / build / run app inside EC2 slave') {
            //     agent { node { label 'terraform-slave'} }
            // //     environment {
            // //     RDS_ENDPOINT = '$(aws ssm get-parameter --name /dev/database/endpoint --query "Parameter.Value" --with-decryption --output text)'
            // //     RDS_USERNAME = '$(aws ssm get-parameter --name /dev/database/username --query "Parameter.Value" --with-decryption --output text)'
            // //     RDS_PASSWORD = '$(aws ssm get-parameter --name /dev/database/password --query "Parameter.Value" --with-decryption --output text)'
            // //     REDIS_ENDPOINT = '$(aws ssm get-parameter --name /dev/redis/endpoint --query "Parameter.Value" --with-decryption --output text)'
            // // }
            //     steps {
            //         git url:'https://github.com/mahmoud254/jenkins_nodejs_example.git' , branch: 'rds_redis'
            //         withAWS(credentials: 'aws', region: 'us-east-1'){
            //            sh '''
            //             sudo chmod 666 /var/run/docker.sock
            //             sudo usermod -aG docker ubuntu
            //             docker build -f dockerfile -t app-image .
            //             docker run -d -p 3000:3000 --name node-app -e RDS_HOSTNAME='terraform-20220729121505186500000001.cwhaypjos7tr.us-east-1.rds.amazonaws.com' -e RDS_USERNAME='rizk' -e RDS_PASSWORD='rizk123456' -e RDS_PORT='3306' -e REDIS_HOSTNAME='cluster-example.byh8zr.0001.use1.cache.amazonaws.com' -e REDIS_PORT='6379' app-image
            //             '''
            //         }
            //     }
            // }

            // stage('build docker image') {
            //     agent { node { label 'terraform-slave'} }
            //     steps {
            //         withAWS(credentials: 'aws', region: 'us-east-1'){
            //         sh '''
            //         sudo usermod -aG docker ubuntu
            //         docker build . -f dockerfile -t app-image
            //         '''
            //         }
            //     }
            // }


            // stage('run container based created docker image') {
            //     agent { node { label 'terraform-slave'} }
            //     steps {
            //         withAWS(credentials: 'aws', region: 'us-east-1'){
            //         sh "docker run -d --name node-app -e RDS_HOSTNAME='mydb' -e RDS_USERNAME='rizk' -e RDS_PASSWORD='rizk123456' -e RDS_PORT='3306' app-image"
            //         }
            //     }
            // }

            stage('terraform destroy') {
                steps {
                    withAWS(credentials: 'aws', region: 'us-east-1'){
                    sh 'terraform destroy --auto-approve -no-color '}
                    }
            }
        }
        
    }