#!/bin/bash

echo "🔍 Secret 디코딩 스크립트"
echo "=========================="

# 개발용 Secret 디코딩
echo ""
echo "🔧 Development Secret Values:"
echo "----------------------------"
echo "NODE_ENV: $(echo 'ZGV2ZWxvcG1lbnQ=' | base64 -d)"
echo "PORT: $(echo 'MzAwMQ==' | base64 -d)"
echo "APP_NAME: $(echo 'TmVzdEpTIEFwcCAoRGV2KQ==' | base64 -d)"
echo "DB_HOST: $(echo 'bG9jYWxob3N0' | base64 -d)"
echo "DB_PASSWORD: $(echo 'ZGV2X3Bhc3N3b3Jk' | base64 -d)"
echo "JWT_SECRET: $(echo 'ZGV2LXNlY3JldC1rZXk=' | base64 -d)"

echo ""
echo "🚀 Production Secret Values:"
echo "---------------------------"
echo "NODE_ENV: $(echo 'cHJvZHVjdGlvbg==' | base64 -d)"
echo "PORT: $(echo 'MzAwMQ==' | base64 -d)"
echo "APP_NAME: $(echo 'TmVzdEpTIEFwcCAoUHJvZCk=' | base64 -d)"
echo "DB_HOST: $(echo 'cHJvZC1kYi5leGFtcGxlLmNvbQ==' | base64 -d)"
echo "DB_PASSWORD: $(echo 'cHJvZC1zZWN1cmUtcGFzc3dvcmQ=' | base64 -d)"
echo "JWT_SECRET: $(echo 'cHJvZC1zdXBlci1zZWN1cmUtc2VjcmV0LWtleQ==' | base64 -d)"

echo ""
echo "✅ 디코딩 완료!"
