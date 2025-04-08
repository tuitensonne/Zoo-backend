import { IsIn, IsString } from "class-validator"

export class AuthSignInDto {
    @IsString()
    email: string

    @IsString()
    password: string

    @IsString()
    @IsIn(['van phong', 'thu y', 'cham soc'], { message: 'Job type must be one of the following: van phong, thy y, cham soc' })
    jobType: string
}

