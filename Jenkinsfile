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
                        rm -f .terraform.lock.hcl
                        terraform init
                        terraform validate
                        terraform fmt
                        terraform plan -out=tfplan
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
                        if [ -f "tfplan" ]; then
                            terraform apply -auto-approve tfplan
                        else
                            echo "Error: tfplan file not found!"
                            exit 1
                        fi
                        '''
                    }
                }
            }
        }
    }
    
    post {
        always {
            node {
                cleanWs()
            }
        }
        failure {
            echo 'Pipeline failed!'
        }
        success {
            echo 'Pipeline completed successfully!'
        }
    }
}
