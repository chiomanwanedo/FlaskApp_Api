pipeline {
    agent any

    environment {
        AWS_REGION = "eu-west-2"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/chiomanwanedo/FlaskApp_Api.git'
            }
        }

        stage('Terraform Init & Plan') {
            steps {
                script {
                    withAWS(credentials: 'aws_jenkins', region: 'eu-west-2') {
                        sh '''
                        terraform init
                        terraform plan
                        '''
                    }
                }
            }
        } 

        stage('Terraform Apply') {
            steps {
                script {
                    withAWS(credentials: 'aws_jenkins', region: 'eu-west-2') {
                        sh '''
                        terraform apply -auto-approve
                        '''
                    }
                }
            }
        }
    }
}
