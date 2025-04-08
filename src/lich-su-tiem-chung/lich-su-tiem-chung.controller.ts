import {
  Controller,
  Post,
  Body,
  UseGuards,
} from '@nestjs/common';
import { LichSuTiemChungService } from './lich-su-tiem-chung.service';
import { CreateLichSuTiemChungDto } from './dto/create-lich-su-tiem-chung.dto';
import { AuthGuard } from 'src/auth/auth.guard';
import { Role } from 'src/auth/Roles/role.enum';
import { Roles } from 'src/auth/Roles/roles.decorator';

@Controller('lich-su-tiem-chung')
@UseGuards(AuthGuard)
@Roles(Role.Vet)
export class LichSuTiemChungController {
  constructor(private readonly LichSuDieuTriService: LichSuTiemChungService) {}

  @Post('create')
  create(@Body() CreateLichSuDieuTriDto: CreateLichSuTiemChungDto) {
    return this.LichSuDieuTriService.create(CreateLichSuDieuTriDto);
  }
}
