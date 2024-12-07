import { PartialType } from '@nestjs/mapped-types';
import { CreatePhieuNhapThucAnDto } from './create-phieu-nhap-thuc-an.dto';

export class UpdatePhieuNhapThucAnDto extends PartialType(CreatePhieuNhapThucAnDto) {
    tenThucAn?: string
    so_luong?: number
    ngay_nhap?: Date
}
