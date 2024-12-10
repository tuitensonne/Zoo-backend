import { MiddlewareConsumer, Module, RequestMethod } from '@nestjs/common';
import { LichSuTiemChungService } from './lich-su-tiem-chung.service';
import { LichSuTiemChungController } from './lich-su-tiem-chung.controller';
import { validateCreateVaccination } from './create-lstc.validation';

@Module({
  controllers: [LichSuTiemChungController],
  providers: [LichSuTiemChungService],
})
export class LichSuTiemChungModule {
  configure(consumer: MiddlewareConsumer) {
    consumer.apply(validateCreateVaccination).forRoutes({
      path: 'lich-su-tiem-chung/create',
      method: RequestMethod.POST,
    });
  }
}
