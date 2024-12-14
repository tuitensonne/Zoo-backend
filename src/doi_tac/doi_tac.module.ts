import { Module } from '@nestjs/common';
import { DoiTacService } from './doi_tac.service';
import { DoiTacController } from './doi_tac.controller';

@Module({
  controllers: [DoiTacController],
  providers: [DoiTacService],
})
export class DoiTacModule {}
