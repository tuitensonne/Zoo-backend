import { Controller, Delete, Get, Param, Query, UseGuards } from '@nestjs/common';
import { PhieuXuatDongVatService } from './phieu-xuat-dong-vat.service';
import { AuthGuard } from 'src/auth/auth.guard';
import { Role } from 'src/auth/Roles/role.enum';
import { Roles } from 'src/auth/Roles/roles.decorator';

@Controller('phieu-xuat-dong-vat')
@UseGuards(AuthGuard)
@Roles(Role.Office)

export class PhieuXuatDongVatController {
  constructor(private readonly PhieuXuatDongVatService: PhieuXuatDongVatService) { }

  @Get('/details/:ID_phieu_xuat_dong_vat')
  findOne(@Param('ID_phieu_xuat_dong_vat') ID_phieu_xuat_dong_vat: string) {
    return this.PhieuXuatDongVatService.findOne(ID_phieu_xuat_dong_vat);
  }

  @Get()
  findAll(
    @Query('page') page: Number = 1,
    @Query('limit') limit: Number = 10
  ) {
    return this.PhieuXuatDongVatService.findAll(page, limit);
  }

  @Get('/total-pages')
  findNumberOfPN(
    @Query('limit') limit: number = 10
  ) {
    return this.PhieuXuatDongVatService.findNumberOfPagePN(limit);
  }

  @Delete(':id')
  async remove(@Param('id') id: string) {
      return this.PhieuXuatDongVatService.remove(+id);
  }
}
