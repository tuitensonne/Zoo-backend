import { Pool, ResultSetHeader } from 'mysql2/promise';
import {
  Injectable,
  Inject,
  InternalServerErrorException,
} from '@nestjs/common';
import { TaoPhieuXuatDongVatNhomDto } from './dto/tao-phieu-xuat-dong-vat-nhom.dto';
import { TaoPhieuXuatDongVatctDto } from './dto/tao-phieu-xuat-dong-vat-ct.dto';
@Injectable()
export class TaoPhieuXuatDongVatService {
  constructor(@Inject('DATABASE_POOL') private readonly pool: Pool) {}

  async createGroup(TaoPhieuXuatDongVatNhomDto: TaoPhieuXuatDongVatNhomDto) {
    const connection = await this.pool.getConnection();

    try {
      const {
        ldv,
        id_nhom,
        so_luong_xuat,
        ngay_xuat,
        ly_do_xuat,
        doi_tac,
        cccd,
      } = TaoPhieuXuatDongVatNhomDto;
      // Kiểm tra xem CCCD có tồn tại trong bảng nhanvien_vanphong không
      const cccdExists = await this.checkCccdExists(cccd);
      if (!cccdExists) {
        throw new InternalServerErrorException({
          message: 'Mã CCCD không tồn tại trong hệ thống.',
          details: `Không tìm thấy CCCD: ${cccd}`,
        });
      }
      // Kiểm tra sự tồn tại của id_nhom và ten_khoa_hoc
      const idNhomValid = await this.checkIdNhomExist(id_nhom, ldv);
      if (!idNhomValid) {
        throw new InternalServerErrorException({
          message: 'Id Nhóm không tồn tại.',
          details: `Không tìm thấy nhóm với id_nhom: ${id_nhom} và tên khoa học: ${ldv}`,
        });
      }


      // Kiểm tra số lượng xuất
    const exportQuantityValid = await this.checkSoluongExport(id_nhom, so_luong_xuat);
    if (!exportQuantityValid) {
      throw new InternalServerErrorException({
        message: 'Số lượng xuất không hợp lệ.',
        details: `Không thể xuất số lượng: ${so_luong_xuat} cho nhóm ${so_luong_xuat}`,
      });
    }

      // Gọi stored procedure để tạo lịch sử điều trị
      const [result] = await connection.query<ResultSetHeader>(
        'CALL tao_phieu_xuat_dong_vat(?, ?, ?, ?, ?, ?)',
        [
            ldv,
            so_luong_xuat,
            ngay_xuat,
            ly_do_xuat,
            doi_tac,
            cccd,
        ],
      );

      //console.log('Rows from database:', result);

      // Kiểm tra affectedRows (nếu không tồn tại, throw error)
      if (!result || result.affectedRows === 0) {
        throw new InternalServerErrorException({
          message: 'Error creating export card',
          details: 'Stored procedure did not affect any rows.',
        });
      }

      // Trả về thông tin hoặc một thông báo thành công
      return { message: 'Phiếu xuất động vật đã được tạo thành công!' };
    } catch (error) {
      throw new InternalServerErrorException({
        message: 'Error creating export card',
        details: error.message,
      });
    } finally {
      connection.release();
    }
  }



  // tạo cá thể
  async createct(TaoPhieuXuatDongVatctDto: TaoPhieuXuatDongVatctDto) {
    const connection = await this.pool.getConnection();
  
    try {
      const {
        ldv,
        id_ct,  // id_ct là mảng các ID
        so_luong_xuat,
        ngay_xuat,
        ly_do_xuat,
        doi_tac,
        cccd,
      } = TaoPhieuXuatDongVatctDto;
  
      // Log giá trị của id_ct để kiểm tra
      // console.log('Received id_ct:', id_ct); 
      // Kiểm tra xem CCCD có tồn tại trong bảng nhanvien_vanphong không
      const cccdExists = await this.checkCccdExists(cccd);
      if (!cccdExists) {
        throw new InternalServerErrorException({
          message: 'Mã CCCD không tồn tại trong hệ thống.',
          details: `Không tìm thấy CCCD: ${cccd}`,
        });
      }
      
      // Kiểm tra id_ct có phải là mảng không
      if (!Array.isArray(id_ct)) {
        throw new InternalServerErrorException({
          message: 'Invalid input for id_ct',
          details: `id_ct phải là một mảng các ID. Giá trị nhận được: ${id_ct}`,
        });
      }
  
      // Kiểm tra từng ID trong mảng id_ct
      let idctValid = true;  // Biến kiểm tra tính hợp lệ của tất cả các ID
  
      for (const id of id_ct) {
        const idCheck = await this.checkIdCtExist(id.toString(), ldv);  // Kiểm tra từng ID với tên loài động vật
  
        if (!idCheck.includes('Tồn tại')) {  // Kiểm tra nếu ID không tồn tại
          idctValid = false;
          break;  // Dừng lại ngay khi tìm thấy ID không hợp lệ
        }
      }
  
      // Nếu một trong các ID không hợp lệ, ném lỗi
      if (!idctValid) {
        throw new InternalServerErrorException({
          message: 'Id ct không tồn tại.',
          details: `Không tìm thấy nhóm với id_nhom: ${id_ct} và tên khoa học: ${ldv}`,
        });
      }
  
      // Gọi stored procedure để tạo phiếu xuất động vật
      const [result] = await connection.query<ResultSetHeader>(
        'CALL tao_phieu_xuat_dong_vat(?, ?, ?, ?, ?, ?)',
        [
          ldv,
          so_luong_xuat,
          ngay_xuat,
          ly_do_xuat,
          doi_tac,
          cccd,
        ],
      );
  
      // Kiểm tra affectedRows (nếu không tồn tại, throw error)
      if (!result || result.affectedRows === 0) {
        throw new InternalServerErrorException({
          message: 'Error creating export card',
          details: 'Stored procedure did not affect any rows.',
        });
      }
  
      // Trả về thông tin hoặc một thông báo thành công
      return { message: 'Phiếu xuất động vật đã được tạo thành công!' };
    } catch (error) {
      throw new InternalServerErrorException({
        message: 'Error creating export card',
        details: error.message,
      });
    } finally {
      connection.release();
    }
  }
  
  
  


