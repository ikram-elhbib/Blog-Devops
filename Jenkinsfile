pipeline {
    agent any

    environment {
        KUBECONFIG = '/home/jenkins/.kube/config'  // chemin kubeconfig vers le master
        IMAGE_NAME = 'blog-devops:latest'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM',
                    branches: [[name: 'main']],
                    userRemoteConfigs: [[url: 'https://github.com/ikram-elhbib/Blog-Devops.git']]])
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Construire l'image localement
                    sh "docker build -t ${IMAGE_NAME} ."
                }
            }
        }

        stage('Deploy MongoDB') {
            steps {
                // Déployer MongoDB avec Kubernetes
                sh "kubectl apply -f k8s/mongodb-deployment.yaml"
            }
        }

        stage('Deploy Node.js App') {
            steps {
                // Déployer l'app Node.js avec l'image locale
                sh "kubectl apply -f k8s/nodeapp-deployment.yaml"
            }
        }
    }
}
