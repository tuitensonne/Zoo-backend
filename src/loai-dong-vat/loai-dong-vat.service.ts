import { Pool } from 'mysql2/promise';
import { Injectable, Inject, InternalServerErrorException } from '@nestjs/common';
import { CreateLoaiDongVatDto } from './dto/create-loai-dong-vat.dto';
import { UpdateLoaiDongVatDto } from './dto/update-loai-dong-vat.dto';

@Injectable()
export class LoaiDongVatService {
  constructor(
    @Inject('DATABASE_POOL') private readonly pool: Pool,
  ) {}

  async create(createLoaiDongVatDto: CreateLoaiDongVatDto) {
    const connection = await this.pool.getConnection();

    try {
      const { 
        ten_khoa_hoc, 
        ten_loai, 
        do_quy_hiem, 
        loai_thuc_an, 
        thoi_gian_chu_ki, 
        thoi_gian_mang_thai, 
        loai_moi_truong_song 
      } = createLoaiDongVatDto;
  
      const result = await connection.query(
        'CALL add_loai_dong_vat(?, ?, ?, ?, ?, ?, ?)', 
        [
          ten_khoa_hoc, 
          ten_loai, 
          do_quy_hiem, 
          loai_thuc_an, 
          thoi_gian_chu_ki, 
          thoi_gian_mang_thai, 
          loai_moi_truong_song
        ]
      );
      return { message: 'Request Successfully!', data: result };
    } catch (error) {
      throw new InternalServerErrorException({
        message: 'ERROR!!!!',
        details: error.message,
      });
    } finally {
      connection.release();
    }
  }

  findAll() {
    return `This action returns all loaiDongVat`;
  }

  findOne(ten_khoa_hoc: string) {
    return `This action returns a #${ten_khoa_hoc} loaiDongVat`;
  }

  update(id: number, updateLoaiDongVatDto: UpdateLoaiDongVatDto) {
    return `This action updates a #${id} loaiDongVat`;
  }

  remove(id: number) {
    return `This action removes a #${id} loaiDongVat`;
  }
}
