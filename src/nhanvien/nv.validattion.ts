import { Request, Response, NextFunction } from 'express';
import { BadRequestException } from '@nestjs/common';

export function ValidateRequest(req: Request, res: Response, next: NextFunction) {
  const stringFields = ['cccd', 'ten_thuc_an', 'nguon_goc_xuat_xu'];
  const numberFields = ['ID_ben_cung_cap_thuc_an', 'ham_luong_dinh_duong', 'so_luong', 'offsetPage', 'id']; 
  const dateFields = ['ngay_het_han', 'ngay_nhap']; 

  const dateRegex = /^\d{4}-\d{2}-\d{2}$/; 

  for (const field of stringFields) {
    if (req.body[field] && typeof req.body[field] !== 'string') {
      throw new BadRequestException(
        `${field} phải là kiểu chuỗi!`
      );
    }
  }

  for (const field of numberFields) {
    if (req.body[field] !== undefined) {
      if (typeof req.body[field] !== 'number' || isNaN(req.body[field])) {
        throw new BadRequestException(
          `${field} phải là số hợp lệ!`
        );
      }
    }
  }

  for (const field of dateFields) {
    if (req.body[field]) {
      const value = req.body[field];

      if (!dateRegex.test(value)) {
        throw new BadRequestException(
          `${field} phải theo định dạng YYYY-MM-DD!`
        );
      }

      const date = new Date(value);
      if (isNaN(date.getTime())) {
        throw new BadRequestException(
          `${field} không phải là ngày hợp lệ!`
        );
      }

      req.body[field] = date;
    }
  }

  next();
}
