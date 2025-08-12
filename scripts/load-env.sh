#!/bin/bash

# 환경변수 파일 로드 스크립트
# 사용법: source scripts/load-env.sh [dev|prod]

ENV=${1:-dev}

if [ "$ENV" = "dev" ]; then
    echo "🔧 Loading development environment variables..."
    export $(cat env.dev | grep -v '^#' | xargs)
    echo "✅ Development environment loaded"
elif [ "$ENV" = "prod" ]; then
    echo "🚀 Loading production environment variables..."
    export $(cat env.prod | grep -v '^#' | xargs)
    echo "✅ Production environment loaded"
else
    echo "❌ Invalid environment. Use 'dev' or 'prod'"
    exit 1
fi

# 환경변수 확인
echo ""
echo "📋 Current Environment Variables:"
echo "NODE_ENV: $NODE_ENV"
echo "PORT: $PORT"
echo "APP_NAME: $APP_NAME"
echo "DB_HOST: $DB_HOST"
echo "REDIS_HOST: $REDIS_HOST"
echo ""
