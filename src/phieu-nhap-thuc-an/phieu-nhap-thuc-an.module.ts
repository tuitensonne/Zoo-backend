import { Module, MiddlewareConsumer, NestModule, RequestMethod } from '@nestjs/common';
import { ValidateRequest } from './pn.validattion';
import { PhieuNhapThucAnService } from './phieu-nhap-thuc-an.service';
import { PhieuNhapThucAnController } from './phieu-nhap-thuc-an.controller';

@Module({
  controllers: [PhieuNhapThucAnController],
  providers: [PhieuNhapThucAnService],
})
export class PhieuNhapThucAnModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer
      .apply(ValidateRequest)
      .forRoutes({ path: 'phieu-nhap-thuc-an/id', method: RequestMethod.POST });
      
  }
}
