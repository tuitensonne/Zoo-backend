import {
  Controller,
  //Get,
  Post,
  Body,
  //Patch,
  //Param,
  //Delete,
} from '@nestjs/common';
import { LichSuDieuTriService } from './lich-su-dieu-tri.service';
import { CreateLichSuDieuTriDto } from './dto/create-lich-su-dieu-tri.dto';

@Controller('lich-su-dieu-tri')
export class LichSuDieuTriController {
  constructor(private readonly LichSuDieuTriService: LichSuDieuTriService) {}

  @Post('create')
  create(@Body() CreateLichSuDieuTriDto: CreateLichSuDieuTriDto) {
    return this.LichSuDieuTriService.create(CreateLichSuDieuTriDto);
  }
}
