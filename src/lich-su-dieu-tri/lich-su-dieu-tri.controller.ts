import {
  Controller,
  Post,
  Body,
  UseGuards,
} from '@nestjs/common';
import { LichSuDieuTriService } from './lich-su-dieu-tri.service';
import { CreateLichSuDieuTriDto } from './dto/create-lich-su-dieu-tri.dto';
import { AuthGuard } from 'src/auth/auth.guard';
import { Roles } from 'src/auth/Roles/roles.decorator';
import { Role } from 'src/auth/Roles/role.enum';

@Controller('lich-su-dieu-tri')
@UseGuards(AuthGuard)
@Roles(Role.Vet)
export class LichSuDieuTriController {
  constructor(private readonly LichSuDieuTriService: LichSuDieuTriService) {}

  @Post('create')
  create(@Body() CreateLichSuDieuTriDto: CreateLichSuDieuTriDto) {
    return this.LichSuDieuTriService.create(CreateLichSuDieuTriDto);
  }
}
