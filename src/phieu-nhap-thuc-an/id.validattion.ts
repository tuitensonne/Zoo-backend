import { Request, Response, NextFunction } from 'express';
import { BadRequestException } from '@nestjs/common';

export function ValidateIDRequest(req: Request, res: Response, next: NextFunction) {
  if (typeof req.body['id'] !== 'number' || isNaN(req.body['id'])) {
    throw new BadRequestException(
      `${'id'} phải là số hợp lệ!`
    );
  }
  next();
}
