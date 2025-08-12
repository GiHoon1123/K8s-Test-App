#!/bin/bash

echo "🚀 Setting up Jenkins..."

# Jenkins 컨테이너 시작
docker-compose up -d jenkins

# Jenkins 시작 대기
echo "⏳ Waiting for Jenkins to start..."
sleep 30

# Jenkins 초기 비밀번호 가져오기
echo "🔑 Jenkins initial admin password:"
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword

echo ""
echo "✅ Jenkins setup complete!"
echo "🌐 Jenkins UI: http://localhost:8080"
echo "🔑 Initial password: (see above)"
echo ""
echo "📋 다음 단계:"
echo "1. http://localhost:8080 접속"
echo "2. 초기 비밀번호 입력"
echo "3. 'Install suggested plugins' 선택"
echo "4. 관리자 계정 생성"
echo "5. 새 Pipeline Job 생성"
echo "6. Pipeline script from SCM 선택"
echo "7. Git 저장소: https://github.com/GiHoon1123/kubu-test.git"
echo "8. Jenkinsfile 경로: Jenkinsfile"
