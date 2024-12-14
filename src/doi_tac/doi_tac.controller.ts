import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { DoiTacService } from './doi_tac.service';

@Controller('doi-tac')
export class DoiTacController {
  constructor(private readonly doiTacService: DoiTacService) {}

  @Get('/sothu')
  findAllSoThu() {
    return this.doiTacService.findAllSoThu();
  }

  @Get('/thucan')
  findAllDTThucAn() {
    return this.doiTacService.findAllDTThucAn();
  }
}
