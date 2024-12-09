import { PartialType } from '@nestjs/mapped-types';
import { CreateNhanVienDTO } from './create-nhanvien.dto';

export class UpdateNhanvienDto extends PartialType(CreateNhanVienDTO) {
    ho?: string;
    ten?: string;
    dia_chi?: string;
    loai_cong_viec?: string;
}