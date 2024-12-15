import { Controller, Get, Post, Body, Patch, Param, Delete, Query } from '@nestjs/common';
import { LoaiDongVatService } from './loai-dong-vat.service';
import { CreateLoaiDongVatDto } from './dto/create-loai-dong-vat.dto';


@Controller('loai-dong-vat')
export class LoaiDongVatController {
  constructor(private readonly LoaiDongVatService: LoaiDongVatService) {}

  @Post('create')
  create(@Body() createLoaiDongVatDto: CreateLoaiDongVatDto) {
    return this.LoaiDongVatService.create(createLoaiDongVatDto)
  }

  @Get('/cathe')
  getAllCT(
    @Query('ten_khoa_hoc') ten_khoa_hoc: string = "",
    @Query('gioi_tinh') gioi_tinh: string ="0"
  ) {
    return this.LoaiDongVatService.getAllCT(ten_khoa_hoc, +gioi_tinh)
  }
  
  @Get('/getallLDV')
  getAllLDV() {
    return this.LoaiDongVatService.getAllLDV();
  }

}
