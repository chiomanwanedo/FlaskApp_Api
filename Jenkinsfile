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
                    withCredentials([
                        string(credentialsId: 'aws_jenkins', variable: 'AWS_ACCESS_KEY_ID'),
                        string(credentialsId: 'aws_jenkins', variable: 'AWS_SECRET_ACCESS_KEY')
                    ]) {
                        sh '''
                        export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                        export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
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
                    withCredentials([
                        string(credentialsId: 'aws_jenkins', variable: 'AWS_ACCESS_KEY_ID'),
                        string(credentialsId: 'aws_jenkins', variable: 'AWS_SECRET_ACCESS_KEY')
                    ]) {
                        sh '''
                        export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                        export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
                        export AWS_REGION=eu-west-2
                        terraform apply -auto-approve
                        '''
                    }
                }
            }
        }
    }
}
