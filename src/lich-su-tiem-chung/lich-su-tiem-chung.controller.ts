import {
  Controller,
  //Get,
  Post,
  Body,
  //Patch,
  //Param,
  //Delete,
} from '@nestjs/common';
import { LichSuTiemChungService } from './lich-su-tiem-chung.service';
import { CreateLichSuTiemChungDto } from './dto/create-lich-su-tiem-chung.dto';

@Controller('lich-su-tiem-chung')
export class LichSuTiemChungController {
  constructor(private readonly LichSuDieuTriService: LichSuTiemChungService) {}

  @Post('create')
  create(@Body() CreateLichSuDieuTriDto: CreateLichSuTiemChungDto) {
    return this.LichSuDieuTriService.create(CreateLichSuDieuTriDto);
  }
}
