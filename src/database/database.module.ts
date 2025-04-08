import { Module, Global } from '@nestjs/common';
import * as mysql from 'mysql2/promise';

@Global()
@Module({
  providers: [
    { 
      provide: 'DATABASE_POOL',
      useFactory: async () => {
        try {
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

          const connection = await pool.getConnection();
          console.log('Database connected successfully!');
          connection.release();

          return pool; 
        } catch (err) {
          console.error('Database connection failed:', err.message);
          throw err; 
        }
      },
    },
  ],
  exports: ['DATABASE_POOL'],
})
export class DatabaseModule {}
