import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // 환경변수에서 설정 가져오기
  const port = process.env.PORT || '의존성 주입 안되면 에러나게끔 처리';
  console.log(`📡 Server running on port ${port}`);
  if (port == '의존성 주입 안되면 에러나게끔 처리') {
    console.log('환경변수 에러');
    throw new Error('PORT is not a number');
  }
  const appName = process.env.APP_NAME || 'NestJS App';
  const nodeEnv = process.env.NODE_ENV || 'development';

  console.log(`🚀 Starting ${appName} in ${nodeEnv} mode`);

  console.log(`🔧 Environment: ${nodeEnv}`);

  await app.listen(port);
}

bootstrap();
