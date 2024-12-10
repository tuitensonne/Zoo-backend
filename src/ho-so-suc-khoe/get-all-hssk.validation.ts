import { Request, Response, NextFunction } from 'express';
import { BadRequestException } from '@nestjs/common';

export function validateGetHealthRecords(
  req: Request,
  res: Response,
  next: NextFunction,
) {
  // Các trường cần kiểm tra
  const stringFields = ['searchId', 'searchName'];
  const numberFields = ['page', 'pageSize'];

  // Kiểm tra chuỗi
  for (const field of stringFields) {
    if (req.query[field] !== undefined && req.query[field] !== null) {
      if (typeof req.query[field] !== 'string') {
        throw new BadRequestException(`${field} phải là kiểu chuỗi!`);
      }
    }
  }

  // Kiểm tra số
  for (const field of numberFields) {
    if (req.query[field] !== undefined) {
      const value = Number(req.query[field]);

      if (!Number.isInteger(value) || value <= 0) {
        throw new BadRequestException(`${field} phải là số nguyên dương!`);
      }
    }
  }

  next();
}

export function validateGetHealthRecordsDetails(
  req: Request,
  res: Response,
  next: NextFunction,
) {
  const id = Number(req.params.id); // Chuyển đổi từ chuỗi sang số

  if (isNaN(id) || id <= 0) {
    throw new BadRequestException('ID phải là số hợp lệ và lớn hơn 0!');
  }

  next();
}
