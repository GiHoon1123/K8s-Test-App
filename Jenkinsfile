pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = 'nestjs-app'
        DOCKER_TAG = "${env.BUILD_NUMBER}"
        KUBECONFIG = '/var/jenkins_home/.kube/config'
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Install Dependencies') {
            steps {
                dir('k8s-test-app') {
                    sh 'npm ci'
                }
            }
        }
        
        stage('Run Tests') {
            steps {
                dir('k8s-test-app') {
                    sh 'npm run test'
                }
            }
        }
        
        stage('Build Application') {
            steps {
                dir('k8s-test-app') {
                    sh 'npm run build'
                }
            }
        }
        
        stage('Build Docker Image') {
            steps {
                dir('k8s-test-app') {
                    sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
                    sh "docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ${DOCKER_IMAGE}:latest"
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                script {
                    // Docker Hub나 private registry에 푸시하는 로직
                    // sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
                    // sh "docker push ${DOCKER_IMAGE}:latest"
                    echo "Docker image would be pushed here"
                    
                    // Kind 클러스터에 이미지 로드 (로컬 테스트용)
                    sh "kind load docker-image ${DOCKER_IMAGE}:${DOCKER_TAG} --name nestjs-cluster"
                    sh "kind load docker-image ${DOCKER_IMAGE}:latest --name nestjs-cluster"
                }
            }
        }
        
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Kubernetes 배포
                    sh "kubectl apply -f k8s/namespace.yaml"
                    sh "kubectl apply -f k8s/configmap.yaml"
                    sh "kubectl apply -f k8s/deployment.yaml"
                    sh "kubectl apply -f k8s/service.yaml"
                    sh "kubectl apply -f k8s/ingress.yaml"
                    
                    // 배포 상태 확인
                    sh "kubectl rollout status deployment/nestjs-app -n nestjs-app"
                }
            }
        }
        
        stage('Health Check') {
            steps {
                script {
                    // 헬스 체크
                    sh "kubectl get pods -n nestjs-app"
                    sh "kubectl get services -n nestjs-app"
                }
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
