import {Controller,Post,Get,Body, UseGuards,} from '@nestjs/common';
import { TaoPhieuXuatDongVatService } from './tao-phieu-xuat-dong-vat.service';
import { TaoPhieuXuatDongVatNhomDto } from './dto/tao-phieu-xuat-dong-vat-nhom.dto';
import { TaoPhieuXuatDongVatctDto } from './dto/tao-phieu-xuat-dong-vat-ct.dto';
import { AuthGuard } from 'src/auth/auth.guard';
import { Role } from 'src/auth/Roles/role.enum';
import { Roles } from 'src/auth/Roles/roles.decorator';

@Controller('tao-phieu-xuat-dong-vat')
@UseGuards(AuthGuard)
@Roles(Role.Vet)
export class TaoPhieuXuatDongVatController {
  constructor(private readonly TaoPhieuXuatDongVatService: TaoPhieuXuatDongVatService) {}

  @Post('createGroup')
  createGroup(@Body() TaoPhieuXuatDongVatNhomDto: TaoPhieuXuatDongVatNhomDto) {
    return this.TaoPhieuXuatDongVatService.createGroup(TaoPhieuXuatDongVatNhomDto);
  }

  @Post('createct')
  createct(@Body() TaoPhieuXuatDongVatctDto: TaoPhieuXuatDongVatctDto) {
    return this.TaoPhieuXuatDongVatService.createct(TaoPhieuXuatDongVatctDto);
  }

  @Get('ct')
  getCtInfo() {
    return this.TaoPhieuXuatDongVatService.getCtInfo();
  }

  @Get('nhom')
  getNhomInfo() {
    return this.TaoPhieuXuatDongVatService.getNhomInfo();
  }

  @Get('getdoitac')
  getdoitacInfo() {
    return this.TaoPhieuXuatDongVatService.getdoitacInfo();
  }
}