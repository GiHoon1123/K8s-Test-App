#!/bin/bash

echo "🚀 Setting up ArgoCD..."

# ArgoCD 컨테이너 시작
docker-compose up -d argocd

# ArgoCD 시작 대기
echo "⏳ Waiting for ArgoCD to start..."
sleep 30

echo ""
echo "✅ ArgoCD setup complete!"
echo "🌐 ArgoCD UI: http://localhost:9092"
echo "🔑 Username: admin"
echo "🔑 Password: admin123"
echo ""
echo "📋 다음 단계:"
echo "1. http://localhost:9092 접속"
echo "2. admin/admin123 로그인"
echo "3. 'New App' 클릭"
echo "4. Application 설정:"
echo "   - Name: nestjs-app"
echo "   - Project: default"
echo "   - Repository URL: https://github.com/GiHoon1123/kubu-test.git"
echo "   - Path: k8s"
echo "   - Destination: https://kubernetes.default.svc"
echo "   - Namespace: nestjs-app"
echo "5. 'Create' 클릭"
