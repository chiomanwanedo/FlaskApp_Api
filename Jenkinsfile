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
                    withCredentials([string(credentialsId: 'aws-credentials', variable: 'AWS_CREDENTIALS')]) {
                        sh '''
                        export AWS_ACCESS_KEY_ID=$(echo $AWS_CREDENTIALS | cut -d':' -f1)
                        export AWS_SECRET_ACCESS_KEY=$(echo $AWS_CREDENTIALS | cut -d':' -f2)
                        export AWS_REGION=eu-west-2
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
                    withCredentials([string(credentialsId: 'aws-credentials', variable: 'AWS_CREDENTIALS')]) {
                        sh '''
                        export AWS_ACCESS_KEY_ID=$(echo $AWS_CREDENTIALS | cut -d':' -f1)
                        export AWS_SECRET_ACCESS_KEY=$(echo $AWS_CREDENTIALS | cut -d':' -f2)
                        export AWS_REGION=eu-west-2
                        terraform apply -auto-approve
                        '''
                    }
                }
            }
        }
    }
}
