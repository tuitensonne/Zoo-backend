import { Pool } from 'mysql2/promise';
import {
  Injectable,
  Inject,
  InternalServerErrorException,
  NotFoundException,
} from '@nestjs/common';
import { GetHoSoSucKhoeDto } from './dto/get-ho-so-suc-khoe.dto';
import { GetHoSoSucKhoeChiTietDto } from './dto/get-ho-so-suc-khoe-chi-tiet.dto';

@Injectable()
export class HoSoSucKhoeService {
  constructor(@Inject('DATABASE_POOL') private readonly pool: Pool) {}

  async findAll(
    page: number = 1,
    pageSize: number = 10,
    searchId: number = null,
    searchName: string = null,
  ) {
    const connection = await this.pool.getConnection();

    try {
      // Tính toán offset và limit cho phân trang
      const offset = (page - 1) * pageSize;
      
      // Thực hiện truy vấn với phân trang
      const [rows] = await connection.query(
        'CALL get_all_ho_so_suc_khoe(?, ?, ?, ?)',
        [offset, pageSize, searchId, searchName],
      );
      const rowsData = rows[0];
      
      if (Array.isArray(rowsData)) {
        const result: GetHoSoSucKhoeDto[] = rowsData.map((row) => ({
          id_ho_so_suc_khoe: row.id_hssk,
          loai: row.loai,
          ten_khoa_hoc: row.ten_khoa_hoc,
          tuoi_or_soluong: row.tuoi_or_soluong,
          tinh_trang_suc_khoe: row.tinh_trang_suc_khoe,
          chieu_cao: row.chieu_cao,
          can_nang: row.can_nang,
        }));
        
        //Tinh tong so ban ghi
        // Thực hiện truy vấn với phân trang
        const [totalCountRows] = await connection.query(
          'SELECT get_total_ho_so_suc_khoe(?, ?) AS total_count',
          [searchId, searchName],
        );
        
        const totalRecords = totalCountRows[0]
          ? totalCountRows[0].total_count
          : 0;

        return {
          records: result,
          page,
          pageSize,
          totalRecords,
        };
      } else {
        throw new InternalServerErrorException({
          message: 'Expected rows to be an array.',
          details: 'Query result is not in expected format.',
        });
      }
    } catch (error) {
      throw new InternalServerErrorException({
        message: 'Error retrieving all health records',
        details: error.message,
      });
    } finally {
      connection.release();
    }
  }
}
