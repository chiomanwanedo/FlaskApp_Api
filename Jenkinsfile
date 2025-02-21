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

        stage('Install Dependencies') {
            steps {
                sh 'pip install -r requirements.txt'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'pytest'
            }
        }

        stage('Terraform Init & Plan') {
            steps {
                sh '''
                cd terraform
                terraform init
                terraform plan
                '''
            }
        }

        stage('Terraform Apply') {
            steps {
                sh '''
                cd terraform
                terraform apply -auto-approve
                '''
            }
        }

        stage('Deploy API to EC2') {
            steps {
                sshagent(credentials: ['your-ssh-key']) {
                    sh 'scp -r * ubuntu@your-ec2-ip:/var/www/api'
                    sh 'ssh ubuntu@your-ec2-ip "sudo systemctl restart flask-api"'
                }
            }
        }
    }
}
