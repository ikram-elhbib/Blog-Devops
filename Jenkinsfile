pipeline {
    agent {
        docker {
            image 'docker:24.0.5'   // image avec Docker CLI
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    environment {
        KUBECONFIG = '/home/jenkins/.kube/config'  // chemin vers kubeconfig sur le master
        IMAGE_NAME = 'blog-devops:latest'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/ikram-elhbib/Blog-Devops.git'
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
