import { Module } from '@nestjs/common';
import { KhuVucNuoiService } from './khu_vuc_nuoi.service';
import { KhuVucNuoiController } from './khu_vuc_nuoi.controller';

@Module({
  controllers: [KhuVucNuoiController],
  providers: [KhuVucNuoiService],
})
export class KhuVucNuoiModule {}
