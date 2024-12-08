import { Pool } from 'mysql2/promise';
import { Injectable, Inject, InternalServerErrorException } from '@nestjs/common';
import { UpdateNhanvienDto } from './dto/update-nhanvien.dto';

@Injectable()
export class NhanvienService {
  constructor(
    @Inject('DATABASE_POOL') private readonly pool: Pool,
  ) {}

  findAll() {
    return `This action returns all nhanvien`;
  }

  async findOneNV(cccd: string) {
    const connection = await this.pool.getConnection();

    try {
      const [rows] = await connection.query(
        'CALL get_nv_van_phong_theo_cccd(?)',
        [cccd],
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

  update(id: number, updateNhanvienDto: UpdateNhanvienDto) {
    return `This action updates a #${id} nhanvien`;
  }

  remove(id: number) {
    return `This action removes a #${id} nhanvien`;
  }
}
