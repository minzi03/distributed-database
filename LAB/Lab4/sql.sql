DROP TABLE BaiThiHTCL1.PHANCONG
DROP TABLE BaiThiHTCL1.NVHANGKHONG
DROP TABLE BaiThiHTCL1.CHUYENBAY
DROP TABLE BaiThiHTCL1.HANGHANGKHONG
/*1. Cai dat bang HANGHANGKHONG*/
CREATE TABLE BaiThiHTCL1.HANGHANGKHONG
(
    MAHANG varchar2(4) NOT NULL,
    TENHANG varchar2(25) NOT NULL,
    NGTL date NOT NULL,
    DUONGBAY number NOT NULL,
    CONSTRAINT PK_HHK PRIMARY KEY (MAHANG)
)

DROP TABLE BaiThiHTCL1.CHUYENBAY
/*2. Cai dat bang CHUYENBAY*/
CREATE TABLE BaiThiHTCL1.CHUYENBAY
(
    MACB varchar2(5) NOT NULL,
    MAHANG varchar2(4) NOT NULL,
    XUATPHAT varchar2(25) NOT NULL,
    DIEMDEN varchar2(25) NOT NULL,
    BATDAU date NOT NULL,
    TGBAY number NOT NULL,
    CONSTRAINT PK_CB PRIMARY KEY(MACB)
)

/*3. Cai dat bang NHANVIEN*/
CREATE TABLE BaiThiHTCL1.NHANVIEN
(
    MANV varchar2(4) NOT NULL,
    HOTEN varchar2(50) NOT NULL,
    GIOITINH varchar2(3) NOT NULL,
    NGSINH date NOT NULL,
    NGVL date NOT NULL,
    CHUYENMON varchar2(25),
    CONSTRAINT PK_NV_HANGKHONG PRIMARY KEY(MANV) 
)

/*4. Cai dat bang PHANCONG*/
CREATE TABLE BaiThiHTCL1.PHANCONG
(
    MACB varchar2(5) NOT NULL,
    MANV varchar2(4) NOT NULL,
    NHIEMVU varchar2(15) NOT NULL,
    CONSTRAINT PK_PC PRIMARY KEY(MACB,MANV)
)

ALTER TABLE BaiThiHTCL1.CHUYENBAY
ADD CONSTRAINT FK_CHUYENBAY_HANG FOREIGN KEY (MAHANG) REFERENCES BaiThiHTCL1.HANGHANGKHONG(MAHANG);

ALTER TABLE BaiThiHTCL1.PHANCONG
ADD CONSTRAINT FK_PHANCONG_CHUYENBAY FOREIGN KEY (MACB) REFERENCES BaiThiHTCL1.CHUYENBAY(MACB);

ALTER TABLE BaiThiHTCL1.PHANCONG
ADD CONSTRAINT FK_PHANCONG_NHANVIEN FOREIGN KEY (MANV) REFERENCES BaiThiHTCL1.NHANVIEN(MANV);

ALTER SESSION SET NLS_DATE_FORMAT =' DD/MM/YYYY  HH24:MI:SS ';

INSERT INTO BaiThiHTCL1.HANGHANGKHONG VALUES('VN','Vietnam Airlines', to_date('15/01/1956','dd/mm/yyyy'),52);
INSERT INTO BaiThiHTCL1.HANGHANGKHONG VALUES ('VJ','Vietjet Air',to_date('25/12/2011','dd/mm/yyyy'),33);
INSERT INTO BaiThiHTCL1.HANGHANGKHONG VALUES ('BL','Jetstar Pacific Airlines ',to_date('01/12/1991','dd/mm/yyyy'),13);

select * from BaiThiHTCL1.HANGHANGKHONG

INSERT INTO BaiThiHTCL1.CHUYENBAY VALUES('VN550','VN','TP.HCM','Singapore','20/12/2015 13:15',2);
INSERT INTO BaiThiHTCL1.CHUYENBAY VALUES('VJ332','VJ','Da Nang','Vinh','28/12/2015 22:30',1);
INSERT INTO BaiThiHTCL1.CHUYENBAY VALUES('BL696','BL','TP.HCM','Da Lat','24/12/2015 6:00',0.5);
INSERT INTO BaiThiHTCL1.CHUYENBAY VALUES('VN999','VN','TP.HCM','Singapore','20/09/2021 14:15',2);
INSERT INTO BaiThiHTCL1.CHUYENBAY VALUES('VJ452','VJ','Da Nang','TP.HCM','20/09/2021 22:30',1.5);
INSERT INTO BaiThiHTCL1.CHUYENBAY VALUES('BL743','BL','TP.HCM','Ha Noi','06/10/2021 7:00',2);

