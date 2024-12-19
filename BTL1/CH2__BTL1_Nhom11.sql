
--ch2
ALTER SESSION SET "_ORACLE_SCRIPT"=true;  
ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YY HH24:MI:SS';
create user ch2 identified by ch2;
grant create session, connect, dba to ch2;
connect ch2/ch2;
ALTER SESSION SET "_ORACLE_SCRIPT"=true; 
ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YY HH24:MI:SS'; 

CREATE TABLE ch2.HAISAN(
	MAHS VARCHAR(20) PRIMARY KEY,
	TenHS VARCHAR(255),
	NgayNhap DATE,
	MaLoai VARCHAR(20),
	XuatXu	VARCHAR(255),
	GiaNhap NUMBER, 
	GiaBan NUMBER, 
	DVT VARCHAR(20),
FOREIGN KEY (MaLoai) REFERENCES LOAI(MaLoai)
);
CREATE TABLE ch2.LOAI(MaLoai VARCHAR(20) PRIMARY KEY, TenLoai VARCHAR(255));	
CREATE TABLE ch2.CUAHANG(MACH VARCHAR(20) PRIMARY KEY, TenCH VARCHAR(255), DiaChi VARCHAR(255), SoDT VARCHAR(10));

CREATE SEQUENCE MaNV_ID_SEQ
    START WITH 1
    INCREMENT BY 1;
CREATE TABLE ch2.NHANVIEN (
    MaNV VARCHAR2(20) DEFAULT 'NV' || TO_CHAR(MANV_ID_SEQ.NEXTVAL, 'FM000') PRIMARY KEY,
    TenNV VARCHAR2(255),
    DiaChi VARCHAR2(255),
    SoDT VARCHAR2(10),
    Luong NUMBER,
    MACH VARCHAR2(20) DEFAULT 'CH002',
FOREIGN KEY (MACH) REFERENCES CUAHANG(MACH)  
);
CREATE TABLE ch2.KHOHS_QLKHO(
	MACH VARCHAR(20) DEFAULT 'CH002', 
	MAHS VARCHAR(20), 
	SoLuong NUMBER, 
	NgayCapNhat DATE DEFAULT SYSDATE, 
	PRIMARY KEY(MACH, MAHS)
	FOREIGN KEY (MACH) REFERENCES CUAHANG(MACH),
	FOREIGN KEY (MAHS) REFERENCES HAISAN(MAHS)
);
CREATE TABLE ch2.KHOHS_NVBH(
	MACH VARCHAR(20) DEFAULT 'CH002', 
	MAHS VARCHAR(20), 
	tinhtrang VARCHAR(20), 
	PRIMARY KEY(MACH, MAHS)
	FOREIGN KEY (MACH) REFERENCES CUAHANG(MACH),
	FOREIGN KEY (MAHS) REFERENCES HAISAN(MAHS)
);

CREATE SEQUENCE MAKH_ID_SEQ
    START WITH 1
    INCREMENT BY 1;

CREATE TABLE ch2.KHACHHANG (
    MAKH VARCHAR2(20) DEFAULT 'KH' || TO_CHAR(MAKH_ID_SEQ.NEXTVAL, 'FM000') PRIMARY KEY,
    TenKH VARCHAR2(255),
    NgaySinh DATE,
    GioiTinh VARCHAR2(5),
    DiaChi VARCHAR2(255),
    Phone VARCHAR2(10),
    NgayDK DATE DEFAULT SYSDATE
);

CREATE SEQUENCE VIP_ID_SEQ
    START WITH 1
    INCREMENT BY 1;
CREATE TABLE ch2.VIP_RECORD (
    VIP_ID NUMBER DEFAULT VIP_ID_SEQ.NEXTVAL PRIMARY KEY,
    MaKH VARCHAR2(50),
    NgayHetHan DATE
);
CREATE SEQUENCE BILL_ID_SEQ
    START WITH 1
    INCREMENT BY 1;