   // Phương thức lấy thông tin về cá thể (ct)
   async getCtInfo() {
    const connection = await this.pool.getConnection();
    
    try {
      const [rows] = await connection.query('CALL get_ct_info()');
      return rows; // Trả về danh sách tên khoa học từ bảng cá thể
    } catch (error) {
      throw new InternalServerErrorException({
        message: 'Error fetching ct information',
        details: error.message,
      });
    } finally {
      connection.release();
    }
  }

  // Phương thức lấy thông tin về nhóm (nhom)
  async getNhomInfo() {
    const connection = await this.pool.getConnection();

    try {
      const [rows] = await connection.query('CALL get_nhom_info()');
      return rows; // Trả về danh sách tên khoa học từ bảng nhóm
    } catch (error) {
      throw new InternalServerErrorException({
        message: 'Error fetching nhom information',
        details: error.message,
      });
    } finally {
      connection.release();
    }
  }


   // Phương thức lấy thông tin ten doi tac (doi tac)
// Phương thức lấy thông tin đối tác (id_dt và ten_doi_tac)
async getdoitacInfo() {
  const connection = await this.pool.getConnection();

  try {
    // Thực hiện truy vấn gọi thủ tục lấy thông tin đối tác
    const [rows] = await connection.query('CALL get_ten_doi_tac_info()');

    // Kiểm tra và trả về đúng kiểu dữ liệu (rows là mảng đối tượng)
    if (Array.isArray(rows) && Array.isArray(rows[0])) {
      return rows[0].map(row => ({
        id_dt: row.id_dt, // Lấy id_dt
        ten_doi_tac: row.ten_doi_tac, // Lấy ten_doi_tac
      }));
    } else {
      throw new Error("Dữ liệu trả về không phải là mảng hoặc không có dữ liệu");
    }
  } catch (error) {
    throw new InternalServerErrorException({
      message: 'Error fetching partner information',
      details: error.message,
    });
  } finally {
    connection.release();
  }
}



// Phương thức kiểm tra CCCD tồn tại trong bảng nhanvien_vanphong thông qua thủ tục
async checkCccdExists(cccd: string): Promise<boolean> {
  const connection = await this.pool.getConnection();

  try {
    // Gọi thủ tục lấy CCCD từ bảng nhanvien_vanphong
    const [rows] = await connection.query('CALL get_cccd_by_vanphong(?)', [cccd]);

    // Kiểm tra xem rows có dữ liệu không
    return Array.isArray(rows) && rows.length > 0;
  } catch (error) {
    // Kiểm tra lỗi MySQL cụ thể
    if (error.code === 'ER_SIGNAL_EXCEPTION' && error.sqlState === '45000') {
      throw new InternalServerErrorException({
        message: 'Mã CCCD không tồn tại trong hệ thống.',
        details: error.sqlMessage, // "CCCD không tồn tại trong hệ thống"
      });
    } else {
      throw new InternalServerErrorException({
        message: 'Error checking CCCD existence from stored procedure',
        details: error.message,
      });
    }
  } finally {
    connection.release();
  }
}


// Phương thức kiểm tra số lượng xuất
async checkSoluongExport(groupId: number, quantity: number): Promise<boolean> {
  const connection = await this.pool.getConnection();

  try {
    // Gọi thủ tục để kiểm tra số lượng
    const [rows] = await connection.query('SELECT CheckSoluongnhomExportFunc(?, ?)', [groupId, quantity]);

    // Nếu thủ tục chạy thành công mà không có lỗi, trả về true
    return true;
  } catch (error) {
     // In thông tin lỗi chi tiết ra console để debug
     console.error('Error details:', error);
    // Kiểm tra lỗi MySQL nếu có lỗi xảy ra trong thủ tục
    if (error.code === 'ER_SIGNAL_EXCEPTION' && error.sqlState === '45000') {
      throw new InternalServerErrorException({
        message: 'Lỗi khi kiểm tra số lượng xuất.',
        details: error.sqlMessage, // Lấy thông báo lỗi từ MySQL (ví dụ: 'Số lượng xuất vượt quá số lượng hiện có!')
      });
    } else {
      throw new InternalServerErrorException({
        message: 'Error checking export quantity from stored procedure',
        details: error.message,
      });
    }
  } finally {
    connection.release();
  }
}

// Phương thức kiểm tra sự tồn tại của id_nhom và ten_khoa_hoc
async checkIdNhomExist(idNhom: number, tenKhoaHoc: string): Promise<boolean> {
  const connection = await this.pool.getConnection();

  try {
    // Gọi hàm để kiểm tra sự tồn tại của id_nhom và ten_khoa_hoc
    const [rows] = await connection.query('SELECT CheckIdNhomExist(?, ?)', [idNhom, tenKhoaHoc]);

     // Kiểm tra kết quả trả về từ hàm, xác định tên trường chính xác
     const result = rows[0] && rows[0][`CheckIdNhomExist('${idNhom}', '${tenKhoaHoc}')`];

     if (result === 'Tồn tại') {
       return true;
     }
     return false;
  } catch (error) {
    // In thông tin lỗi chi tiết ra console để debug
    console.error('Error details:', error);

    // Kiểm tra lỗi MySQL nếu có lỗi xảy ra trong thủ tục
    if (error.code === 'ER_SIGNAL_EXCEPTION' && error.sqlState === '45000') {
      throw new InternalServerErrorException({
        message: 'Không tồn tại id nhóm này!',
        details: error.sqlMessage, // Lấy thông báo lỗi từ MySQL (ví dụ: 'Không tồn tại nhóm này!')
      });
    } else {
      throw new InternalServerErrorException({
        message: 'Error checking nhom existence from stored procedure',
        details: error.message,
      });
    }
  } finally {
    connection.release();
  }
}

// Phương thức kiểm tra sự tồn tại của danh sách id_ct và ten_khoa_hoc
// async checkIdCtExist(idCtList: string, tenKhoaHoc: string): Promise<string[]> {
//   const connection = await this.pool.getConnection();

//   try {
//     // Gọi thủ tục CheckIdCtList và truyền tham số idCtList và tenKhoaHoc
//     await connection.query(
//       'CALL CheckIdCtList(?, ?, @result)', 
//       [idCtList, tenKhoaHoc]
//     );

//     // Lấy kết quả trả về từ biến OUT @result
//     const [resultRow] = await connection.query('SELECT @result AS result');
//     const result = resultRow[0]?.result;

//     // Kiểm tra và trả về kết quả dưới dạng mảng các dòng kiểm tra
//     return result ? result.split('\n').filter(line => line) : [];  // Tách chuỗi và lọc các dòng trống
//   } catch (error) {
//     // Ghi lỗi chi tiết vào console
//     console.error('Error during checkIdCtExist:', error);

//     // Xử lý lỗi SQL hoặc lỗi khác
//     throw new InternalServerErrorException({
//       message: 'Error checking id_ct existence from stored procedure',
//       details: error.message,
//     });
//   } finally {
//     // Đảm bảo kết nối được giải phóng
//     connection.release();
//   }
// }

// Phương thức kiểm tra sự tồn tại của từng id_ct và ten_khoa_hoc
async checkIdCtExist(idCt: string, tenKhoaHoc: string): Promise<string> {
  const connection = await this.pool.getConnection();

  try {
    // Gọi thủ tục CheckIdCtList và truyền tham số idCt và tenKhoaHoc
    await connection.query(
      'CALL CheckIdCtList(?, ?, @result)', 
      [idCt, tenKhoaHoc]
    );

    // Lấy kết quả trả về từ biến OUT @result
    const [resultRow] = await connection.query('SELECT @result AS result');
    const result = resultRow[0]?.result;

    // Kiểm tra và trả về kết quả
    return result ? result : 'Không có kết quả từ thủ tục';
  } catch (error) {
    console.error('Error during checkIdCtExist:', error);
    throw new InternalServerErrorException({
      message: 'Error checking id_ct existence from stored procedure',
      details: error.message,
    });
  } finally {
    connection.release();
  }
}




}
