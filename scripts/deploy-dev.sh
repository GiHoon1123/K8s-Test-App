#!/bin/bash

set -e

echo "🔧 Deploying to Development Environment..."

# 개발 환경 네임스페이스 생성
kubectl create namespace nestjs-app-dev --dry-run=client -o yaml | kubectl apply -f -

# 개발용 ConfigMap 적용
kubectl apply -f k8s/configmap-dev.yaml

# 개발용 Deployment 생성
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nestjs-app-dev
  namespace: nestjs-app-dev
  labels:
    app: nestjs-app-dev
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nestjs-app-dev
  template:
    metadata:
      labels:
        app: nestjs-app-dev
    spec:
      containers:
      - name: nestjs-app-dev
        image: nestjs-app:dev
        ports:
        - containerPort: 3000
        env:
        - name: NODE_ENV
          valueFrom:
            configMapKeyRef:
              name: nestjs-config-dev
              key: NODE_ENV
        - name: PORT
          valueFrom:
            configMapKeyRef:
              name: nestjs-config-dev
              key: PORT
        - name: APP_NAME
          valueFrom:
            configMapKeyRef:
              name: nestjs-config-dev
              key: APP_NAME
        - name: API_VERSION
          valueFrom:
            configMapKeyRef:
              name: nestjs-config-dev
              key: API_VERSION
        - name: LOG_LEVEL
          valueFrom:
            configMapKeyRef:
              name: nestjs-config-dev
              key: LOG_LEVEL
        - name: DB_HOST
          valueFrom:
            configMapKeyRef:
              name: nestjs-config-dev
              key: DB_HOST
        - name: REDIS_HOST
          valueFrom:
            configMapKeyRef:
              name: nestjs-config-dev
              key: REDIS_HOST
        resources:
          requests:
            memory: "64Mi"
            cpu: "50m"
          limits:
            memory: "128Mi"
            cpu: "100m"
        livenessProbe:
          httpGet:
            path: /health
            port: 3000
          initialDelaySeconds: 30
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /health
            port: 3000
          initialDelaySeconds: 5
          periodSeconds: 5
EOF

# 개발용 Service 생성
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: nestjs-service-dev
  namespace: nestjs-app-dev
  labels:
    app: nestjs-app-dev
spec:
  type: ClusterIP
  ports:
  - port: 80
    targetPort: 3000
    protocol: TCP
    name: http
  selector:
    app: nestjs-app-dev
EOF

# 배포 상태 확인
echo "⏳ Waiting for deployment to be ready..."
kubectl rollout status deployment/nestjs-app-dev -n nestjs-app-dev

# 상태 확인
echo "📊 Development deployment status:"
kubectl get pods -n nestjs-app-dev
kubectl get services -n nestjs-app-dev

echo "✅ Development deployment complete!"
echo "🌐 Service URL: nestjs-service-dev.nestjs-app-dev.svc.cluster.local"
echo "🔍 Environment info: kubectl port-forward svc/nestjs-service-dev 8080:80 -n nestjs-app-dev"
