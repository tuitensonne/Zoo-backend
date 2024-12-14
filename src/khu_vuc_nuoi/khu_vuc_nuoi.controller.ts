import { Controller, Get, Post, Body, Patch, Param, Delete, Query  } from '@nestjs/common';
import { KhuVucNuoiService } from './khu_vuc_nuoi.service';
import { CreateKhuVucNuoiDto } from './dto/create-khu_vuc_nuoi.dto';
import { UpdateKhuVucNuoiDto } from './dto/update-khu_vuc_nuoi.dto';

@Controller('khu-vuc-nuoi')
export class KhuVucNuoiController {
  constructor(private readonly khuVucNuoiService: KhuVucNuoiService) {}

  @Post()
  create(@Body() createKhuVucNuoiDto: CreateKhuVucNuoiDto) {
    return this.khuVucNuoiService.create(createKhuVucNuoiDto);
  }

  @Get()
  findAllKhuVucNuoi(
    @Query('page') page: number = 0,
    @Query('limit') limit: number = 10
  ) {
    return this.khuVucNuoiService.findAllKhuVucNuoi(page, limit);
  }

  @Get('/total-pages')
  findNumberOfKVN(
    @Query('limit') limit: number = 10
  ) {
    return this.khuVucNuoiService.findNumberOfPageKVN(limit);
  }

  @Get('/list')
  findKVNList() {
    return this.khuVucNuoiService.findKVNList();
  }

  @Patch(':id')
  updateTrangThai(
    @Param('id') id_kv: number,
    @Body('trang_thai_hoat_dong') trang_thai_hoat_dong: string,
  ) {
      return this.khuVucNuoiService.update(id_kv, trang_thai_hoat_dong);
  }

  @Get(':id')
  findOne(@Param('id') id: string) { 
    return this.khuVucNuoiService.findOne(+id);
  }

  @Delete(':id')
  removeById(@Param('id') id: number) {
    return this.khuVucNuoiService.remove(id);
  }
}
