pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = 'test-php:latest'
        DOCKER_REGISTRY = 'docker.io'
    }
    
    stages {
        stage('Clone Repository') {
            steps {
                git credentialsId: 'github-credentials', url: 'https://github.com/sanyamkumar0107/test-php-app-.git'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $DOCKER_IMAGE .'
                }
            }
        }
        
        stage('Run Docker Container') {
            steps {
                script {
                    sh 'docker run -d -p 8081:80 --name test-php $DOCKER_IMAGE'
                }
            }
        }
        
        stage('Clean Up') {
            steps {
                script {
                    sh 'docker stop test-php'
                    sh 'docker rm test-php'
                }
            }
        }
    }
    
    post {
        always {
            sh 'docker rmi $DOCKER_IMAGE'
        }
    }
}
