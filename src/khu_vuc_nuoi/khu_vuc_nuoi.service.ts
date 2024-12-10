import { Injectable, Inject, InternalServerErrorException } from '@nestjs/common';
import { Pool } from 'mysql2/promise';
import { CreateKhuVucNuoiDto } from './dto/create-khu_vuc_nuoi.dto';
import { UpdateKhuVucNuoiDto } from './dto/update-khu_vuc_nuoi.dto';

@Injectable()
export class KhuVucNuoiService {
  constructor(
    @Inject('DATABASE_POOL') private readonly pool: Pool,
  ) {}
  
  async create(createKhuVucNuoiDto: CreateKhuVucNuoiDto) {
    const connection = await this.pool.getConnection();
    console.log(createKhuVucNuoiDto)
    try {
      const {
          vi_tri,
          suc_chua_toi_da,
          trang_thai_hoat_dong,
          dien_tich,
          chieu_cao,
          loai_moi_truong
      } = createKhuVucNuoiDto;

      const [rows] = await connection.query(
        'CALL add_khu_vuc_nuoi(?, ?, ?, ?, ?, ?)',
        [
          vi_tri,
          suc_chua_toi_da,
          trang_thai_hoat_dong,
          dien_tich,
          chieu_cao,
          loai_moi_truong
        ],
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

  async findAllKhuVucNuoi(page: number, limit: number) {
    const connection = await this.pool.getConnection();
    const offset = (page - 1) * limit;
    try {
      // Gọi procedure get_cac_phieu_nhap_thuc_an
      const [rows] = await connection.query(
        'CALL get_all_khu_vuc_nuoi(?, ?)',
        [offset, limit],
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

  async findOne(id: number) {
    const connection = await this.pool.getConnection();
    try {
      // Gọi procedure get_cac_phieu_nhap_thuc_an
      const [rows] = await connection.query(
        'CALL get_khu_vuc_nuoi_by_id(?)',
        [id],
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

  async findNumberOfPageKVN(limit: number){
    const connection = await this.pool.getConnection();
    
    try {
      const [rows] = await connection.query('SELECT get_number_of_khu_vuc_nuoi() AS recordCount');
      
      const totalRecords = rows[0].recordCount;
      const totalPages = Math.ceil(totalRecords / limit);
      
      return { message: 'Request Successfully!', data: totalPages};
    } catch (error) {
      throw new InternalServerErrorException({
        message: 'ERROR!!!!',
        details: error.message,
      });
    } finally {
      connection.release();
    }
  }

  update(id: number, updateKhuVucNuoiDto: UpdateKhuVucNuoiDto) {
    return `This action updates a #${id} khuVucNuoi`;
  }

  remove(id: number) {
    return `This action removes a #${id} khuVucNuoi`;
  }
}
