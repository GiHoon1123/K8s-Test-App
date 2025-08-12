# Kubernetes 테스트용 NestJS 애플리케이션

이 프로젝트는 Jenkins, ArgoCD, Kubernetes를 연습하기 위한 NestJS 애플리케이션입니다.

## 🏗️ 프로젝트 구조

```
.
├── k8s/                 # Kubernetes 매니페스트 (배포, 서비스, 인그레스, HPA)
├── argocd/              # ArgoCD 설정
├── scripts/             # 유틸리티 스크립트
├── src/                 # NestJS 애플리케이션 소스
├── Jenkinsfile          # Jenkins Pipeline
├── kind.yaml           # Kind 클러스터 설정
└── README.md           # 이 파일
```

## 🚀 빠른 시작

### 1. 사전 요구사항

- Docker
- Kind
- kubectl

### 2. Kind 클러스터 설정

```bash
# 스크립트 실행 권한 부여
chmod +x scripts/setup-kind.sh

# Kind 클러스터 생성 및 설정
./scripts/setup-kind.sh
```

### 3. 애플리케이션 배포

```bash
# 스크립트 실행 권한 부여
chmod +x scripts/deploy.sh

# 애플리케이션 배포
./scripts/deploy.sh
```

### 4. 접속

1. `/etc/hosts` 파일에 다음 줄 추가:

   ```
   127.0.0.1 k8s-test-app.local
   ```

2. 브라우저에서 접속:
   ```
   http://k8s-test-app.local
   ```

## 🛠️ 수동 배포

### Kubernetes 매니페스트 배포

```bash
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/ingress.yaml
```

### 자동 스케일링 (HPA)

```bash
# HPA 적용
kubectl apply -f k8s/hpa.yaml

# HPA 상태 확인
kubectl get hpa -n k8s-test-app

# HPA 상세 정보 확인
kubectl describe hpa k8s-test-app-hpa -n k8s-test-app
```

### ArgoCD 배포

```bash
# ArgoCD Application 생성
kubectl apply -f argocd/application.yaml
```

## 🔧 Jenkins Pipeline

Jenkins에서 이 프로젝트를 빌드하려면:

1. Jenkins에 새 Pipeline Job 생성
2. Pipeline script from SCM 선택
3. Git 저장소 URL 설정
4. Jenkinsfile 경로 설정: `Jenkinsfile`

## 📊 모니터링

### Pod 상태 확인

```bash
kubectl get pods -n k8s-test-app
```

### 서비스 상태 확인

```bash
kubectl get services -n k8s-test-app
```

### 로그 확인

```bash
kubectl logs -f deployment/k8s-test-app -n k8s-test-app
```

## 🧹 정리

### Kind 클러스터 삭제

```bash
kind delete cluster --name nestjs-cluster
```

### Kubernetes 리소스 삭제

```bash
kubectl delete namespace k8s-test-app
```

## 📚 학습 자료

- [Kubernetes 공식 문서](https://kubernetes.io/docs/)
- [Jenkins 공식 문서](https://www.jenkins.io/doc/)
- [ArgoCD 공식 문서](https://argo-cd.readthedocs.io/)

## 🤝 기여

이 프로젝트는 학습 목적으로 만들어졌습니다. 개선사항이나 버그 리포트는 언제든 환영합니다!
