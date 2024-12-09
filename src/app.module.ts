import { Module } from '@nestjs/common';
import { LoaiDongVatModule } from './loai-dong-vat/loai-dong-vat.module';
import { PhieuNhapThucAnModule } from './phieu-nhap-thuc-an/phieu-nhap-thuc-an.module';
import { DatabaseModule } from './database.module';
import { NhanvienModule } from './nhanvien/nhanvien.module';
import { PhieuXuatDongVatModule } from './phieu-xuat-dong-vat/phieu-xuat-dong-vat.module';
import { TaoPhieuXuatDongVatModule } from './tao_phieu_xuat_dong_vat/tao-phieu-xuat-dong-vat.module';

@Module({
  imports: [DatabaseModule, LoaiDongVatModule, PhieuNhapThucAnModule, NhanvienModule, PhieuXuatDongVatModule,TaoPhieuXuatDongVatModule],
})

export class AppModule {} 
