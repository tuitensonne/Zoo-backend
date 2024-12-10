export enum LoaiEnum {
  ca_the = 0,
  nhom = 1,
}

export class GetHoSoSucKhoeDto {
  id_ho_so_suc_khoe: number;
  loai: LoaiEnum;
  ten_khoa_hoc: string;
  tuoi_or_soluong: number;
  tinh_trang_suc_khoe: string;
  chieu_cao: number;
  can_nang: number;
}
