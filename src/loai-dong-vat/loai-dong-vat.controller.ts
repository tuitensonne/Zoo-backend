import { Controller, Get, Post, Body, Patch, Param, Delete, Query } from '@nestjs/common';
import { LoaiDongVatService } from './loai-dong-vat.service';
import { CreateLoaiDongVatDto } from './dto/create-loai-dong-vat.dto';
import { UpdateLoaiDongVatDto } from './dto/update-loai-dong-vat.dto';

@Controller('loai-dong-vat')
export class LoaiDongVatController {
  constructor(private readonly LoaiDongVatService: LoaiDongVatService) {}

  @Post('create')
  create(@Body() createLoaiDongVatDto: CreateLoaiDongVatDto) {
    return this.LoaiDongVatService.create(createLoaiDongVatDto)
  }

  @Get()
  findOne(@Query('ten_khoa_hoc') ten_khoa_hoc: string) {
    return this.LoaiDongVatService.findOne(ten_khoa_hoc);
  }

  @Get('test')
  findAll() {
    return "hello";
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
