import { Module } from '@nestjs/common';
import { PhieuXuatDongVatService } from './phieu-xuat-dong-vat.service';
import { PhieuXuatDongVatController } from './phieu-xuat-dong-vat.controller';

@Module({
  controllers: [PhieuXuatDongVatController],
  providers: [PhieuXuatDongVatService],
})
export class PhieuXuatDongVatModule {}
