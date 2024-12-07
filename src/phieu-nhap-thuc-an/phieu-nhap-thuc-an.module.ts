import { Module } from '@nestjs/common';
import { PhieuNhapThucAnService } from './phieu-nhap-thuc-an.service';
import { PhieuNhapThucAnController } from './phieu-nhap-thuc-an.controller';

@Module({
  controllers: [PhieuNhapThucAnController],
  providers: [PhieuNhapThucAnService],
})
export class PhieuNhapThucAnModule {}
