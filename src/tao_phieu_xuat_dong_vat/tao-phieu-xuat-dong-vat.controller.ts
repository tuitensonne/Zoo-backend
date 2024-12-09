import {Controller,Post,Get,Body,} from '@nestjs/common';
import { TaoPhieuXuatDongVatService } from './tao-phieu-xuat-dong-vat.service';
import { TaoPhieuXuatDongVatNhomDto } from './dto/tao-phieu-xuat-dong-vat-nhom.dto';
import { TaoPhieuXuatDongVatctDto } from './dto/tao-phieu-xuat-dong-vat-ct.dto';
  @Controller('tao-phieu-xuat-dong-vat')
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
      // Endpoint GET để lấy thông tin về cá thể (ct)
  @Get('ct')
  getCtInfo() {
    return this.TaoPhieuXuatDongVatService.getCtInfo();
  }

  // Endpoint GET để lấy thông tin về nhóm (nhom)
  @Get('nhom')
  getNhomInfo() {
    return this.TaoPhieuXuatDongVatService.getNhomInfo();
  }

  // Endpoint GET để lấy thông tin về ten_doi_tac
  @Get('getdoitac')
  getdoitacInfo() {
    return this.TaoPhieuXuatDongVatService.getdoitacInfo();
  }
}