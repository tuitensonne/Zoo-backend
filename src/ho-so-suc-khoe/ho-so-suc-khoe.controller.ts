import {
  Controller,
  Get,
  Param,
  Query,
  UseGuards,
} from '@nestjs/common';
import { HoSoSucKhoeService } from './ho-so-suc-khoe.service';
import { AuthGuard } from 'src/auth/auth.guard';
import { Roles } from 'src/auth/Roles/roles.decorator';
import { Role } from 'src/auth/Roles/role.enum';

@Controller('ho-so-suc-khoe')
@UseGuards(AuthGuard)
@Roles(Role.Vet)
export class HoSoSucKhoeController {
  constructor(private readonly HoSoSucKhoeService: HoSoSucKhoeService) {}

  @Get('all')
  findAll(
    @Query('page') page: number = 1,
    @Query('pageSize') pageSize: number = 10, 
    @Query('searchId') searchId: number = null,
    @Query('searchName') searchName: string = null,
  ) {
    searchId = searchId || null;
    searchName = searchName || null;

    return this.HoSoSucKhoeService.findAll(
      page,
      pageSize,
      searchId,
      searchName,
    );
  }
}
