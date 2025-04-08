import { Body, Controller, Get, Patch, Req, UseGuards } from '@nestjs/common';
import { NhanVienService } from './nhan_vien.service';
import { AuthGuard } from 'src/auth/auth.guard';

@Controller('nhan-vien')
@UseGuards(AuthGuard)

export class NhanVienController { 
  constructor(private readonly nhanVienService: NhanVienService) {}

  @Get('vanphong')
  findAllNhanVien() {
    return this.nhanVienService.findAllNhanVienVanPhong();
  }
  
  @Get('profile')
  async getProfileByEmail(@Req() request: Request) {
    return this.nhanVienService.getProfileByEmail(request['user'].email)
  }

  @Patch('profile')
  async updateProfile(@Req() request: Request, @Body() body: any) {
    return this.nhanVienService.updateProfile(request['user'].email, body)
  }

}
