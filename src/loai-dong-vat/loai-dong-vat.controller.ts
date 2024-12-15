import { Controller, Get, Post, Body, Patch, Param, Delete, Query } from '@nestjs/common';
import { LoaiDongVatService } from './loai-dong-vat.service';


@Controller('loai-dong-vat')
export class LoaiDongVatController {
  constructor(private readonly LoaiDongVatService: LoaiDongVatService) {}

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
