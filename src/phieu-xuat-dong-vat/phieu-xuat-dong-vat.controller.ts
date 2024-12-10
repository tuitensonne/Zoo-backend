import {
    Controller,
    Get,
    //Post,
    //Body,
    //Patch,
    Param,
    //Delete,
  } from '@nestjs/common';
  import { PhieuXuatDongVatService } from './phieu-xuat-dong-vat.service';
  
  @Controller('phieu-xuat-dong-vat')
  export class PhieuXuatDongVatController {
    constructor(private readonly PhieuXuatDongVatService: PhieuXuatDongVatService) {}
  
    //   @Post('create')
    //   create(@Body() createLoaiDongVatDto: CreateLoaiDongVatDto) {
    //     return this.HoSoSucKhoeService.create(createLoaiDongVatDto);
    //   }
  
    @Get('/details/:ID_phieu_xuat_dong_vat')
    findOne(@Param('ID_phieu_xuat_dong_vat') ID_phieu_xuat_dong_vat: string) {
      return this.PhieuXuatDongVatService.findOne(ID_phieu_xuat_dong_vat);
    }
  
    @Get('all')
    findAll() {
      return this.PhieuXuatDongVatService.findAll();
    }
  


    //   @Patch(':id')
    //   update(
    //     @Param('id') id: string,
    //     @Body() updateLoaiDongVatDto: UpdateLoaiDongVatDto,
    //   ) {
    //     return this.HoSoSucKhoeService.update(+id, updateLoaiDongVatDto);
    //   }
  
    //   @Delete(':id')
    //   remove(@Param('id') id: string) {
    //     return this.HoSoSucKhoeService.remove(+id);
    //   }
  }
  