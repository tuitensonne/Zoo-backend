import { Controller, Get, Post, Body, Query, Param, Delete, UseGuards, UsePipes, ValidationPipe } from '@nestjs/common';
import { PhieuNhapDongVatService } from './phieu_nhap_dong_vat.service';
import { CreatePhieuNhapDongVatCTDto } from './dto/create-phieu_nhap_dong_vat.dto';
import { CreatePhieuNhapDongVatNhomDto } from './dto/create-phieu_nhap_dong_vat.dto';
import { AuthGuard } from 'src/auth/auth.guard';
import { Roles } from 'src/auth/Roles/roles.decorator';
import { Role } from 'src/auth/Roles/role.enum';

@Controller('phieu-nhap-dong-vat') 
@Roles(Role.Office)
@UseGuards(AuthGuard)

export class PhieuNhapDongVatController {
  constructor(private readonly phieuNhapDongVatService: PhieuNhapDongVatService) {}

  @Post('/cathe')
  createCT(@Body() CreatePhieuNhapDongVatCTDto : CreatePhieuNhapDongVatCTDto ) {
    return this.phieuNhapDongVatService.createCT(CreatePhieuNhapDongVatCTDto );
  }

  @Post('/nhom')
  createNhom(@Body() CreatePhieuNhapDongVatNhomDto : CreatePhieuNhapDongVatNhomDto ) {
    return this.phieuNhapDongVatService.createNhom(CreatePhieuNhapDongVatNhomDto );
  }

  @Get()
  findAllPhieuNhapDongVat(
    @Query('page') page: number = 0,
    @Query('limit') limit: number = 10
  ) {
    return this.phieuNhapDongVatService.findPNByPage(page, limit);
  }

  @Get('/total-pages')
  findNumberOfPN(
    @Query('limit') limit: number = 10
  ) {
    return this.phieuNhapDongVatService.findNumberOfPagePN(limit);
  }

  @Get(':id')
  findOnePN(@Param('id') id: number) {
    return this.phieuNhapDongVatService.findOnePN(id);
  }

  @Delete(':id')
  removeById(@Param('id') id: number) {
    return this.phieuNhapDongVatService.remove(id);
  }
}
