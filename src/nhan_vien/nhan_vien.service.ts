import { Pool } from 'mysql2/promise';
import { Injectable, Inject, InternalServerErrorException } from '@nestjs/common';
import { ExceptionsHandler } from '@nestjs/core/exceptions/exceptions-handler';

@Injectable()
export class NhanVienService {
  constructor(
    @Inject('DATABASE_POOL') private readonly pool: Pool,
  ) {}

  async findAllNhanVienVanPhong() {
      const connection = await this.pool.getConnection();
   
      try {
        const [rows] = await connection.query(
  
          'CALL get_all_nv_van_phong()'
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
    
  async getProfileByEmail(email: string){
    const connection = await this.pool.getConnection()
    
    try {
      const [user] = await connection.query(
        'CALL get_nhan_vien_by_email(?)',
        [email]
      )
      const {hash_pass , ...result} = user[0][0] 
      return result
    } catch (error) {
      console.log(error)
      throw new ExceptionsHandler(error)
    } finally {
      connection.release();
    }
  }

  async updateProfile(email: string, body: any){
    const connection = await this.pool.getConnection()

    try {
      const [user] = await connection.query(
        'CALL update_nhan_vien_by_email(?, ?, ?, ?)',
        [email, body.ho_ten, body.sdt, body.dia_chi]
      )
      const {hash_pass , ...result} = user[0][0] 
      return result
    } catch (error) {
      console.log(error)
      throw new ExceptionsHandler(error)
    } finally {
      connection.release();
    }
  }
}
