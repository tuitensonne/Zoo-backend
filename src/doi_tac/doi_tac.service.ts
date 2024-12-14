import { Pool } from 'mysql2/promise';
import { Injectable, Inject, InternalServerErrorException } from '@nestjs/common';

@Injectable()
export class DoiTacService {
  constructor(
    @Inject('DATABASE_POOL') private readonly pool: Pool,
  ) {}

  async findAllSoThu() {
    const connection = await this.pool.getConnection();
 
    try {
      const [rows] = await connection.query(

        'CALL get_all_doi_tac_so_thu()'
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

  async findAllDTThucAn() {
    const connection = await this.pool.getConnection();
 
    try {
      const [rows] = await connection.query(

        'CALL get_all_doi_tac_thuc_an()'
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
