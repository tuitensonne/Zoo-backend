import {
  Controller,
  Get,
  //Post,
  //Body,
  //Patch,
  Param,
  //Delete,
  Query,
} from '@nestjs/common';
import { HoSoSucKhoeService } from './ho-so-suc-khoe.service';

@Controller('ho-so-suc-khoe')
export class HoSoSucKhoeController {
  constructor(private readonly HoSoSucKhoeService: HoSoSucKhoeService) {}

  //   @Post('create')
  //   create(@Body() createLoaiDongVatDto: CreateLoaiDongVatDto) {
  //     return this.HoSoSucKhoeService.create(createLoaiDongVatDto);
  //   }

  @Get('/details/:ID_ho_so_suc_khoe')
  findOne(@Param('ID_ho_so_suc_khoe') ID_ho_so_suc_khoe: string) {
    return this.HoSoSucKhoeService.findOne(ID_ho_so_suc_khoe);
  }

  @Get('all')
  findAll(
    @Query('page') page: number = 1, // Lấy tham số page từ query params, mặc định là 1
    @Query('pageSize') pageSize: number = 10, // Lấy tham số pageSize từ query params, mặc định là 10
    @Query('searchId') searchId: number = null, // Thêm tham số searchId từ query params
    @Query('searchName') searchName: string = null, // Thêm tham số searchName từ query params
  ) {
    // Xử lý tham số searchId và searchName để đảm bảo không truyền giá trị null hoặc undefined
    searchId = searchId || null; // Gán null nếu searchId không có giá trị hợp lệ
    searchName = searchName || null; // Gán chuỗi rỗng nếu searchName không có giá trị hợp lệ

    return this.HoSoSucKhoeService.findAll(
      page,
      pageSize,
      searchId,
      searchName,
    );
  }

  //   @Patch(':id')
  //   update(
  //     @Param('id') id: string,
  //     @Body() updateLoaiDongVatDto: UpdateLoaiDongVatDto,
  //   ) {
  //     return this.HoSoSucKhoeService.update(+id, updateLoaiDongVatDto);
  //   }

  //   @Delete(':id')
  //   remove(@Param('id') id: string) {
  //     return this.HoSoSucKhoeService.remove(+id);
  //   }
}
