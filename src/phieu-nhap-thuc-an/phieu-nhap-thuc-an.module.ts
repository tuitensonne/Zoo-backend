import { Module, MiddlewareConsumer, NestModule, RequestMethod } from '@nestjs/common';
import { ValidateRequest } from './pn.validattion';
import { ValidateIDRequest } from './id.validattion';
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
      .forRoutes('phieu-nhap-thuc-an');
      
    consumer
      .apply(ValidateIDRequest)
      .forRoutes(
        { path: 'phieu-nhap-thuc-an', method: RequestMethod.GET }, 
        { path: 'phieu-nhap-thuc-an/id', method: RequestMethod.GET }, 
        { path: 'phieu-nhap-thuc-an/id', method: RequestMethod.DELETE } 
      );
  }
}
