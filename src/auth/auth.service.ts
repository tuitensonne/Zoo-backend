import { ForbiddenException, Inject, Injectable, InternalServerErrorException, NotFoundException, UnauthorizedException } from '@nestjs/common';
import * as argon from 'argon2'
import { AuthSignInDto } from './dto/auth.dto';
import { JwtService, TokenExpiredError } from '@nestjs/jwt';
import { Pool } from 'mysql2/promise';


@Injectable()
export class AuthService {
    constructor(
        @Inject('DATABASE_POOL') private readonly pool: Pool,
        private readonly jwtService: JwtService
    ) { }

    async signin(authDto: AuthSignInDto): Promise<{ access_token: string, refresh_token: string, role: string }> {
        const connection = await this.pool.getConnection();
        try {
            const [user] = await connection.query(
                'CALL get_nhan_vien_by_email(?)',
                [authDto.email]
            );
            
            if (!user[0][0]) {
                throw new NotFoundException("User not found");
            }
    
            if (user[0][0].loai_cong_viec !== authDto.jobType) {
                throw new ForbiddenException("Wrong job type");
            }
    
            const passMatch = await argon.verify(
                user[0][0].hash_pass,
                authDto.password
            );
    
            if (!passMatch) {
                throw new ForbiddenException("Credentials incorrect");
            }
            
            const payload = { email: user[0][0].email, jobType: user[0][0].loai_cong_viec };
            const access_token = await this.jwtService.signAsync(
                payload,
                { expiresIn: '15m' }
            );
            const refresh_token = await this.jwtService.signAsync(
                payload, 
                { expiresIn: '1h' }
            );
            const role = user[0][0].loai_cong_viec;
            return {
                access_token,
                refresh_token,
                role
            };
        } catch (error) {
            if (error instanceof ForbiddenException || error instanceof NotFoundException) {
                throw error; 
            } else {
                throw new InternalServerErrorException("An unexpected error occurred during sign-in");
            }
        } finally {
            connection.release();
        }
    }

    async refreshToken(refreshToken: string) {
        const connection = await this.pool.getConnection();
        try {
            const oldPayload = await this.jwtService.verifyAsync(refreshToken, {
                secret: process.env.JWT_SECRET_KEY,
            })
            
            const {iat, exp, ...payload} = oldPayload
            if (!payload) {
                throw new UnauthorizedException("Invalid refresh token");
            }

            const [user] = await connection.query(
                'CALL get_nhan_vien_by_email(?)',
                [payload.email]
            );

            const access_token = await this.jwtService.signAsync(
                payload,
                { expiresIn: '15m' }
            );
            const newRefreshToken = await this.jwtService.signAsync(
                payload, 
                { expiresIn: '1h' }
            );
            
            return {
                access_token,
                refresh_token: newRefreshToken,
                role: user[0][0].loai_cong_viec
            };
        } catch (error) {
            if (error instanceof TokenExpiredError) {
                throw new UnauthorizedException({statusCode: 1001, message: 'Refresh token expired', error: error}); 
            } else {
                throw new InternalServerErrorException("An unexpected error occurred during refresh token");
            }
        } finally {
            connection.release();
        }
    }
} 
    