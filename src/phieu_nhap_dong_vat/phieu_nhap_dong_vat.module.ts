import { Module } from '@nestjs/common';
import { PhieuNhapDongVatService } from './phieu_nhap_dong_vat.service';
import { PhieuNhapDongVatController } from './phieu_nhap_dong_vat.controller';

@Module({
  controllers: [PhieuNhapDongVatController],
  providers: [PhieuNhapDongVatService],
})
export class PhieuNhapDongVatModule {}
