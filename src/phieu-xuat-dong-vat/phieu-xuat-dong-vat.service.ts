import { Pool } from 'mysql2/promise';
import {
  Injectable,
  Inject,
  InternalServerErrorException,
  NotFoundException,
} from '@nestjs/common';
import { GetPhieuXuatDongVatDto } from './dto/get-phieu-xuat-dong-vat.dto';
import { GetPhieuXuatDongVatChiTietDto } from './dto/get-phieu-xuat-dong-vat-chi-tiet.dto';  
@Injectable()
export class PhieuXuatDongVatService {
  constructor(@Inject('DATABASE_POOL') private readonly pool: Pool) {}

  async findAll() {
    const connection = await this.pool.getConnection();
    
    try {
      // Thực hiện query để lấy dữ liệu
      const [rows] = await connection.query('CALL get_all_phieu_xuat_dong_vat()');
      
      // Kiểm tra lại dữ liệu thô trả về
    //   console.log('Raw data from query:', rows);
      
      // Lấy dữ liệu từ rows[0] (cấu trúc khi dùng CALL trong MySQL)
      const rowsData = rows[0];
      
      // Kiểm tra nếu dữ liệu có dạng mảng
      if (Array.isArray(rowsData)) {
        // Ánh xạ dữ liệu vào DTO
        const result: GetPhieuXuatDongVatDto[] = rowsData.map((row) => {
        //   console.log('Raw row data:', row); // Kiểm tra từng row dữ liệu
        
          return {
            id_px: row.id_px,  // Kiểm tra tên trường trong kết quả SQL
            ten_khoa_hoc: row.ten_khoa_hoc,  // Tên khoa học loài động vật
            ngay_xuat: row.ngay_xuat,  // Ngày xuất động vật
            so_luong: row.so_luong,  // Số lượng động vật xuất
            ly_do_xuat: row.ly_do_xuat,  // Lý do xuất động vật
            id_dt: row.id_dt,  // ID đối tác (trường khoá ngoại)
            cccd: row.cccd,  // CCCD của nhân viên (trường khoá ngoại)
            loai: row.loai,  // Loại phiếu xuất (Cá thể hay Nhóm)
          };
        });
        
        // Kiểm tra dữ liệu đã ánh xạ
        // console.log('Mapped DTO:', result);
        return result;
      } else {
        // Nếu dữ liệu không phải mảng, throw lỗi
        throw new InternalServerErrorException({
          message: 'Expected rows to be an array.',
          details: 'Query result is not in expected format.',
        });
      }
    } catch (error) {
      // Xử lý lỗi và throw exception
      throw new InternalServerErrorException({
        message: 'Error retrieving all export records',
        details: error.message,
      });
    } finally {
      // Giải phóng kết nối sau khi sử dụng
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

    //   console.log('Query Result:', rows);  // In ra kết quả trả về

      if (!rows[0] || rows[0].length === 0) {
        throw new Error('Phiếu xuất động vật không tồn tại');
      }

      const row = rows[0];
    //   console.log('Processed Row:', row);  // In ra dòng dữ liệu sau khi xử lý
      
      // Lấy dữ liệu từ rows[0] (cấu trúc khi dùng CALL trong MySQL)
      const rowsData = rows[0];
      
     // Kiểm tra nếu dữ liệu có dạng mảng
     if (Array.isArray(rowsData)) {
        // Ánh xạ dữ liệu vào DTO
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
        
        // console.log('Final Result:', result);  // In ra kết quả sau ánh xạ
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
}