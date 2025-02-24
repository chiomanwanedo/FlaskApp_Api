pipeline {
    agent any  // This ensures the pipeline runs on any available agent

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
                        terraform apply -auto-approve tfplan
                        '''
                    }
                }
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
        failure {
            echo 'Pipeline failed!'
        }
        success {
            echo 'Pipeline completed successfully!'
        }
    }
}
