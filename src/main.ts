import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import * as dotenv from 'dotenv';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';

dotenv.config();

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // CORS cấu hình cho frontend (React)
  app.enableCors({
    origin: process.env.FRONTEND_URL,
    methods: ['GET', 'POST', 'PATCH', 'DELETE'],
    allowedHeaders: ['Content-Type', 'Authorization'],
    credentials: true,
  });
  console.log(process.env.FRONTEND_URL)
  // ✅ Swagger config
  const config = new DocumentBuilder()
    .setTitle('Animal Health Export App')
    .setDescription('API cho hệ thống quản lý hồ sơ sức khỏe và phiếu xuất động vật')
    .setVersion('1.0')
    .addBearerAuth()
    .build();

  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api-docs', app, document);

  await app.listen(process.env.BACKEND_PORT ?? 8080);
}
bootstrap();
