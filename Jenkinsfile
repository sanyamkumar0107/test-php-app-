pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = 'php-app:latest'
        DOCKER_REGISTRY = 'docker.io'  // You can change this to your own registry if needed
        IMAGE_NAME = 'sam0107/test-php:latest'  
    }
    
    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/sanyamkumar0107/test-php-app-.git  
            }
        }

        stage('Pull Docker Image') {
            steps {
                script {
                    // Pull the image from the Docker registry
                    sh "docker pull $DOCKER_REGISTRY/$IMAGE_NAME:$DOCKER_IMAGE"
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Run the Docker container from the pulled image
                    sh "docker run -d -p 8081:80 --name test-php $DOCKER_REGISTRY/$IMAGE_NAME:$DOCKER_IMAGE"
                }
            }
        }

        stage('Clean Up') {
            steps {
                script {
                    // Stop and remove the running container
                    sh 'docker stop test-php'
                    sh 'docker rm test-php'
                }
            }
        }
    }

    post {
        always {
            // Remove the Docker image after running
            sh "docker rmi $DOCKER_REGISTRY/$IMAGE_NAME:$DOCKER_IMAGE"
        }
    }
}
