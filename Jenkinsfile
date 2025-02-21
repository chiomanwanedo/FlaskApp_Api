pipeline {
    agent any

    environment {
        AWS_REGION = "eu-west-2"
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/chiomanwanedo/FlaskApp_Api.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh '''
                python3 -m venv venv
                bash -c "source venv/bin/activate && pip install -r requirements.txt"
                '''
            }
        }

        stage('Run Tests') {   
            steps {
                sh '''
                python3 -m venv venv
                bash -c "source venv/bin/activate && pip install -r requirements.txt"
                '''
            }
        }

        stage('Terraform Init & Plan') {
            steps {
                script {
                    sh 'export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID'
                    sh 'export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY'
                    sh 'export AWS_REGION=$AWS_REGION'
                    sh 'terraform init'
                    sh 'terraform plan'
                }
            }
        } 

        stage('Terraform Apply') {
            steps {
                script {
                    sh 'export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID'
                    sh 'export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY'
                    sh 'export AWS_REGION=$AWS_REGION'
                    sh 'terraform apply -auto-approve'
                }
            }
        } 

        stage('Deploy API to EC2') {
            steps {
                sshagent(credentials: ['chioma_keypair']) {
                    sh '''
                    scp -r * ubuntu@18.175.114.52:/var/www/api
                    ssh ubuntu@18.175.114.52 "sudo systemctl restart flask-api"
                    '''
                }
            }
        }
    } 
}
