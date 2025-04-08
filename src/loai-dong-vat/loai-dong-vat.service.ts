import { Pool } from 'mysql2/promise';
import { Injectable, Inject, InternalServerErrorException } from '@nestjs/common';


@Injectable()
export class LoaiDongVatService {
  constructor(
    @Inject('DATABASE_POOL') private readonly pool: Pool,
  ) {}

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
      gioi_tinh = "đuc"
    else gioi_tinh = "cai"
      try {
      const [rows] = await connection.query(
        'CALL get_all_ct_of_loai_dong_vat(?, ?)', [ten_khoa_hoc
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
