import { Module, MiddlewareConsumer, NestModule  } from '@nestjs/common';
import { ValidateRequest } from './nv.validattion';
import { NhanvienService } from './nhanvien.service';
import { NhanvienController } from './nhanvien.controller';

@Module({
  controllers: [NhanvienController],
  providers: [NhanvienService],
})
export class NhanvienModule {
  configure(consumer: MiddlewareConsumer) {
    consumer
      .apply(ValidateRequest )
      .forRoutes('*');
  }
}
