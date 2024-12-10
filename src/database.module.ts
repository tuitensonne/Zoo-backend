import { Module, Global } from '@nestjs/common';
import * as mysql from 'mysql2/promise';
import * as dotenv from 'dotenv';

// Nạp file môi trường
dotenv.config({ path: 'sensitive.env' });

@Global()
@Module({
  providers: [
    {
      provide: 'DATABASE_POOL',
      useFactory: async () => {
        try {
          // Tạo Pool kết nối MySQL
          const pool = mysql.createPool({
            host: process.env.DB_HOST,
            port: parseInt(process.env.DB_PORT, 10),
            user: process.env.DB_USER,
            password: process.env.DB_PASSWORD,
            database: process.env.DB_NAME,
            waitForConnections: true,
            connectionLimit: 10,
            queueLimit: 0,
          });

          // Kiểm tra kết nối
          const connection = await pool.getConnection();
          console.log('✅ Database connected successfully!');
          connection.release();

          return pool; // Trả về Pool
        } catch (err) {
          console.error('❌ Database connection failed:', err.message);
          throw err; // Ném lỗi nếu không kết nối được
        }
      },
    },
  ],
  exports: ['DATABASE_POOL'],
})
export class DatabaseModule {}
