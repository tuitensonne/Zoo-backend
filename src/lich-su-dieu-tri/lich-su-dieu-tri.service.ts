import { Pool, ResultSetHeader } from 'mysql2/promise';
import {
  Injectable,
  Inject,
  InternalServerErrorException,
} from '@nestjs/common';
import { CreateLichSuDieuTriDto } from './dto/create-lich-su-dieu-tri.dto';

@Injectable()
export class LichSuDieuTriService {
  constructor(@Inject('DATABASE_POOL') private readonly pool: Pool) {}

  async create(createLichSuDieuTriDto: CreateLichSuDieuTriDto) {
    const connection = await this.pool.getConnection();

    try {
      const {
        ID_ho_so_suc_khoe,
        trieu_chung,
        chan_doan,
        ket_qua,
        loai_thuoc,
        ghi_chu,
      } = createLichSuDieuTriDto;

      // Gọi stored procedure để tạo lịch sử điều trị
      const [result] = await connection.query<ResultSetHeader>(
        'CALL create_lich_su_dieu_tri(?, ?, ?, ?, ?, ?)',
        [
          ID_ho_so_suc_khoe,
          trieu_chung,
          chan_doan,
          ket_qua,
          loai_thuoc,
          ghi_chu,
        ],
      );

      //console.log('Rows from database:', result);

      // Kiểm tra affectedRows (nếu không tồn tại, throw error)
      if (!result || result.affectedRows === 0) {
        throw new InternalServerErrorException({
          message: 'Error creating treatment history',
          details: 'Stored procedure did not affect any rows.',
        });
      }

      // Trả về thông tin hoặc một thông báo thành công
      return { message: 'Lịch sử điều trị đã được tạo thành công!' };
    } catch (error) {
      throw new InternalServerErrorException({
        message: 'Error creating treatment history',
        details: error.message,
      });
    } finally {
      connection.release();
    }
  }
}
