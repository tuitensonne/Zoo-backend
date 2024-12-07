import { Pool } from 'mysql2/promise';
import { Injectable, Inject, InternalServerErrorException } from '@nestjs/common';
import { CreatePhieuNhapThucAnDto } from './dto/create-phieu-nhap-thuc-an.dto';

@Injectable()
export class PhieuNhapThucAnService {
  constructor(
    @Inject('DATABASE_POOL') private readonly pool: Pool,
  ) {}

  async create(createPhieuNhapThucAnDto: CreatePhieuNhapThucAnDto) {
    const connection = await this.pool.getConnection();

    try {
      const {
        cccd,
        ID_ben_cung_cap_thuc_an,
        ten_thuc_an,
        ham_luong_dinh_duong,
        ngay_het_han,
        ngay_nhap,
        so_luong,
        nguon_goc_xuat_xu,
      } = createPhieuNhapThucAnDto;

      // Gọi procedure add_phieu_nhap_thuc_an
      await connection.query(
        'CALL add_phieu_nhap_thuc_an(?, ?, ?, ?, ?, ?, ?, ?)',
        [
          cccd,
          ID_ben_cung_cap_thuc_an,
          ten_thuc_an,
          ham_luong_dinh_duong,
          ngay_het_han,
          ngay_nhap,
          so_luong,
          nguon_goc_xuat_xu,
        ],
      );

      return { message: 'Request Successfully!' };
    } catch (error) {
      throw new InternalServerErrorException({
        message: 'ERROR!!!!',
        details: error.message,
      });
    } finally {
      connection.release();
    }
  }

  async findPNByPage(offsetPage: number) {
    const connection = await this.pool.getConnection();

    try {
      // Gọi procedure get_cac_phieu_nhap_thuc_an
      const [rows] = await connection.query(
        'CALL get_cac_phieu_nhap_thuc_an(?)',
        [offsetPage],
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

  async findOnePN(id: number) {
    const connection = await this.pool.getConnection();

    try {
      // Gọi procedure get_phieu_nhap_thuc_an_theo_id
      const [rows] = await connection.query(
        'CALL get_phieu_nhap_thuc_an_theo_id(?)',
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

  async remove(id: number) {
    const connection = await this.pool.getConnection();

    try {
      // Gọi procedure delete_phieu_nhap_thuc_an_theo_id
      await connection.query('CALL delete_phieu_nhap_thuc_an_theo_id(?)', [id]);

      return { message: 'Request Successfully!' };
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
