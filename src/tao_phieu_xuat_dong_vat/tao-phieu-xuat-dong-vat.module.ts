import { Module } from '@nestjs/common';
import { TaoPhieuXuatDongVatService } from './tao-phieu-xuat-dong-vat.service';
import { TaoPhieuXuatDongVatController } from './tao-phieu-xuat-dong-vat.controller';

@Module({
  controllers: [TaoPhieuXuatDongVatController],
  providers: [TaoPhieuXuatDongVatService],
}) 
export class TaoPhieuXuatDongVatModule {}  