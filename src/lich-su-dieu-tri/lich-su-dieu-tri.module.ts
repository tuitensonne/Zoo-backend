import { MiddlewareConsumer, Module, RequestMethod } from '@nestjs/common';
import { LichSuDieuTriService } from './lich-su-dieu-tri.service';
import { LichSuDieuTriController } from './lich-su-dieu-tri.controller';
import { validateCreateTreatment } from './create-lsdt.validation';

@Module({
  controllers: [LichSuDieuTriController],
  providers: [LichSuDieuTriService],
})
export class LichSuDieuTriModule {
  configure(consumer: MiddlewareConsumer) {
    consumer.apply(validateCreateTreatment).forRoutes({
      path: 'lich-su-dieu-tri/create',
      method: RequestMethod.POST,
    });
  }
}
