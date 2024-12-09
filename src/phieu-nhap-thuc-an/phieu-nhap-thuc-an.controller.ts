import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { PhieuNhapThucAnService } from './phieu-nhap-thuc-an.service';
import { CreatePhieuNhapThucAnDto } from './dto/create-phieu-nhap-thuc-an.dto';

@Controller('phieu-nhap-thuc-an')
export class PhieuNhapThucAnController {
  constructor(private readonly phieuNhapThucAnService: PhieuNhapThucAnService) {}

  @Post()
  create(@Body() createPhieuNhapThucAnDto: CreatePhieuNhapThucAnDto) {
    return this.phieuNhapThucAnService.create(createPhieuNhapThucAnDto);
  }

  @Get()
  findPNByPage(@Body('id') id: number) {
    return this.phieuNhapThucAnService.findPNByPage(id);
  }

  @Get('/id')
  findOnePN(@Body('id') id: number) {
    return this.phieuNhapThucAnService.findOnePN(id);
  }

  @Get('/thucan')
  findOneTA(@Body('id') id: number) {
    return this.phieuNhapThucAnService.findOneTA(id);
  } 

  @Delete('/id')
  removeById(@Body('id') id: number) {
    return this.phieuNhapThucAnService.remove(id);
  }
}
