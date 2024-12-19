--procedure chuyển hàng, được demo trên ch2.KHOHS_QLKHO và ch2.KHOHS_NVBH

--Procedure thực hiện việc chuyển hàng trong kho của cửa hàng từ cửa hàng này sang cửa 
--hàng khác. Ở tài khoản của cửa hàng hiện tại, ta nhập vào mã của của hàng sẽ nhận sản 
--phẩm chuyển, nhập mã sản phẩm cần chuyển, số lượng chuyển.

CREATE OR REPLACE PROCEDURE CHUYEN_HANG( 
    P_MAHS IN VARCHAR2, 
    P_MACH_DESTINATION IN VARCHAR2, 
    P_SOLUONG_CHUYEN IN NUMBER 
) 
IS 
    V_SO_LUONG_HIENTAI NUMBER; 
    V_SO_LUONG_DESTINATION NUMBER; 
    V_COUNT_DESTINATION NUMBER; 
    V_CHECK_SO_LUONG NUMBER; 
BEGIN 
    -- Kiểm tra số lượng chuyển 
    IF P_SOLUONG_CHUYEN <= 0 THEN 
        DBMS_OUTPUT.PUT_LINE('So luong chuyen phai lon hon 0'); 
        RETURN; 
    END IF; 

    -- Kiểm tra xem cặp khóa chính MACH, MAHS có tồn tại trong bảng KHOHS_QLKHO không 
    BEGIN 
        SELECT SoLuong INTO V_SO_LUONG_HIENTAI 
        FROM ch2.KHOHS_QLKHO 
        WHERE MAHS = P_MAHS; 

    EXCEPTION 
        WHEN NO_DATA_FOUND THEN 
            -- Xuất lỗi nếu không tìm thấy dữ liệu ở cửa hàng hiện tại 
            DBMS_OUTPUT.PUT_LINE('Co loi voi Ma Cua Hang, Ma Hai San can chuyen.'); 
            RETURN; 
    END; 
  

    -- Nếu tồn tại, kiểm tra xem có đủ số lượng để chuyển không 
    IF V_SO_LUONG_HIENTAI >= P_SOLUONG_CHUYEN THEN 

        -- Kiểm tra xem MACH_destination có tồn tại trong bảng CUAHANG không 
        SELECT COUNT(*) INTO V_COUNT_DESTINATION 
	FROM (	SELECT * 
		FROM ch1.CUAHANG
		UNION ALL
		SELECT * 
		FROM ch2.CUAHANG@ch2_dblink)
	WHERE MACH = P_MACH_DESTINATION;

  
        IF V_COUNT_DESTINATION > 0 THEN 
           -- Kiểm tra xem cặp khóa chính MACH_destination, MAHS có tồn tại không 
            BEGIN 
                SELECT SoLuong INTO V_SO_LUONG_DESTINATION 
                FROM ch2.KHOHS_QLKHO@ch2_dblink 
                WHERE MACH = P_MACH_DESTINATION AND MAHS = P_MAHS; 

            EXCEPTION 
                WHEN NO_DATA_FOUND THEN 
                    -- Nếu không tìm thấy dữ liệu ở cửa hàng đích, thêm mới vào cửa hàng đích 
                    INSERT INTO ch2.KHOHS_QLKHO@ch2_dblink (MACH, MAHS, SoLuong, NgayCapNhat) 
                    VALUES (P_MACH_DESTINATION, P_MAHS, 0, SYSDATE); 
            END; 

  
            -- Cập nhật số lượng ở cả hai cửa hàng 
            UPDATE ch2.KHOHS_QLKHO@ch2_dblink 
            SET SoLuong = SoLuong + P_SOLUONG_CHUYEN, NgayCapNhat = SYSDATE 
            WHERE MACH = P_MACH_DESTINATION AND MAHS = P_MAHS; 
            COMMIT; 


            UPDATE ch2.KHOHS_QLKHO 
            SET SoLuong = SoLuong - P_SOLUONG_CHUYEN, NgayCapNhat = SYSDATE 
            WHERE MAHS = P_MAHS; 
            COMMIT; 

            -- Thông báo chuyển hàng thành công 
            DBMS_OUTPUT.PUT_LINE('Chuyen hang thanh cong'); 
        ELSE 
            -- Xuất lỗi nếu không tồn tại cửa hàng đích 
            DBMS_OUTPUT.PUT_LINE('Khong ton tai cua hang dich trong danh sach cua hang'); 
        END IF; 

    ELSE 
        -- Thông báo không đủ số lượng để chuyển 
        DBMS_OUTPUT.PUT_LINE('Khong du so luong hang de chuyen'); 
    END IF; 

EXCEPTION 
    WHEN OTHERS THEN 
        -- Xử lý ngoại lệ 
        DBMS_OUTPUT.PUT_LINE('Co loi xay ra: ' || SQLERRM); 

END CHUYEN_HANG; 
/ 



