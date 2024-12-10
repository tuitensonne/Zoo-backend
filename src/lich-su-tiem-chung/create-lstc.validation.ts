import { Request, Response, NextFunction } from 'express';
import { BadRequestException } from '@nestjs/common';

export function validateCreateVaccination(
  req: Request,
  res: Response,
  next: NextFunction,
) {
  const requiredFields = [
    { name: 'ID_ho_so_suc_khoe', type: 'number' },
    { name: 'ngay_tiem', type: 'date' },
    { name: 'phuong_phap_tiem', type: 'string' },
    { name: 'loai_vaccine', type: 'string' },
    { name: 'lieu_luong', type: 'number' },
    { name: 'phan_ung_sau_tiem', type: 'string' },
  ];

  const dateRegex = /^\d{4}-\d{2}-\d{2}$/;

  for (const field of requiredFields) {
    const value = req.body[field.name];

    // Kiểm tra not null
    if (value === null || value === undefined) {
      throw new BadRequestException(`${field.name} không được phép null!`);
    }

    // Kiểm tra kiểu dữ liệu
    switch (field.type) {
      case 'number':
        if (typeof value !== 'number' || isNaN(value) || value <= 0) {
          throw new BadRequestException(
            `${field.name} phải là số hợp lệ và lớn hơn 0!`,
          );
        }
        break;

      case 'string':
        if (typeof value !== 'string' || value.trim() === '') {
          throw new BadRequestException(
            `${field.name} phải là chuỗi không rỗng!`,
          );
        }
        break;

      case 'date':
        if (typeof value !== 'string' || !dateRegex.test(value)) {
          throw new BadRequestException(
            `${field.name} phải có định dạng YYYY-MM-DD!`,
          );
        }
        const parsedDate = new Date(value);
        if (isNaN(parsedDate.getTime())) {
          throw new BadRequestException(
            `${field.name} không phải là ngày hợp lệ!`,
          );
        }
        break;

      default:
        throw new BadRequestException(
          `Kiểu dữ liệu của ${field.name} không được hỗ trợ!`,
        );
    }
  }

  next();
}
