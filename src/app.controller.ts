import { Controller, Get } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { AppService } from './app.service';

@Controller()
export class AppController {
  constructor(
    private readonly appService: AppService,
    private readonly configService: ConfigService,
  ) {}

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }

  @Get('health')
  healthCheck(): string {
    return 'OK';
  }

  @Get('env')
  getEnvironmentInfo(): object {
    return {
      appName: this.configService.get('APP_NAME', 'NestJS App'),
      nodeEnv: this.configService.get('NODE_ENV', 'development'),
      port: this.configService.get('PORT', 3000),
      apiVersion: this.configService.get('API_VERSION', '1.0.0'),
      logLevel: this.configService.get('LOG_LEVEL', 'info'),
      timestamp: new Date().toISOString(),
    };
  }

  @Get('config')
  getConfig(): object {
    return {
      database: {
        host: this.configService.get('DB_HOST', 'localhost'),
        port: this.configService.get('DB_PORT', 5432),
        name: this.configService.get('DB_NAME', 'nestjs'),
      },
      redis: {
        host: this.configService.get('REDIS_HOST', 'localhost'),
        port: this.configService.get('REDIS_PORT', 6379),
      },
      external: {
        apiUrl: this.configService.get(
          'EXTERNAL_API_URL',
          'https://api.example.com',
        ),
      },
    };
  }
}
