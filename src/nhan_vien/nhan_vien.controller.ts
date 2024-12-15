import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { NhanVienService } from './nhan_vien.service';
@Controller('nhan-vien')
export class NhanVienController { 
  constructor(private readonly nhanVienService: NhanVienService) {}

  @Get('vanphong')
  findAllNhanVien() {
    return this.nhanVienService.findAllNhanVienVanPhong();
  }
}
