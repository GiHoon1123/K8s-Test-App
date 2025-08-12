#!/bin/bash

echo "🧪 Testing Environment Variables..."

echo ""
echo "🔧 Testing Development Environment:"
echo "=================================="
cd my-nest-app
NODE_ENV=development npm run start:dev &
DEV_PID=$!

# 잠시 대기
sleep 5

echo ""
echo "📡 Testing /env endpoint:"
curl -s http://localhost:3000/env | jq '.'

echo ""
echo "📡 Testing /config endpoint:"
curl -s http://localhost:3000/config | jq '.'

# 개발 서버 종료
kill $DEV_PID

echo ""
echo "🚀 Testing Production Environment:"
echo "=================================="
NODE_ENV=production npm run start:prod &
PROD_PID=$!

# 잠시 대기
sleep 5

echo ""
echo "📡 Testing /env endpoint:"
curl -s http://localhost:3000/env | jq '.'

echo ""
echo "📡 Testing /config endpoint:"
curl -s http://localhost:3000/config | jq '.'

# 프로덕션 서버 종료
kill $PROD_PID

echo ""
echo "✅ Environment variable test completed!"
