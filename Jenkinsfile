pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build and Push Docker Image') {
            when {
                branch 'master'
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_HUB_USERNAME', passwordVariable: 'DOCKER_HUB_PASSWORD')]) {
                    script {
                        // Authenticate with Docker Hub using credentials
                        sh 'docker login -u $DOCKER_HUB_USERNAME -p $DOCKER_HUB_PASSWORD'

                        // Build and push the Docker image to the dev repository on Docker Hub
                        sh 'docker build -t anbuvanitha/frontend:v1 ./frontend'
                        sh 'docker build -t anbuvanitha/backend:v1 ./backend'
                        sh 'docker push anbuvanitha/frontend:v1'
                        sh 'docker push anbuvanitha/backend:v1'
                    }
                }
            }
        }
        
    }
}
