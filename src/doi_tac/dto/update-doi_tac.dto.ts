import { PartialType } from '@nestjs/mapped-types';
import { CreateDoiTacDto } from './create-doi_tac.dto';

export class UpdateDoiTacDto extends PartialType(CreateDoiTacDto) {}
