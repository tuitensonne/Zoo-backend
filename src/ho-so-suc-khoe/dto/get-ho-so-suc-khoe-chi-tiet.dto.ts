export enum LoaiEnum {
  ca_the = 0,
  nhom = 1,
}
export enum GioiTinhEnum {
  duc = 0,
  cai = 1,
}

export class LichSuDieuTriDto {
  id_lsdt: number;
  trieu_chung: string;
  chan_doan: string;
  ket_qua: string;
  loai_thuoc: string;
  ghi_chu: string;
}

export class LichSuTiemChungDto {
  id_tc: number;
  ngay_tiem: string;
  phuong_phap_tiem: string;
  loai_vaccine: string;
  lieu_luong: string;
  phan_ung_sau_tiem: string;
}

export class GetHoSoSucKhoeChiTietDto {
  ten_thu_y: string;
  cccd_thu_y: string;
  ID_ho_so_suc_khoe: number;
  loai: LoaiEnum;
  gioi_tinh: GioiTinhEnum;
  tinh_trang: number;
  chieu_cao: number;
  can_nang: number;
  lich_su_dieu_tri: LichSuDieuTriDto[];
  lich_su_tiem_chung: LichSuTiemChungDto[];
}
