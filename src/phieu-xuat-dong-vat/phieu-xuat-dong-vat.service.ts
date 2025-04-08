import { Pool } from 'mysql2/promise';
import {
  Injectable,
  Inject,
  InternalServerErrorException,
  NotFoundException,
} from '@nestjs/common';
import { GetPhieuXuatDongVatDto } from './dto/get-phieu-xuat-dong-vat.dto';
import { GetPhieuXuatDongVatChiTietDto } from './dto/get-phieu-xuat-dong-vat-chi-tiet.dto';  
import { ExceptionsHandler } from '@nestjs/core/exceptions/exceptions-handler';
import { Console } from 'console';
@Injectable()
export class PhieuXuatDongVatService {
  constructor(@Inject('DATABASE_POOL') private readonly pool: Pool) {}

  async findNumberOfPagePN(limit: number) {
    const connection = await this.pool.getConnection()

    try {
      const [rows] = await connection.query(
        'SELECT get_number_of_phieu_xuat() AS recordCount'
      )

      const totalRecords = rows[0].recordCount;
      const totalPages = Math.ceil(totalRecords / limit);
      return { message: 'Request Successfully!', data: totalPages};
    } catch (error) {
      console.log(error)
      throw new ExceptionsHandler(error)
    } finally {
      connection.release();
    }
  }

  async findAll(page: Number, limit: Number) {
    const connection = await this.pool.getConnection();
    
    try {
      const [rows] = await connection.query(
        'CALL get_all_phieu_xuat_dong_vat(?,?)',
        [page, limit]
      );
      const rowsData = rows[0];
      
      if (Array.isArray(rowsData)) {
        // Ánh xạ dữ liệu vào DTO
        const result: GetPhieuXuatDongVatDto[] = rowsData.map((row) => {
        
        return {
            id_px: row.id_px,  
            ten_khoa_hoc: row.ten_khoa_hoc, 
            ngay_xuat: row.ngay_xuat,  
            so_luong: row.so_luong, 
            ly_do_xuat: row.ly_do_xuat, 
            id_dt: row.id_dt, 
            cccd: row.cccd,
            loai: row.loai,
          };
        });
        
        return result;
      } else {
        throw new InternalServerErrorException({
          message: 'Expected rows to be an array.',
          details: 'Query result is not in expected format.',
        });
      }
    } catch (error) {
      throw new InternalServerErrorException({
        message: 'Error retrieving all export records',
        details: error.message,
      });
    } finally {
      connection.release();
    }
  }

  async findOne(ID_phieu_xuat_dong_vat: string) {
    const connection = await this.pool.getConnection();

    try {
      const [rows] = await connection.query(
        'CALL get_phieu_xuat_dong_vat_chi_tiet(?)',
        [ID_phieu_xuat_dong_vat],
      );

      if (!rows[0] || rows[0].length === 0) {
        throw new Error('Phiếu xuất động vật không tồn tại');
      }

      const row = rows[0];
      
      const rowsData = rows[0];
      
     if (Array.isArray(rowsData)) {
        const result: GetPhieuXuatDongVatChiTietDto[] = rowsData.map((row) => {
          return {
            ten_nguoi_tao: row.ten_nguoi_tao,
            address: row.address,
            cccd: row.cccd,
            id_dt: row.id_dt,
            ten_doi_tac: row.ten_doi_tac,
            ten_khoa_hoc: row.ten_khoa_hoc,
            ten_loai: row.ten_loai,
            do_quy_hiem: row.do_quy_hiem,
            loai_thuc_an: row.loai_thuc_an,
            loai_moi_truong_song: row.loai_moi_truong_song,
            loai: row.loai,
          };
        });
        
        return result;
      } else {
        throw new InternalServerErrorException({
          message: 'Expected rows to be an array.',
          details: 'Query result is not in expected format.',
        });
      }
    } catch (error) {
      if (error.message === 'Phiếu xuất động vật không tồn tại') {
        throw new NotFoundException({
          message: 'Error retrieving export record details',
          details: error.message,
        });
      } else {
        throw new InternalServerErrorException({
          message: 'Error retrieving export record details',
          details: error.message,
        });
      }
    } finally {
      connection.release();
    }
  }

  async remove(id: number) {
    const connection = await this.pool.getConnection()

    try {
      await connection.query(
        'CALL delete_phieu_xuat_dong_vat(?)',
        [id]
      )
      return { message: 'Request Successfully!' };
    } catch (error) { 
      console.log(error)
      throw new ExceptionsHandler(error)
    } finally {
      connection.release();
    }
  }
}