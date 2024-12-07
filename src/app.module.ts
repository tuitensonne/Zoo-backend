import { Module } from '@nestjs/common';
import { LoaiDongVatModule } from './loai-dong-vat/loai-dong-vat.module';
import { PhieuNhapThucAnModule } from './phieu-nhap-thuc-an/phieu-nhap-thuc-an.module';
import { DatabaseModule } from './database.module';
@Module({
  imports: [DatabaseModule, LoaiDongVatModule, PhieuNhapThucAnModule],
})

export class AppModule {} 
