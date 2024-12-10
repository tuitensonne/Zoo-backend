import { Request, Response, NextFunction } from 'express';
import { BadRequestException } from '@nestjs/common';

export function validateCreateTreatment(
  req: Request,
  res: Response,
  next: NextFunction,
) {
  const requiredFields = [
    { field: 'ID_ho_so_suc_khoe', type: 'number' },
    { field: 'trieu_chung', type: 'string' },
    { field: 'chan_doan', type: 'string' },
    { field: 'ket_qua', type: 'string' },
    { field: 'loai_thuoc', type: 'string' },
  ];

  // Kiểm tra các trường bắt buộc
  for (const { field, type } of requiredFields) {
    if (req.body[field] === undefined || req.body[field] === null) {
      throw new BadRequestException(`${field} không được phép null!`);
    }

    if (typeof req.body[field] !== type) {
      throw new BadRequestException(`${field} phải là kiểu ${type}!`);
    }
  }

  // Kiểm tra trường ghi_chu (được phép null)
  if (
    req.body['ghi_chu'] !== undefined &&
    typeof req.body['ghi_chu'] !== 'string'
  ) {
    throw new BadRequestException('ghi_chu phải là kiểu string hoặc null!');
  }

  next();
}
