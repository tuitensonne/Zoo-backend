import { Controller, Get, Post, Body, Query, Param, Delete } from '@nestjs/common';
import { PhieuNhapDongVatService } from './phieu_nhap_dong_vat.service';
import { CreatePhieuNhapDongVatDto } from './dto/create-phieu_nhap_dong_vat.dto';

@Controller('phieu-nhap-dong-vat')
export class PhieuNhapDongVatController {
  constructor(private readonly phieuNhapDongVatService: PhieuNhapDongVatService) {}

  @Post()
  create(@Body() CreatePhieuNhapDongVatDto : CreatePhieuNhapDongVatDto ) {
    return this.phieuNhapDongVatService.create(CreatePhieuNhapDongVatDto );
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

  @Get('/thucan')
  findOneTA(@Body('id') id: number) {
    return this.phieuNhapDongVatService.findOneTA(id);
  } 

  @Delete('/id')
  removeById(@Body('id') id: number) {
    return this.phieuNhapDongVatService.remove(id);
  }
}
