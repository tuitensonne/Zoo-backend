USE TRIG;
-- get all phieu xuat dv
DROP PROCEDURE IF EXISTS get_all_phieu_xuat_dong_vat;
DELIMITER $$
CREATE PROCEDURE get_all_phieu_xuat_dong_vat()
BEGIN
    -- Kiểm tra nếu bảng phieu_xuat_dong_vat không có dữ liệu
	IF (SELECT COUNT(*) FROM phieu_xuat_dong_vat) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Không có phiếu xuất động vật nào';
    END IF;

    -- Kiểm tra nếu bảng ldv không có loài động vật
    IF (SELECT COUNT(*) FROM ldv) = 0 THEN
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
            WHEN EXISTS (SELECT 1 FROM ct WHERE ct.ten_khoa_hoc = px.ten_khoa_hoc) THEN 0
            ELSE 'None'
        END AS loai
    FROM phieu_xuat_dong_vat px
	LEFT JOIN ldv ON px.ten_khoa_hoc = ldv.ten_khoa_hoc
    LEFT JOIN nv_van_phong nvv ON px.cccd = nvv.cccd
    LEFT JOIN nhan_vien nv ON nvv.cccd = nv.cccd;
END $$

DELIMITER ;







-- get chi tiet phieu xuat dong vat

-- CALL get_all_phieu_xuat_dong_vat();
DROP PROCEDURE IF EXISTS get_phieu_xuat_dong_vat_chi_tiet;
DELIMITER $$

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
				WHEN EXISTS (SELECT 1 FROM ct WHERE ct.ten_khoa_hoc = px.ten_khoa_hoc) THEN 0
				ELSE 'None'
			END AS loai
        FROM phieu_xuat_dong_vat px
        JOIN nhan_vien nv ON px.cccd = nv.cccd
        JOIN ldv ld ON px.ten_khoa_hoc = ld.ten_khoa_hoc
        JOIN doi_tac dt ON px.id_dt = dt.id_dt
        WHERE px.id_px = p_id_px;
    END IF;
END $$

DELIMITER ;

-- CALL get_phieu_xuat_dong_vat_chi_tiet(1);



DROP PROCEDURE IF EXISTS tao_phieu_xuat_dong_vat;
-- tao phieu xuat dong vat 
DELIMITER $$

CREATE PROCEDURE tao_phieu_xuat_dong_vat(
  IN ten_khoa_hoc VARCHAR(100),
  IN so_luong INT,
  IN ngay_xuat DATE,
  IN ly_do_xuat VARCHAR(255),
  IN id_doi_tac INT,
  IN cccd VARCHAR(12)
)
BEGIN
  -- Kiểm tra điều kiện ten_khoa_hoc có tồn tại trong bảng ldv
  IF NOT EXISTS (SELECT 1 FROM ldv WHERE ten_khoa_hoc = ten_khoa_hoc) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Tên khoa học không tồn tại trong bảng ldv';
  END IF;

  -- Kiểm tra điều kiện id_doi_tac có tồn tại trong bảng doi_tac
  IF NOT EXISTS (SELECT 1 FROM doi_tac WHERE id_dt = id_doi_tac) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'ID đối tác không tồn tại trong bảng doi_tac';
  END IF;

  -- Kiểm tra điều kiện cccd có tồn tại trong bảng nv_van_phong
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
END$$

DELIMITER ;


DROP PROCEDURE IF EXISTS get_nhom_info;
-- lay thong tin cua nhom
DELIMITER $$

CREATE PROCEDURE get_nhom_info()
BEGIN
    SELECT DISTINCT ten_khoa_hoc
    FROM nhom;
END $$

DELIMITER ;


DROP PROCEDURE IF EXISTS get_ct_info;
-- lay thong tin cua ca the
DELIMITER $$
CREATE PROCEDURE get_ct_info()
BEGIN
    SELECT DISTINCT ten_khoa_hoc
    FROM ct;
END $$

DELIMITER ;

DROP PROCEDURE IF EXISTS get_ten_doi_tac_info;
-- lay thong tin cua doi tac
DELIMITER $$
CREATE PROCEDURE get_ten_doi_tac_info()
BEGIN
    SELECT ten_doi_tac,id_dt
    FROM doi_tac;
END $$

DELIMITER ;
CALL get_ten_doi_tac_info;



-- get cccd by nhan vien van phong
DROP PROCEDURE IF EXISTS get_cccd_by_vanphong;
DELIMITER $$

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
END$$

DELIMITER ;

-- CALL get_cccd_by_vanphong('012345678901');


DROP FUNCTION IF EXISTS CheckSoluongnhomExportFunc;
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

-- Check id nhom co thuoc ldv ko (ldv co id do ko)
DROP FUNCTION IF EXISTS CheckIdNhomExist;
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

SELECT CheckIdNhomExist(2, 'Crocodylus porosus');

-- Check id ct có thuộc ldv đó ko (check ldv có id ct đó ko)


DROP PROCEDURE IF EXISTS CheckIdCtList;
DELIMITER //

CREATE PROCEDURE CheckIdCtList(
    IN p_id_ct_list VARCHAR(255), -- Danh sách ID ct (dạng chuỗi, cách nhau bởi dấu phẩy)
    IN p_ten_khoa_hoc VARCHAR(100), -- Tên loài động vật
    OUT p_result TEXT -- Kết quả trả về
)
BEGIN
    DECLARE id_ct VARCHAR(50); -- Biến tạm để giữ từng ID ct
    DECLARE idx INT DEFAULT 1; -- Vị trí phần tử trong chuỗi
    DECLARE id_count INT DEFAULT 0; -- Số lượng ID ct hợp lệ
    DECLARE total_count INT DEFAULT 0; -- Tổng số lượng ID ct trong danh sách
    DECLARE result_text TEXT DEFAULT ''; -- Kết quả kiểm tra từng ID

    -- Tính tổng số lượng ID ct trong danh sách
    SET total_count = LENGTH(p_id_ct_list) - LENGTH(REPLACE(p_id_ct_list, ',', '')) + 1;

    -- Tách danh sách ID ct và kiểm tra từng ID
    WHILE idx <= total_count DO
        -- Lấy ID ct hiện tại từ danh sách, tách theo dấu phẩy
        SET id_ct = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(p_id_ct_list, ',', idx), ',', -1));
        
        -- Kiểm tra ID ct có thuộc loài động vật không
        SET id_count = (
            SELECT COUNT(*)
            FROM ct
            WHERE ct.id_ct = id_ct AND ct.ten_khoa_hoc = p_ten_khoa_hoc
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

CALL CheckIdCtList('1,2,3', 'Panthera leo', @result);
SELECT @result;

-- Giả sử bạn có nhóm có id_n = 1 và so_luong = 10
-- SELECT CheckSoluongnhomExportFunc(1, 15);  -- Gửi vào số lượng xuất là 15, lớn hơn so_luong của nhóm (10)

DELIMITER $$

CREATE PROCEDURE GetSoLuongLdv(IN ten_khoa_hoc_input VARCHAR(100), OUT so_luong INT)
BEGIN
    -- Lấy số lượng từ bảng ldv dựa trên ten_khoa_hoc
    SELECT so_luong 
    INTO so_luong 
    FROM ldv 
    WHERE ten_khoa_hoc = ten_khoa_hoc_input;
    
    -- Nếu không tìm thấy, trả về 0 hoặc giá trị mặc định
    IF so_luong IS NULL THEN
        SET so_luong = 0;
    END IF;
END$$

DELIMITER ;