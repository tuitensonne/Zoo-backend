import { Controller, Get, Post, Body, Patch, Param, Delete, Query, UseGuards  } from '@nestjs/common';
import { KhuVucNuoiService } from './khu_vuc_nuoi.service';
import { CreateKhuVucNuoiDto } from './dto/create-khu_vuc_nuoi.dto';
import { AuthGuard } from 'src/auth/auth.guard';
import { Roles } from 'src/auth/Roles/roles.decorator';
import { Role } from 'src/auth/Roles/role.enum';

@Controller('khu-vuc-nuoi')
@UseGuards(AuthGuard)
@Roles(Role.Office)
export class KhuVucNuoiController {
  constructor(private readonly khuVucNuoiService: KhuVucNuoiService) {}

  @Post()
  create(@Body() createKhuVucNuoiDto: CreateKhuVucNuoiDto) {
    return this.khuVucNuoiService.create(createKhuVucNuoiDto);
  }

  @Get()
  getAllKhuVucNuoi(
    @Query('page') page: number = 1,
    @Query('limit') limit: number = 10
  ) {
    return this.khuVucNuoiService.getAllKhuVucNuoi(page, limit);
  }

  @Get('list')
  getKVNList() {
    return this.khuVucNuoiService.getAllActiveKVN();
  }

  @Patch(':id')
  updateTrangThai(
    @Param('id') id_kv: number,
    @Body('trang_thai_hoat_dong') trang_thai_hoat_dong: string,
  ) {
      return this.khuVucNuoiService.update(id_kv, trang_thai_hoat_dong);
  }

  @Get(':id/status')
  getOne(@Param('id') id: string) { 
    return this.khuVucNuoiService.getOne(+id);
  }

  @Delete(':id')
  removeById(@Param('id') id: number) {
    return this.khuVucNuoiService.remove(id);
  }
}