CREATE TABLE ch2.HOADON (
	MaHD VARCHAR(20) DEFAULT 'HD' || TO_CHAR(BILL_ID_SEQ.NEXTVAL, 'FM000') PRIMARY KEY, 
	MANV VARCHAR(20), 
	MAKH VARCHAR(20), 
	NgayLap DATE DEFAULT SYSDATE, 
	TongTien NUMBER,
	FOREIGN KEY (MANV) REFERENCES NHANVIEN(MaNV),
	FOREIGN KEY (MAKH) REFERENCES KHACHHANG(MAKH)
);
CREATE TABLE ch2.CTHD( CREATE TABLE ch2.CTHD(
	MaHD VARCHAR(20), 
	MAHS VARCHAR(20), 
	SoLuong NUMBER, 
	PRIMARY KEY (MaHD, MAHS),
	FOREIGN KEY (MaHD) REFERENCES HOADON(MaHD),
 	FOREIGN KEY (MAHS) REFERENCES HAISAN(MAHS)
);



-- BANG HAISAN
INSERT INTO ch2.HAISAN VALUES('HS001', 'Ca Hoi Tuoi', TO_DATE('18/11/2023', 'DD/MM/YYYY'), 'L02', 'Norway', 500, 700, 'Kg');
INSERT INTO ch2.HAISAN VALUES('HS002', 'Tom Hum Tuoi', TO_DATE('18/11/2023', 'DD/MM/YYYY'), 'L01', 'Alaska', 900, 1100, 'Kg');
INSERT INTO ch2.HAISAN VALUES('HS003', 'Muc Tuoi', TO_DATE('19/11/2023', 'DD/MM/YYYY'), 'L03', 'Japan', 250, 400, 'Kg');
INSERT INTO ch2.HAISAN VALUES('HS004', 'Cua Hoang De', TO_DATE('17/11/2023', 'DD/MM/YYYY'), 'L04', 'Viet Nam', 1200, 1500, 'Kg');
INSERT INTO ch2.HAISAN VALUES('HS005', 'Ca Ngu', TO_DATE('19/11/2023', 'DD/MM/YYYY'), 'L02', 'Vietnam', 150, 280, 'Kg');
INSERT INTO ch2.HAISAN VALUES('HS006', 'Tom Cang Xanh', TO_DATE('10/11/2023', 'DD/MM/YYYY'), 'L01', 'Viet Nam', 280, 420, 'Kg');
INSERT INTO ch2.HAISAN VALUES('HS007', 'Ca Chep Trang', TO_DATE('5/11/2023', 'DD/MM/YYYY'), 'L02', 'Viet Nam', 20, 30, 'Kg');
INSERT INTO ch2.HAISAN VALUES('HS008', 'Oc Buou', TO_DATE('25/11/2023', 'DD/MM/YYYY'), 'L06', 'Vietnam', 45, 60, 'Kg');
INSERT INTO ch2.HAISAN VALUES('HS009', 'Ghe Xanh Tuoi', TO_DATE('26/11/2023', 'DD/MM/YYYY'), 'L07', 'Viet Nam', 180, 280, 'Kg');
INSERT INTO ch2.HAISAN VALUES('HS010', 'Ngao song', TO_DATE('20/11/2023', 'DD/MM/YYYY'), 'L05', 'Viet Nam', 120, 200, 'Kg');

INSERT INTO ch2.HAISAN VALUES('HS011', 'Ca Ngu Dai Duong', TO_DATE('11/11/2023', 'DD/MM/YYYY'), 'L02', 'Nhat Ban', 600, 750, 'Kg');
INSERT INTO ch2.HAISAN VALUES('HS012', 'Tom Hum Ngop', TO_DATE('18/10/2023', 'DD/MM/YYYY'), 'L01', 'Alaska', 600, 750, 'Kg');
INSERT INTO ch2.HAISAN VALUES('HS013', 'Muc Trung', TO_DATE('19/10/2023', 'DD/MM/YYYY'), 'L03', 'Phu Quoc', 260, 450, 'Kg');
INSERT INTO ch2.HAISAN VALUES('HS014', 'Cua Bien Ca Mau tuoi', TO_DATE('17/11/2023', 'DD/MM/YYYY'), 'L04', 'Ca Mau', 450, 650, 'Kg');
INSERT INTO ch2.HAISAN VALUES('HS015', 'Ca Ro Phi', TO_DATE('23/10/2023', 'DD/MM/YYYY'), 'L02', 'Viet Nam', 60, 80, 'Kg');
INSERT INTO ch2.HAISAN VALUES('HS016', 'Tom Song', TO_DATE('09/10/2023', 'DD/MM/YYYY'), 'L01', 'Viet Nam', 220, 260, 'Kg');
INSERT INTO ch2.HAISAN VALUES('HS017', 'Ca Chep Trang', TO_DATE('5/12/2023', 'DD/MM/YYYY'), 'L02', 'Viet Nam', 25, 45, 'Kg');
INSERT INTO ch2.HAISAN VALUES('HS018', 'So Huyet', TO_DATE('25/10/2023', 'DD/MM/YYYY'), 'L06', 'Vietnam', 250, 310, 'Kg');
INSERT INTO ch2.HAISAN VALUES('HS019', 'Ghe Xanh Ngop', TO_DATE('26/10/2023', 'DD/MM/YYYY'), 'L07', 'Viet Nam', 180, 280, 'Kg');
INSERT INTO ch2.HAISAN VALUES('HS020', 'So Diep song', TO_DATE('25/11/2023', 'DD/MM/YYYY'), 'L08', 'Viet Nam', 120, 200, 'Kg');

INSERT INTO ch2.HAISAN VALUES('HS021', 'Tom Su', TO_DATE('17/12/2023', 'DD/MM/YYYY'), 'L01', 'Viet Nam', 400, 520, 'Kg');
INSERT INTO ch2.HAISAN VALUES('HS022', 'Tom Su Ngop', TO_DATE('23/11/2023', 'DD/MM/YYYY'), 'L01', 'Viet Nam', 200, 270, 'Kg');
INSERT INTO ch2.HAISAN VALUES('HS023', 'Muc Trung Size Nho', TO_DATE('09/11/2023', 'DD/MM/YYYY'), 'L03', 'Phu Quoc', 230, 350, 'Kg');
INSERT INTO ch2.HAISAN VALUES('HS024', 'Cua Bien Ca Mau Ngop', TO_DATE('13/12/2023', 'DD/MM/YYYY'), 'L04', 'Ca Mau', 330, 460, 'Kg');
INSERT INTO ch2.HAISAN VALUES('HS025', 'Vem Xanh', TO_DATE('06/12/2023', 'DD/MM/YYYY'), 'L10', 'Viet Nam', 230, 270, 'Kg');
INSERT INTO ch2.HAISAN VALUES('HS026', 'Ghe Cang Xanh', TO_DATE('20/12/2023', 'DD/MM/YYYY'), 'L07', 'Viet Nam', 280, 400, 'Kg');
INSERT INTO ch2.HAISAN VALUES('HS027', 'Ca Dieu Hong', TO_DATE('05/12/2023', 'DD/MM/YYYY'), 'L02', 'Viet Nam', 20, 30, 'Kg');
INSERT INTO ch2.HAISAN VALUES('HS028', 'Oc Buou Vang', TO_DATE('25/11/2023', 'DD/MM/YYYY'), 'L06', 'Viet Nam', 40, 55, 'Kg');
INSERT INTO ch2.HAISAN VALUES('HS029', 'Ghe Xanh To', TO_DATE('11/12/2023', 'DD/MM/YYYY'), 'L07', 'Trung Quoc', 260, 380, 'Kg');
INSERT INTO ch2.HAISAN VALUES('HS030', 'Sao Bien', TO_DATE('20/09/2023', 'DD/MM/YYYY'), 'L09', 'Phu Quoc', 120, 200, 'Kg');
--Loai

INSERT INTO ch2.LOAI VALUES('L01', 'Tom');
INSERT INTO ch2.LOAI VALUES('L02', 'Ca');
INSERT INTO ch2.LOAI VALUES('L03', 'Muc');
INSERT INTO ch2.LOAI VALUES('L04', 'Cua');
INSERT INTO ch2.LOAI VALUES('L05', 'Ngheu');
INSERT INTO ch2.LOAI VALUES('L06', 'Oc');
INSERT INTO ch2.LOAI VALUES('L07', 'Ghe');
INSERT INTO ch2.LOAI VALUES('L08', 'So');
INSERT INTO ch2.LOAI VALUES('L09', 'Sao');
INSERT INTO ch2.LOAI VALUES('L10', 'Vem');
INSERT INTO ch2.LOAI VALUES('L11', 'Khac');

--BANG NHANVIEN
INSERT INTO ch2.NHANVIEN (TenNV, DiaChi, SoDT, Luong, MaCH) VALUES('Nguyen Van L', 'Quan Thu Duc, HCM', '0932484666', 8500000, 'CH002');
INSERT INTO ch2.NHANVIEN (TenNV, DiaChi, SoDT, Luong, MaCH) VALUES('Nguyen Van M', 'Quan 5, HCM', '0324484666', 7500000, 'CH002');
INSERT INTO ch2.NHANVIEN (TenNV, DiaChi, SoDT, Luong, MaCH) VALUES('Nguyen Van N', 'Quan 4, HCM', '0324484666', 7500000, 'CH002');
INSERT INTO ch2.NHANVIEN (TenNV, DiaChi, SoDT, Luong, MaCH) VALUES('Nguyen Ngoc Yen', 'Dong Nai', '0324484666', 7500000, 'CH002');
INSERT INTO ch2.NHANVIEN (TenNV, DiaChi, SoDT, Luong, MaCH) VALUES('Nguyen Thi Thu Ha', 'Binh Duong', '0324484666', 7500000, 'CH002');
INSERT INTO ch2.NHANVIEN (TenNV, DiaChi, SoDT, Luong, MaCH) VALUES('Vo Van Dao', 'Quan 1, HCM', '0324484666', 7500000, 'CH002');
INSERT INTO ch2.NHANVIEN (TenNV, DiaChi, SoDT, Luong, MaCH) VALUES('Tran Thi Hoc Gioi', 'Quan 2, HCM', '0788662220', 7500000, 'CH002');
INSERT INTO ch2.NHANVIEN (TenNV, DiaChi, SoDT, Luong, MaCH) VALUES('Co Be Vui Tinh', 'Quan 6, HCM', '0788662221', 7600000, 'CH002');
INSERT INTO ch2.NHANVIEN (TenNV, DiaChi, SoDT, Luong, MaCH) VALUES('Cau Be U Buon', 'Quan 9, HCM', '0788662222', 6600000, 'CH002');
INSERT INTO ch2.NHANVIEN (TenNV, DiaChi, SoDT, Luong, MaCH) VALUES('Trum Bom Hang', 'Quan 9, HCM', '0788662223', 6600000, 'CH002');
INSERT INTO ch2.NHANVIEN (TenNV, DiaChi, SoDT, Luong, MaCH) VALUES('Trum An Hai San', 'Quan 10, HCM', '0788662223', 6600000, 'CH002');
INSERT INTO ch2.NHANVIEN (TenNV, DiaChi, SoDT, Luong, MaCH) VALUES('Dai Ca', 'Quan 9, HCM', '0788662224', 6600000, 'CH002');
INSERT INTO ch2.NHANVIEN (TenNV, DiaChi, SoDT, Luong, MaCH) VALUES('Thanh An Hai San', 'Vinh Long', '0788662225', 9000000, 'CH002');
INSERT INTO ch2.NHANVIEN (TenNV, DiaChi, SoDT, Luong, MaCH) VALUES('Anh Thanh Nien', 'Ha Noi', '0788662227', 6200000, 'CH002');
INSERT INTO ch2.NHANVIEN (TenNV, DiaChi, SoDT, Luong, MaCH) VALUES('Son Tung MTP', 'Thai Binh', '0788662229', 16600000, 'CH002');
INSERT INTO ch2.NHANVIEN (TenNV, DiaChi, SoDT, Luong, MaCH) VALUES('Toc Tien', 'HCM', '0788662230', 14500000, 'CH002');
INSERT INTO ch2.NHANVIEN (TenNV, DiaChi, SoDT, Luong, MaCH) VALUES('Nhan Vien Uu Tu', 'Binh Duong', '0788662231', 10000000, 'CH002');

--Bảng KHACHHANG 
INSERT INTO ch2.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Nguyen Tan Phat', TO_DATE('18/11/2002', 'DD/MM/YYYY'), 'Nam', 'Quan 2, HCM', '0123456781',TO_DATE('19/11/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Le Duc Anh', TO_DATE('19/01/2002', 'DD/MM/YYYY'), 'Nam', 'Quan 3, HCM', '0123456789',TO_DATE('19/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Nguyen Phuc Hau', TO_DATE('19/01/2002', 'DD/MM/YYYY'), 'Nam', 'Quan 4, HCM', '0123456789',TO_DATE('18/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Tu Ngoc Yen', TO_DATE('05/05/2002', 'DD/MM/YYYY'), 'Nu', 'Quan 5, HCM', '0123456788',TO_DATE('18/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Huynh Thi Nhu', TO_DATE('18/03/2002', 'DD/MM/YYYY'), 'Nu', 'Quan 6, HCM', '0123456787',TO_DATE('06/11/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Bui Thi Thanh', TO_DATE('08/08/2002', 'DD/MM/YYYY'), 'Nu', 'Quan 7, HCM', '0123456786',TO_DATE('07/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Nguyen Thanh Nhi', TO_DATE('07/11/2001', 'DD/MM/YYYY'), 'Nu', 'Quan 8, HCM', '0123456785',TO_DATE('18/11/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Nguyen Thi Thuy Tien', TO_DATE('18/11/2003', 'DD/MM/YYYY'), 'Nu', 'Quan 9, HCM', '0123456784',TO_DATE('25/11/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Le Ngoc Thao', TO_DATE('18/02/2000', 'DD/MM/YYYY'), 'Nu', 'Quan 10, HCM', '0123456783',TO_DATE('18/11/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Trum Bom Hang', TO_DATE('18/09/1999', 'DD/MM/YYYY'), 'Nam', 'Quan 11, HCM', '0123456782',TO_DATE('20/10/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Vua Hai San', TO_DATE('11/11/1999', 'DD/MM/YYYY'), 'Nam', 'Quan 12, HCM', '0123456789' ,TO_DATE('18/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Le Thi Ngoc Hao', TO_DATE('19/07/1999', 'DD/MM/YYYY'), 'Nu', 'Quan 1, HCM', '0123456799',TO_DATE('19/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Le Ngoc Thu Thao', TO_DATE('12/08/1996', 'DD/MM/YYYY'), 'Nu', 'Quan 2, HCM', '0123456798',TO_DATE('14/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Nguyen Tan Thanh', TO_DATE('19/10/1996', 'DD/MM/YYYY'), 'Nam', 'Quan 3, HCM', '0123456797',TO_DATE('10/10/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Nguyen Van Anh', TO_DATE('19/06/1996', 'DD/MM/YYYY'), 'Nam', 'Quan 4, HCM', '0123456796',TO_DATE('10/10/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Nguyen Thi Be Ba', TO_DATE('07/07/1996', 'DD/MM/YYYY'), 'Nu', 'Quan 5, HCM', 0123456795 ,TO_DATE('21/10/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Nguyen Trung Kien', TO_DATE('21/03/2002', 'DD/MM/YYYY'), 'Nam', 'Quan 6, HCM', 0123456796 ,TO_DATE('20/09/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Nguyen Trung Truc', TO_DATE('21/04/2002', 'DD/MM/YYYY'), 'Nam', 'Quan 7, HCM', 0123456797 ,TO_DATE('21/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Nguyen Anh Huy', TO_DATE('22/03/2001', 'DD/MM/YYYY'), 'Nam', 'Quan 8, HCM', 0123456778 ,TO_DATE('21/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Nguyen Thi Nhu Quynh', TO_DATE('20/12/2000', 'DD/MM/YYYY'), 'Nu', 'Quan 9, HCM', 0123456779 ,TO_DATE('21/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Huynh Nhu Hao', TO_DATE('21/05/2002', 'DD/MM/YYYY'), 'Nam', 'Quan 8, HCM', 0123456777 ,TO_DATE('18/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Tran Anh Duc', TO_DATE('24/04/2002', 'DD/MM/YYYY'), 'Nam', 'Quan 1, HCM', 0123456798 ,TO_DATE('21/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Vo Thi Ha Trang', TO_DATE('09/09/1994', 'DD/MM/YYYY'), 'Nu', 'Quan 7, HCM', 0123456771 ,TO_DATE('20/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Tran Thu Thao', TO_DATE('11/07/1995', 'DD/MM/YYYY'), 'Nu', 'Quan 2, HCM', 0123456772 ,TO_DATE('21/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Vo Quang Minh', TO_DATE('30/03/1996', 'DD/MM/YYYY'), 'Nam', 'Quan 12, HCM', 0123456773 ,TO_DATE('22/09/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Nguyen Ngoc Tho', TO_DATE('05/09/2003', 'DD/MM/YYYY'), 'Nu', 'Quan 11, HCM', 0123456774 ,TO_DATE('22/09/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Tran Anh Tu', TO_DATE('14/01/2000', 'DD/MM/YYYY'), 'Nam', 'Thu Duc, HCM', 0123456775 ,TO_DATE('20/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Ly Ly', TO_DATE('21/10/1997', 'DD/MM/YYYY'), 'Nu', 'Thu Duc, HCM', 0123456776 ,TO_DATE('20/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Duong Qua', TO_DATE('12/12/1996', 'DD/MM/YYYY'), 'Nam', 'Ben Cat, Binh Duong', 0123456761 ,TO_DATE('22/09/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Than Dieu Dai Hiep', TO_DATE('13/02/1985', 'DD/MM/YYYY'), 'Nam', 'Bien Hoa, Dong Nai', 0123456762 ,TO_DATE('22/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Quach Tinh', TO_DATE('05/02/2004', 'DD/MM/YYYY'), 'Nam', 'Quan 6, HCM', 0123456763 ,TO_DATE('20/12/2023', 'DD/MM/YYYY'));

--Bảng KHOHS_QLKHO 

INSERT INTO ch2.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES ('HS001', 22, TO_DATE('05/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES ('HS002', 17, TO_DATE('06/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES ('HS003', 19, TO_DATE('05/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES ('HS004', 22, TO_DATE('05/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES ('HS005', 0, TO_DATE('05/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES ('HS006', 16, TO_DATE('06/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES ('HS007', 10, TO_DATE('28/11/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES ('HS008', 40, TO_DATE('05/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES ('HS009', 0, TO_DATE('16/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES ('HS010', 22, TO_DATE('09/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES ('HS011', 60, TO_DATE('10/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES ('HS012', 7, TO_DATE('28/11/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES ('HS013', 11, TO_DATE('05/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES ('HS014', 5, TO_DATE('18/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES ('HS015', 3, TO_DATE('18/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES ('HS016', 22, TO_DATE('20/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES ('HS017', 0, TO_DATE('21/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES ('HS018', 22, TO_DATE('05/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES ('HS019', 24, TO_DATE('06/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES ('HS020', 9, TO_DATE('14/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES ('HS021', 10, TO_DATE('14/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES ('HS022', 20, TO_DATE('05/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES ('HS023', 0, TO_DATE('20/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES ('HS024', 19, TO_DATE('22/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES ('HS025', 0, TO_DATE('08/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES ('HS026', 0, TO_DATE('09/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES ('HS027', 1, TO_DATE('15/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES ('HS028', 3, TO_DATE('20/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES ('HS029', 6, TO_DATE('22/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch2.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES ('HS030', 3, TO_DATE('05/12/2023', 'DD/MM/YYYY'));


--Bang KHOHS_NVB
INSERT INTO ch2.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS001', 'Con hang');
INSERT INTO ch2.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS002', 'Con hang');
INSERT INTO ch2.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS003', 'Con hang');
INSERT INTO ch2.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS004', 'Con hang');
INSERT INTO ch2.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS005', 'Het hang');
INSERT INTO ch2.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS006', 'Con hang');
INSERT INTO ch2.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS007', 'Con hang');
INSERT INTO ch2.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS008', 'Con hang');
INSERT INTO ch2.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS009', 'Het hang');
INSERT INTO ch2.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS010', 'Con hang');
INSERT INTO ch2.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS011', 'Con hang');
INSERT INTO ch2.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS012', 'Con hang');
INSERT INTO ch2.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS013', 'Con hang');
INSERT INTO ch2.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS014', 'Con hang');
INSERT INTO ch2.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS015', 'Con hang');
INSERT INTO ch2.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS016', 'Con hang');
INSERT INTO ch2.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS017', 'Het hang');
INSERT INTO ch2.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS018', 'Con hang');
INSERT INTO ch2.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS019', 'Con hang');
INSERT INTO ch2.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS020', 'Con hang');
INSERT INTO ch2.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS021', 'Con hang');
INSERT INTO ch2.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS022', 'Con hang');
INSERT INTO ch2.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS023', 'Het hang');
INSERT INTO ch2.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS024', 'Con hang');
INSERT INTO ch2.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS025', 'Het hang');
INSERT INTO ch2.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS026', 'Het hang');
INSERT INTO ch2.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS027', 'Con hang');
INSERT INTO ch2.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS028', 'Con hang');
INSERT INTO ch2.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS029', 'Con hang');
INSERT INTO ch2.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS030', 'Con hang');

--Cua Hang
INSERT INTO ch2.CUAHANG VALUES('CH002', 'Hai San Best', '381 Dien Bien Phu, Quan Binh Thanh', '0764484235');


--HoaDon 
INSERT INTO ch2.HOADON (MANV, MAKH, NgayLap, TongTien) VALUES('NV001', 'KH003', TO_DATE('18/12/2023', 'DD/MM/YYYY'), 650);
INSERT INTO ch2.HOADON (MANV, MAKH, NgayLap, TongTien) VALUES('NV001', 'KH006', TO_DATE('18/12/2023', 'DD/MM/YYYY'), 250);
INSERT INTO ch2.HOADON (MANV, MAKH, NgayLap, TongTien) VALUES('NV006', 'KH009', TO_DATE('19/12/2023', 'DD/MM/YYYY'), 2000);
INSERT INTO ch2.HOADON (MANV, MAKH, NgayLap, TongTien) VALUES('NV006', 'KH005', TO_DATE('19/12/2023', 'DD/MM/YYYY'), 600);
INSERT INTO ch2.HOADON (MANV, MAKH, NgayLap, TongTien) VALUES('NV003', 'KH007', TO_DATE('19/12/2023', 'DD/MM/YYYY'), 1950);
INSERT INTO ch2.HOADON (MANV, MAKH, NgayLap, TongTien) VALUES('NV003', 'KH011', TO_DATE('19/12/2023', 'DD/MM/YYYY'), 520);
INSERT INTO ch2.HOADON (MANV, MAKH, NgayLap, TongTien) VALUES('NV007', 'KH015', TO_DATE('12/12/2023', 'DD/MM/YYYY'), 920);
INSERT INTO ch2.HOADON (MANV, MAKH, NgayLap, TongTien) VALUES('NV004', 'KH013', TO_DATE('20/12/2023', 'DD/MM/YYYY'), 580);
INSERT INTO ch2.HOADON (MANV, MAKH, NgayLap, TongTien) VALUES('NV008', 'KH019', TO_DATE('20/12/2023', 'DD/MM/YYYY'), 1000);
INSERT INTO ch2.HOADON (MANV, MAKH, NgayLap, TongTien) VALUES('NV008', 'KH022', TO_DATE('20/12/2023', 'DD/MM/YYYY'), 2400);

--ch2 CTHD
INSERT INTO ch2.CTHD VALUES ('HD001', 'HS014', 1);
INSERT INTO ch2.CTHD VALUES ('HD002', 'HS015', 2);
INSERT INTO ch2.CTHD VALUES ('HD002', 'HS017', 2);
INSERT INTO ch2.CTHD VALUES ('HD003', 'HS026', 5);
INSERT INTO ch2.CTHD VALUES ('HD004', 'HS022', 1);
INSERT INTO ch2.CTHD VALUES ('HD004', 'HS024', 1);
INSERT INTO ch2.CTHD VALUES ('HD005', 'HS014', 3);
INSERT INTO ch2.CTHD VALUES ('HD006', 'HS016', 2);
INSERT INTO ch2.CTHD VALUES ('HD007', 'HS024', 2);
INSERT INTO ch2.CTHD VALUES ('HD008', 'HS029', 1);
INSERT INTO ch2.CTHD VALUES ('HD008', 'HS030', 1);
INSERT INTO ch2.CTHD VALUES ('HD009', 'HS020', 5); 
INSERT INTO ch2.CTHD VALUES ('HD010', 'HS013', 2); 
INSERT INTO ch2.CTHD VALUES ('HD010', 'HS004', 1); 

--PHAN QUYEN (NHỚ ĐỌC LẠI)
    
ALTER SESSION SET "_ORACLE_SCRIPT"=true;  
ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YY HH24:MI:SS';

CREATE USER giamdocreal identified by giamdocreal;
grant create session, connect to giamdocreal;
grant insert, select, update, delete on ch2.KHACHHANG to giamdocreal;
grant insert, select, update, delete on ch2.NHANVIEN to giamdocreal;
grant insert, select, update, delete on ch2.HAISAN to giamdocreal;
grant insert, select, update, delete on ch2.CUAHANG to giamdocreal;
grant insert, select, update, delete on ch2.LOAI to giamdocreal;
grant insert, select, update, delete on ch2.HOADON to giamdocreal;
grant insert, select, update, delete on ch2.CTHD to giamdocreal;
grant insert, select, update, delete on ch2.KHOHS_QLKHO to giamdocreal;
grant insert, select, update, delete on ch2.KHOHS_NVBH to giamdocreal;

CREATE USER TruongKho identified by truongKho;
grant create session, connect to TruongKho;
grant insert, select, update, delete on ch2.KHOHS_QLKHO to TruongKho;
grant select on ch2.KHOHS_NVBH to TruongKho;
grant insert, select, update, delete on ch2.KHACHHANG to TruongKho;
grant select on ch2.HAISAN to TruongKho;
grant select on ch2.CUAHANG to TruongKho;
grant select on ch2.LOAI to TruongKho;
grant select on ch2.HOADON to TruongKho;
grant select on ch2.CTHD to TruongKho;


CREATE USER NhanVien identified by nhanvien;
grant create session, connect to NhanVien;
grant insert, select, update on ch2.KHACHHANG to NhanVien;
grant insert, select on ch2.HOADON to NhanVien;
grant insert, select on ch2.CTHD to NhanVien;
grant select on ch2.NHANVIEN to NhanVien;
grant select on ch2.HAISAN to NhanVien;
grant select on ch2.LOAI to NhanVien;
grant select on ch2.CUAHANG to NhanVien;


CREATE USER ch1 identified by ch1;
grant create session, dba to ch1;
grant select on ch2.KHACHHANG to ch1;
grant select on ch2.NHANVIEN to ch1;
grant select on ch2.HAISAN to ch1;
grant select on ch2.CUAHANG to ch1;
grant select on ch2.LOAI to ch1;
grant select on ch2.HOADON to ch1;
grant select on ch2.CTHD to ch1;
grant select on ch2.KHOHS_QLKHO to ch1;
grant select on ch2.KHOHS_NVBH to ch1;



create public database link ch1_dblink connect to ch1 identified by ch1 using 'ch1';
create public database link ch1_dblink_tk connect to TruongKho identified by truongkho using 'ch1';
create public database link ch1_dblink_nv connect to NhanVien identified by nhanvien using 'ch1';


_Lost update:
m2- GĐ:
SELECT MaNV, TenNV, MACH FROM ch2.NHANVIEN WHERE MaNV = 'NV002';

m1- GĐ:
SELECT MaNV, TenNV, MACH FROM ch2.NHANVIEN@ch2_dblink_gd WHERE MaNV = 'NV002';

m2- giám đốc sửa nhân viên cn2:
UPDATE ch2.NHANVIEN SET TenNV = 'Tran Thi Thanh' WHERE MaNV = 'NV002';
commit;

m1- giám đốc sửa nhân viên cn2:
UPDATE ch2.NHANVIEN@ch2_dblink_gd SET TenNV = 'Tran Thi Thy' WHERE MaNV = 'NV002';
commit;

m2- :
SELECT MaNV, TenNV, MACH FROM ch2.NHANVIEN WHERE MaNV = 'NV002';

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-----------------------------------------------------------
_Unrepeatable read:

2:
SELECT MaNV, TenNV, Luong, MACH FROM ch2.NHANVIEN WHERE MaNV = 'NV002';
1:
UPDATE ch2.NHANVIEN@ch2_dblink_gd SET Luong = 7000000 WHERE MaNV = 'NV002';
commit;
2:
SELECT MaNV, TenNV, Luong, MACH FROM ch2.NHANVIEN WHERE MaNV = 'NV002';
commit; 

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;


-----------------------------------------------------------

_Phantom read:
2:
SELECT MANV, TenNV, Luong, MACH FROM ch2.NHANVIEN WHERE MANV = 'NV017';
1:
DELETE ch2.NHANVIEN@ch2_dblink_gd WHERE MaNV = 'NV022';
commit;
2:
SELECT MANV, TenNV, Luong, MACH FROM ch2.NHANVIEN;
2:
INSERT INTO ch2.NHANVIEN (TenNV, DiaChi, SoDT, Luong, MaCH) VALUES('Tran Thi Thy', 'Quan 5, HCM', '0324484666', 7500000, 'CH002');

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;


-----------------------------------------------------------

_Deadlock:
2:
UPDATE ch2.NHANVIEn SET TenNV = 'Tran Thi Thanh' WHERE MaNV = 'NV002';
1:
UPDATE ch2.NHANVIEN@ch2_dblink_gd SET TenNV = 'Nguyen Thi Hoai Thanh' WHERE MaNV = 'NV001';
2:
UPDATE ch2.NHANVIEn SET TenNV = 'Nguyen Thi Hoai Thanh' WHERE MaNV = 'NV001';
1:
UPDATE ch2.NHANVIEN@ch2_dblink_gd SET TenNV = 'Tran Thi Thanh' WHERE MaNV = 'NV002';


