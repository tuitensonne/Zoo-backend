import { Module, MiddlewareConsumer, RequestMethod } from '@nestjs/common';
import { HoSoSucKhoeService } from './ho-so-suc-khoe.service';
import { HoSoSucKhoeController } from './ho-so-suc-khoe.controller';
import {
  validateGetHealthRecords,
  validateGetHealthRecordsDetails,
} from './get-all-hssk.validation';

@Module({
  controllers: [HoSoSucKhoeController],
  providers: [HoSoSucKhoeService],
})
export class HoSoSucKhoeModule {
  configure(consumer: MiddlewareConsumer) {
    consumer
      .apply(validateGetHealthRecords)
      .forRoutes({ path: 'ho-so-suc-khoe/all', method: RequestMethod.GET });

    consumer.apply(validateGetHealthRecordsDetails).forRoutes({
      path: 'ho-so-suc-khoe/details/:id',
      method: RequestMethod.GET,
    });
  }
}
