import { Module } from '@nestjs/common';
import { LoaiDongVatModule } from './loai-dong-vat/loai-dong-vat.module';
import { PhieuNhapThucAnModule } from './phieu-nhap-thuc-an/phieu-nhap-thuc-an.module';
import { DatabaseModule } from './database.module';
import { NhanvienModule } from './nhanvien/nhanvien.module';

import { PhieuXuatDongVatModule } from './phieu-xuat-dong-vat/phieu-xuat-dong-vat.module';
import { TaoPhieuXuatDongVatModule } from './tao_phieu_xuat_dong_vat/tao-phieu-xuat-dong-vat.module';

import { KhuVucNuoiModule } from './khu_vuc_nuoi/khu_vuc_nuoi.module';
import { PhieuNhapDongVatModule } from './phieu_nhap_dong_vat/phieu_nhap_dong_vat.module';
import { HoSoSucKhoeModule } from './ho-so-suc-khoe/ho-so-suc-khoe.module';
import { LichSuDieuTriModule } from './lich-su-dieu-tri/lich-su-dieu-tri.module';
import { LichSuTiemChungModule } from './lich-su-tiem-chung/lich-su-tiem-chung.module';
@Module({
  imports: [DatabaseModule, 
            LoaiDongVatModule, 
            PhieuNhapThucAnModule, 
            NhanvienModule, 
            KhuVucNuoiModule, 
            PhieuNhapDongVatModule, 
            PhieuXuatDongVatModule,
            TaoPhieuXuatDongVatModule,
            HoSoSucKhoeModule,
            LichSuDieuTriModule,
            LichSuTiemChungModule],
}) 
 
export class AppModule {} 
