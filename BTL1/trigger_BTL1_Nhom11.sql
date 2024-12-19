--trigger demo on ch2.KHOHS_QLKHO

CREATE OR REPLACE TRIGGER TG_Insert_Update_KHOHS_QLKHO
AFTER INSERT OR UPDATE OF SoLuong
ON ch2.KHOHS_QLKHO
FOR EACH ROW 
BEGIN
    IF :NEW.SoLuong < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Error: So luong nho hon 0.');
        ROLLBACK;
    END IF;

    CASE
        WHEN UPDATING ('SoLuong') THEN
            IF(:NEW.SoLuong > 0) THEN
                UPDATE ch2.KHOHS_NVBH SET TinhTrang = 'Con hang' 
                WHERE MaCH = :NEW.MaCH AND MaHS=:NEW.MaHS; 
            ELSE
                UPDATE ch2.KHOHS_NVBH  SET TinhTrang = 'Het hang' 
                WHERE MaCH = :NEW.MaCH AND MaHS=:NEW.MaHS; 
            END IF;
        WHEN INSERTING THEN
            IF(:NEW.SoLuong > 0) THEN
                INSERT INTO ch2.KHOHS_NVBH (MaCH, MaHS, tinhtrang) VALUES (:NEW.MaCH, :NEW.MaHS,'Con hang');
            ELSE
                INSERT INTO ch2.KHOHS_NVBH (MaCH, MaHS, tinhtrang) VALUES (:NEW.MaCH, :NEW.MaHS,'Het hang');
            END IF;
    END CASE;
END;
/



--test trigger

GRANT CREATE ANY TRIGGER TO TruongKho;
GRANT CREATE ANY PROCEDURE TO TruongKho;



SELECT * FROM ch2.KHOHS_QLKHO WHERE MaHS='HS031'; 
INSERT INTO ch2.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES ('HS031', 12, TO_DATE('05/12/2023', 'DD/MM/YYYY'));
SELECT * FROM ch2.KHOHS_NVBH WHERE MaHS='HS031';
UPDATE ch2.KHOHS_QLKHO SET SoLuong = 0 WHERE MaHS='HS031'; 
SELECT * FROM ch2.KHOHS_NVBH WHERE MaHS='HS031';

lỗi
SELECT * FROM ch2.KHOHS_QLKHO WHERE MaHS='HS032'; 
INSERT INTO ch2.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES ('HS032', -1, TO_DATE('05/12/2023', 'DD/MM/YYYY'));
UPDATE ch2.KHOHS_QLKHO SET SoLuong = -1 WHERE MaHS='HS031'; 


UPDATE ch2.KHOHS_QLKHO SET SoLuong = 5 WHERE MaHS='HS030'; 
 

