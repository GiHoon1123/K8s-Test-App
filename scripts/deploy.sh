#!/bin/bash

set -e

echo "🚀 Deploying NestJS application..."

# Build Docker image
echo "📦 Building Docker image..."
cd my-nest-app
docker build -t nestjs-app:latest .

# Load image into kind cluster
echo "📤 Loading image into Kind cluster..."
kind load docker-image nestjs-app:latest --name nestjs-cluster

# Deploy to Kubernetes
echo "☸️  Deploying to Kubernetes..."
cd ..
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/ingress.yaml

# Wait for deployment to be ready
echo "⏳ Waiting for deployment to be ready..."
kubectl rollout status deployment/nestjs-app -n nestjs-app

# Show deployment status
echo "📊 Deployment status:"
kubectl get pods -n nestjs-app
kubectl get services -n nestjs-app
kubectl get ingress -n nestjs-app

echo "✅ Deployment complete!"
echo "🌐 Application URL: http://nestjs-app.local"
echo "💡 Add '127.0.0.1 nestjs-app.local' to your /etc/hosts file"
