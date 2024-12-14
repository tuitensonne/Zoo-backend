import { Pool } from 'mysql2/promise';
import { Injectable, Inject, InternalServerErrorException } from '@nestjs/common';

@Injectable()
export class NhanVienService {
  constructor(
    @Inject('DATABASE_POOL') private readonly pool: Pool,
  ) {}

  async findAllNhanVienVanPhong() {
      const connection = await this.pool.getConnection();
   
      try {
        const [rows] = await connection.query(
  
          'CALL get_all_nv_van_phong()'
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

}
