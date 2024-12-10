import { PartialType } from '@nestjs/mapped-types';
import { CreateKhuVucNuoiDto } from './create-khu_vuc_nuoi.dto';

export class UpdateKhuVucNuoiDto extends PartialType(CreateKhuVucNuoiDto) {}
