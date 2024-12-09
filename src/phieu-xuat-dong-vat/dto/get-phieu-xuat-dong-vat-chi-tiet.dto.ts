export enum LoaiPhieuXuatEnum {
    ca_the = 0,  // Phiếu xuất cá thể
    nhom = 1,    // Phiếu xuất nhóm
  }
export class GetPhieuXuatDongVatChiTietDto{
    ten_nguoi_tao: string;
    address: string;
    cccd: string;
    id_dt: string;
    ten_doi_tac: string;
    ten_khoa_hoc: string;
    ten_loai: string;
    do_quy_hiem:string;
    loai_thuc_an:string;
    loai_moi_truong_song: string;
    loai: LoaiPhieuXuatEnum;
}