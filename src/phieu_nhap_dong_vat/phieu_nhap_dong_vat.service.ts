import { Injectable, Inject, InternalServerErrorException } from '@nestjs/common';
import { Pool } from 'mysql2/promise';
import { CreatePhieuNhapDongVatCTDto } from './dto/create-phieu_nhap_dong_vat.dto';
import { CreatePhieuNhapDongVatNhomDto

 } from './dto/create-phieu_nhap_dong_vat.dto';
@Injectable()
export class PhieuNhapDongVatService {
  constructor(
    @Inject('DATABASE_POOL') private readonly pool: Pool,
  ) {}

  async createCT(createPhieuNhapDongVatCTDto: CreatePhieuNhapDongVatCTDto) {
    const connection = await this.pool.getConnection();
    try {
      const {
        cccd,
        ID_so_thu,
        ten_khoa_hoc,
        so_luong,
        ngay_nhap,
        ly_do_nhap,
        id_kv,             
        can_nang,
        chieu_cao,     
        id_ct_cha,
        ten_khoa_hoc_cha,
        id_ct_me, 
        ten_khoa_hoc_me,
        tuoi,    
        adn,       
        gioi_tinh,
        trang_thai,
      } = createPhieuNhapDongVatCTDto;
      // Gọi procedure add_phieu_nhap_dong_vat
      const result =  connection.query(
        'CALL add_phieu_nhap_dong_vat_ct(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [ 
          cccd,     
          ID_so_thu,     
          ten_khoa_hoc,      
          ngay_nhap,     
          so_luong,     
          ly_do_nhap,
          id_kv,                  
          can_nang,
          chieu_cao,           
          id_ct_cha,  
          ten_khoa_hoc_cha,
          id_ct_me,      
          ten_khoa_hoc_me, 
          tuoi, 
          adn,         
          gioi_tinh,   
          trang_thai   
        ],
      );
      await result;
      return { message: 'Request Successfully!'};
    } catch (error) {
      console.log(error)
      throw new InternalServerErrorException({
        message: 'ERROR!!!!',
        details: error.message,
      });
    } finally {
      connection.release();
    }
  }
 
  async createNhom(createPhieuNhapDongVatNhomDto: CreatePhieuNhapDongVatNhomDto) {
    const connection = await this.pool.getConnection();
    try {
      const {
        cccd,
        ID_so_thu,

        ten_khoa_hoc,

        so_luong,
        ngay_nhap,

        ly_do_nhap,
        id_kv,
        id_hssk
      } = createPhieuNhapDongVatNhomDto;
      // Gọi procedure add_phieu_nhap_dong_vat
      const result =  connection.query(
        'CALL add_phieu_nhap_dong_vat_nhom(?, ?, ?, ?, ?, ?, ?)',
        [ 
          cccd,
          ID_so_thu,
  
          ten_khoa_hoc,
  
          ngay_nhap,
          so_luong,
  
          ly_do_nhap,
          id_kv,
          id_hssk
        ],
      );
      await result;
      return { message: 'Request Successfully!'};
    } catch (error) {
      
      console.log(error)
      throw new InternalServerErrorException({
        message: 'ERROR!!!!',
        details: error.message,
      });
    } finally {
      connection.release();
    }
  }

  async findPNByPage(page: number, limit: number) {
    const connection = await this.pool.getConnection();
    const offset = (page - 1) * limit;
 
    try {
      const [rows] = await connection.query(
        'CALL get_all_phieu_nhap_dong_vat(?, ?)',
        [offset, limit],
      );

      return { message: 'Request Successfully!', data: rows[0] };
    } catch (error) {
      console.log(error)
      throw new InternalServerErrorException({
        message: 'ERROR!!!!',
        details: error.message,
      });
    } finally {
      connection.release();
    }
  }

  async findOnePN(id: number) {
    const connection = await this.pool.getConnection();

    try {
      // Gọi procedure get_phieu_nhap_dong_vat_theo_id
      const [rows] = await connection.query(
        'CALL get_phieu_nhap_dong_vat_theo_id(?)',
        [id],
      );
      return { message: 'Request Successfully!', data: rows[0] };
    } catch (error) {
      console.log(error)
      throw new InternalServerErrorException({
        message: 'ERROR!!!!',
        details: error.message,
      });
    } finally {
      connection.release();
    }
  }

  async findNumberOfPagePN(limit: number){
    const connection = await this.pool.getConnection();
    
    try {
      const [rows] = await connection.query('SELECT get_number_of_phieu_nhap_dong_vat() AS recordCount');
      
      const totalRecords = rows[0].recordCount;
      const totalPages = Math.ceil(totalRecords / limit);
      return { message: 'Request Successfully!', data: totalPages};
    } catch (error) {
      console.log(error)
      throw new InternalServerErrorException({
        message: 'ERROR!!!!',
        details: error.message,
      });
    } finally {
      connection.release();
    }
  }

  async findOneTA(id: number) {
    const connection = await this.pool.getConnection();

    try {
      const [rows] = await connection.query(
        'CALL get_dong_vat_theo_id(?)',
        [id],
      );

      return { message: 'Request Successfully!', data: rows[0] };
    } catch (error) {
      console.log(error)
      throw new InternalServerErrorException({
        message: 'ERROR!!!!',
        details: error.message,
      });
    } finally {
      connection.release();
    }
  }

  async remove(id: number) {
    const connection = await this.pool.getConnection();

    try {
      // Gọi procedure delete_phieu_nhap_dong_vat_theo_id
      await connection.query('CALL delete_phieu_nhap_dong_vat_theo_id(?)', [id]);

      return { message: 'Request Successfully!' };
    } catch (error) {
      console.log(error)
      throw new InternalServerErrorException({
        message: 'ERROR!!!!',
        details: error.message,
      });
    } finally {
      connection.release();
    }
  }
}
