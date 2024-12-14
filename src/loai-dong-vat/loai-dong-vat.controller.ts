import { Controller, Get, Post, Body, Patch, Param, Delete, Query } from '@nestjs/common';
import { LoaiDongVatService } from './loai-dong-vat.service';
import { CreateCaTheDto, CreateLoaiDongVatDto, CreateNhomDto } from './dto/create-loai-dong-vat.dto';
import { UpdateLoaiDongVatDto } from './dto/update-loai-dong-vat.dto';

@Controller('loai-dong-vat')
export class LoaiDongVatController {
  constructor(private readonly LoaiDongVatService: LoaiDongVatService) {}

  @Post('create')
  create(@Body() createLoaiDongVatDto: CreateLoaiDongVatDto) {
    return this.LoaiDongVatService.create(createLoaiDongVatDto)
  }

  @Post('create/cathe')
  createCT(@Body() createCaTheDto: CreateCaTheDto) {
    return this.LoaiDongVatService.createCT(createCaTheDto)
  }

  @Post('create/nhom')
  createNhom(@Body() createNhomDto: CreateNhomDto) {
    return this.LoaiDongVatService.createNhom(createNhomDto)
  }

  @Get('/cathe')
  getAllCT(
    @Query('ten_khoa_hoc') ten_khoa_hoc: string = "",
    @Query('gioi_tinh') gioi_tinh: string ="0"
  ) {
    return this.LoaiDongVatService.getAllCT(ten_khoa_hoc, +gioi_tinh)
  }

  @Get()
  findOne(@Query('ten_khoa_hoc') ten_khoa_hoc: string) {
    return this.LoaiDongVatService.findOne(ten_khoa_hoc);
  }
  
  @Get('/getallLDV')
  getAllLDV() {
    return this.LoaiDongVatService.getAllLDV();
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateLoaiDongVatDto: UpdateLoaiDongVatDto) {
    return this.LoaiDongVatService.update(+id, updateLoaiDongVatDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.LoaiDongVatService.remove(+id);
  }
}
