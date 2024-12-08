import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { NhanvienService } from './nhanvien.service';
import { UpdateNhanvienDto } from './dto/update-nhanvien.dto';

@Controller('nhanvien')
export class NhanvienController {
  constructor(private readonly nhanvienService: NhanvienService) {}

  @Get()
  findAll() {
    return this.nhanvienService.findAll();
  }

  @Get(':id')
  findOne(@Body('cccd') cccd: string) {
    return this.nhanvienService.findOneNV(cccd);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateNhanvienDto: UpdateNhanvienDto) {
    return this.nhanvienService.update(+id, updateNhanvienDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.nhanvienService.remove(+id);
  }
}
