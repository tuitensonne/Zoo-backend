import { Controller, Get, Post, Body, Query, Param, Delete, UseGuards } from '@nestjs/common';
import { PhieuNhapThucAnService } from './phieu-nhap-thuc-an.service';
import { CreatePhieuNhapThucAnDto } from './dto/create-phieu-nhap-thuc-an.dto';
import { AuthGuard } from 'src/auth/auth.guard';
import { Role } from 'src/auth/Roles/role.enum';
import { Roles } from 'src/auth/Roles/roles.decorator';

@Controller('phieu-nhap-thuc-an')
@UseGuards(AuthGuard)
@Roles(Role.Office)
export class PhieuNhapThucAnController {
  constructor(private readonly phieuNhapThucAnService: PhieuNhapThucAnService) {}

  @Post()
  create(@Body() createPhieuNhapThucAnDto: CreatePhieuNhapThucAnDto) {
    return this.phieuNhapThucAnService.create(createPhieuNhapThucAnDto);
  }

  @Get()
  findAllPhieuNhapThucAn(
    @Query('page') page: number = 1,
    @Query('limit') limit: number = 10
  ) {
    return this.phieuNhapThucAnService.findPNByPage(page, limit);
  }

  @Get('/total-pages')
  findNumberOfPN(
    @Query('limit') limit: number = 10
  ) {
    return this.phieuNhapThucAnService.findNumberOfPagePN(limit);
  }

  @Get(':id')
  findOnePN(@Param('id') id: number) {
    return this.phieuNhapThucAnService.findOnePN(id);
  }

  @Delete(':id')
  removeById(@Param('id') id: number) {
    return this.phieuNhapThucAnService.remove(id);
  }
}
