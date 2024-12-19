--DE 1--
ALTER USER BAITHI quota 100M ON USERS;

--1. T?o user t那n BAITHI g?m c車 4 table HANGHANGKHONG, CHUYENBAY, NHANVIEN, 
--PHANCONG. T?o kh車a ch赤nh, kh車a ngo?i cho c芍c table ?車.
CREATE TABLE BAITHI.HANGHANGKHONG (
    MAHANG CHAR(2),
    TENHANG VARCHAR2(50),
    NGTL DATE,
    DUONGBAY NUMBER,
    PRIMARY KEY (MAHANG)
);

CREATE TABLE BAITHI.CHUYENBAY (
    MACB CHAR(5),
    MAHANG CHAR(2),
    XUATPHAT VARCHAR2(50),
    DIEMDEN VARCHAR2(50),
    BATDAU DATE,
    TGBAY NUMBER,
    PRIMARY KEY (MACB),
    CONSTRAINT FK_CHUYENBAY_HANGHK FOREIGN KEY (MAHANG) REFERENCES BAITHI.HANGHANGKHONG(MAHANG)
);

CREATE TABLE BAITHI.NHANVIEN (
    MANV CHAR(4),
    HOTEN VARCHAR2(50),
    GIOITINH VARCHAR2(3),
    NGSINH DATE,
    NGVL DATE,
    CHUYENMON VARCHAR2(50),
    PRIMARY KEY (MANV)
);

CREATE TABLE BAITHI.PHANCONG (
    MACB CHAR(5),
    MANV CHAR(4),
    NHIEMVU VARCHAR2(50),
    PRIMARY KEY (MACB, MANV),
    CONSTRAINT FK_PHANCONG_CBAY FOREIGN KEY (MACB) REFERENCES BAITHI.CHUYENBAY(MACB),
    CONSTRAINT FK_PHANCONG_NHANVIEN FOREIGN KEY (MANV) REFERENCES BAITHI.NHANVIEN
);

--2. Nh?p d? li?u cho 4 table nh? ?? b角i.
INSERT INTO BAITHI.HANGHANGKHONG VALUES('VN','Vietnam Airlines', TO_DATE( '15/01/1956', 'dd/MM/yyyy'), 53);
INSERT INTO BAITHI.HANGHANGKHONG VALUES('VJ','Vietjet Air', TO_DATE( '25/12/2011', 'dd/MM/yyyy'), 33);
INSERT INTO BAITHI.HANGHANGKHONG VALUES('BL','Jetstar Pacific Airlines', TO_DATE( '01/12/1990', 'dd/MM/yyyy'), 13);

INSERT INTO BAITHI.CHUYENBAY VALUES('VN550','VN','TP.HCM', 'Singapore', TO_DATE( '13:15:00 20/12/2015', 'HH24:MI:SS dd/MM/yyyy'), 2);
INSERT INTO BAITHI.CHUYENBAY VALUES('VJ331','VJ','Da Nang', 'Vinh', TO_DATE( '22:30:00 28/12/2015', 'HH24:MI:SS dd/MM/yyyy'), 1);
INSERT INTO BAITHI.CHUYENBAY VALUES('BL696','BL','TP.HCM', 'Da Lat', TO_DATE( '6:00:00 24/12/2015', 'HH24:MI:SS dd/MM/yyyy'), 0.5);

INSERT INTO BAITHI.NHANVIEN VALUES('NV01', 'Lam Van Ben', 'Nam',  TO_DATE( '10/09/1978', 'dd/MM/yyyy'), TO_DATE( '05/06/2000', 'dd/MM/yyyy'), 'Phi cong');
INSERT INTO BAITHI.NHANVIEN VALUES('NV02', 'Duong Thi Luc', 'Nu',  TO_DATE( '22/03/1989', 'dd/MM/yyyy'), TO_DATE( '12/11/2013', 'dd/MM/yyyy'), 'Tiep vien');
INSERT INTO BAITHI.NHANVIEN VALUES('NV03', 'Hoang Thanh Tung', 'Nam',  TO_DATE( '29/07/1983', 'dd/MM/yyyy'), TO_DATE( '11/04/2007', 'dd/MM/yyyy'), 'Tiep vien');

INSERT INTO BAITHI.PHANCONG VALUES('VN550', 'NV01', 'Co truong');
INSERT INTO BAITHI.PHANCONG VALUES('VN550', 'NV02', 'Tiep vien');
INSERT INTO BAITHI.PHANCONG VALUES('BL696', 'NV03', 'Tiep vien truong');

--3. Hi?n th?c r角ng bu?c to角n v?n sau: Chuy那n m?n c?a nh?n vi那n ch? ???c nh?n gi芍 tr? l角 ＆Phi 
--c?ng＊ ho?c ＆Ti?p vi那n＊.
ALTER TABLE BAITHI.NHANVIEN
ADD CONSTRAINT CK_NHANVIEN_CHUYENMON CHECK (CHUYENMON IN ('Phi Cong', 'Tiep Vien'));

--4. Hi?n th?c r角ng bu?c to角n v?n sau: Ng角y b?t ??u chuy?n bay lu?n l?n h?n ng角y th角nh l?p h?ng 
--h角ng kh?ng qu?n l? chuy?n bay ?車.


--5. T足m t?t c? c芍c nh?n vi那n c車 sinh nh?ttrong th芍ng 07.
SELECT *
FROM BAITHI.NHANVIEN
WHERE EXTRACT(MONTH FROM NGSINH) = 7;

--6. T足m chuy?n bay c車 s? nh?n vi那n nhi?u nh?t.
SELECT MACB
FROM BAITHI.PHANCONG 
GROUP BY MACB 
HAVING COUNT(*) = 
        (SELECT MAX(COUNT(*)) 
        FROM BAITHI.PHANCONG 
        GROUP BY MACB);

--7. V?i m?ih?ng h角ng kh?ng, th?ng k那 s? chuy?n bay c車 ?i?m xu?t ph芍t l角 ＆?角 N?ng＊ v角 c車 s?
--nh?n vi那n ???c ph?n c?ng 赤t h?n 2.
SELECT CB.MAHANG, COUNT(CB.MACB)
FROM BAITHI.CHUYENBAY CB, BAITHI.PHANCONG PC
WHERE CB.MACB = PC.MACB
    AND XUATPHAT = 'Da Nang' 
GROUP BY CB.MAHANG 
HAVING COUNT(PC.MANV) < 2;

--8. T足m nh?n vi那n ???c ph?n c?ng tham gia t?t c? c芍c chuy?n bay.
SELECT NV.MANV
FROM BAITHI.NHANVIEN NV
WHERE
    NOT EXISTS ( 
        SELECT *
        FROM BAITHI.CHUYENBAY CB
        WHERE
            NOT EXISTS (
                SELECT *
                FROM BAITHI.PHANCONG PC
                WHERE PC.MACB = CB.MACB
                    AND PC.MANV = PC.MANV
            )
    );