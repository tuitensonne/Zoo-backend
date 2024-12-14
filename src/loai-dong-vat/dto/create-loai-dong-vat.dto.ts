export class CreateLoaiDongVatDto {
    ten_khoa_hoc: string
    ten_loai: string
    do_quy_hiem: string
    loai_thuc_an: string
    thoi_gian_chu_ki: number
    thoi_gian_mang_thai: number
    loai_moi_truong_song: string
}

export class CreateCaTheDto {
    id_kv: number
    id_hssk: number
    ten_khoa_hoc: string
    id_ct_cha: number
    ten_khoa_hoc_cha: string
    id_ct_me: number
    ten_khoa_hoc_me: string
    tuoi: number
    adn: string
    gioi_tinh: string
    trang_thai: string
}

export class CreateNhomDto {
    id_kv: number
    id_hssk: number
    ten_khoa_hoc: string
    so_luong: number
}