CREATE TABLE loai_dong_vat (
    ten_khoa_hoc VARCHAR(50),
    ten_loai VARCHAR(50) NOT NULL,
    do_quy_hiem VARCHAR(50) NOT NULL,
    loai_thuc_an VARCHAR(10) NOT NULL CHECK (loai_thuc_an IN ('ăn thịt', 'ăn cỏ', 'ăn tạp')),
    thoi_gian_chu_ki INT NOT NULL,
    thoi_gian_mang_thai INT NOT NULL,
    so_luong INT NOT NULL DEFAULT 0,
    loai_moi_truong_song VARCHAR(10) NOT NULL CHECK (loai_moi_truong_song IN ('trên cạn', 'dưới nước', 'cả hai')),
    PRIMARY KEY (ten_khoa_hoc)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE san_moi (
    ten_khoa_hoc_sm VARCHAR(100) NOT NULL,
    ten_khoa_hoc_cm VARCHAR(100) NOT NULL,

    PRIMARY KEY (ten_khoa_hoc_cm, ten_khoa_hoc_sm)

) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE khu_vuc_nuoi (
    id_kv INT AUTO_INCREMENT,
    vi_tri VARCHAR(50) NOT NULL,
    suc_chua_toi_da INT NOT NULL CHECK (suc_chua_toi_da > 0),
    trang_thai_hoat_dong VARCHAR(10) NOT NULL CHECK (trang_thai_hoat_dong IN ('sử dụng' , 'bảo trì')),
    dien_tich INT NOT NULL CHECK (dien_tich > 0),
    chieu_cao INT NOT NULL CHECK (chieu_cao > 0),
    loai_moi_truong VARCHAR(10) NOT NULL CHECK (loai_moi_truong IN ('trên cạn', 'dưới nước', 'cả hai')),
    PRIMARY KEY (id_kv)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE nhan_vien (
    cccd CHAR(12) NOT NULL,
    ho VARCHAR(50) NOT NULL,
    ten VARCHAR(10) NOT NULL,
    dia_chi VARCHAR(100),
    loai_cong_viec VARCHAR(10) NOT NULL CHECK (loai_cong_viec IN ('văn phòng' , 'thú y' , 'chăm sóc')),
    
    PRIMARY KEY(cccd)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE nhan_vien_sdt (
    cccd CHAR(12) NOT NULL,
    so_dien_thoai CHAR(10) NOT NULL CHECK (char_length(so_dien_thoai) = 10),

    PRIMARY KEY(cccd, so_dien_thoai)

) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE nv_van_phong (
    cccd CHAR(12) NOT NULL,
    bang_cap VARCHAR(100) NOT NULL,

    PRIMARY KEY(cccd)

    
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE nv_thu_y (
    cccd CHAR(12) NOT NULL,
    gphn VARCHAR(100) NOT NULL,
    nam_kinh_nghiem INT NOT NULL CHECK (nam_kinh_nghiem >= 0),

    PRIMARY KEY(cccd)

    
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE nv_cham_soc (
    cccd CHAR(12) NOT NULL,
    chung_nhan_csdv VARCHAR(100) NOT NULL,

    PRIMARY KEY(cccd)
    
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE ho_so_suc_khoe (
    id_hssk INT AUTO_INCREMENT,
    cccd CHAR(12) NOT NULL,  
    tinh_trang_suc_khoe VARCHAR(50),
    chieu_cao INT,
    can_nang INT,
    PRIMARY KEY (id_hssk)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE lich_su_dieu_tri (
    id_hssk INT NOT NULL,
    id_lsdt INT AUTO_INCREMENT,
    trieu_chung VARCHAR(100) NOT NULL,
    chuan_doan VARCHAR(100) NOT NULL,
    ket_qua VARCHAR(100) NOT NULL,
    loai_thuoc VARCHAR(100) NOT NULL,
    ghi_chu VARCHAR(255),

    PRIMARY KEY(id_lsdt , id_hssk)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE lich_su_tiem_chung (
    id_hssk INT NOT NULL,
    id_tc INT AUTO_INCREMENT,
    ngay_tiem_chung DATE NOT NULL,
    phuong_phap_tiem VARCHAR(100) NOT NULL,
    loai_vaccine VARCHAR(100) NOT NULL,
    lieu_luong INT NOT NULL,
    phan_ung_sau_tiem VARCHAR(150),

    PRIMARY KEY(id_tc, id_hssk)

    
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE che_do_dinh_duong (
    id_cddd INT AUTO_INCREMENT,
    id_hssk INT NOT NULL,
    cccd CHAR(12),
    hlddtt INT NOT NULL,
    luong_nuoc INT NOT NULL,
    bua_an INT NOT NULL,

    PRIMARY KEY (id_cddd, id_hssk)
    
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE thuc_pham_can_tranh (
    id_hssk INT NOT NULL,
    id_cddd INT NOT NULL,
    thuc_pham_can_tranh VARCHAR(100) NOT NULL,

    PRIMARY KEY(id_cddd, id_hssk, thuc_pham_can_tranh)

) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE khau_phan_an (
    id_kpa INT AUTO_INCREMENT,
    loai_dong_vat_an VARCHAR(10) NOT NULL CHECK( loai_dong_vat_an IN ('ăn cỏ' , 'ăn thịt' , 'ăn tạp')),
    ten_khau_phan VARCHAR(100) NOT NULL,
    id_cddd INT NOT NULL,
    thoi_gian_an VARCHAR(10) NOT NULL CHECK(thoi_gian_an in ('Buổi sáng', 'Buổi trưa', 'Buổi chiều')),

    PRIMARY KEY(id_kpa)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE qua_trinh_cho_an (
    id_kpa INT NOT NULL,
    id_kv INT NOT NULL,
    cccd CHAR(12) NOT NULL,
    ngay DATE NOT NULL,

    PRIMARY KEY(id_kpa, id_kv)

) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE thuc_an (
    id_ta INT NOT NULL AUTO_INCREMENT,
    ten_thuc_an VARCHAR(50) NOT NULL,
    ham_luong_dinh_duong FLOAT NOT NULL,
    ngay_het_han DATE NOT NULL,
    so_luong INT NOT NULL,
    PRIMARY KEY (id_ta)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE kpa_thuc_an (
    id_kpa INT NOT NULL,
    id_ta INT NOT NULL,
    so_luong INT NOT NULL,

    PRIMARY KEY(id_kpa, id_ta)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Văn phòng
CREATE TABLE doi_tac (
    id_dt INT AUTO_INCREMENT,
    ten_doi_tac VARCHAR(100) NOT NULL,
    loai_doi_tac VARCHAR(50) NOT NULL CHECK(loai_doi_tac IN ('sở thú', 'cung cấp thức ăn', 'viện nghiên cứu')),

    PRIMARY KEY(id_dt)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE doi_tac_lien_he (
    id_dt INT NOT NULL,
    dia_chi VARCHAR(150),
    sdt VARCHAR(10) CHECK (char_length(sdt) = 10),
    email VARCHAR(100),

    PRIMARY KEY(id_dt, dia_chi, sdt, email)

) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE dt_cung_cap_thuc_an (
    id_dt INT NOT NULL,
    gioi_han_dat_hang INT NOT NULL CHECK (gioi_han_dat_hang >= 0),

    PRIMARY KEY(id_dt)

    
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE ccta_chung_nhan_attp (
    id_dt INT NOT NULL,
    chung_nhan_attp VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_dt, chung_nhan_attp)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE dt_so_thu (
    id_dt INT NOT NULL AUTO_INCREMENT,
    loai_hinh_so_thu VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_dt)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE ca_the(
    id_ct INT AUTO_INCREMENT,
    id_kv INT NOT NULL,
    id_hssk INT NOT NULL,
    ten_khoa_hoc VARCHAR(50) NOT NULL,
    id_ct_cha INT,
    ten_khoa_hoc_cha VARCHAR(100),
    id_ct_me INT,
    ten_khoa_hoc_me VARCHAR(100),
    tuoi INT NOT NULL CHECK (tuoi >= 0),
    adn VARCHAR(100) NOT NULL,
    gioi_tinh VARCHAR(10) NOT NULL CHECK (gioi_tinh IN ('đực' , 'cái' , 'lưỡng tính')),
    trang_thai VARCHAR(10) NOT NULL CHECK (trang_thai IN ('chết' , 'còn sống' , 'cho thuê' , 'được thuê' , 'đã bán')),
    
    PRIMARY KEY (id_ct, ten_khoa_hoc)
    
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE nhom (
    id_n INT AUTO_INCREMENT,
    id_kv INT NOT NULL,
    id_hssk INT NOT NULL,
    ten_khoa_hoc VARCHAR(50) NOT NULL,
    so_luong INT NOT NULL CHECK (so_luong >= 0),

    PRIMARY KEY (id_n, ten_khoa_hoc)
    
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE cho_thue(
    id_dt INT NOT NULL,
    id_ct INT NOT NULL,
    ten_khoa_hoc VARCHAR(50),
    thoi_han INT,

    PRIMARY KEY (id_ct , ten_khoa_hoc)

) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE st_chuong_trinh_bao_ton (
    id_dt INT NOT NULL,
    chuong_trinh_bao_ton VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_dt, chuong_trinh_bao_ton)
    
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE dt_vien_nghien_cuu (
    id_dt INT NOT NULL AUTO_INCREMENT,
    linh_vuc_nghien_cuu VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_dt)
    
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE mau_vat (
    id_mv VARCHAR(10) NOT NULL,
    ten_mau VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    loai_mau VARCHAR(50) NOT NULL,
    tinh_trang_mau VARCHAR(50) NOT NULL,
    ngay_thu_thap DATE NOT NULL,
    ten_khoa_hoc VARCHAR(50) NOT NULL,
    id_ct INT NOT NULL,
    id_dt INT,

    PRIMARY KEY (id_mv)

    
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE phieu_nhap (
    id_pn INT NOT NULL AUTO_INCREMENT,
    ngay_nhap DATE NOT NULL,
    so_luong INT NOT NULL,
    loai_phieu_nhap VARCHAR(50) NOT NULL CHECK (loai_phieu_nhap IN ('phiếu nhập động vật', 'phiếu nhập thức ăn')),
    cccd CHAR(12),

    PRIMARY KEY (id_pn)
    
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE phieu_nhap_thuc_an (
    id_pn INT NOT NULL,
    nguon_goc_xuat_xu VARCHAR(50) NOT NULL,
    id_dt INT,
    id_ta INT NOT NULL,
    
    PRIMARY KEY (id_pn)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE phieu_nhap_dong_vat (
    id_pn INT NOT NULL,
    ly_do_nhap VARCHAR(100),
    id_dt INT,
    ten_khoa_hoc VARCHAR(50) NOT NULL,
    
    PRIMARY KEY (id_pn)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE phieu_xuat_dong_vat (
    id_px INT AUTO_INCREMENT,
    ngay_xuat DATE NOT NULL,
    so_luong INT NOT NULL,
    ly_do_xuat VARCHAR(150) NOT NULL,
    id_dt INT,
    ten_khoa_hoc VARCHAR(50) NOT NULL,
    cccd CHAR(12),
    
    PRIMARY KEY (id_px)
    
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Adding foreign key
ALTER TABLE san_moi
ADD FOREIGN KEY (ten_khoa_hoc_cm)
        REFERENCES loai_dong_vat (ten_khoa_hoc)
        ON UPDATE CASCADE
        ON DELETE CASCADE;

ALTER TABLE san_moi    
ADD FOREIGN KEY (ten_khoa_hoc_sm)
        REFERENCES loai_dong_vat (ten_khoa_hoc)
        ON UPDATE CASCADE
        ON DELETE CASCADE;
     
ALTER TABLE nhan_vien_sdt
ADD FOREIGN KEY(cccd)
        REFERENCES nhan_vien(cccd)
        ON UPDATE CASCADE
        ON DELETE CASCADE;
        
ALTER TABLE nv_van_phong
ADD FOREIGN KEY(cccd)
        REFERENCES nhan_vien(cccd)
        ON UPDATE CASCADE
        ON DELETE CASCADE;
        
ALTER TABLE nv_thu_y
ADD FOREIGN KEY(cccd)
        REFERENCES nhan_vien(cccd)
        ON UPDATE CASCADE
        ON DELETE CASCADE;
        
ALTER TABLE nv_cham_soc 
ADD FOREIGN KEY(cccd)
        REFERENCES nhan_vien(cccd)
        ON UPDATE CASCADE
        ON DELETE CASCADE;
        
ALTER TABLE ho_so_suc_khoe 
ADD FOREIGN KEY(cccd)
		REFERENCES nv_thu_y (cccd)
		ON UPDATE CASCADE;
        
ALTER TABLE lich_su_dieu_tri
ADD FOREIGN KEY(id_hssk)
        REFERENCES ho_so_suc_khoe(id_hssk)
        ON UPDATE CASCADE
        ON DELETE CASCADE;
        
ALTER TABLE lich_su_tiem_chung
ADD FOREIGN KEY(id_hssk)
        REFERENCES ho_so_suc_khoe(id_hssk)
        ON UPDATE CASCADE
        ON DELETE CASCADE;
        
ALTER TABLE che_do_dinh_duong 
ADD FOREIGN KEY (id_hssk)
        REFERENCES ho_so_suc_khoe (id_hssk)
        ON UPDATE CASCADE
        ON DELETE CASCADE;

ALTER TABLE che_do_dinh_duong 
ADD FOREIGN KEY(cccd)
		REFERENCES nv_thu_y (cccd)
		ON UPDATE CASCADE
        ON DELETE SET NULL;
        
ALTER TABLE thuc_pham_can_tranh
ADD FOREIGN KEY(id_hssk)
		REFERENCES ho_so_suc_khoe(id_hssk)
		ON UPDATE CASCADE
		ON DELETE CASCADE;

ALTER TABLE thuc_pham_can_tranh
ADD FOREIGN KEY(id_cddd)
        REFERENCES che_do_dinh_duong(id_cddd)
        ON UPDATE CASCADE
        ON DELETE CASCADE;
        
ALTER TABLE khau_phan_an
ADD FOREIGN KEY(id_cddd)
        REFERENCES che_do_dinh_duong(id_cddd)
        ON UPDATE CASCADE;
        
ALTER TABLE qua_trinh_cho_an
ADD FOREIGN KEY(id_kpa)
        REFERENCES khau_phan_an(id_kpa)
        ON UPDATE CASCADE
        ON DELETE CASCADE;

ALTER TABLE qua_trinh_cho_an
ADD FOREIGN KEY(id_kv)
        REFERENCES khu_vuc_nuoi(id_kv)
        ON UPDATE CASCADE
        ON DELETE CASCADE;

ALTER TABLE qua_trinh_cho_an
ADD FOREIGN KEY(cccd)
        REFERENCES nv_cham_soc(cccd)
        ON UPDATE CASCADE;
        
ALTER TABLE kpa_thuc_an 
ADD FOREIGN KEY(id_kpa)
        REFERENCES khau_phan_an(id_kpa)
        ON UPDATE CASCADE;
        
ALTER TABLE kpa_thuc_an 
ADD FOREIGN KEY (id_ta)
		REFERENCES thuc_an (id_ta)
		ON UPDATE CASCADE
        ON DELETE CASCADE;
        
ALTER TABLE doi_tac_lien_he
ADD FOREIGN KEY(id_dt)
        REFERENCES doi_tac(id_dt)
        ON UPDATE CASCADE
        ON DELETE CASCADE;
        
ALTER TABLE dt_cung_cap_thuc_an
ADD FOREIGN KEY(id_dt)
        REFERENCES doi_tac(id_dt)
        ON UPDATE CASCADE
        ON DELETE CASCADE;

ALTER TABLE ccta_chung_nhan_attp
ADD FOREIGN KEY (id_dt) 
        REFERENCES doi_tac (id_dt) 
        ON UPDATE CASCADE
        ON DELETE CASCADE;
        
ALTER TABLE dt_so_thu
ADD  FOREIGN KEY (id_dt) 
        REFERENCES doi_tac (id_dt) 
        ON UPDATE CASCADE
        ON DELETE CASCADE;
        
ALTER TABLE ca_the
ADD FOREIGN KEY (ten_khoa_hoc)
        REFERENCES loai_dong_vat (ten_khoa_hoc)
        ON UPDATE CASCADE
        ON DELETE CASCADE;

ALTER TABLE ca_the
ADD FOREIGN KEY (id_ct_cha)
        REFERENCES ca_the (id_ct)
        ON UPDATE CASCADE
        ON DELETE SET NULL;
    
ALTER TABLE ca_the
ADD FOREIGN KEY (id_ct_me)
        REFERENCES ca_the (id_ct)
        ON UPDATE CASCADE
        ON DELETE SET NULL;
    
ALTER TABLE ca_the
ADD FOREIGN KEY (ten_khoa_hoc_cha)
        REFERENCES ca_the (ten_khoa_hoc)
        ON UPDATE CASCADE
        ON DELETE SET NULL;
    
ALTER TABLE ca_the
ADD FOREIGN KEY (ten_khoa_hoc_me)
        REFERENCES ca_the (ten_khoa_hoc)
        ON UPDATE CASCADE
        ON DELETE SET NULL;
        
ALTER TABLE ca_the
ADD FOREIGN KEY (id_kv)
		REFERENCES khu_vuc_nuoi (id_kv)
		ON UPDATE CASCADE;
        
ALTER TABLE nhom
ADD FOREIGN KEY (ten_khoa_hoc)
        REFERENCES loai_dong_vat (ten_khoa_hoc)
        ON UPDATE CASCADE
        ON DELETE CASCADE;

ALTER TABLE nhom        
ADD FOREIGN KEY (id_kv)
		REFERENCES khu_vuc_nuoi (id_kv)
		ON UPDATE CASCADE;
        
ALTER TABLE cho_thue
ADD FOREIGN KEY(id_dt) 
        REFERENCES doi_tac(id_dt) 
        ON UPDATE CASCADE
        ON DELETE CASCADE;

ALTER TABLE cho_thue
ADD FOREIGN KEY(id_ct) 
        REFERENCES ca_the(id_ct) 
        ON UPDATE CASCADE
        ON DELETE CASCADE;


ALTER TABLE cho_thue
ADD FOREIGN KEY(ten_khoa_hoc) 
        REFERENCES ca_the(ten_khoa_hoc) 
        ON UPDATE CASCADE
        ON DELETE CASCADE;
        

ALTER TABLE st_chuong_trinh_bao_ton
ADD FOREIGN KEY (id_dt) 
        REFERENCES dt_so_thu (id_dt)
        ON UPDATE CASCADE
        ON DELETE CASCADE;
        
ALTER TABLE dt_vien_nghien_cuu
ADD FOREIGN KEY (id_dt) 
        REFERENCES doi_tac (id_dt)
        ON UPDATE CASCADE
        ON DELETE CASCADE;
        
ALTER TABLE mau_vat
ADD FOREIGN KEY (ten_khoa_hoc)
        REFERENCES ca_the (ten_khoa_hoc)
        ON UPDATE CASCADE;

ALTER TABLE mau_vat        
ADD FOREIGN KEY (id_ct)
        REFERENCES ca_the (id_ct)
        ON UPDATE CASCADE;

ALTER TABLE mau_vat        
ADD FOREIGN KEY (id_dt)
		REFERENCES dt_vien_nghien_cuu (id_dt)
		ON UPDATE CASCADE
        ON DELETE SET NULL;
        
ALTER TABLE phieu_nhap
ADD FOREIGN KEY (cccd) 
        REFERENCES nv_van_phong (cccd)
        ON UPDATE CASCADE
        ON DELETE SET NULL;
        
ALTER TABLE phieu_nhap_thuc_an
ADD FOREIGN KEY (id_dt) 
        REFERENCES dt_cung_cap_thuc_an (id_dt)
        ON UPDATE CASCADE
        ON DELETE SET NULL;
        
ALTER TABLE phieu_nhap_thuc_an
ADD FOREIGN KEY (id_ta) 
        REFERENCES thuc_an (id_ta)
        ON UPDATE CASCADE;
        
ALTER TABLE phieu_nhap_thuc_an
ADD FOREIGN KEY (id_pn) 
        REFERENCES phieu_nhap (id_pn)
        ON UPDATE CASCADE
        ON DELETE CASCADE;
        
ALTER TABLE phieu_nhap_dong_vat
ADD FOREIGN KEY (id_pn) 
        REFERENCES phieu_nhap (id_pn)
        ON UPDATE CASCADE
        ON DELETE CASCADE;
        
ALTER TABLE phieu_nhap_dong_vat
ADD FOREIGN KEY (id_dt) 
        REFERENCES dt_so_thu (id_dt)
        ON UPDATE CASCADE
        ON DELETE SET NULL;
        
ALTER TABLE phieu_nhap_dong_vat
ADD FOREIGN KEY (ten_khoa_hoc) 
        REFERENCES loai_dong_vat (ten_khoa_hoc)
        ON UPDATE CASCADE
        ON DELETE CASCADE;
        
ALTER TABLE phieu_xuat_dong_vat
ADD FOREIGN KEY (id_dt) 
        REFERENCES dt_so_thu (id_dt)
        ON UPDATE CASCADE
        ON DELETE SET NULL;
        
ALTER TABLE phieu_xuat_dong_vat
ADD FOREIGN KEY (ten_khoa_hoc) 
        REFERENCES loai_dong_vat (ten_khoa_hoc)
        ON UPDATE CASCADE
        ON DELETE CASCADE;


-- -----------------------------------------------------------------Function --
DELIMITER //

CREATE FUNCTION get_number_of_khu_vuc_nuoi()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE recordCount INT;

    SELECT COUNT(*) INTO recordCount
    FROM khu_vuc_nuoi;

    RETURN recordCount;
END//

DELIMITER ;

DELIMITER //

CREATE FUNCTION get_number_in_khu_vuc_nuoi(
	p_id_kv INT
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE so_luong_ca_the INT DEFAULT 0;
    DECLARE so_luong_cac_nhom INT DEFAULT 0;

    -- Đếm số lượng cá thể trong khu vực nuôi
    SELECT COUNT(*)
    INTO so_luong_ca_the
    FROM ca_the
    WHERE id_kv = p_id_kv;

    -- Tính tổng số lượng các nhóm trong khu vực nuôi
    SELECT COALESCE(SUM(so_luong), 0)
    INTO so_luong_cac_nhom
    FROM nhom
    WHERE id_kv = p_id_kv;

    -- Trả về tổng số lượng
    RETURN (so_luong_ca_the + so_luong_cac_nhom);
END//

DELIMITER ;

DELIMITER //

CREATE FUNCTION get_number_of_phieu_nhap_thuc_an()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE recordCount INT;

    SELECT COUNT(*) INTO recordCount
    FROM phieu_nhap_thuc_an;

    RETURN recordCount;
END//

DELIMITER ;


DELIMITER //

CREATE FUNCTION get_number_of_phieu_nhap_dong_vat()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE recordCount INT;

    SELECT COUNT(*) INTO recordCount
    FROM phieu_nhap_dong_vat;

    RETURN recordCount;
END//

DELIMITER ;

DELIMITER //

CREATE FUNCTION get_total_ho_so_suc_khoe(
    searchId INT,    -- Tham số tìm kiếm theo ID
    searchName VARCHAR(255)   -- Tham số tìm kiếm theo tên khoa học
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;

    SELECT COUNT(*) INTO total
    FROM ho_so_suc_khoe h
    LEFT JOIN ca_the c ON c.id_hssk = h.id_hssk
    LEFT JOIN nhom n ON n.id_hssk = h.id_hssk
    WHERE (searchId IS NULL OR h.id_hssk LIKE CONCAT('%', searchId, '%'))
      AND (searchName IS NULL OR 
           COALESCE(c.ten_khoa_hoc  COLLATE utf8mb4_unicode_ci
           , n.ten_khoa_hoc  COLLATE utf8mb4_unicode_ci
           ) LIKE CONCAT('%', searchName, '%'));

    RETURN total;
END//

DELIMITER ;

-- ---------------------------------------------------------------------------------Trigger --
-- Ràng buộc disjoint cho đối tác
DELIMITER //
CREATE TRIGGER trg_disjoint_dt_so_thu
BEFORE INSERT ON dt_so_thu
FOR EACH ROW
BEGIN
    -- Kiểm tra loại đối tác trong bảng doi_tac
    DECLARE loai_doi_tac_check VARCHAR(50);
    SELECT loai_doi_tac INTO loai_doi_tac_check
    FROM doi_tac
    WHERE id_dt = NEW.id_dt;

    IF loai_doi_tac_check != 'sở thú' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'id_dt không thuộc đối tác sở thú';
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_disjoint_dt_cung_cap_thuc_an
BEFORE INSERT ON dt_cung_cap_thuc_an
FOR EACH ROW
BEGIN
    -- Kiểm tra loại đối tác trong bảng doi_tac
    DECLARE loai_doi_tac_check VARCHAR(50);
    SELECT loai_doi_tac INTO loai_doi_tac_check
    FROM doi_tac
    WHERE id_dt = NEW.id_dt;

    IF loai_doi_tac_check != 'cung cấp thức ăn' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'id_dt không thuộc đối tác cung cấp thức ăn';
    END IF;
END //

DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_disjoint_dt_vien_nghien_cuu
BEFORE INSERT ON dt_vien_nghien_cuu
FOR EACH ROW
BEGIN
    -- Kiểm tra loại đối tác trong bảng doi_tac
    DECLARE loai_doi_tac_check VARCHAR(50);
    SELECT loai_doi_tac INTO loai_doi_tac_check
    FROM doi_tac
    WHERE id_dt = NEW.id_dt;

    -- Nếu không phải loại 'viện nghiên cứu', báo lỗi
    IF loai_doi_tac_check != 'viện nghiên cứu' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'id_dt không thuộc đối tác viện nghiên cứu';
    END IF;
END //

DELIMITER ;

-- Ràng buộc disjoint cho phiếu nhập
DELIMITER //

CREATE TRIGGER trg_disjoint_pn_thuc_an
BEFORE INSERT ON phieu_nhap_thuc_an
FOR EACH ROW
BEGIN

    DECLARE loai_phieu_nhap_check VARCHAR(50);
    SELECT loai_phieu_nhap INTO loai_phieu_nhap_check
    FROM phieu_nhap
    WHERE id_pn = NEW.id_pn;

    IF loai_phieu_nhap_check != 'phiếu nhập thức ăn' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'id_pn không thuộc phiếu nhập thức ăn';
    END IF;
END //
DELIMITER ;

DELIMITER //

CREATE TRIGGER trg_disjoint_pn_dong_vat
BEFORE INSERT ON phieu_nhap_dong_vat
FOR EACH ROW
BEGIN

    DECLARE loai_phieu_nhap_check VARCHAR(50);
    SELECT loai_phieu_nhap INTO loai_phieu_nhap_check
    FROM phieu_nhap
    WHERE id_pn = NEW.id_pn;

    IF loai_phieu_nhap_check != 'phiếu nhập động vật' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'id_pn không thuộc phiếu nhập động vật';
    END IF;
END //
DELIMITER ;

-- Ràng buộc disjoint cho nhân viên
DELIMITER //

CREATE TRIGGER trg_disjoint_nv_van_phong
BEFORE INSERT ON nv_van_phong
FOR EACH ROW
BEGIN
    DECLARE loai_cong_viec_check VARCHAR(50);
    SELECT loai_cong_viec INTO loai_cong_viec_check
    FROM nhan_vien
    WHERE cccd = NEW.cccd;

    IF loai_cong_viec_check != 'văn phòng' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'cccd không thuộc nhân viên văn phòng';
    END IF;
END //
DELIMITER ;

DELIMITER //

CREATE TRIGGER trg_disjoint_nv_cham_soc
BEFORE INSERT ON nv_cham_soc
FOR EACH ROW
BEGIN
    DECLARE loai_cong_viec_check VARCHAR(50);
    SELECT loai_cong_viec INTO loai_cong_viec_check
    FROM nhan_vien
    WHERE cccd = NEW.cccd;

    IF loai_cong_viec_check != 'chăm sóc' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'cccd không thuộc nhân viên chăm sóc';
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER trg_disjoint_nv_thu_y
BEFORE INSERT ON nv_thu_y
FOR EACH ROW
BEGIN
    DECLARE loai_cong_viec_check VARCHAR(50);
    SELECT loai_cong_viec INTO loai_cong_viec_check
    FROM nhan_vien
    WHERE cccd = NEW.cccd;

    -- Nếu không phải loại 'viện nghiên cứu', báo lỗi
    IF loai_cong_viec_check != 'thú y' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'cccd không thuộc nhân viên thú y';
    END IF;
END //

DELIMITER ;

-- Ràng buộc tạo khóa chính cho mẫu vật
DELIMITER //

CREATE TRIGGER trg_primary_key_mau_vat
BEFORE INSERT ON mau_vat
FOR EACH ROW
BEGIN
    DECLARE new_id VARCHAR(10);
    DECLARE max_id INT;
    
    SELECT IFNULL(MAX(CAST(SUBSTRING(id_mv, 3) AS UNSIGNED)), 0) + 1
    INTO max_id
    FROM mau_vat;
    
    -- Nếu không có record nào thì gán id_mv là PX0001
    IF max_id = 1 THEN
        SET new_id = 'MV0001';
    ELSE
        -- Tạo id_mv theo dạng PXxxxx
        SET new_id = CONCAT('MV', LPAD(max_id, 4, '0'));
    END IF;
    
    -- Gán giá trị id_mv mới vào bản ghi
    SET NEW.id_mv = new_id;
END //
DELIMITER ;

-- Ràng buộc kiểm tra loại môi trường khi thêm cá thể 
-- vào khu vực nuôi phải cùng với loại môi trường của khu vực nuôi đó
DELIMITER //
CREATE TRIGGER trg_kiem_tra_loai_moi_truong_song_ct
BEFORE INSERT ON ca_the
FOR EACH ROW
BEGIN
    DECLARE loai_moi_truong_loai_dong_vat VARCHAR(50);
    DECLARE loai_moi_truong_khu_vuc VARCHAR(50);
    DECLARE trang_thai_khu_vuc VARCHAR(10);
    
    SELECT loai_moi_truong_song INTO loai_moi_truong_loai_dong_vat
    FROM loai_dong_vat
    WHERE ten_khoa_hoc = NEW.ten_khoa_hoc;

    SELECT loai_moi_truong INTO loai_moi_truong_khu_vuc
    FROM khu_vuc_nuoi
    WHERE id_kv = NEW.id_kv;
    
    SELECT trang_thai_hoat_dong INTO trang_thai_khu_vuc
    FROM khu_vuc_nuoi
    WHERE id_kv = NEW.id_kv;

    IF loai_moi_truong_loai_dong_vat != loai_moi_truong_khu_vuc THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Môi trường sống của loài động vật và khu vực nuôi không khớp!';
    END IF;
    
    IF trang_thai_khu_vuc = 'bảo trì' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Khu vực nuôi đang bảo trì không thể thêm';
    END IF;
END;
//
DELIMITER ;

-- Ràng buộc kiểm tra sức chứa tối da của khu vực nuôi khi thêm cá thể vào khu vực nuôi
DELIMITER //
CREATE TRIGGER trg_kiem_tra_so_luong_ct
BEFORE INSERT ON ca_the
FOR EACH ROW
BEGIN
	DECLARE suc_chua_toi_da_khu_vuc INT;
	DECLARE so_luong_hien_tai INT;
    
    SELECT get_number_in_khu_vuc_nuoi(NEW.id_kv) INTO so_luong_hien_tai;
    
    IF (so_luong_hien_tai + 1) > suc_chua_toi_da_khu_vuc THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tổng số lượng động vật trong khu vực nuôi vượt quá sức chứa tối đa!';
    END IF;
END;
//
DELIMITER ;

-- Ràng buộc kiểm tra loại môi trường khi thêm nhóm vào khu vực nuôi
DELIMITER //
CREATE TRIGGER trg_kiem_tra_loai_moi_truong_song_nhom
BEFORE INSERT ON nhom
FOR EACH ROW
BEGIN
    DECLARE loai_moi_truong_loai_dong_vat VARCHAR(50);
    DECLARE loai_moi_truong_khu_vuc VARCHAR(50);
    DECLARE trang_thai_khu_vuc VARCHAR(10);
    
    SELECT loai_moi_truong_song INTO loai_moi_truong_loai_dong_vat
    FROM loai_dong_vat
    WHERE ten_khoa_hoc = NEW.ten_khoa_hoc;

    SELECT loai_moi_truong INTO loai_moi_truong_khu_vuc
    FROM khu_vuc_nuoi
    WHERE id_kv = NEW.id_kv;
	
	SELECT trang_thai_hoat_dong INTO trang_thai_khu_vuc
    FROM khu_vuc_nuoi
    WHERE id_kv = NEW.id_kv;
    
    IF loai_moi_truong_loai_dong_vat != loai_moi_truong_khu_vuc THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Môi trường sống của loài động vật và khu vực nuôi không khớp!';
    END IF;
    
	IF trang_thai_khu_vuc = 'bảo trì' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Khu vực nuôi đang bảo trì không thể thêm';
    END IF;
END;
//
DELIMITER ;

-- Ràng buộc kiểm tra sức chứa tối da của khu vực nuôi khi thêm nhóm vào khu vực nuôi
DELIMITER //
CREATE TRIGGER trg_kiem_tra_so_luong_nhom
BEFORE INSERT ON nhom
FOR EACH ROW
BEGIN
	DECLARE suc_chua_toi_da_khu_vuc INT;
    DECLARE so_luong_hien_tai INT;
    
    SELECT get_number_in_khu_vuc_nuoi(NEW.id_kv) INTO so_luong_hien_tai;
    
    IF (so_luong_hien_tai + NEW.so_luong) > suc_chua_toi_da_khu_vuc THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tổng số lượng động vật trong khu vực nuôi vượt quá sức chứa tối đa!';
    END IF;
END;
//
DELIMITER ;

-- Các loài động vật mà là “con mồi” của loài khác trong quan hệ đệ quy “ăn” thì không thể ở chung một khu vực nuôi.
DELIMITER //
CREATE TRIGGER trg_check_san_moi_ct
BEFORE INSERT ON ca_the
FOR EACH ROW
BEGIN
    DECLARE conflict_count INT;

    SELECT COUNT(*)
    INTO conflict_count
    FROM ca_the AS prey
    JOIN san_moi
    ON NEW.ten_khoa_hoc = san_moi.ten_khoa_hoc_sm 
    AND prey.ten_khoa_hoc = san_moi.ten_khoa_hoc_cm 
    WHERE prey.id_kv = NEW.id_kv;

    IF conflict_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Kẻ săn mồi và con mồi không thể tồn tại trong cùng khu vực nuôi!';
    END IF;
	
    SELECT COUNT(*)
    INTO conflict_count
    FROM nhom AS prey
    JOIN san_moi
    ON NEW.ten_khoa_hoc = san_moi.ten_khoa_hoc_sm 
    AND prey.ten_khoa_hoc = san_moi.ten_khoa_hoc_cm 
    WHERE prey.id_kv = NEW.id_kv;

    IF conflict_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Kẻ săn mồi và con mồi không thể tồn tại trong cùng khu vực nuôi!';
    END IF;

    SELECT COUNT(*)
    INTO conflict_count
    FROM ca_the AS predator
    JOIN san_moi
    ON NEW.ten_khoa_hoc = san_moi.ten_khoa_hoc_cm 
    AND predator.ten_khoa_hoc = san_moi.ten_khoa_hoc_sm
    WHERE predator.id_kv = NEW.id_kv;

    IF conflict_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Kẻ săn mồi và con mồi không thể tồn tại trong cùng khu vực nuôi!';
    END IF;
    
        SELECT COUNT(*)
    INTO conflict_count
    FROM nhom AS predator
    JOIN san_moi
    ON NEW.ten_khoa_hoc = san_moi.ten_khoa_hoc_cm 
    AND predator.ten_khoa_hoc = san_moi.ten_khoa_hoc_sm
    WHERE predator.id_kv = NEW.id_kv;

    IF conflict_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Kẻ săn mồi và con mồi không thể tồn tại trong cùng khu vực nuôi!';
    END IF;
END; //

DELIMITER;


-- Các loài động vật mà là “con mồi” của loài khác trong quan hệ đệ quy “ăn” thì không thể ở chung một khu vực nuôi.
DELIMITER //

CREATE TRIGGER trg_check_san_moi_nhom
BEFORE INSERT ON nhom
FOR EACH ROW
BEGIN
    DECLARE conflict_count INT;

    SELECT COUNT(*)
    INTO conflict_count
    FROM nhom AS prey
    JOIN san_moi
    ON NEW.ten_khoa_hoc = san_moi.ten_khoa_hoc_sm 
    AND prey.ten_khoa_hoc = san_moi.ten_khoa_hoc_cm 
    WHERE prey.id_kv = NEW.id_kv;

    IF conflict_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Kẻ săn mồi và con mồi không thể tồn tại trong cùng khu vực nuôi!';
    END IF;
	
	SELECT COUNT(*)
    INTO conflict_count
    FROM ca_the AS prey
    JOIN san_moi
    ON NEW.ten_khoa_hoc = san_moi.ten_khoa_hoc_sm 
    AND prey.ten_khoa_hoc = san_moi.ten_khoa_hoc_cm 
    WHERE prey.id_kv = NEW.id_kv;

    IF conflict_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Kẻ săn mồi và con mồi không thể tồn tại trong cùng khu vực nuôi!';
    END IF;
    
    SELECT COUNT(*)
    INTO conflict_count
    FROM nhom AS predator
    JOIN san_moi
    ON NEW.ten_khoa_hoc = san_moi.ten_khoa_hoc_cm 
    AND predator.ten_khoa_hoc = san_moi.ten_khoa_hoc_sm
    WHERE predator.id_kv = NEW.id_kv;

    IF conflict_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Kẻ săn mồi và con mồi không thể tồn tại trong cùng khu vực nuôi!';
    END IF;
    
    SELECT COUNT(*)
    INTO conflict_count
    FROM ca_the AS predator
    JOIN san_moi
    ON NEW.ten_khoa_hoc = san_moi.ten_khoa_hoc_cm 
    AND predator.ten_khoa_hoc = san_moi.ten_khoa_hoc_sm
    WHERE predator.id_kv = NEW.id_kv;

    IF conflict_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Kẻ săn mồi và con mồi không thể tồn tại trong cùng khu vực nuôi!';
    END IF;
END; //

DELIMITER //

DELIMITER //

-- Khi thêm phiếu nhập loài động vật thì số lượng trong loài động vật phải tăng thêm
CREATE TRIGGER trg_thay_doi_so_luong_loai_dong_vat_pn
AFTER INSERT ON phieu_nhap_dong_vat
FOR EACH ROW
BEGIN
    DECLARE p_so_luong INT;

    SELECT so_luong INTO p_so_luong 
    FROM phieu_nhap 
    WHERE id_pn = NEW.id_pn;

    UPDATE loai_dong_vat
    SET so_luong = so_luong + p_so_luong
    WHERE ten_khoa_hoc = NEW.ten_khoa_hoc;
END; //

DELIMITER ;

DELIMITER //

-- Khi thêm phiếu xuất loài động vật thì số lượng trong loài động vật phải giảm thêm

CREATE TRIGGER update_so_luong_xuat_loai_dong_vat
AFTER INSERT ON phieu_xuat_dong_vat
FOR EACH ROW
BEGIN
    DECLARE current_quantity INT;

    -- Lấy số lượng hiện tại của loài động vật trong bảng loai_dong_vat
    SELECT so_luong INTO current_quantity
    FROM loai_dong_vat
    WHERE ten_khoa_hoc = NEW.ten_khoa_hoc;

    -- Kiểm tra nếu số lượng hiện tại nhỏ hơn số lượng xuất
    IF current_quantity < NEW.so_luong THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số lượng động vật xuất vượt quá số lượng hiện có trong hệ thống!';
    END IF;

    -- Cập nhật số lượng loài động vật trong bảng loai_dong_vat
    UPDATE loai_dong_vat
    SET so_luong = current_quantity - NEW.so_luong
    WHERE ten_khoa_hoc = NEW.ten_khoa_hoc;
END; //
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_check_cach_chia_loai_dong_vat_ct
BEFORE INSERT ON ca_the
FOR EACH ROW
BEGIN
    IF EXISTS(SELECT 1 FROM nhom WHERE ten_khoa_hoc = NEW.ten_khoa_hoc) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Loài động vật chỉ có thể chia theo nhóm';
	END IF;
END; //
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_check_cach_chia_loai_dong_vat_nhom
BEFORE INSERT ON nhom
FOR EACH ROW
BEGIN
    IF EXISTS(SELECT 1 FROM ca_the WHERE ten_khoa_hoc = NEW.ten_khoa_hoc) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Loài động vật chỉ có thể chia theo cá thể';
	END IF;
END; //
DELIMITER ;

DELIMITER //

CREATE TRIGGER trg_thay_doi_trang_thai_kvn
AFTER UPDATE ON khu_vuc_nuoi
FOR EACH ROW
BEGIN
	DECLARE so_luong_hien_tai INT;
	IF OLD.trang_thai_hoat_dong != NEW.trang_thai_hoat_dong THEN
        
        IF NEW.trang_thai_hoat_dong = 'bảo trì' THEN
			SELECT get_number_in_khu_vuc_nuoi(NEW.id_kv) INTO so_luong_hien_tai;
            IF so_luong_hien_tai > 0 THEN
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Khu vực nuôi đang có loài động vật ở';
			END IF;
        END IF;
    END IF;
END;
//

DELIMITER ;
-- --------------------------------------------------------------------Procedure --
DELIMITER //

-- Procedure của loài động vật
CREATE PROCEDURE add_loai_dong_vat(
    IN n_ten_khoa_hoc VARCHAR(50),
    IN ten_loai VARCHAR(50),
    IN do_quy_hiem VARCHAR(50),
    IN loai_thuc_an VARCHAR(10),
    IN thoi_gian_chu_ki INT,
    IN thoi_gian_mang_thai INT,
    IN loai_moi_truong_song VARCHAR(10)
)
BEGIN
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;
    
    START TRANSACTION;

    IF EXISTS (SELECT 1 FROM loai_dong_vat WHERE ten_khoa_hoc = n_ten_khoa_hoc) THEN
        SIGNAL SQLSTATE '45000' -- Báo lỗi
        SET MESSAGE_TEXT = 'Loài động vật đã có trong sở thú';
    ELSE
        INSERT INTO loai_dong_vat (
            ten_khoa_hoc,
            ten_loai,
            do_quy_hiem,
            loai_thuc_an,
            thoi_gian_chu_ki,
            thoi_gian_mang_thai,
            loai_moi_truong_song)
        VALUES (
            n_ten_khoa_hoc,
            ten_loai,
            do_quy_hiem,
            loai_thuc_an,
            thoi_gian_chu_ki,
            thoi_gian_mang_thai,
            loai_moi_truong_song
        );
    END IF;
    
    COMMIT;
END //

CREATE PROCEDURE get_loai_dong_vat_list()
BEGIN
    SELECT DISTINCT ten_khoa_hoc, 'Cá thể' AS loai
    FROM ca_the
    UNION ALL
    SELECT DISTINCT ten_khoa_hoc, 'Nhóm' AS loai
    FROM nhom
    UNION ALL
	SELECT ten_khoa_hoc, '' AS loai
    FROM loai_dong_vat WHERE so_luong = 0;
END //

CREATE PROCEDURE get_all_ct_of_loai_dong_vat(
	IN p_ten_khoa_hoc VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    IN p_gioi_tinh VARCHAR(10)CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci 
)
BEGIN
    -- Truy vấn để lấy danh sách ten_khoa_hoc
    SELECT id_ct FROM ca_the WHERE ten_khoa_hoc = p_ten_khoa_hoc AND gioi_tinh = p_gioi_tinh;
END //

-- Procedure của phiếu nhập thức ăn
CREATE PROCEDURE add_phieu_nhap_thuc_an(     
	IN p_cccd CHAR(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,     
    IN p_id_ben_cung_cap_thuc_an INT,     
    IN p_ten_thuc_an VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,     
    IN p_ham_luong_dinh_duong FLOAT,     
    IN p_ngay_het_han DATE,     
    IN p_ngay_nhap DATE,     
    IN p_so_luong INT,     
    IN p_nguon_goc_xuat_xu VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci 
)
BEGIN 
    DECLARE last_insert_id INT; 
    DECLARE p_id_ta INT; 


    -- Bắt đầu giao dịch 
    START TRANSACTION; 

    IF NOT EXISTS (SELECT 1 FROM doi_tac WHERE id_dt = p_id_ben_cung_cap_thuc_an) THEN 
		ROLLBACK;
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Đối tác không tồn tại.'; 
    END IF; 

    IF NOT EXISTS (SELECT 1 FROM nhan_vien WHERE cccd = p_cccd) THEN 
		ROLLBACK;
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Nhân viên không tồn tại.'; 
    END IF; 

    IF p_ngay_nhap >= p_ngay_het_han THEN 
		ROLLBACK;
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Ngày nhập phải nhỏ hơn ngày hết hạn.'; 
    END IF; 

    INSERT INTO thuc_an (ten_thuc_an, ham_luong_dinh_duong, ngay_het_han, so_luong) 
    VALUES (p_ten_thuc_an, p_ham_luong_dinh_duong, p_ngay_het_han, p_so_luong); 

    SET p_id_ta = LAST_INSERT_ID(); 

    IF p_id_ta IS NULL THEN 
		ROLLBACK;
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Không thể chèn dữ liệu vào bảng thuc_an.'; 
    END IF; 

    INSERT INTO phieu_nhap (ngay_nhap, so_luong, cccd, loai_phieu_nhap) 
    VALUES (p_ngay_nhap, p_so_luong, p_cccd, 'phiếu nhập thức ăn'); 

    SET last_insert_id = LAST_INSERT_ID(); 

    IF last_insert_id IS NULL THEN 
		ROLLBACK;
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Không thể chèn dữ liệu vào bảng phieu_nhap.'; 
    END IF; 

    INSERT INTO phieu_nhap_thuc_an (id_pn, nguon_goc_xuat_xu, id_dt, id_ta) 
    VALUES (last_insert_id, p_nguon_goc_xuat_xu, p_id_ben_cung_cap_thuc_an, p_id_ta); 

    IF ROW_COUNT() = 0 THEN 
		ROLLBACK;
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Không thể chèn dữ liệu vào bảng phieu_nhap_thuc_an.'; 
    END IF; 

    -- Hoàn tất giao dịch 
    COMMIT; 
END//

CREATE PROCEDURE get_all_phieu_nhap_thuc_an(
	IN p_offset INT,
    IN p_limit INT
)
BEGIN
    SELECT *
    FROM phieu_nhap pn
    NATURAL JOIN phieu_nhap_thuc_an pnta
    LIMIT p_offset, p_limit;
END //

CREATE PROCEDURE delete_phieu_nhap_thuc_an_theo_id(
    IN p_id_pn INT
)
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM phieu_nhap WHERE id_pn = p_id_pn
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Phiếu nhập không tồn tại';
    END IF;
    
    DELETE FROM phieu_nhap WHERE id_pn = p_id_pn;
END //

CREATE PROCEDURE get_phieu_nhap_thuc_an_theo_id(
    IN p_id_pn INT
)
BEGIN
	IF NOT EXISTS (
        SELECT 1 FROM phieu_nhap WHERE id_pn = p_id_pn
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Phiếu nhập không tồn tại';
    END IF;

    SELECT *
    FROM phieu_nhap pn
    NATURAL JOIN phieu_nhap_thuc_an pnta
    WHERE id_pn = p_id_pn;
END //

-- Procedure của phiếu nhập động vật cá thể
CREATE PROCEDURE add_phieu_nhap_dong_vat_ct(     
    IN p_cccd CHAR(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,     
    IN p_id_so_thu INT,     
    IN p_ten_khoa_hoc VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,     
    IN p_ngay_nhap DATE,     
    IN p_so_luong INT,     
    IN p_ly_do_nhap VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    IN p_id_kv INT,                 
    IN p_id_hssk INT,           
    IN p_id_ct_cha INT,  
    IN p_ten_khoa_hoc_cha VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    IN p_id_ct_me INT,      
    IN p_ten_khoa_hoc_me VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, 
    IN p_tuoi INT,                  -- Tuổi
    IN p_adn VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,         
    IN p_gioi_tinh VARCHAR(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,   
    IN p_trang_thai VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci   
) 
BEGIN 
    DECLARE last_insert_id INT; 
    -- Bắt đầu giao dịch 
    START TRANSACTION; 
    IF NOT EXISTS (SELECT 1 FROM dt_so_thu WHERE id_dt = p_id_so_thu) OR p_id_so_thu != NULL THEN 
		ROLLBACK;
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Đối tác không tồn tại.'; 
    END IF; 

    IF NOT EXISTS (SELECT 1 FROM nv_van_phong WHERE cccd = p_cccd) THEN 
		ROLLBACK;
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Nhân viên không tồn tại.'; 
    END IF; 

    INSERT INTO phieu_nhap (ngay_nhap, so_luong, cccd, loai_phieu_nhap) 
    VALUES (p_ngay_nhap, p_so_luong, p_cccd, 'phiếu nhập động vật'); 

    SET last_insert_id = LAST_INSERT_ID(); 

    IF last_insert_id IS NULL THEN 
		ROLLBACK;
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Không thể chèn dữ liệu vào bảng phieu_nhap.'; 
    END IF; 

    INSERT INTO phieu_nhap_dong_vat (id_pn, ly_do_nhap, id_dt, ten_khoa_hoc) 
    VALUES (last_insert_id, p_ly_do_nhap, p_id_so_thu, p_ten_khoa_hoc); 

    IF ROW_COUNT() = 0 THEN 
		ROLLBACK;
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Không thể chèn dữ liệu vào bảng phieu_nhap_dong_vat.'; 
    END IF; 
	
    -- Kiểm tra id_kv tồn tại
    IF NOT EXISTS (SELECT 1 FROM khu_vuc_nuoi WHERE id_kv = p_id_kv) THEN
		ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ID khu vực không tồn tại.';
    END IF;
    
    -- Kiểm tra id_hssk tồn tại
    IF NOT EXISTS (SELECT 1 FROM ho_so_suc_khoe WHERE id_hssk = p_id_hssk) THEN
		ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ID hồ sơ sức khỏe không tồn tại.';
    END IF;

    -- Kiểm tra id_ct_cha tồn tại (nếu không NULL)
    IF p_id_ct_cha IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ca_the 
    WHERE id_ct = p_id_ct_cha AND ten_khoa_hoc = p_ten_khoa_hoc_cha) THEN
		ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ID cá thể cha không tồn tại hoặc không khớp tên khoa học.';
    END IF;
    
    -- Kiểm tra id_ct_me tồn tại (nếu không NULL)
    IF p_id_ct_me IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ca_the 
    WHERE id_ct = p_id_ct_me AND ten_khoa_hoc = p_ten_khoa_hoc_me) THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ID cá thể mẹ không tồn tại hoặc không khớp tên khoa học.';
    END IF;

    -- Thêm cá thể mới vào bảng ca_the
    INSERT INTO ca_the (
        id_kv, id_hssk, ten_khoa_hoc, ten_khoa_hoc_cha, id_ct_cha, ten_khoa_hoc_me, id_ct_me, tuoi, adn, gioi_tinh, trang_thai
    )
    VALUES (
        p_id_kv, p_id_hssk, p_ten_khoa_hoc, p_ten_khoa_hoc_cha, p_id_ct_cha, p_ten_khoa_hoc_me, p_id_ct_me, p_tuoi, p_adn, p_gioi_tinh, p_trang_thai
    );
    COMMIT; 
END //

CREATE PROCEDURE add_phieu_nhap_dong_vat_nhom(     
    IN p_cccd CHAR(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,     
    IN p_id_so_thu INT,     
    IN p_ten_khoa_hoc VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,     
    IN p_ngay_nhap DATE,     
    IN p_so_luong INT,     
    IN p_ly_do_nhap VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    IN p_id_kv INT,
    IN p_id_hssk INT
) 
BEGIN 
    DECLARE last_insert_id INT; 

    -- Bắt đầu giao dịch 
    START TRANSACTION; 

    IF NOT EXISTS (SELECT 1 FROM dt_so_thu WHERE id_dt = p_id_so_thu) OR p_id_so_thu != NULL THEN 
		ROLLBACK;
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Đối tác không tồn tại.'; 
    END IF; 

    IF NOT EXISTS (SELECT 1 FROM nv_van_phong WHERE cccd = p_cccd) THEN 
		ROLLBACK;
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Nhân viên không tồn tại.'; 
    END IF; 

    INSERT INTO phieu_nhap (ngay_nhap, so_luong, cccd, loai_phieu_nhap) 
    VALUES (p_ngay_nhap, p_so_luong, p_cccd, 'phiếu nhập động vật'); 

    SET last_insert_id = LAST_INSERT_ID(); 

    IF last_insert_id IS NULL THEN 
		ROLLBACK;
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Không thể chèn dữ liệu vào bảng phieu_nhap.'; 
    END IF; 

    INSERT INTO phieu_nhap_dong_vat (id_pn, ly_do_nhap, id_dt, ten_khoa_hoc) 
    VALUES (last_insert_id, p_ly_do_nhap, p_id_so_thu, p_ten_khoa_hoc); 

    IF ROW_COUNT() = 0 THEN 
		ROLLBACK;
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Không thể chèn dữ liệu vào bảng phieu_nhap_dong_vat.'; 
    END IF; 
	
    IF NOT EXISTS (SELECT 1 FROM khu_vuc_nuoi WHERE id_kv = p_id_kv) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ID khu vực không tồn tại.';
    END IF;

    -- Kiểm tra id_hssk tồn tại
    IF NOT EXISTS (SELECT 1 FROM ho_so_suc_khoe WHERE id_hssk = p_id_hssk) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ID hồ sơ sức khỏe không tồn tại.';
    END IF;

    -- Kiểm tra nếu số lượng phải lớn hơn hoặc bằng 0
    IF p_so_luong < 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số lượng phải lớn hơn hoặc bằng 0';
    ELSE
        -- Chèn nhóm vào bảng nhom
        INSERT INTO nhom (id_kv, id_hssk, ten_khoa_hoc, so_luong)
        VALUES (p_id_kv, p_id_hssk, p_ten_khoa_hoc, p_so_luong);
    END IF;
	
    -- Hoàn tất giao dịch 
    COMMIT; 
END //

CREATE PROCEDURE get_all_phieu_nhap_dong_vat(
	IN p_offset INT,
    IN p_limit INT
)
BEGIN
    SELECT *
    FROM phieu_nhap pn
    NATURAL JOIN phieu_nhap_dong_vat pndv
    LIMIT p_offset, p_limit;
END //

CREATE PROCEDURE delete_phieu_nhap_dong_vat_theo_id(
    IN p_id_pn INT
)
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM phieu_nhap WHERE id_pn = p_id_pn
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Phiếu nhập không tồn tại';
    END IF;
    
    DELETE FROM phieu_nhap WHERE id_pn = p_id_pn;
END //

CREATE PROCEDURE get_phieu_nhap_dong_vat_theo_id(
    IN p_id_pn INT
)
BEGIN
	IF NOT EXISTS (
        SELECT 1 FROM phieu_nhap WHERE id_pn = p_id_pn
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Phiếu nhập không tồn tại';
    END IF;

    SELECT *
    FROM phieu_nhap pn
    NATURAL JOIN phieu_nhap_dong_vat pndv
    WHERE id_pn = p_id_pn;
END //

CREATE PROCEDURE get_all_doi_tac_so_thu()
BEGIN
	SELECT id_dt, ten_doi_tac
    FROM dt_so_thu NATURAL JOIN doi_tac;
END//

CREATE PROCEDURE get_all_doi_tac_thuc_an()
BEGIN
	SELECT id_dt, ten_doi_tac
    FROM dt_cung_cap_thuc_an NATURAL JOIN doi_tac;
END//

CREATE PROCEDURE get_all_nv_van_phong()
BEGIN
    SELECT cccd, CONCAT(ho, ' ', ten) AS ho_va_ten
    FROM nhan_vien
    NATURAL JOIN nv_van_phong;
END//

CREATE PROCEDURE get_list_khu_vuc_nuoi()
BEGIN
    SELECT id_kv, vi_tri, loai_moi_truong
    FROM khu_vuc_nuoi
    WHERE trang_thai_hoat_dong != "bảo trì";
END//


-- Procedure của thức ăn
CREATE PROCEDURE delete_thuc_an(
    IN p_ID_TA INT
)
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM thuc_an WHERE id_ta = p_ID_TA
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Thức ăn không tồn tại.';
    END IF;

    DELETE FROM thuc_an WHERE id_ta = p_ID_TA;
END //

CREATE PROCEDURE update_thuc_an(
    IN p_ID_TA INT,
    IN p_SoLuong INT
)
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM thuc_an WHERE id_ta = p_ID_TA
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Thức ăn không tồn tại.';
    END IF;

    UPDATE thuc_an
    SET so_luong = COALESCE(p_SoLuong, so_luong)
    WHERE id_ta = p_ID_TA;
END //

CREATE PROCEDURE get_thuc_an_theo_id(
	p_id_ta INT
)
BEGIN
	SELECT 
		ten_thuc_an,
		ham_luong_dinh_duong,
		ngay_het_han,
		so_luong
	FROM thuc_an
    WHERE id_ta = p_id_ta;
END //

-- Procedure cho nhân viên văn phòng
CREATE PROCEDURE get_nv_van_phong_theo_cccd(
    IN p_cccd VARCHAR(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
)
BEGIN
    SELECT *
    FROM nhan_vien
    NATURAL JOIN nv_van_phong
    WHERE nv_van_phong.cccd = p_cccd;
END //

-- Procedure cho khu vực nuôi
CREATE PROCEDURE get_all_khu_vuc_nuoi(
	IN p_offset INT,
    IN p_limit INT
)
BEGIN
    SELECT *
    FROM khu_vuc_nuoi
	LIMIT p_offset, p_limit;
END //



CREATE PROCEDURE get_khu_vuc_nuoi_by_id(
	IN p_id_kv INT
)
BEGIN
    SELECT *
    FROM khu_vuc_nuoi
	WHERE id_kv = p_id_kv;
END //

CREATE PROCEDURE add_khu_vuc_nuoi(
	p_vi_tri VARCHAR(50),
    p_suc_chua_toi_da INT,
    p_trang_thai_hoat_dong VARCHAR(50),
    p_dien_tich INT,
    p_chieu_cao INT,
    p_loai_moi_truong VARCHAR(10)
)
BEGIN
    INSERT INTO khu_vuc_nuoi (vi_tri, suc_chua_toi_da, trang_thai_hoat_dong, dien_tich, chieu_cao, loai_moi_truong) 
    VALUES (p_vi_tri, p_suc_chua_toi_da, p_trang_thai_hoat_dong, p_dien_tich, p_chieu_cao, p_loai_moi_truong); 
END //

CREATE PROCEDURE delete_khu_vuc_nuoi_theo_id(
    IN p_id_kv INT
)
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM khu_vuc_nuoi WHERE id_kv = p_id_kv
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Phiếu khu vực nuôi không tồn tại';
    END IF;
    
    DELETE FROM khu_vuc_nuoi WHERE id_kv = p_id_kv;
END //

CREATE PROCEDURE update_trang_thai_kv(
    IN p_id_kv INT, 
    IN p_trang_thai_hoat_dong VARCHAR(50)
)
BEGIN
    -- Kiểm tra xem ID có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM khu_vuc_nuoi WHERE id_kv = p_id_kv) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Khu vực nuôi với ID không tồn tại';
    END IF;
    
    -- Cập nhật trạng thái hoạt động
    UPDATE khu_vuc_nuoi
    SET trang_thai_hoat_dong = p_trang_thai_hoat_dong
    WHERE id_kv = p_id_kv;
END //

CREATE PROCEDURE get_all_ho_so_suc_khoe(
    IN offset INT,
    IN pageSize INT,
    IN searchId INT,
    IN searchName VARCHAR(255)
)
BEGIN
    SELECT h.id_hssk, 
           CASE
               WHEN n.so_luong IS NOT NULL THEN 1
               ELSE 0
           END AS loai,
           h.tinh_trang_suc_khoe, 
           h.chieu_cao, 
           h.can_nang,
           CASE
               WHEN n.so_luong IS NOT NULL THEN n.so_luong
               ELSE c.tuoi
           END AS tuoi_or_soluong,
           COALESCE(c.ten_khoa_hoc, n.ten_khoa_hoc, 'Tên khoa học không xác định') AS ten_khoa_hoc
    FROM ho_so_suc_khoe h
    LEFT JOIN ca_the c ON c.id_hssk = h.id_hssk
    LEFT JOIN nhom n ON n.id_hssk = h.id_hssk
    WHERE 
        (searchId IS NULL OR searchId = 0 OR h.id_hssk LIKE CONCAT('%', searchId, '%')) 
        AND (searchName IS NULL OR searchName = '' OR 
             COALESCE(c.ten_khoa_hoc COLLATE utf8mb4_unicode_ci, 
                      n.ten_khoa_hoc COLLATE utf8mb4_unicode_ci) 
             LIKE CONCAT('%', searchName, '%') COLLATE utf8mb4_unicode_ci)
    LIMIT offset, pageSize;
END//

CREATE PROCEDURE get_ho_so_suc_khoe_chi_tiet(IN id_hssk INT)
BEGIN
    SELECT  
        CONCAT(nv.ho, ' ', nv.ten) AS ten_thu_y, -- Tên thú y (kết hợp họ và tên)
        nv.cccd AS cccd_thu_y, -- CCCD của thú y
        h.id_hssk, 
        CASE
            WHEN n.so_luong IS NOT NULL THEN 1 -- Loại nhóm
            ELSE 0 -- Loại cá thể
        END AS loai,
        CASE 
            WHEN c.gioi_tinh = 'đực' THEN 0
            WHEN c.gioi_tinh = 'cái' THEN 1
            ELSE 2 -- Lưỡng tính
        END AS gioi_tinh_enum, -- Chuyển đổi giới tính thành enum
        h.tinh_trang_suc_khoe, 
        h.chieu_cao, 
        h.can_nang,

        -- Lịch sử điều trị dưới dạng mảng JSON
        (SELECT JSON_ARRAYAGG(
                JSON_OBJECT(
                    'id_lsdt', lsd.id_lsdt,
                    'trieu_chung', lsd.trieu_chung,
                    'chan_doan', lsd.chuan_doan,
                    'ket_qua', lsd.ket_qua,
                    'loai_thuoc', lsd.loai_thuoc,
                    'ghi_chu', lsd.ghi_chu
                )
            )
            FROM (
                SELECT DISTINCT id_lsdt, trieu_chung, chuan_doan, ket_qua, loai_thuoc, ghi_chu
                FROM lich_su_dieu_tri lsd
                WHERE lsd.id_hssk = h.id_hssk
            ) lsd
        ) AS lich_su_dieu_tri,

        -- Lịch sử tiêm chủng dưới dạng mảng JSON
        (SELECT JSON_ARRAYAGG(
                JSON_OBJECT(
                    'id_tc', lst.id_tc,
                    'ngay_tiem', lst.ngay_tiem_chung,
                    'phuong_phap_tiem', lst.phuong_phap_tiem,
                    'loai_vaccine', lst.loai_vaccine,
                    'lieu_luong', lst.lieu_luong,
                    'phan_ung_sau_tiem', lst.phan_ung_sau_tiem
                )
            )
            FROM (
                SELECT DISTINCT id_tc, ngay_tiem_chung, phuong_phap_tiem, loai_vaccine, lieu_luong, phan_ung_sau_tiem
                FROM lich_su_tiem_chung tc
                WHERE tc.id_hssk = h.id_hssk
            ) lst
        ) AS lich_su_tiem_chung

    FROM ho_so_suc_khoe h
    LEFT JOIN ca_the c ON c.id_hssk = h.id_hssk
    LEFT JOIN nhom n ON n.id_hssk = h.id_hssk
    LEFT JOIN nhan_vien nv ON nv.cccd = h.cccd 
    WHERE h.id_hssk = id_hssk;

END//

CREATE PROCEDURE create_lich_su_dieu_tri(
    IN p_ID_ho_so_suc_khoe INT,
    IN p_trieu_chung TEXT,
    IN p_chan_doan TEXT,
    IN p_ket_qua TEXT,
    IN p_loai_thuoc TEXT,
    IN p_ghi_chu TEXT
)
BEGIN
    INSERT INTO lich_su_dieu_tri (
        id_hssk,
        trieu_chung,
        chuan_doan,
        ket_qua,
        loai_thuoc,
        ghi_chu
    ) VALUES (
        p_ID_ho_so_suc_khoe,
        p_trieu_chung,
        p_chan_doan,
        p_ket_qua,
        p_loai_thuoc,
        p_ghi_chu
    );
END //

CREATE PROCEDURE create_lich_su_tiem_chung(
    IN p_ID_ho_so_suc_khoe INT,
    IN p_ngay_tiem DATE,
    IN p_phuong_phap_tiem TEXT,
    IN p_loai_vaccine TEXT,
    IN p_lieu_luong INT,
    IN p_phan_ung_sau_tiem TEXT
)
BEGIN
    -- Kiểm tra xem ID hồ sơ sức khỏe có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM ho_so_suc_khoe WHERE id_hssk = p_ID_ho_so_suc_khoe) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ID hồ sơ sức khỏe không tồn tại';
    ELSE
        -- Nếu tồn tại, thực hiện thêm mới lịch sử tiêm chủng
        INSERT INTO lich_su_tiem_chung (id_hssk, ngay_tiem_chung, phuong_phap_tiem, loai_vaccine, lieu_luong, phan_ung_sau_tiem) 
        VALUES (p_ID_ho_so_suc_khoe, p_ngay_tiem, p_phuong_phap_tiem, p_loai_vaccine, p_lieu_luong, p_phan_ung_sau_tiem);
    END IF;
END //

DELIMITER ;


-- get all phieu xuat dv
DELIMITER //
CREATE PROCEDURE get_all_phieu_xuat_dong_vat()
BEGIN
    -- Kiểm tra nếu bảng phieu_xuat_dong_vat không có dữ liệu
	IF (SELECT COUNT(*) FROM phieu_xuat_dong_vat) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Không có phiếu xuất động vật nào';
    END IF;

    -- Kiểm tra nếu bảng loai_dong_vat không có loài động vật
    IF (SELECT COUNT(*) FROM loai_dong_vat) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Không có loài động vật nào trong hệ thống';
    END IF;

    -- Kiểm tra nếu bảng nv_van_phong không có nhân viên văn phòng
    IF (SELECT COUNT(*) FROM nv_van_phong) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Không có nhân viên văn phòng nào';
    END IF;

    -- Lấy tất cả thông tin từ phieu_xuat_dong_vat
    SELECT
        px.id_px,
        px.ten_khoa_hoc,
        px.ngay_xuat,
        px.so_luong,
        px.ly_do_xuat,
        px.id_dt,
        nvv.cccd,  -- Sử dụng cccd từ bảng nv_van_phong
        -- Xác định loại dựa trên sự tồn tại trong bảng nhóm hoặc cá thể
        CASE
            WHEN EXISTS (SELECT 1 FROM nhom WHERE nhom.ten_khoa_hoc = px.ten_khoa_hoc) THEN 1
            WHEN EXISTS (SELECT 1 FROM ca_the WHERE ca_the.ten_khoa_hoc = px.ten_khoa_hoc) THEN 0
            ELSE 'None'
        END AS loai
    FROM phieu_xuat_dong_vat px
	LEFT JOIN loai_dong_vat ON px.ten_khoa_hoc = loai_dong_vat.ten_khoa_hoc
    LEFT JOIN nv_van_phong nvv ON px.cccd = nvv.cccd
    LEFT JOIN nhan_vien nv ON nvv.cccd = nv.cccd;
END //
DELIMITER ;

-- get chi tiet phieu xuat dong vat

DELIMITER //
CREATE PROCEDURE get_phieu_xuat_dong_vat_chi_tiet(
    IN p_id_px INT
)
BEGIN
    -- Kiểm tra xem id_px có tồn tại trong bảng phieu_xuat_dong_vat hay không
    DECLARE v_count INT;
    
    SELECT COUNT(*) INTO v_count
    FROM phieu_xuat_dong_vat
    WHERE id_px = p_id_px;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Phieu xuat dong vat khong ton tai';
    ELSE
        -- Lấy thông tin chi tiết phiếu xuất động vật
        SELECT 
            CONCAT(nv.ho, ' ', nv.ten) AS ten_nguoi_tao,  -- Kết hợp họ và tên
            nv.dia_chi AS address,
            nv.cccd,
            px.id_dt,
            dt.ten_doi_tac,
            ld.ten_khoa_hoc,
            ld.ten_loai,
            ld.do_quy_hiem,
            ld.loai_thuc_an,
            ld.loai_moi_truong_song,
            CASE
				WHEN EXISTS (SELECT 1 FROM nhom WHERE nhom.ten_khoa_hoc = px.ten_khoa_hoc) THEN 1
				WHEN EXISTS (SELECT 1 FROM ca_the WHERE ca_the.ten_khoa_hoc = px.ten_khoa_hoc) THEN 0
				ELSE 'None'
			END AS loai
        FROM phieu_xuat_dong_vat px
        JOIN nhan_vien nv ON px.cccd = nv.cccd
        JOIN loai_dong_vat ld ON px.ten_khoa_hoc = ld.ten_khoa_hoc
        JOIN doi_tac dt ON px.id_dt = dt.id_dt
        WHERE px.id_px = p_id_px;
    END IF;
END //
DELIMITER ;

-- tao phieu xuat dong vat 
DELIMITER //
CREATE PROCEDURE tao_phieu_xuat_dong_vat(
  IN ten_khoa_hoc VARCHAR(100),
  IN so_luong INT,
  IN ngay_xuat DATE,
  IN ly_do_xuat VARCHAR(255),
  IN id_doi_tac INT,
  IN cccd VARCHAR(12)
)
BEGIN
  -- Kiểm tra điều kiện `ten_khoa_hoc` có tồn tại trong bảng `loai_dong_vat`
  IF NOT EXISTS (SELECT 1 FROM loai_dong_vat WHERE ten_khoa_hoc = ten_khoa_hoc) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Tên khoa học không tồn tại trong bảng loai_dong_vat';
  END IF;

  -- Kiểm tra điều kiện `id_doi_tac` có tồn tại trong bảng `doi_tac`
  IF NOT EXISTS (SELECT 1 FROM doi_tac WHERE id_dt = id_doi_tac) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'ID đối tác không tồn tại trong bảng doi_tac';
  END IF;

  -- Kiểm tra điều kiện `cccd` có tồn tại trong bảng `nv_van_phong`
  IF NOT EXISTS (SELECT 1 FROM nv_van_phong WHERE cccd = cccd) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'CCCD không tồn tại trong bảng nv_van_phong';
  END IF;

  -- Kiểm tra các tham số đầu vào
  IF ten_khoa_hoc IS NULL OR ten_khoa_hoc = '' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Tên khoa học loài động vật không được để trống';
  END IF;

  IF so_luong <= 0 OR ngay_xuat IS NULL OR ly_do_xuat IS NULL OR ly_do_xuat = '' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Các tham số không hợp lệ hoặc thiếu thông tin';
  END IF;

  -- Tiến hành thêm phiếu xuất động vật
  INSERT INTO phieu_xuat_dong_vat (ngay_xuat, so_luong, ly_do_xuat, id_dt, ten_khoa_hoc, cccd)
  VALUES (ngay_xuat, so_luong, ly_do_xuat, id_doi_tac, ten_khoa_hoc, cccd);

  -- Trả về thông báo thành công
  SELECT 'Phiếu xuất động vật đã được tạo thành công!' AS message;
END//
DELIMITER ;


DROP PROCEDURE IF EXISTS get_nhom_info;
-- lay thong tin cua nhom
DELIMITER //
CREATE PROCEDURE get_nhom_info()
BEGIN
    SELECT DISTINCT ten_khoa_hoc
    FROM nhom;
END //
DELIMITER ;


-- lay thong tin cua ca the
DELIMITER //CREATE PROCEDURE get_ct_info()
BEGIN
    SELECT DISTINCT ten_khoa_hoc
    FROM ct;
END //
DELIMITER ;
-- lay thong tin cua doi tac
DELIMITER //CREATE PROCEDURE get_ten_doi_tac_info()
BEGIN
    SELECT ten_doi_tac,id_dt
    FROM doi_tac;
END //
DELIMITER ;



-- get cccd by nhan vien van phong
DELIMITER //
CREATE PROCEDURE get_cccd_by_vanphong(IN input_cccd VARCHAR(12))
BEGIN
  DECLARE cccd_found VARCHAR(12);

  -- Kiểm tra và lưu kết quả tìm thấy cccd
  SELECT cccd INTO cccd_found
  FROM nv_van_phong
  WHERE cccd = input_cccd;

  -- Nếu không tìm thấy, trả về thông báo lỗi hoặc giá trị NULL
  IF cccd_found IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'CCCD không tồn tại trong hệ thống';
  ELSE
    SELECT cccd_found AS cccd;
  END IF;
END//
DELIMITER ;


-- Hàm check số lượng xuat phai nho hon so luong cua nhom 
DELIMITER //
CREATE FUNCTION CheckSoluongnhomExportFunc(p_groupId INT, p_quantity INT) 
RETURNS VARCHAR(255)
READS SQL DATA
BEGIN
    DECLARE current_quantity INT;
    DECLARE result VARCHAR(255);

    SELECT so_luong INTO current_quantity
    FROM nhom
    WHERE id_n = p_groupId;

    IF current_quantity IS NULL THEN
        SET result = 'Nhóm không tồn tại!';
    ELSEIF p_quantity > current_quantity THEN
        SET result = 'Số lượng xuất vượt quá số lượng hiện có!';
    ELSE
        SET result = 'Có thể xuất!';
    END IF;

    RETURN result;
END;
//

DELIMITER ;

-- Check id nhom co thuoc loai_dong_vat ko (loai_dong_vat co id do ko)
DELIMITER //

CREATE FUNCTION CheckIdNhomExist(p_id_n INT, p_ten_khoa_hoc VARCHAR(100))
RETURNS VARCHAR(255)
READS SQL DATA
BEGIN
    DECLARE result VARCHAR(255);

    -- Kiểm tra sự tồn tại của id_n và ten_khoa_hoc trong bảng nhom
    SELECT COUNT(*) INTO result
    FROM nhom
    WHERE id_n = p_id_n AND ten_khoa_hoc = p_ten_khoa_hoc;

    -- Nếu có ít nhất 1 dòng dữ liệu trả về "Tồn tại", nếu không trả về "Không tồn tại"
    IF result > 0 THEN
        SET result = 'Tồn tại';
    ELSE
        SET result = 'Không tồn tại';
    END IF;

    RETURN result;
END //

DELIMITER ;

-- Check id ca_the có thuộc loai_dong_vat đó ko (check loai_dong_vat có id ca_the đó ko)

DELIMITER //

CREATE PROCEDURE CheckIdCtList(
    IN p_id_ct_list VARCHAR(255), -- Danh sách ID ca_the (dạng chuỗi, cách nhau bởi dấu phẩy)
    IN p_ten_khoa_hoc VARCHAR(100), -- Tên loài động vật
    OUT p_result TEXT -- Kết quả trả về
)
BEGIN
    DECLARE id_ct VARCHAR(50); -- Biến tạm để giữ từng ID ct
    DECLARE idx INT DEFAULT 1; -- Vị trí phần tử trong chuỗi
    DECLARE id_count INT DEFAULT 0; -- Số lượng ID ca_the hợp lệ
    DECLARE total_count INT DEFAULT 0; -- Tổng số lượng ID ca_the trong danh sách
    DECLARE result_text TEXT DEFAULT ''; -- Kết quả kiểm tra từng ID

    -- Tính tổng số lượng ID ca_the trong danh sách
    SET total_count = LENGTH(p_id_ct_list) - LENGTH(REPLACE(p_id_ct_list, ',', '')) + 1;

    -- Tách danh sách ID ca_the và kiểm tra từng ID
    WHILE idx <= total_count DO
        -- Lấy ID ca_the hiện tại từ danh sách, tách theo dấu phẩy
        SET id_ct = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(p_id_ct_list, ',', idx), ',', -1));
        
        -- Kiểm tra ID ca_the có thuộc loài động vật không
        SET id_count = (
            SELECT COUNT(*)
            FROM ct
            WHERE ca_the.id_ct = id_ct AND ca_the.ten_khoa_hoc = p_ten_khoa_hoc
        );

        -- Thêm kết quả kiểm tra vào chuỗi kết quả
        IF id_count > 0 THEN
            SET result_text = CONCAT(result_text, id_ct, ': Tồn tại\n');
        ELSE
            SET result_text = CONCAT(result_text, id_ct, ': Không tồn tại\n');
        END IF;

        -- Tăng vị trí
        SET idx = idx + 1;
    END WHILE;

    -- Gán chuỗi kết quả vào biến OUT
    SET p_result = result_text;
END //

DELIMITER ;

-- ---------------------------------------------------------------------- Insert dữ liệu --
INSERT INTO loai_dong_vat 
(ten_khoa_hoc, ten_loai, do_quy_hiem, loai_thuc_an, thoi_gian_chu_ki, thoi_gian_mang_thai, so_luong, loai_moi_truong_song) 
VALUES
('Panthera_tigris', 'Hổ', 'Nguy cấp', 'ăn thịt', 3, 4, 0, 'trên cạn'),
('Elephas_maximus', 'Voi', 'Nguy cấp', 'ăn cỏ', 6, 22, 0, 'trên cạn'),
('Python_molurus', 'Trăn gấm', 'Nguy cấp', 'ăn thịt', 2, 3, 0, 'trên cạn'),
('Ailuropoda_melanoleuca', 'Gấu trúc', 'Dễ bị tổn thương', 'ăn tạp', 2, 5, 0, 'trên cạn'),
('Spheniscus_demersus', 'Chim cánh cụt', 'Nguy cấp', 'ăn thịt', 1, 2, 0, 'dưới nước'),
('Equus_quagga', 'Ngựa vằn', 'Không nguy cấp', 'ăn cỏ', 2, 12, 0, 'trên cạn'),
('Giraffa_camelopardalis', 'Hươu cao cổ', 'Không nguy cấp', 'ăn cỏ', 3, 15, 0, 'trên cạn');

INSERT INTO san_moi (ten_khoa_hoc_cm, ten_khoa_hoc_sm) 
VALUES
('Spheniscus_demersus', 'Panthera_tigris'), -- Hổ săn Chim cánh cụt
('Ailuropoda_melanoleuca', 'Panthera_tigris'), -- Hổ săn Gấu trúc
('Giraffa_camelopardalis', 'Panthera_tigris'), -- Hổ săn Hươu cao cổ
('Panthera_tigris', 'Python_molurus'), -- Trăn săn Hổ
('Ailuropoda_melanoleuca', 'Python_molurus'), -- Trăn săn Gấu trúc
('Spheniscus_demersus', 'Ailuropoda_melanoleuca'); -- Gấu trúc săn Chim cánh cụt

INSERT INTO khu_vuc_nuoi (vi_tri, suc_chua_toi_da, trang_thai_hoat_dong, dien_tich, chieu_cao, loai_moi_truong) 
VALUES
('Khu vực A', 40, 'sử dụng', 100, 10, 'trên cạn'),
('Khu vực B', 60, 'sử dụng', 200, 12, 'trên cạn'),
('Khu vực C', 50, 'sử dụng', 300, 15, 'cả hai'),
('Khu vực D', 40, 'sử dụng', 50, 8, 'trên cạn'),
('Khu vực E', 40, 'sử dụng', 120, 10, 'dưới nước'),
('Khu vực F', 50, 'sử dụng', 150, 9, 'dưới nước');

INSERT INTO nhan_vien (cccd, ho, ten, dia_chi, loai_cong_viec) VALUES
('123456789001', 'Nguyễn Văn', 'An', '123 Đường A, TP.HCM', 'văn phòng'),
('123456789002', 'Trần Minh', 'Bình', '456 Đường B, TP.HCM', 'văn phòng'),
('123456789003', 'Lê Quang', 'Cương', '789 Đường C, TP.HCM', 'thú y'),
('123456789004', 'Phạm Thị', 'Dung', '101 Đường D, TP.HCM', 'thú y'),
('123456789005', 'Hồ Thi', 'E', '202 Đường E, TP.HCM', 'chăm sóc'),
('123456789006', 'Võ Phúc', 'Hoàng', '303 Đường F, TP.HCM', 'chăm sóc'),
('123456789007', 'Nguyễn Thị', 'An', '123 Đường A, TP.HCM', 'văn phòng'),
('123456789008', 'Trần Quang', 'Bình', '456 Đường B, TP.HCM', 'văn phòng'),
('123456789009', 'Lê Minh', 'Cương', '789 Đường C, TP.HCM', 'thú y'),
('123456789010', 'Phạm Thị', 'Dung', '101 Đường D, TP.HCM', 'thú y'),
('123456789011', 'Hồ Thị', 'E', '202 Đường E, TP.HCM', 'chăm sóc'),
('123456789012', 'Võ Minh', 'Phúc', '303 Đường F, TP.HCM', 'chăm sóc');


INSERT INTO nhan_vien_sdt (cccd, so_dien_thoai) VALUES
('123456789001', '0901234567'),
('123456789001', '0911234567'),
('123456789002', '0902234567'),
('123456789003', '0903234567'),
('123456789004', '0904234567'),
('123456789005', '0905234567'),
('123456789006', '0906234567'),
('123456789007', '0907234567'),
('123456789008', '0908234567'),
('123456789009', '0909234567'),
('123456789010', '0910234567'),
('123456789011', '0911234567'),
('123456789012', '0912234567');

INSERT INTO nv_van_phong (cccd, bang_cap) VALUES
('123456789001', 'Cử nhân Quản trị Kinh doanh'),
('123456789002', 'Cử nhân Tài chính Kế toán'),
('123456789007', 'Cử nhân Quản trị Kinh doanh'),
('123456789008', 'Cử nhân Tài chính Kế toán');

INSERT INTO nv_thu_y (cccd, gphn, nam_kinh_nghiem) VALUES
('123456789003', 'Giấy phép hành nghề thú y số 12345', 5),
('123456789004', 'Giấy phép hành nghề thú y số 67890', 8),
('123456789009', 'Giấy phép hành nghề thú y số 12345', 5),
('123456789010', 'Giấy phép hành nghề thú y số 67890', 8);

INSERT INTO nv_cham_soc (cccd, chung_nhan_csdv) VALUES
('123456789005', 'Chứng nhận chăm sóc động vật số A123'),
('123456789006', 'Chứng nhận chăm sóc động vật số B456'),
('123456789011', 'Chứng nhận chăm sóc động vật số A123'),
('123456789012', 'Chứng nhận chăm sóc động vật số B456');


-- Bảng ho_so_suc_khoe
INSERT INTO ho_so_suc_khoe (cccd, tinh_trang_suc_khoe, chieu_cao, can_nang)
VALUES
('123456789003', 'Tốt', 175, 68),
('123456789003', 'Yếu', 160, 50),
('123456789004', 'Khá', 180, 75),
('123456789004', 'Tốt', 172, 70),
('123456789009', 'Khá', 165, 62),
('123456789009', 'Yếu', 160, 55),
('123456789010', 'Khá', 170, 68),
('123456789010', 'Tốt', 175, 72),
('123456789004', 'Khá', 178, 74),
('123456789004', 'Tốt', 182, 78),
('123456789003', 'Yếu', 165, 60),
('123456789009', 'Khá', 180, 76),
('123456789010', 'Tốt', 185, 80);

-- Bảng lich_su_dieu_tri
INSERT INTO lich_su_dieu_tri (id_hssk, trieu_chung, chuan_doan, ket_qua, loai_thuoc, ghi_chu)
VALUES
(1, 'Sốt', 'Cảm cúm', 'Khỏi', 'Paracetamol', 'Theo dõi nhiệt độ'),
(2, 'Đau đầu', 'Huyết áp cao', 'Ổn định', 'Thuốc hạ áp', 'Đo huyết áp thường xuyên'),
(3, 'Buồn nôn', 'Rối loạn tiêu hóa', 'Khỏi', 'Thuốc kháng sinh', 'Ăn uống lành mạnh'),
(3, 'Đau bụng', 'Viêm ruột', 'Ổn định', 'Thuốc kháng viêm', 'Kiểm tra định kỳ');

-- Bảng lich_su_tiem_chung
INSERT INTO lich_su_tiem_chung (id_hssk, ngay_tiem_chung, phuong_phap_tiem, loai_vaccine, lieu_luong, phan_ung_sau_tiem)
VALUES
(1, '2024-01-01', 'Tiêm dưới da', 'Vaccine dại', 1, 'Không có phản ứng'),
(2, '2024-02-15', 'Tiêm bắp', 'Vaccine ho gà', 2, 'Đau nhẹ tại chỗ tiêm'),
(3, '2024-03-20', 'Tiêm bắp', 'Vaccine sởi', 1, 'Không có phản ứng'),
(2, '2024-04-05', 'Tiêm dưới da', 'Vaccine bạch hầu', 2, 'Sưng nhẹ tại chỗ tiêm');

-- Bảng che_do_dinh_duong
INSERT INTO che_do_dinh_duong (id_hssk, cccd, hlddtt, luong_nuoc, bua_an)
VALUES
    (1, '123456789003', 2500, 2000, 3),
    (2, '123456789003', 2000, 1500, 3),
    (3, '123456789004', 2700, 2500, 4),
    (2, '123456789004', 2300, 1800, 3);

-- Bảng thuc_pham_can_tranh
INSERT INTO thuc_pham_can_tranh (id_hssk, id_cddd, thuc_pham_can_tranh)
VALUES
    (1, 1, 'Chocolate'),
    (2, 2, 'Nho khô'),
    (3, 3, 'Hành tây'),
    (2, 4, 'Tỏi');

-- Bảng khau_phan_an
INSERT INTO khau_phan_an (loai_dong_vat_an, ten_khau_phan, id_cddd, thoi_gian_an)
VALUES
    ('ăn thịt', 'Khẩu phần 1', 1, 'Buổi sáng'),
    ('ăn cỏ', 'Khẩu phần 2', 2, 'Buổi trưa'),
    ('ăn tạp', 'Khẩu phần 3', 3, 'Buổi chiều'),
    ('ăn thịt', 'Khẩu phần 4', 4, 'Buổi sáng');

-- Bảng qua_trinh_cho_an
INSERT INTO qua_trinh_cho_an (id_kpa, id_kv, cccd, ngay)
VALUES
    (1, 1, '123456789005', '2024-05-01'),
    (2, 2, '123456789005', '2024-05-02'),
    (3, 3, '123456789005', '2024-05-03'),
    (4, 4, '123456789005', '2024-05-04');
    
INSERT INTO thuc_an (ten_thuc_an, ham_luong_dinh_duong, ngay_het_han, so_luong)
VALUES
    ('Rau củ', 25.5, '2024-12-31', 100),
    ( 'Ức ga', 30.0, '2024-11-30', 80),
    ('Ức gà', 15.5, '2025-01-15', 50),
    ('Ức gà', 20.0, '2024-10-20', 120);

-- Bảng kpa_thuc_an
INSERT INTO kpa_thuc_an (id_kpa, id_ta, so_luong)
VALUES
    (1, 1, 10),
    (2, 2, 15),
    (3, 3, 8),
    (4, 4, 12);

-- Bảng doi_tac
INSERT INTO doi_tac (ten_doi_tac, loai_doi_tac)
VALUES
    ('Công ty Thực phẩm ABC', 'cung cấp thức ăn'),
    ('Nhà cung cấp XYZ' , 'cung cấp thức ăn'),
    ('Trang trại Bình Minh', 'cung cấp thức ăn'),
    ('Công ty Nông nghiệp Xanh', 'cung cấp thức ăn'),
    ('Sở thú ABC', 'sở thú'),
    ('Sở thú XYZ' , 'sở thú'),
    ('Sở thú DEF', 'sở thú'),
    ('Sở thú GHK', 'sở thú'),
    ('Viện nghiên cứu ABC', 'viện nghiên cứu'),
    ('Viện nghiên cứu XYZ' , 'viện nghiên cứu'),
    ('Viện nghiên cứu Bình Minh', 'viện nghiên cứu'),
    ('Viện nghiên cứu Xanh', 'viện nghiên cứu');

-- Bảng doi_tac_lien_he
INSERT INTO doi_tac_lien_he (id_dt, dia_chi, sdt, email)
VALUES
    (1, '123 Đường A, Quận 1, TP.HCM', '0912345678', 'abc@company.com'),
    (2, '456 Đường B, Quận 2, TP.HCM', '0923456789', 'xyz@supplier.com'),
    (3, '789 Đường C, Hà Nội', '0934567890', 'binhminh@farm.vn'),
    (4, '321 Đường D, Đà Nẵng', '0945678901', 'nongnghiepxanh@green.vn');

-- Bảng dt_cung_cap_thuc_an
INSERT INTO dt_cung_cap_thuc_an (id_dt, gioi_han_dat_hang)
VALUES
    (1, 500),
    (2, 300),
    (3, 200),
    (4, 400);

-- Bảng ccta_chung_nhan_attp
INSERT INTO ccta_chung_nhan_attp (id_dt, chung_nhan_attp)
VALUES
    (1, 'Giấy chứng nhận số 12345'),
    (2, 'Giấy chứng nhận số 67890'),
    (3, 'Giấy chứng nhận số 54321'),
    (4, 'Giấy chứng nhận số 98765');

-- Bảng dt_so_thu
INSERT INTO dt_so_thu (id_dt, loai_hinh_so_thu)
VALUES
    (5, 'Sở thú truyền thông'),
    (6, 'Công viên Safari'),
    (7, 'Vườn thú mở'),
    (8, 'Sở thú chuyên biệt');

INSERT INTO st_chuong_trinh_bao_ton (id_dt, chuong_trinh_bao_ton)
VALUES
(5, 'Bảo tồn tài nguyên biển và hải đảo'),
(6, 'Bảo tồn di tích và kiến trúc cổ'),
(7, 'Bảo tồn các loài thực vật quý hiếm'),
(8, 'Bảo vệ môi trường và giảm thiểu ô nhiễm không khí');
    
INSERT INTO dt_vien_nghien_cuu (id_dt, linh_vuc_nghien_cuu) VALUES
	(9, 'Công nghệ sinh học'),
	(10, 'Hóa học môi trường'),
	(11, 'Kỹ thuật di truyền'),
	(12, 'Sinh thái học');

-- 6 phiếu nhập động vật
INSERT INTO phieu_nhap (ngay_nhap, so_luong, loai_phieu_nhap, cccd) VALUES
('2024-12-01', 1, 'phiếu nhập động vật', '123456789001'),
('2024-12-01', 1, 'phiếu nhập động vật', '123456789001'),
('2024-12-01', 1, 'phiếu nhập động vật', '123456789001'),
('2024-12-02', 1, 'phiếu nhập động vật', '123456789001'),
('2024-12-03', 20, 'phiếu nhập động vật', '123456789001'),
('2024-12-04', 1, 'phiếu nhập động vật', '123456789002'),
('2024-12-04', 1, 'phiếu nhập động vật', '123456789002'),
('2024-12-04', 1, 'phiếu nhập động vật', '123456789002'),
('2024-12-05', 20, 'phiếu nhập động vật', '123456789002'),
('2024-12-05', 20, 'phiếu nhập động vật', '123456789001'),
('2024-12-06', 20, 'phiếu nhập động vật', '123456789002'),
('2024-12-06', 1, 'phiếu nhập động vật', '123456789002'),
('2024-12-06', 1, 'phiếu nhập động vật', '123456789002');

-- 6 phiếu nhập thức ăn
INSERT INTO phieu_nhap (ngay_nhap, so_luong, loai_phieu_nhap, cccd) VALUES
('2024-12-07', 200, 'phiếu nhập thức ăn', '123456789001'),
('2024-12-08', 150, 'phiếu nhập thức ăn', '123456789001'),
('2024-12-09', 180, 'phiếu nhập thức ăn', '123456789001'),
('2024-12-10', 220, 'phiếu nhập thức ăn', '123456789002'),
('2024-12-11', 160, 'phiếu nhập thức ăn', '123456789002'),
('2024-12-12', 210, 'phiếu nhập thức ăn', '123456789002');

-- Dữ liệu cho các phiếu nhập động vật
INSERT INTO phieu_nhap_dong_vat (id_pn, ly_do_nhap, id_dt, ten_khoa_hoc) VALUES
(1, 'Nhập khẩu động vật cho sở thú', 5, 'Panthera_tigris'),
(2, 'Nhập khẩu động vật cho sở thú', 5, 'Panthera_tigris'),
(3, 'Nhập khẩu động vật cho sở thú', 5, 'Panthera_tigris'),
(4, 'Nhập khẩu động vật cho sở thú', 8, 'Ailuropoda_melanoleuca'),
(5, 'Nhập khẩu động vật cho sở thú', 5, 'Giraffa_camelopardalis'),
(6, 'Nhập khẩu động vật cho sở thú', 6, 'Elephas_maximus'),
(7, 'Nhập khẩu động vật cho sở thú', 6, 'Elephas_maximus'),
(8, 'Nhập khẩu động vật cho sở thú', 6, 'Elephas_maximus'),
(9, 'Nhập khẩu động vật cho sở thú', 5, 'Giraffa_camelopardalis'),
(10, 'Nhập khẩu động vật cho sở thú', 5, 'Equus_quagga'),
(11, 'Nhập khẩu động vật cho sở thú', 7, 'Spheniscus_demersus'),
(12, 'Nhập khẩu động vật cho sở thú', 6, 'Python_molurus'),
(13, 'Nhập khẩu động vật cho sở thú', 6, 'Python_molurus');


-- Dữ liệu cho các phiếu nhập thức ăn
INSERT INTO phieu_nhap_thuc_an (id_pn, nguon_goc_xuat_xu, id_dt, id_ta) VALUES
(14, 'Việt Nam', 2, 1),
(15, 'Thái Lan', 2, 2),
(16, 'Malaysia', 2, 3),
(17, 'Indonesia', 2, 4),
(18, 'Campuchia', 2, 2),
(19, 'Lào', 2, 3);

INSERT INTO ca_the (id_kv, id_hssk, ten_khoa_hoc, id_ct_cha, ten_khoa_hoc_cha, id_ct_me, ten_khoa_hoc_me, tuoi, adn, gioi_tinh, trang_thai) VALUES
(1, 1, 'Panthera_tigris', NULL, NULL, NULL, NULL, 6, 'ADN001', 'đực', 'cho thuê'),
(1, 2, 'Panthera_tigris', NULL, NULL, NULL, NULL, 5, 'ADN002', 'cái', 'còn sống'),
(2, 3, 'Elephas_maximus', NULL, NULL, NULL, NULL, 10, 'ADN004', 'cái', 'còn sống'),
(2, 4, 'Elephas_maximus', NULL, NULL, NULL, NULL, 15, 'ADN005', 'đực', 'cho thuê'),
(4, 5, 'Python_molurus', NULL, NULL, NULL, NULL, 3, 'ADN007', 'cái', 'cho thuê'),
(4, 6, 'Python_molurus', NULL, NULL, NULL, NULL, 8, 'ADN008', 'đực', 'còn sống'),
(2, 7, 'Ailuropoda_melanoleuca', NULL, NULL, NULL, NULL, 6, 'ADN009', 'cái', 'cho thuê');


INSERT INTO ca_the (id_kv, id_hssk, ten_khoa_hoc, id_ct_cha, ten_khoa_hoc_cha, id_ct_me, ten_khoa_hoc_me, tuoi, adn, gioi_tinh, trang_thai) VALUES
(1, 8, 'Panthera_tigris', 1, 'Panthera_tigris', 2, 'Panthera_tigris', 1, 'ADN003', 'đực', 'còn sống'),
(2, 9, 'Elephas_maximus', 4, 'Elephas_maximus', 5, 'Elephas_maximus', 2, 'ADN006', 'đực', 'còn sống');

INSERT INTO nhom (id_kv, id_hssk, ten_khoa_hoc, so_luong)
VALUES
(6, 10,  'Spheniscus_demersus', 10),
(2, 11,  'Giraffa_camelopardalis', 15),
(2, 12,  'Giraffa_camelopardalis', 12),
(2, 13,  'Equus_quagga', 12);

INSERT INTO cho_thue (id_dt, id_ct, ten_khoa_hoc, thoi_han) VALUES
(5, 1, 'Panthera_tigris', 12),
(6, 4, 'Elephas_maximus', 24),
(7, 5, 'Python_molurus', 18),
(8, 7, 'Ailuropoda_melanoleuca', 36);

INSERT INTO phieu_xuat_dong_vat(ngay_xuat, so_luong, ly_do_xuat, id_dt, ten_khoa_hoc, cccd)
VALUES
('2024-12-01', 5, 'Xuất bán thương mại', 6, 'Giraffa_camelopardalis', '123456789001'),
('2024-12-01', 8, 'Xuất bán thương mại', 6, 'Giraffa_camelopardalis', '123456789001'),
('2024-12-01', 8, 'Xuất bán thương mại', 6, 'Equus_quagga', '123456789001'),
('2024-12-01', 1, 'Cho thuê', 6, 'Ailuropoda_melanoleuca', '123456789002'),
('2024-12-01', 10, 'Xuất bán thương mại', 6, 'Spheniscus_demersus', '123456789001');

INSERT INTO mau_vat (ten_mau, loai_mau, tinh_trang_mau, ngay_thu_thap, ten_khoa_hoc, id_ct, id_dt) VALUES
('Lông hổ', 'Lông', 'Tốt', '2024-01-15', 'Panthera_tigris', 1, 9),
('Ngà voi', 'Xương', 'Tốt', '2024-02-10', 'Elephas_maximus', 3, 10),
('Vảy trăn', 'Vảy', 'Tốt', '2024-03-05', 'Python_molurus', 5, NULL),
('Lông gấu trúc', 'Lông', 'Tốt', '2024-04-18', 'Ailuropoda_melanoleuca', 7, 10),
('Xương hổ', 'Xương', 'Đang phân hủy', '2024-08-12', 'Panthera_tigris', 2, 9),
('Ngà voi nhỏ', 'Xương', 'Tốt', '2024-09-01', 'Elephas_maximus', 4, 11);