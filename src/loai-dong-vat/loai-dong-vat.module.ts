import { Module } from '@nestjs/common';
import { LoaiDongVatService } from './loai-dong-vat.service';
import { LoaiDongVatController } from './loai-dong-vat.controller';

@Module({
  controllers: [LoaiDongVatController],
  providers: [LoaiDongVatService],
})
export class LoaiDongVatModule {}
