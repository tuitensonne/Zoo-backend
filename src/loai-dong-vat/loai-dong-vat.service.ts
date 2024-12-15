import { Pool } from 'mysql2/promise';
import { Injectable, Inject, InternalServerErrorException } from '@nestjs/common';
import { CreateLoaiDongVatDto} from './dto/create-loai-dong-vat.dto';


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

  async getAllLDV() {
    const connection = await this.pool.getConnection();

    try {
      const [rows] = await connection.query(
        'CALL get_loai_dong_vat_list()'
      );
      return { message: 'Request Successfully!', data: rows[0] };
    } catch (error) {
      throw new InternalServerErrorException({
        message: 'ERROR!!!!',
        details: error.message,
      });
    } finally {
      connection.release();
    }
  }

  async getAllCT(ten_khoa_hoc: string , gt: number) {
    const connection = await this.pool.getConnection();
    let gioi_tinh = ""
    if (gt === 0)
      gioi_tinh = "đực"
    else gioi_tinh = "cái"
      try {
      const [rows] = await connection.query(
        'CALL get_all_ct_of_ldv(?, ?)', [ten_khoa_hoc
          , gioi_tinh]
      );
      return { message: 'Request Successfully!', data: rows[0]};
    } catch (error) {
      throw new InternalServerErrorException({
        message: 'ERROR!!!!',
        details: error.message,
      });
    } finally {
      connection.release();
    }
  }

}
