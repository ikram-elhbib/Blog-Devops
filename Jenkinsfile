pipeline {
    agent any

    environment {
        KUBECONFIG = '/home/jenkins/.kube/config'  // chemin vers kubeconfig sur le master
        IMAGE_NAME = 'blog-devops:latest'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/ikram-elhbib/Blog-Devops.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Deploy MongoDB') {
            steps {
                sh "kubectl apply -f k8s/mongodb-deployment.yaml"
            }
        }

        stage('Deploy Node.js App') {
            steps {
                sh "kubectl apply -f k8s/nodeapp-deployment.yaml"
            }
        }
    }
}
