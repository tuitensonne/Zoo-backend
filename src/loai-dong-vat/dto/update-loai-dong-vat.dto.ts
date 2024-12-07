import { PartialType } from '@nestjs/mapped-types';
import { CreateLoaiDongVatDto } from './create-loai-dong-vat.dto';

export class UpdateLoaiDongVatDto extends PartialType(CreateLoaiDongVatDto) {}