SELECT * FROM BaiThiHTCL1.CHUYENBAY
INSERT INTO BaiThiHTCL1.NHANVIEN VALUES('NV01','Lam Van Ben','Nam','10/09/1978','05/06/2000','Phi cong');
INSERT INTO BaiThiHTCL1.NHANVIEN VALUES('NV02','Duong The Luc','Nu','22/03/1989 ','12/11/2013 ','Tiep vien');
INSERT INTO BaiThiHTCL1.NHANVIEN VALUES('NV03','Hoang Thanh Tung','Nam','29/07/1983  ','11/04/2007  ','Tiep vien');

SELECT * FROM BaiThiHTCL1.NHANVIEN;

INSERT INTO BaiThiHTCL1.PHANCONG VALUES('VN550','NV01','Co truong');
INSERT INTO BaiThiHTCL1.PHANCONG VALUES('VN550','NV02','Tiep vien');
INSERT INTO BaiThiHTCL1.PHANCONG VALUES('BL696','NV03','Tiep vien trg');
INSERT INTO BaiThiHTCL1.PHANCONG VALUES('VN999','NV01','Co truong');
INSERT INTO BaiThiHTCL1.PHANCONG VALUES('VN999','NV03','Tiep vien trg');
INSERT INTO BaiThiHTCL1.PHANCONG VALUES('VJ452','NV02','Tiep vien');

SELECT PHANCONG.MANV FROM BaiThiHTCL1.PHANCONG;

SELECT * FROM PHANCONG;

set serveroutput on size 30000;
CREATE OR REPLACE PROCEDURE BaiThiHTCL1.proc_quanlynhanvien(
    manv_in IN PHANCONG.MANV%TYPE)
IS
    var_soluong number;
    var_tennhanvien NHANVIEN.HOTEN%TYPE;
    var_nhiemvu     PHANCONG.NHIEMVU%TYPE;
    var_mahang      CHUYENBAY.MAHANG%TYPE;
    var_xuatphat    CHUYENBAY.XUATPHAT%TYPE;
    var_diemden     CHUYENBAY.DIEMDEN%TYPE;
    var_batdau      CHUYENBAY.BATDAU%TYPE;
    var_tgbay       CHUYENBAY.TGBAY%TYPE;
    cur_machuyenbay PHANCONG.MACB%TYPE;
    CURSOR CUR IS SELECT PHANCONG.MACB
                    FROM BaiThiHTCL1.PHANCONG
                    WHERE PHANCONG.MANV = manv_in;
BEGIN
    SELECT NV.HOTEN,COUNT(*) INTO var_tennhanvien, var_soluong
    FROM BaiThiHTCL1.NHANVIEN NV, BaiThiHTCL1.PHANCONG PC
    WHERE NV.MANV = PC.MANV AND 
    NV.MANV = manv_in
    GROUP BY NV.MANV,NV.HOTEN;
    
    DBMS_OUTPUT.PUT_LINE('** THONG TIN CHUYEN BAY CUA NHAN VIEN: '|| var_tennhanvien || ' **');
    DBMS_OUTPUT.PUT_LINE('** SO LUONG CHUYEN BAY THAM GIA: '|| var_soluong || ' **');
    OPEN CUR;
    LOOP 
        FETCH CUR INTO cur_machuyenbay;
        DBMS_OUTPUT.PUT_LINE('=============================================');
        EXIT WHEN CUR%NOTFOUND;
        SELECT 
              NHIEMVU, MAHANG, XUATPHAT, DIEMDEN, BATDAU, TGBAY 
              INTO
                  var_nhiemvu, var_mahang, var_xuatphat, 
                  var_diemden, var_batdau, var_tgbay
        FROM  
              BaiThiHTCL1.PHANCONG,BaiThiHTCL1.CHUYENBAY
        WHERE 
              PHANCONG.MACB = CHUYENBAY.MACB AND
              CHUYENBAY.MACB = cur_machuyenbay AND PHANCONG.MANV = manv_in ;
        
       
        DBMS_OUTPUT.PUT_LINE('NHIEM VU ' || var_nhiemvu);
        DBMS_OUTPUT.PUT_LINE('CHUYEN BAY: '||cur_machuyenbay||' ,HANG: '||var_mahang);
        DBMS_OUTPUT.PUT_LINE('XUAT PHAT: '||var_xuatphat||' ,DIEM DEN: '||var_diemden);
        DBMS_OUTPUT.PUT_LINE('THOI GIAN BAT DAU: '||var_batdau);
        DBMS_OUTPUT.PUT_LINE('THOI GIAN BAY: '||var_tgbay);
    
    END LOOP;
    CLOSE CUR;
END;

BEGIN 
    BaiThiHTCL1.proc_quanlynhanvien('NV01');
END;


