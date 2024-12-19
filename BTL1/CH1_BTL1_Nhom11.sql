ch1
ALTER SESSION SET "_ORACLE_SCRIPT"=true;  
ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YY HH24:MI:SS';
create user ch1 identified by ch1;
grant create session, connect, dba to ch1;
connect ch1/ch1;
ALTER SESSION SET "_ORACLE_SCRIPT"=true;  
ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YY HH24:MI:SS';
CREATE TABLE ch1.HAISAN(
	MAHS VARCHAR(20) PRIMARY KEY,
	TenHS VARCHAR(255),
	NgayNhap DATE,
	MaLoai	VARCHAR(20),
	XuatXu	VARCHAR(255),
	GiaNhap NUMBER, 
	GiaBan NUMBER, 
	DVT VARCHAR(20),
FOREIGN KEY (MaLoai) REFERENCES LOAI(MaLoai)
);
CREATE TABLE ch1.LOAI(MaLoai VARCHAR(20) PRIMARY KEY, TenLoai VARCHAR(255));	
CREATE TABLE ch1.CUAHANG(MACH VARCHAR(20) PRIMARY KEY, TenCH VARCHAR(255), DiaChi VARCHAR(255), SoDT VARCHAR(10));

CREATE SEQUENCE MaNV_ID_SEQ
    START WITH 1
    INCREMENT BY 1;
CREATE TABLE ch1.NHANVIEN (
    MaNV VARCHAR2(20) DEFAULT 'NV' || TO_CHAR(MANV_ID_SEQ.NEXTVAL, 'FM000') PRIMARY KEY,
    TenNV VARCHAR2(255),
    DiaChi VARCHAR2(255),
    SoDT VARCHAR2(10),
    Luong NUMBER,
    MACH VARCHAR2(20) DEFAULT 'CH001',
FOREIGN KEY (MACH) REFERENCES CUAHANG(MACH) 
);
CREATE TABLE ch1.KHOHS_QLKHO(
	MACH VARCHAR(20) DEFAULT 'CH001', 
	MAHS VARCHAR(20), 
	SoLuong NUMBER, 
	NgayCapNhat DATE DEFAULT SYSDATE, 
	PRIMARY KEY(MACH, MAHS)
	FOREIGN KEY (MACH) REFERENCES CUAHANG(MACH),
	FOREIGN KEY (MAHS) REFERENCES HAISAN(MAHS)
);
CREATE TABLE ch1.KHOHS_NVBH(
	MACH VARCHAR(20) DEFAULT 'CH001', 
	MAHS VARCHAR(20), 
	tinhtrang VARCHAR(20), 
	PRIMARY KEY(MACH, MAHS)
	FOREIGN KEY (MACH) REFERENCES CUAHANG(MACH),
	FOREIGN KEY (MAHS) REFERENCES HAISAN(MAHS)
);

CREATE SEQUENCE MAKH_ID_SEQ
    START WITH 1
    INCREMENT BY 1;

