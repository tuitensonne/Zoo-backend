import { Controller, Get, Post, Body, Patch, Param, Delete, Query, UseGuards, UsePipes } from '@nestjs/common';
import { LoaiDongVatService } from './loai-dong-vat.service';
import { Roles } from 'src/auth/Roles/roles.decorator';
import { Role } from 'src/auth/Roles/role.enum';
import { AuthGuard } from 'src/auth/auth.guard';


@Controller('loai-dong-vat')
@Roles(Role.Office)
@UseGuards(AuthGuard)

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
