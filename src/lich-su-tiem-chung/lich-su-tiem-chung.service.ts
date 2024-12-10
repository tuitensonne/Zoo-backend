import { Pool, ResultSetHeader } from 'mysql2/promise';
import {
  Injectable,
  Inject,
  InternalServerErrorException,
} from '@nestjs/common';
import { CreateLichSuTiemChungDto } from './dto/create-lich-su-tiem-chung.dto';

@Injectable()
export class LichSuTiemChungService {
  constructor(@Inject('DATABASE_POOL') private readonly pool: Pool) {}

  async create(createLichSuTiemChungDto: CreateLichSuTiemChungDto) {
    const connection = await this.pool.getConnection();

    try {
      const {
        ID_ho_so_suc_khoe,
        ngay_tiem,
        phuong_phap_tiem,
        loai_vaccine,
        lieu_luong,
        phan_ung_sau_tiem,
      } = createLichSuTiemChungDto;

      // Gọi stored procedure để tạo lịch sử điều trị
      const [result] = await connection.query<ResultSetHeader>(
        'CALL create_lich_su_tiem_chung(?, ?, ?, ?, ?, ?)',
        [
          ID_ho_so_suc_khoe,
          ngay_tiem,
          phuong_phap_tiem,
          loai_vaccine,
          lieu_luong,
          phan_ung_sau_tiem,
        ],
      );

      //console.log('Rows from database:', result);

      // Kiểm tra affectedRows (nếu không tồn tại, throw error)
      if (!result || result.affectedRows === 0) {
        throw new InternalServerErrorException({
          message: 'Error creating vaccinate history',
          details: 'Stored procedure did not affect any rows.',
        });
      }

      // Trả về thông tin hoặc một thông báo thành công
      return { message: 'Lịch sử tiêm chủng đã được tạo thành công!' };
    } catch (error) {
      throw new InternalServerErrorException({
        message: 'Error creating vaccinate history',
        details: error.message,
      });
    } finally {
      connection.release();
    }
  }
}
