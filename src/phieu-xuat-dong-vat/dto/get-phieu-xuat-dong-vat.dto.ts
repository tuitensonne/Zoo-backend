export enum LoaiPhieuXuatEnum {
    ca_the = 0,  // Phiếu xuất cá thể
    nhom = 1,    // Phiếu xuất nhóm
  }

// import { IsString, IsNotEmpty, IsInt, IsEnum, IsDateString } from 'class-validator';


// export class GetPhieuXuatDongVatDto {
// //   @IsInt()
// //   @IsNotEmpty()
//   idPx: number;  // Thêm idPx để lưu trữ ID phiếu xuất

// //   @IsString()
// //   @IsNotEmpty()
//   tenKhoaHoc: string;  // Tên khoa học loài động vật (trường khoá ngoại)

// //   @IsDateString()
// //   @IsNotEmpty()
//   ngayXuat: string;  // Ngày xuất động vật

// //   @IsInt()
// //   @IsNotEmpty()
//   soLuong: number;  // Số lượng động vật xuất

// //   @IsString()
// //   @IsNotEmpty()
//   lyDoXuat: string;  // Lý do xuất động vật

// //   @IsInt()
// //   @IsNotEmpty()
//   idDt: number;  // ID đối tác (trường khoá ngoại)


// //   @IsString()
// //   @IsNotEmpty()
//   cccd: string;  // CCCD của nhân viên (trường khoá ngoại)

// //   @IsEnum(LoaiPhieuXuatEnum)
// //   @IsNotEmpty()
//   loai: string;  // Loại phiếu xuất (Cá thể hay Nhóm)
// }

export class GetPhieuXuatDongVatDto {
    id_px: number;
    ten_khoa_hoc: string;
    ngay_xuat: string;
    so_luong: number;
    ly_do_xuat: string;
    id_dt: number;
    cccd: string;
    loai: LoaiPhieuXuatEnum;
  }
  