CREATE TABLE ch1.KHACHHANG (
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
CREATE TABLE ch1.VIP_RECORD (
    VIP_ID NUMBER DEFAULT VIP_ID_SEQ.NEXTVAL PRIMARY KEY,
    MaKH VARCHAR2(50),
    NgayHetHan DATE,
FOREIGN KEY (MAKH) REFERENCES KHACHHANG(MAKH)
);
CREATE SEQUENCE BILL_ID_SEQ
    START WITH 1
    INCREMENT BY 1;
CREATE TABLE ch1.HOADON (
	MaHD VARCHAR(20) DEFAULT 'HD' || TO_CHAR(BILL_ID_SEQ.NEXTVAL, 'FM000') PRIMARY KEY, 
	MANV VARCHAR(20), 
	MAKH VARCHAR(20), 
	NgayLap DATE DEFAULT SYSDATE, 
	TongTien NUMBER,
	FOREIGN KEY (MANV) REFERENCES NHANVIEN(MaNV),
	FOREIGN KEY (MAKH) REFERENCES KHACHHANG(MAKH)
);
CREATE TABLE ch1.CTHD( CREATE TABLE ch2.CTHD(
	MaHD VARCHAR(20), 
	MAHS VARCHAR(20), 
	SoLuong NUMBER, 
	PRIMARY KEY (MaHD, MAHS),
	FOREIGN KEY (MaHD) REFERENCES HOADON(MaHD),
 	FOREIGN KEY (MAHS) REFERENCES HAISAN(MAHS)
);



--INSERT BANG HAISAN
INSERT INTO ch1.HAISAN VALUES('HS001', 'Ca Hoi Tuoi', TO_DATE('18/11/2023', 'DD/MM/YYYY'), 'L02', 'Norway', 500, 700, 'Kg');
INSERT INTO ch1.HAISAN VALUES('HS002', 'Tom Hum Tuoi', TO_DATE('18/11/2023', 'DD/MM/YYYY'), 'L01', 'Alaska', 900, 1100, 'Kg');
INSERT INTO ch1.HAISAN VALUES('HS003', 'Muc Tuoi', TO_DATE('19/11/2023', 'DD/MM/YYYY'), 'L03', 'Japan', 250, 400, 'Kg');
INSERT INTO ch1.HAISAN VALUES('HS004', 'Cua Hoang De', TO_DATE('17/11/2023', 'DD/MM/YYYY'), 'L04', 'Viet Nam', 1200, 1500, 'Kg');
INSERT INTO ch1.HAISAN VALUES('HS005', 'Ca Ngu', TO_DATE('19/11/2023', 'DD/MM/YYYY'), 'L02', 'Vietnam', 150, 280, 'Kg');
INSERT INTO ch1.HAISAN VALUES('HS006', 'Tom Cang Xanh', TO_DATE('10/11/2023', 'DD/MM/YYYY'), 'L01', 'Viet Nam', 280, 420, 'Kg');
INSERT INTO ch1.HAISAN VALUES('HS007', 'Ca Chep Trang', TO_DATE('5/11/2023', 'DD/MM/YYYY'), 'L02', 'Viet Nam', 20, 30, 'Kg');
INSERT INTO ch1.HAISAN VALUES('HS008', 'Oc Buou', TO_DATE('25/11/2023', 'DD/MM/YYYY'), 'L06', 'Vietnam', 45, 60, 'Kg');
INSERT INTO ch1.HAISAN VALUES('HS009', 'Ghe Xanh Tuoi', TO_DATE('26/11/2023', 'DD/MM/YYYY'), 'L07', 'Viet Nam', 180, 280, 'Kg');
INSERT INTO ch1.HAISAN VALUES('HS010', 'Ngao song', TO_DATE('20/11/2023', 'DD/MM/YYYY'), 'L05', 'Viet Nam', 120, 200, 'Kg');

INSERT INTO ch1.HAISAN VALUES('HS011', 'Ca Ngu Dai Duong', TO_DATE('11/11/2023', 'DD/MM/YYYY'), 'L02', 'Nhat Ban', 600, 750, 'Kg');
INSERT INTO ch1.HAISAN VALUES('HS012', 'Tom Hum Ngop', TO_DATE('18/10/2023', 'DD/MM/YYYY'), 'L01', 'Alaska', 600, 750, 'Kg');
INSERT INTO ch1.HAISAN VALUES('HS013', 'Muc Trung', TO_DATE('19/10/2023', 'DD/MM/YYYY'), 'L03', 'Phu Quoc', 260, 450, 'Kg');
INSERT INTO ch1.HAISAN VALUES('HS014', 'Cua Bien Ca Mau tuoi', TO_DATE('17/11/2023', 'DD/MM/YYYY'), 'L04', 'Ca Mau', 450, 650, 'Kg');
INSERT INTO ch1.HAISAN VALUES('HS015', 'Ca Ro Phi', TO_DATE('23/10/2023', 'DD/MM/YYYY'), 'L02', 'Viet Nam', 60, 80, 'Kg');
INSERT INTO ch1.HAISAN VALUES('HS016', 'Tom Song', TO_DATE('09/10/2023', 'DD/MM/YYYY'), 'L01', 'Viet Nam', 220, 260, 'Kg');
INSERT INTO ch1.HAISAN VALUES('HS017', 'Ca Chep Trang', TO_DATE('5/12/2023', 'DD/MM/YYYY'), 'L02', 'Viet Nam', 25, 45, 'Kg');
INSERT INTO ch1.HAISAN VALUES('HS018', 'So Huyet', TO_DATE('25/10/2023', 'DD/MM/YYYY'), 'L06', 'Vietnam', 250, 310, 'Kg');
INSERT INTO ch1.HAISAN VALUES('HS019', 'Ghe Xanh Ngop', TO_DATE('26/10/2023', 'DD/MM/YYYY'), 'L07', 'Viet Nam', 180, 280, 'Kg');
INSERT INTO ch1.HAISAN VALUES('HS020', 'So Diep song', TO_DATE('25/11/2023', 'DD/MM/YYYY'), 'L08', 'Viet Nam', 120, 200, 'Kg');

INSERT INTO ch1.HAISAN VALUES('HS021', 'Tom Su', TO_DATE('17/12/2023', 'DD/MM/YYYY'), 'L01', 'Viet Nam', 400, 520, 'Kg');
INSERT INTO ch1.HAISAN VALUES('HS022', 'Tom Su Ngop', TO_DATE('23/11/2023', 'DD/MM/YYYY'), 'L01', 'Viet Nam', 200, 270, 'Kg');
INSERT INTO ch1.HAISAN VALUES('HS023', 'Muc Trung Size Nho', TO_DATE('09/11/2023', 'DD/MM/YYYY'), 'L03', 'Phu Quoc', 230, 350, 'Kg');
INSERT INTO ch1.HAISAN VALUES('HS024', 'Cua Bien Ca Mau Ngop', TO_DATE('13/12/2023', 'DD/MM/YYYY'), 'L04', 'Ca Mau', 330, 460, 'Kg');
INSERT INTO ch1.HAISAN VALUES('HS025', 'Vem Xanh', TO_DATE('06/12/2023', 'DD/MM/YYYY'), 'L10', 'Viet Nam', 230, 270, 'Kg');
INSERT INTO ch1.HAISAN VALUES('HS026', 'Ghe Cang Xanh', TO_DATE('20/12/2023', 'DD/MM/YYYY'), 'L07', 'Viet Nam', 280, 400, 'Kg');
INSERT INTO ch1.HAISAN VALUES('HS027', 'Ca Dieu Hong', TO_DATE('05/12/2023', 'DD/MM/YYYY'), 'L02', 'Viet Nam', 20, 30, 'Kg');
INSERT INTO ch1.HAISAN VALUES('HS028', 'Oc Buou Vang', TO_DATE('25/11/2023', 'DD/MM/YYYY'), 'L06', 'Viet Nam', 40, 55, 'Kg');
INSERT INTO ch1.HAISAN VALUES('HS029', 'Ghe Xanh To', TO_DATE('11/12/2023', 'DD/MM/YYYY'), 'L07', 'Trung Quoc', 260, 380, 'Kg');
INSERT INTO ch1.HAISAN VALUES('HS030', 'Sao Bien', TO_DATE('20/09/2023', 'DD/MM/YYYY'), 'L09', 'Phu Quoc', 120, 200, 'Kg');

--Loai
INSERT INTO ch1.LOAI VALUES('L01', 'Tom');
INSERT INTO ch1.LOAI VALUES('L02', 'Ca');
INSERT INTO ch1.LOAI VALUES('L03', 'Muc');
INSERT INTO ch1.LOAI VALUES('L04', 'Cua');
INSERT INTO ch1.LOAI VALUES('L05', 'Ngheu');
INSERT INTO ch1.LOAI VALUES('L06', 'Oc');
INSERT INTO ch1.LOAI VALUES('L07', 'Ghe');
INSERT INTO ch1.LOAI VALUES('L08', 'So');
INSERT INTO ch1.LOAI VALUES('L09', 'Sao');
INSERT INTO ch1.LOAI VALUES('L10', 'Vem');
INSERT INTO ch1.LOAI VALUES('L11', 'Khac');

--BANG NHANVIEN
INSERT INTO ch1.NHANVIEN (TenNV, DiaChi, SoDT, Luong, MaCH) VALUES('Luu Vinh Phat', 'Quan 2, HCM', '0764484234', 15000000, 'CH001');
INSERT INTO ch1.NHANVIEN (TenNV, DiaChi, SoDT, Luong, MaCH) VALUES('Do Huynh My Tam', 'Quan 3, HCM', '0964484234', 15000000, 'CH001');
INSERT INTO ch1.NHANVIEN (TenNV, DiaChi, SoDT, Luong, MaCH) VALUES('Nguyen Minh Duy', 'Quan 4, HCM', '0934484234', 15000000, 'CH001');
INSERT INTO ch1.NHANVIEN (TenNV, DiaChi, SoDT, Luong, MaCH) VALUES('Tran Van The', 'Quan 5, HCM', '0864484234', 12000000, 'CH001');
INSERT INTO ch1.NHANVIEN (TenNV, DiaChi, SoDT, Luong, MaCH) VALUES('Nguyen Van A', 'Quan 6, HCM', '0864484333', 12000000, 'CH001');
INSERT INTO ch1.NHANVIEN (TenNV, DiaChi, SoDT, Luong, MaCH) VALUES('Nguyen Van B', 'Quan 7, HCM', '0454484335', 5000000, 'CH001');
INSERT INTO ch1.NHANVIEN (TenNV, DiaChi, SoDT, Luong, MaCH) VALUES('Nguyen Van C', 'Quan 8, HCM', '0764484555', 6000000, 'CH001');
INSERT INTO ch1.NHANVIEN (TenNV, DiaChi, SoDT, Luong, MaCH) VALUES('Nguyen Van D', 'Quan 9, HCM', '0894484666', 7000000, 'CH001');
INSERT INTO ch1.NHANVIEN (TenNV, DiaChi, SoDT, Luong, MaCH) VALUES('Nguyen Van E', 'Quan 10, HCM', '0324484666', 8000000, 'CH001');
INSERT INTO ch1.NHANVIEN (TenNV, DiaChi, SoDT, Luong, MaCH) VALUES('Nguyen Van F', 'Quan 11, HCM', '0724484667', 9000000, 'CH001');
INSERT INTO ch1.NHANVIEN (TenNV, DiaChi, SoDT, Luong, MaCH) VALUES('Nguyen Van G', 'Quan 12, HCM', '0724484669', 9500000, 'CH001');
INSERT INTO ch1.NHANVIEN (TenNV, DiaChi, SoDT, Luong, MaCH) VALUES('Nguyen Van H', 'Quan 8, HCM', '0324484789', 9500000, 'CH001');
INSERT INTO ch1.NHANVIEN (TenNV, DiaChi, SoDT, Luong, MaCH) VALUES('Nguyen Van I', 'Quan 10, HCM', '0924484345', 9500000, 'CH001');
INSERT INTO ch1.NHANVIEN (TenNV, DiaChi, SoDT, Luong, MaCH) VALUES('Nguyen Van J', 'Quan 12, HCM', '0924484452', 8500000, 'CH001');
INSERT INTO ch1.NHANVIEN (TenNV, DiaChi, SoDT, Luong, MaCH) VALUES('Nguyen Van K', 'Quan Thu Duc, HCM', '0932484111', 8500000, 'CH001');



--Bảng KHACHHANG 
INSERT INTO ch1.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Nguyen Tan Phat', TO_DATE('18/11/2002', 'DD/MM/YYYY'), 'Nam', 'Quan 2, HCM', '0123456781',TO_DATE('19/11/2023', 'DD/MM/YYYY'));
INSERT INTO ch1.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Le Duc Anh', TO_DATE('19/01/2002', 'DD/MM/YYYY'), 'Nam', 'Quan 3, HCM', '0123456789',TO_DATE('19/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch1.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Nguyen Phuc Hau', TO_DATE('19/01/2002', 'DD/MM/YYYY'), 'Nam', 'Quan 4, HCM', '0123456789',TO_DATE('18/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch1.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Tu Ngoc Yen', TO_DATE('05/05/2002', 'DD/MM/YYYY'), 'Nu', 'Quan 5, HCM', '0123456788',TO_DATE('18/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch1.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Huynh Thi Nhu', TO_DATE('18/03/2002', 'DD/MM/YYYY'), 'Nu', 'Quan 6, HCM', '0123456787',TO_DATE('06/11/2023', 'DD/MM/YYYY'));
INSERT INTO ch1.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Bui Thi Thanh', TO_DATE('08/08/2002', 'DD/MM/YYYY'), 'Nu', 'Quan 7, HCM', '0123456786',TO_DATE('07/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch1.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Nguyen Thanh Nhi', TO_DATE('07/11/2001', 'DD/MM/YYYY'), 'Nu', 'Quan 8, HCM', '0123456785',TO_DATE('18/11/2023', 'DD/MM/YYYY'));
INSERT INTO ch1.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Nguyen Thi Thuy Tien', TO_DATE('18/11/2003', 'DD/MM/YYYY'), 'Nu', 'Quan 9, HCM', '0123456784',TO_DATE('25/11/2023', 'DD/MM/YYYY'));
INSERT INTO ch1.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Le Ngoc Thao', TO_DATE('18/02/2000', 'DD/MM/YYYY'), 'Nu', 'Quan 10, HCM', '0123456783',TO_DATE('18/11/2023', 'DD/MM/YYYY'));
INSERT INTO ch1.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Trum Bom Hang', TO_DATE('18/09/1999', 'DD/MM/YYYY'), 'Nam', 'Quan 11, HCM', '0123456782',TO_DATE('20/10/2023', 'DD/MM/YYYY'));
INSERT INTO ch1.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Vua Hai San', TO_DATE('11/11/1999', 'DD/MM/YYYY'), 'Nam', 'Quan 12, HCM', '0123456789' ,TO_DATE('18/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch1.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Le Thi Ngoc Hao', TO_DATE('19/07/1999', 'DD/MM/YYYY'), 'Nu', 'Quan 1, HCM', '0123456799',TO_DATE('19/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch1.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Le Ngoc Thu Thao', TO_DATE('12/08/1996', 'DD/MM/YYYY'), 'Nu', 'Quan 2, HCM', '0123456798',TO_DATE('14/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch1.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Nguyen Tan Thanh', TO_DATE('19/10/1996', 'DD/MM/YYYY'), 'Nam', 'Quan 3, HCM', '0123456797',TO_DATE('10/10/2023', 'DD/MM/YYYY'));
INSERT INTO ch1.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Nguyen Van Anh', TO_DATE('19/06/1996', 'DD/MM/YYYY'), 'Nam', 'Quan 4, HCM', '0123456796',TO_DATE('10/10/2023', 'DD/MM/YYYY'));
INSERT INTO ch1.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Nguyen Thi Be Ba', TO_DATE('07/07/1996', 'DD/MM/YYYY'), 'Nu', 'Quan 5, HCM', 0123456795 ,TO_DATE('21/10/2023', 'DD/MM/YYYY'));
INSERT INTO ch1.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Nguyen Trung Kien', TO_DATE('21/03/2002', 'DD/MM/YYYY'), 'Nam', 'Quan 6, HCM', 0123456796 ,TO_DATE('20/09/2023', 'DD/MM/YYYY'));
INSERT INTO ch1.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Nguyen Trung Truc', TO_DATE('21/04/2002', 'DD/MM/YYYY'), 'Nam', 'Quan 7, HCM', 0123456797 ,TO_DATE('21/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch1.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Nguyen Anh Huy', TO_DATE('22/03/2001', 'DD/MM/YYYY'), 'Nam', 'Quan 8, HCM', 0123456778 ,TO_DATE('21/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch1.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Nguyen Thi Nhu Quynh', TO_DATE('20/12/2000', 'DD/MM/YYYY'), 'Nu', 'Quan 9, HCM', 0123456779 ,TO_DATE('21/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch1.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Huynh Nhu Hao', TO_DATE('21/05/2002', 'DD/MM/YYYY'), 'Nam', 'Quan 8, HCM', 0123456777 ,TO_DATE('18/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch1.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Tran Anh Duc', TO_DATE('24/04/2002', 'DD/MM/YYYY'), 'Nam', 'Quan 1, HCM', 0123456798 ,TO_DATE('21/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch1.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Vo Thi Ha Trang', TO_DATE('09/09/1994', 'DD/MM/YYYY'), 'Nu', 'Quan 7, HCM', 0123456771 ,TO_DATE('20/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch1.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Tran Thu Thao', TO_DATE('11/07/1995', 'DD/MM/YYYY'), 'Nu', 'Quan 2, HCM', 0123456772 ,TO_DATE('21/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch1.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Vo Quang Minh', TO_DATE('30/03/1996', 'DD/MM/YYYY'), 'Nam', 'Quan 12, HCM', 0123456773 ,TO_DATE('22/09/2023', 'DD/MM/YYYY'));
INSERT INTO ch1.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Nguyen Ngoc Tho', TO_DATE('05/09/2003', 'DD/MM/YYYY'), 'Nu', 'Quan 11, HCM', 0123456774 ,TO_DATE('22/09/2023', 'DD/MM/YYYY'));
INSERT INTO ch1.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Tran Anh Tu', TO_DATE('14/01/2000', 'DD/MM/YYYY'), 'Nam', 'Thu Duc, HCM', 0123456775 ,TO_DATE('20/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch1.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Ly Ly', TO_DATE('21/10/1997', 'DD/MM/YYYY'), 'Nu', 'Thu Duc, HCM', 0123456776 ,TO_DATE('20/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch1.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Duong Qua', TO_DATE('12/12/1996', 'DD/MM/YYYY'), 'Nam', 'Ben Cat, Binh Duong', 0123456761 ,TO_DATE('22/09/2023', 'DD/MM/YYYY'));
INSERT INTO ch1.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Than Dieu Dai Hiep', TO_DATE('13/02/1985', 'DD/MM/YYYY'), 'Nam', 'Bien Hoa, Dong Nai', 0123456762 ,TO_DATE('22/12/2023', 'DD/MM/YYYY'));
INSERT INTO ch1.KHACHHANG (TenKH, NgaySinh, GioiTinh, DiaChi, Phone, NgayDK) VALUES('Quach Tinh', TO_DATE('05/02/2004', 'DD/MM/YYYY'), 'Nam', 'Quan 6, HCM', 0123456763 ,TO_DATE('20/12/2023', 'DD/MM/YYYY'));

--Bảng KHOHS_QLKHO 
INSERT INTO ch1.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES('HS001', 22, TO_DATE('05/12/2023', 'DD/MM/YYYY'));

INSERT INTO ch1.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES('HS002', 16, TO_DATE('06/12/2023', 'DD/MM/YYYY'));

INSERT INTO ch1.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES('HS003', 20, TO_DATE('06/12/2023', 'DD/MM/YYYY'));

INSERT INTO ch1.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES('HS004', 22, TO_DATE('06/12/2023', 'DD/MM/YYYY'));

INSERT INTO ch1.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES('HS005', 0, TO_DATE('07/12/2023', 'DD/MM/YYYY'));

INSERT INTO ch1.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES('HS006', 12, TO_DATE('04/12/2023', 'DD/MM/YYYY'));

INSERT INTO ch1.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES('HS007', 7, TO_DATE('30/11/2023', 'DD/MM/YYYY'));

INSERT INTO ch1.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES('HS008', 33, TO_DATE('05/12/2023', 'DD/MM/YYYY'));

INSERT INTO ch1.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES('HS009', 0, TO_DATE('15/12/2023', 'DD/MM/YYYY'));

INSERT INTO ch1.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES('HS010', 29, TO_DATE('11/12/2023', 'DD/MM/YYYY'));

INSERT INTO ch1.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES('HS011', 45, TO_DATE('10/12/2023', 'DD/MM/YYYY'));

INSERT INTO ch1.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES('HS012', 17, TO_DATE('27/11/2023', 'DD/MM/YYYY'));

INSERT INTO ch1.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES('HS013', 11, TO_DATE('05/12/2023', 'DD/MM/YYYY'));

INSERT INTO ch1.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES('HS014', 5, TO_DATE('18/12/2023', 'DD/MM/YYYY'));

INSERT INTO ch1.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES('HS015', 0, TO_DATE('19/12/2023', 'DD/MM/YYYY'));

INSERT INTO ch1.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES('HS016', 0, TO_DATE('20/12/2023', 'DD/MM/YYYY'));

INSERT INTO ch1.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES('HS017', 5, TO_DATE('21/12/2023', 'DD/MM/YYYY'));

INSERT INTO ch1.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES('HS018', 13, TO_DATE('24/11/2023', 'DD/MM/YYYY'));

INSERT INTO ch1.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES('HS019', 0, TO_DATE('05/12/2023', 'DD/MM/YYYY'));

INSERT INTO ch1.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES('HS020', 0, TO_DATE('13/12/2023', 'DD/MM/YYYY'));

INSERT INTO ch1.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES('HS021', 11, TO_DATE('14/12/2023', 'DD/MM/YYYY'));

INSERT INTO ch1.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES('HS022', 0, TO_DATE('05/12/2023', 'DD/MM/YYYY'));

INSERT INTO ch1.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES('HS023', 22, TO_DATE('22/12/2023', 'DD/MM/YYYY'));

INSERT INTO ch1.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES('HS024', 9, TO_DATE('20/12/2023', 'DD/MM/YYYY'));

INSERT INTO ch1.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES('HS025', 6, TO_DATE('08/12/2023', 'DD/MM/YYYY'));

INSERT INTO ch1.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES('HS026', 8, TO_DATE('09/12/2023', 'DD/MM/YYYY'));

INSERT INTO ch1.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES('HS027', 1, TO_DATE('16/12/2023', 'DD/MM/YYYY'));

INSERT INTO ch1.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES('HS028', 0, TO_DATE('18/12/2023', 'DD/MM/YYYY'));

INSERT INTO ch1.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES('HS029', 4, TO_DATE('22/12/2023', 'DD/MM/YYYY'));

INSERT INTO ch1.KHOHS_QLKHO (MAHS, SoLuong, NgayCapNhat) VALUES('HS030', 3, TO_DATE('04/12/2023', 'DD/MM/YYYY'));


--Bang KHOHS_NVBH
INSERT INTO ch1.KHOHS_NVBH  (MaHS, Tinhtrang) VALUES('HS001', 'Con hang');

INSERT INTO ch1.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS002', 'Con hang');

INSERT INTO ch1.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS003', 'Con hang');

INSERT INTO ch1.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS004', 'Con hang');

INSERT INTO ch1.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS005', 'Het hang');

INSERT INTO ch1.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS006', 'Con hang');

INSERT INTO ch1.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS007', 'Con hang');

INSERT INTO ch1.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS008', 'Con hang');

INSERT INTO ch1.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS009', 'Het hang');

INSERT INTO ch1.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS010', 'Con hang');

INSERT INTO ch1.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS011', 'Con hang');

INSERT INTO ch1.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS012', 'Con hang');

INSERT INTO ch1.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS013', 'Con hang');

INSERT INTO ch1.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS014', 'Con hang');

INSERT INTO ch1.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS015', 'Het hang');

INSERT INTO ch1.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS016', 'Het hang');

INSERT INTO ch1.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS017', 'Con hang');

INSERT INTO ch1.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS018', 'Con hang');

INSERT INTO ch1.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS019', 'Het hang');

INSERT INTO ch1.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS020', 'Het hang');

INSERT INTO ch1.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS021', 'Con hang');

INSERT INTO ch1.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS022', 'Het hang');

INSERT INTO ch1.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS023', 'Con hang');

INSERT INTO ch1.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS024', 'Con hang');

INSERT INTO ch1.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS025', 'Con hang');

INSERT INTO ch1.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS026', 'Con hang');

INSERT INTO ch1.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS027', 'Con hang');

INSERT INTO ch1.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS028', 'Het hang');

INSERT INTO ch1.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS029', 'Con hang');

INSERT INTO ch1.KHOHS_NVBH (MaHS, Tinhtrang) VALUES('HS030', 'Con hang');

--Cua Hang
INSERT INTO ch1.CUAHANG VALUES('CH001', 'Hai San Good', '19A Phuong Linh Trung, Thu Duc', '0764484234');



--HoaDon 
--HOADON(MAHD VARCHAR(20) PRIMARY KEY, MANV VARCHAR(20), MAKH VARCHAR(20), NgayLap DATE, TongTien NUMBER);

INSERT INTO ch1.HOADON (MANV, MAKH, NgayLap, TongTien) VALUES('NV001', 'KH002', TO_DATE('16/12/2023', 'DD/MM/YYYY'), 2500);
INSERT INTO ch1.HOADON (MANV, MAKH, NgayLap, TongTien) VALUES('NV001', 'KH003', TO_DATE('16/12/2023', 'DD/MM/YYYY'), 4500);
INSERT INTO ch1.HOADON (MANV, MAKH, NgayLap, TongTien) VALUES('NV002', 'KH001', TO_DATE('16/12/2023', 'DD/MM/YYYY'), 2000);
INSERT INTO ch1.HOADON (MANV, MAKH, NgayLap, TongTien) VALUES('NV002', 'KH004', TO_DATE('16/12/2023', 'DD/MM/YYYY'), 680);
INSERT INTO ch1.HOADON (MANV, MAKH, NgayLap, TongTien) VALUES('NV003', 'KH005', TO_DATE('16/12/2023', 'DD/MM/YYYY'), 1500);
INSERT INTO ch1.HOADON (MANV, MAKH, NgayLap, TongTien) VALUES('NV003', 'KH005', TO_DATE('17/12/2023', 'DD/MM/YYYY'), 1260);
INSERT INTO ch1.HOADON (MANV, MAKH, NgayLap, TongTien) VALUES('NV004', 'KH007', TO_DATE('16/12/2023', 'DD/MM/YYYY'), 1500);
INSERT INTO ch1.HOADON (MANV, MAKH, NgayLap, TongTien) VALUES('NV004', 'KH003', TO_DATE('18/12/2023', 'DD/MM/YYYY'), 300);
INSERT INTO ch1.HOADON (MANV, MAKH, NgayLap, TongTien) VALUES('NV005', 'KH009', TO_DATE('16/12/2023', 'DD/MM/YYYY'), 1000);
INSERT INTO ch1.HOADON (MANV, MAKH, NgayLap, TongTien) VALUES('NV005', 'KH010', TO_DATE('16/12/2023', 'DD/MM/YYYY'), 2400);
INSERT INTO ch1.HOADON (MANV, MAKH, NgayLap, TongTien) VALUES('NV006', 'KH015', TO_DATE('21/12/2023', 'DD/MM/YYYY'), 180);
--CTHD
INSERT INTO ch1.CTHD VALUES ('HD001', 'HS001', 2);
INSERT INTO ch1.CTHD VALUES ('HD001', 'HS002', 1);

INSERT INTO ch1.CTHD VALUES ('HD002', 'HS004', 3);

INSERT INTO ch1.CTHD VALUES ('HD003', 'HS003', 4);
INSERT INTO ch1.CTHD VALUES ('HD004', 'HS010', 2);
INSERT INTO ch1.CTHD VALUES ('HD004', 'HS009', 1);
INSERT INTO ch1.CTHD VALUES ('HD005', 'HS011', 2);
INSERT INTO ch1.CTHD VALUES ('HD006', 'HS006', 3);

INSERT INTO ch1.CTHD VALUES ('HD007', 'HS012', 2);
INSERT INTO ch1.CTHD VALUES ('HD008', 'HS008', 5); 

INSERT INTO ch1.CTHD VALUES ('HD009', 'HS020', 5); 

INSERT INTO ch1.CTHD VALUES ('HD010', 'HS013', 2); 
INSERT INTO ch1.CTHD VALUES ('HD010', 'HS004', 1); 
INSERT INTO ch1.CTHD VALUES ('HD011', 'HS008', 3); 


--PHAN QUYEN (NHỚ ĐỌC LẠI)
    
CREATE USER giamdocreal identified by giamdocreal;
grant create session, connect to giamdocreal;
grant insert, select, update, delete on ch1.KHACHHANG to giamdocreal;
grant insert, select, update, delete on ch1.NHANVIEN to giamdocreal;
grant insert, select, update, delete on ch1.HAISAN to giamdocreal;
grant insert, select, update, delete on ch1.CUAHANG to giamdocreal;
grant insert, select, update, delete on ch1.LOAI to giamdocreal;
grant insert, select, update, delete on ch1.HOADON to giamdocreal;
grant insert, select, update, delete on ch1.CTHD to giamdocreal;
grant insert, select, update, delete on ch1.KHOHS_QLKHO to giamdocreal;
grant select on ch1.KHOHS_NVBH to giamdocreal;

CREATE USER TruongKho identified by truongkho;
grant create session, connect to TruongKho;
grant insert, select, update, delete on ch1.KHOHS_QLKHO to TruongKho;
grant insert, select, update, delete on ch1.HAISAN to TruongKho;
grant insert, select, update, delete on ch1.LOAI to TruongKho;
grant select on ch1.KHACHHANG to TruongKho;
grant select on ch1.KHOHS_NVBH to TruongKho;
grant select on ch1.CUAHANG to TruongKho;
grant select on ch1.HOADON to TruongKho;
grant select on ch1.CTHD to TruongKho;

CREATE USER NhanVien identified by nhanvien;
grant create session, connect to NhanVien;
grant insert, select, update, delete on ch1.KHACHHANG to NhanVien;
grant insert, select, update, delete on ch1.HOADON to NhanVien;
grant insert, select, update, delete on ch1.CTHD to NhanVien;
grant select on ch1.HAISAN to NhanVien;
grant select on ch1.NHANVIEN to NhanVien;
grant select on ch1.LOAI to NhanVien;
grant select on ch1.CUAHANG to NhanVien;

CREATE USER ch2 identified by ch2;
grant create session, connect, dba to ch2;
grant select on ch1.KHACHHANG to ch2;
grant select on ch1.NHANVIEN to ch2;
grant select on ch1.HAISAN to ch2;
grant select on ch1.CUAHANG to ch2;
grant select on ch1.LOAI to ch2;
grant select on ch1.HOADON to ch2;
grant select on ch1.CTHD to ch2;
grant select on ch1.KHOHS_QLKHO to ch2;
grant select on ch1.KHOHS_NVBH to ch2;

--DATABASE LINK
create public database link ch2_dblink connect to ch1 identified by ch1 using 'ch2';
create public database link ch2_dblink_gd connect to giamdocreal identified by giamdocreal using 'ch2';
create public database link ch2_dblink_tk connect to TruongKho identified by truongkho using 'ch2';
create public database link ch2_dblink_nv connect to NhanVien identified by nhanvien using 'ch2';





1 Khách hàng mua hàng cả hai chi nhánh (Tại CN2, tk nhanvien)
    SELECT DISTINCT KH1.makh, KH1.tenkh as ho_ten
    FROM ch1.KHACHHANG@ch1_dblink_nv KH1, ch1.HOADON@ch1_dblink_nv HD1 
    WHERE KH1.makh=HD1.makh
    INTERSECT
    SELECT DISTINCT KH2.makh, KH2.tenkh as ho_ten
    FROM ch2.KHACHHANG KH2, ch2.HOADON HD2
    WHERE KH2.makh=HD2.makh


2 Nhân viên có lương từ 10 triệu của cả 2 chi nhánh (CN1 giamdoc)
    SELECT n1.MANV, n1.TenNV, n1.Luong, 'Cua Hang 1' AS CH
    FROM ch1.NHANVIEN n1
    WHERE n1.Luong >= 10000000
    UNION
    SELECT n2.MANV, n2.TenNV,n2.Luong, 'Cua Hang 2' AS CH
    FROM ch2.NHANVIEN@ch2_dblink n2
    WHERE n2.Luong >= 10000000;

3 'giám đốc' tìm ra hải sản được mua nhiều nhất tại từng chi nhánh (CN1)
(SELECT HS1.mahs, HS1.tenhs, SUM(CTHD1.soluong) AS sl_banduoc
FROM ch1.HAISAN HS1, ch1.CTHD CTHD1
WHERE HS1.mahs = CTHD1.mahs 
GROUP BY HS1.mahs, HS1.tenhs
ORDER BY SUM(CTHD1.soluong) DESC
FETCH FIRST 1 ROWS WITH TIES)
UNION
(SELECT HS2.mahs, HS2.tenhs, SUM(CTHD2.soluong) AS sl_banduoc
FROM ch2.HAISAN@ch2_dblink_gd HS2, ch2.CTHD@ch2_dblink_gd CTHD2
WHERE HS2.mahs = CTHD2.mahs
GROUP BY HS2.mahs, HS2.tenhs
ORDER BY SUM(CTHD2.soluong) DESC
FETCH FIRST 1 ROWS WITH TIES);


4 
SELECT HS.mahs, HS.tenhs 
FROM ch2.HAISAN HS, ch2.KHOHS_QLKHO@ch2_dblink K2 WHERE HS.mahs = K2.mahs
MINUS
SELECT HS.mahs, HS.tenhs, SUM(soluong) as tongbanduoc
FROM (SELECT HS1.mahs, HS1.tenhs, SUM(CTHD1.soluong) AS soluongbanduoc
	FROM ch1.HAISAN HS1, ch1.CTHD CTHD1
	WHERE HS1.mahs = CTHD1.mahs
	GROUP BY HS1.mahs, HS1.tenhs
	UNION ALL
	SELECT HS2.mahs, HS2.tenhs, SUM(CTHD2.soluong) as soluongbanduoc
	FROM ch2.dbHAISAN@ch2_dblink HS2, ch2.dbCTHD@ch2_dblink CTHD2
	WHERE HS2.mahs = CTHD2.mahs 
	GROUP BY HS2.mahs, HS2.tenhs)
GROUP BY mahs, tenhs
ORDER BY tongbanduoc DESC FETCH NEXT 3 ROW ONLY; //chua duoc


--4 Top 3 sản phẩm có doanh số cao nhất ở tất cả cửa hàng (giam doc)
SELECT HSID, HSNAME, SL_BANDUOC 
FROM (
    SELECT HSID, HSNAME, COALESCE(SUM(SL_BANDUOC), 0) AS SL_BANDUOC
    FROM (
        SELECT HS2.MAHS AS HSID, HS2.TenHS AS HSNAME, CTHD2.SoLuong AS SL_BANDUOC
        FROM ch1.HAISAN HS2
        LEFT JOIN ch2.CTHD@ch2_dblink_gd CTHD2 ON HS2.MAHS = CTHD2.MAHS
        UNION ALL
        SELECT HS1.MAHS AS HSID, HS1.TenHS AS HSNAME, CTHD1.SoLuong AS SL_BANDUOC
        FROM ch1.HAISAN HS1
        LEFT JOIN ch1.CTHD CTHD1 ON HS1.MAHS = CTHD1.MAHS
    )
    GROUP BY HSID, HSNAME
    ORDER BY SL_BANDUOC DESC
)
WHERE ROWNUM <= 3;

5. GiamDoc liệt kê số lượng nhân viên ở mỗi chi nhánh
SELECT MACH, SLNV AS SoLuongNhanVien
FROM (SELECT NV1.mach , count(NV1.manv) as SLNV
      FROM ch1.NHANVIEN NV1
      GROUP BY NV1.mach
      UNION ALL
      SELECT NV2.mach, COUNT(NV2.manv) AS SLNV
      FROM ch2.NHANVIEN@ch2_dblink NV2
      GROUP BY NV2.mach);

6. TruongKho liet ke sp het hang o ca hai cua hang
SELECT DISTINCT HS1.MAHS, HS1.TenHS
FROM ch1.HAISAN HS1, ch1.KHOHS_NVBH KH1 
WHERE HS1.MAHS = KH1.MAHS AND KH1.tinhtrang = 'Het hang'
INTERSECT
SELECT DISTINCT HS2.MAHS, HS2.TenHS
FROM ch2.HAISAN@ch2_dblink_tk HS2, ch2.KHOHS_NVBH@ch2_dblink_tk KH2 
WHERE HS2.MAHS = KH2.MAHS AND KH2.tinhtrang = 'Het hang';

7. Tìm sản phẩm  có xuất xứ tại Việt Nam và được bán hơn 2 sản phẩm ở mỗi chi nhánh (Nhân viên tại CN1)
(SELECT HS1.MAHS, HS1.TenHS, HS1.XuatXu, HS1.GiaBan, SUM(SoLuong) AS SUM_SoLuong, 'Cua Hang 1' as CH
FROM ch1.HAISAN HS1, ch1.CTHD CTHD1
WHERE HS1.XuatXu = 'Viet Nam' AND HS1.MAHS = CTHD1.MAHS
HAVING SUM(CTHD1.SoLuong) > 2
GROUP BY HS1.MAHS, HS1.TenHS, HS1.XuatXu, HS1.GiaBan)
UNION
(SELECT HS2.MAHS, HS2.TenHS, HS2.XuatXu, HS2.GiaBan, SUM(SoLuong) AS SUM_SoLuong, 'Cua Hang 2' as CH
FROM ch2.HAISAN@ch2_dblink_nv HS2, 
ch2.CTHD@ch2_dblink CTHD2
WHERE HS2.XuatXu = 'Viet Nam' AND HS2.MAHS = CTHD2.MAHS
HAVING SUM(CTHD2.SoLuong) > 2
GROUP BY HS2.MAHS, HS2.TenHS, HS2.XuatXu, HS2.GiaBan);


8. Tìm KH có số lần mua lớn hơn 2 và được phục vụ bởi 3 nhân viên (Tk CH1)
SELECT MA_KH, Ten_KH, SUM(SO_LAN_MUA) AS TONG_SO_LAN_MUA, SUM(SO_NV_THANHTOAN) AS TONG_SO_NV_THANHTOAN
FROM
	(SELECT KH1.MAKH AS MA_KH, KH1.TenKH AS Ten_KH, COUNT(HD1.MAHD) AS SO_LAN_MUA, COUNT(DISTINCT HD1.MANV) AS SO_NV_THANHTOAN
 	FROM ch1.KHACHHANG KH1, ch1.HOADON HD1
 	WHERE KH1.MAKH = HD1.MAKH
 	GROUP BY KH1.MAKH, KH1.TenKH
	UNION ALL
 	SELECT KH2.MAKH, KH2.TenKH AS Ten_KH, COUNT(HD2.MAHD) AS SO_LAN_MUA, COUNT(DISTINCT HD2.MANV) AS SO_NV_THANHTOAN
 	FROM ch2.KHACHHANG@ch2_dblink KH2, ch2.HOADON@ch2_dblink HD2
 	WHERE KH2.MaKH = HD2.MaKH
 	GROUP BY KH2.MAKH, KH2.TenKH)
GROUP BY MA_KH, Ten_KH
HAVING SUM(SO_LAN_MUA) >= 2 AND SUM(SO_NV_THANHTOAN) >= 3;

9. GiamDoc tìm khách hàng đã mua tất cả những hải sản có xuất sứ là 'Viet Nam'
SELECT KH1.makh, KH1.tenkh AS ho_ten
FROM ch1.KHACHHANG KH1
WHERE NOT EXISTS (
    SELECT *
    FROM ch1.HAISAN HS1
    WHERE HS1.xuatxu = 'Viet Nam'
      AND NOT EXISTS (
        SELECT *
        FROM (
          (SELECT *
          FROM ch1.HOADON HD1
          JOIN ch1.CTHD CTHD1 ON HD1.mahd = CTHD1.mahd AND CTHD1.mahs = HS1.mahs
          WHERE HD1.makh = KH1.makh
          UNION
          SELECT *
          FROM ch2.HOADON@ch2_dblink_gd HD2
          JOIN ch2.CTHD@ch2_dblink_gd CTHD2 ON HD2.mahd = CTHD2.mahd AND CTHD2.mahs = HS1.mahs
          WHERE HD2.makh = KH1.makh)
        )
      )
);

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
MAY 2:
SELECT MANV, TenNV, Luong, MACH FROM ch2.NHANVIEN WHERE MANV = 'NV017';
MAY 1:
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



