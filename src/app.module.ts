import { Module } from '@nestjs/common';
import { LoaiDongVatModule } from './loai-dong-vat/loai-dong-vat.module';
import { PhieuNhapThucAnModule } from './phieu-nhap-thuc-an/phieu-nhap-thuc-an.module';
import { DatabaseModule } from './database.module';
import { NhanvienModule } from './nhanvien/nhanvien.module';
import { KhuVucNuoiModule } from './khu_vuc_nuoi/khu_vuc_nuoi.module';
import { PhieuNhapDongVatModule } from './phieu_nhap_dong_vat/phieu_nhap_dong_vat.module';
@Module({
  imports: [DatabaseModule, LoaiDongVatModule, PhieuNhapThucAnModule, NhanvienModule, KhuVucNuoiModule, PhieuNhapDongVatModule],
})

export class AppModule {} 
