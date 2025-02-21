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
                sh '''
                cd FlaskApp_Api
                terraform init
                terraform plan
                '''
            }
        }

        stage('Terraform Apply') {
            steps {
                sh '''
                cd FlaskApp_Api
                terraform apply -auto-approve
                '''
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
