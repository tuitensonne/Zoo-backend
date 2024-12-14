import { Module } from '@nestjs/common';
import { NhanVienService } from './nhan_vien.service';
import { NhanVienController } from './nhan_vien.controller';

@Module({
  controllers: [NhanVienController],
  providers: [NhanVienService],
})
export class NhanVienModule {}
 