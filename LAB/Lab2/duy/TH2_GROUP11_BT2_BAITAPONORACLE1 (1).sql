--Thêm dữ liệu cả 2 chi nhánh

ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YY HH24:MI:SS';
CREATE TABLE SACH
(
MaSach VARCHAR2(5) CONSTRAINT PK_SACH PRIMARY KEY,
TenSach VARCHAR2(50),
NgayXB DATE,
TacGia VARCHAR2(50),
GiaTien INT,
NhaXuatBan VARCHAR2(20),
LanIn NUMBER
);

CREATE TABLE CHINHANH
(
    MaChiNhanh VARCHAR2(4) CONSTRAINT PK_CHINHANH PRIMARY KEY,
    TenChiNhanh VARCHAR2(50),
    SoDT VARCHAR2(12)
);

CREATE TABLE KHOSACH_QLKHO
(
    MaChiNhanh VARCHAR2(4),
    MaSach VARCHAR2(5),
    SoLuong NUMBER,
    NgayCapNhat DATE,
    CONSTRAINT PK_KS_QLK PRIMARY KEY (MaChiNhanh,MaSach)
);

CREATE TABLE KHOSACH_NVBH (
    MaChiNhanh VARCHAR(4),
    MaSach VARCHAR(5),
    TinhTrang VARCHAR (10),
    KhuyenMai NUMBER ,
    CONSTRAINT PK_KHOSACH_NVBH PRIMARY KEY(MaChiNhanh,MaSach)
);

CREATE TABLE NHANVIEN (
    MaNV VARCHAR(4) CONSTRAINT PK_NV PRIMARY KEY,
    TenNV VARCHAR(50),
    DiaChi VARCHAR(30),
    SoDT VARCHAR(20),
    Luong NUMBER ,
    MaChiNhanh VARCHAR(4)
);

--SACH
INSERT INTO SACH VALUES('Book1', 'SpyxFamily T.6', '29/10/2021', 'Endou Tatsuya', 25000, 'Kim Dong', 1);
INSERT INTO SACH VALUES('Book2', 'S. Family T.6 L', '29/10/2021', 'Endou Tatsuya', 45000, 'Kim Dong', 1);
INSERT INTO SACH VALUES('Book3','Th.L?ng B.H', Null, 'Agatha Christie', 120000, 'Tre', 1);
INSERT INTO SACH VALUES('Book4', 'Black Jack 3', '25/10/2021', 'Osamu Tezuka', 30000, 'Tre', 1);
INSERT INTO SACH VALUES('Book5', 'One Piece 90', '11/10/2021', 'Eiichiro Oda', 19500, 'Kim Dong', 2);

-- CHINHANH
INSERT INTO CHINHANH VALUES('CN01', 'Quan 3, TPHCM', '0939013914');
	
-- KHOSACH_QLKHO
INSERT INTO KHOSACH_QLKHO VALUES('CN01', 'Book1', 0,'29/10/2021');
INSERT INTO KHOSACH_QLKHO VALUES('CN01', 'Book3', 510,'30/10/2021');
INSERT INTO KHOSACH_QLKHO VALUES('CN01', 'Book5', 100,'30/10/2021');

-- KHOSACH_NVBH
INSERT INTO KHOSACH_NVBH VALUES ('CN01','Book1','Het Hang',0);
INSERT INTO KHOSACH_NVBH VALUES ('CN01','Book3','Con Hang',20);
INSERT INTO KHOSACH_NVBH VALUES ('CN01','Book5','Con Hang',20);

-- NHANVIEN
INSERT INTO NHANVIEN VALUES('NV03','Ho Trong Khang','Binh Dinh','0858595208',5200000,'CN01');
INSERT INTO NHANVIEN VALUES('NV04','Ho Huu Thang','Bien Hoa',Null,5200000,'CN01');
INSERT INTO NHANVIEN VALUES('NV06','Tran Thi Ngoc An ','Binh Dinh','0944052874',5200000,'CN01');



--CHI NHÁNH 1
--PHÂN QUYÊN
alter session set "_ORACLE_SCRIPT" = true;

--USER cn1:
create user cn1 identified by cn1;
grant connect, dba to cn1;

--USer GiamDoc
create user giamdoc identified by giamdoc;
create role r_giamdoc;
grant connect to r_giamdoc;
grant create session, dba, connect to r_giamdoc;
grant select on cn1.khosach_NVBH to r_giamdoc;
grant select on cn1.khosach_QLKHO to r_giamdoc;
grant select on cn1.khosach_SACH to r_giamdoc;
grant select on cn1.NHANVIEN to r_giamdoc;
grant r_giamdoc to giamdoc;

--User QuanLyKho
create user qlk1 identified by quanlykho;
create role r_qlk;
grant select on cn1.SACH to r_qlk;
grant select on cn1.KHOSACH_QLKHO to r_qlk;
grant connect to r_qlk;
grant r_qlk to qlk1;

--User NhanVien
create user nhanvien identified by nhanvien;
create role r_nv;
grant select on cn1.SACH to r_nv;
grant select on cn1.KHOSACH_nvbh to r_nv;
grant connect to r_nv;
grant r_nv to nhanvien;


--USER cn2:
create user cn2 identified by cn2;
grant connect to cn2;
grant select on cn1.SACH to cn2;
grant select on cn1.CHINHANH to cn2;
grant select on cn1.KHOSACH_QLKHO to cn2;
grant select on cn1.KHOSACH_NVBH to cn2;
grant select on cn1.NHANVIEN to cn2;

--CREATE DATABASE LINK
create public database link cn2_link connect to cn1 identified by cn1 using 'cn2';
create public database link cn2_link_giamdoc connect to giamdoc identified by giamdoc using 'cn2';
create public database link cn2_link_nhanvien connect to nhanvien identified by nhanvien using 'cn2';

--QUERY 1:
conn nhanvien/nhanvien
SELECT MACHINHANH, NVBH1.MASACH, TENSACH FROM cn1.KHOSACH_NVBH NVBH1, cn1.SACH S1 WHERE NVBH1.MASACH = S1.MASACH AND TINHTRANG = 'Het Hang'
UNION
SELECT MACHINHANH, NVBH2.MASACH, TENSACH FROM cn2.KHOSACH_NVBH@cn2_link_nhanvien2 NVBH2, cn2.SACH@cn2_link_nhanvien2 S2 WHERE NVBH2.MASACH = S2.MASACH AND TINHTRANG = 'Het Hang';

--QUERY 2:
conn giamdoc/giamdoc
SELECT A.MASACH, TENSACH, C.TINHTRANG
FROM cn1.SACH A, cn1.KHOSACH_QLKHO B, cn1.KHOSACH_NVBH C
WHERE A.MASACH = B.MASACH AND A.MASACH = C.MASACH AND B.MACHINHANH = C.MACHINHANH AND B.MASACH = C.MASACH AND SOLUONG >120 AND TINHTRANG = 'Con Hang'
UNION
SELECT D.MASACH, TENSACH, F.TINHTRANG
FROM cn2.SACH@cn2_link_giamdoc D, cn2.KHOSACH_QLKHO@cn2_link_giamdoc E, cn2.KHOSACH_NVBH@cn2_link_giamdoc F
WHERE D.MASACH = E.MASACH AND D.MASACH = F.MASACH AND E.MACHINHANH = F.MACHINHANH AND E.MASACH = F.MASACH AND SOLUONG >120 AND TINHTRANG = 'Con Hang';

--QUERY 3:
conn qlk1/quanlykho
SELECT TENSACH, NGAYXB, TACGIA, GIATIEN, SOLUONG, LANIN, NGAYCAPNHAT
FROM cn1.SACH S1 JOIN cn1.KHOSACH_QLKHO QL1 ON S1.MASACH=QL1.MASACH
WHERE NHAXUATBAN  = 'Kim Dong';

--QUERY 4:
conn giamdoc/giamdoc
SELECT S1.MASACH, S1.TENSACH FROM CN1.SACH S1 JOIN CN1.KHOSACH_NVBH NVBH1 ON S1.MASACH = NVBH1.MASACH AND NVBH1.TINHTRANG = 'Con Hang'
INTERSECT
SELECT S2.MASACH, S2.TENSACH FROM CN2.SACH@cn2_link_giamdoc S2 JOIN CN2.KHOSACH_NVBH@cn2_link_giamdoc NVBH2 ON S2.MASACH = NVBH2.MASACH AND NVBH2.TINHTRANG = 'Con Hang';

--QUERY 5:

SELECT QL1.MASACH FROM CN1.KHOSACH_QLKHO QL1 
INTERSECT 
SELECT QL2.MASACH FROM CN2.KHOSACH_QLKHO@cn2_link_giamdoc QL2;

-- TRUY VẤN MÔI TRƯỜNG
conn cn1/cn1;
SELECT * FROM cn1.SACH;
SELECT * FROM cn1.CHINHANH;
SELECT * FROM cn1.KHOSACH_QLKHO;
SELECT * FROM cn1.KHOSACH_NVBH;
SELECT * FROM cn1.NHANVIEN;





--CHI NHÁNH 2

--PHÂN QUYÊN
alter session set "_ORACLE_SCRIPT" = true;

--USER cn2:
create user cn2 identified by cn2;
grant connect to cn2;

--User GiamDoc: Xem được thông tin tất cả các quan hệ chi nhánh 1, chi nhánh 2
create user giamdoc identified by giamdoc
grant create session, dba, connect to r_giamdoc;
grant select on cn2.khosach_NVBH to r_giamdoc;
grant select on cn2.khosach_QLKHO to r_giamdoc;
grant select on cn2.SACH to r_giamdoc;
grant select on cn2.NHANVIEN to r_giamdoc;
grant r_giamdoc to giamdoc;
grant connect to giamdoc;

--User QuanLyKho: Xem được SACH, KHOSACH_QLKHO của chi nhánh 1, chi nhánh 2
create user qlk2 identified by quanlykho;
create role r_qlk;
grant select on cn2.SACH to r_qlk;
grant select on cn2.KHOSACH_QLKHO to r_qlk;
grant connect to r_qlk;
grant r_qlk to qlk2;

--User NhanVien: Xem được SACH, KHOSACH_NVBH của chi nhánh 1, chi nhánh 2
create user nhanvien identified by nhanvien;
create role r_nv;
grant select on cn2.SACH to r_nv;
grant select on cn2.KHOSACH_NVBH to r_nv;
grant connect to r_nv;
grant r_nv to nhanvien;


--USER cn1:
create user cn1 identified by cn1;
grant create session to cn1;
grant select on cn2.SACH to cn1;
grant select on cn2.CHINHANH to cn1;
grant select on cn2.KHOSACH_QLKHO to cn1;
grant select on cn2.KHOSACH_NVBH to cn1;
grant select on cn2.nhanvien to cn1;
grant connect to cn1;

--Tạo public database link
create public database link cn1_link connect to cn2 identified by cn2 using 'cn1';
create public database link cn1_link_giamdoc connect to giamdoc identified by giamdoc using 'cn1';
create public database link cn1_link_nhanvien connect to nhanvien identified by nhanvien using 'cn1';

--QUERY 6
SELECT S.MASACH, TENSACH, MAX(KHUYENMAI), COUNT(MACHINHANH)
FROM (	SELECT MACHINHANH, NVBH2.MASACH, TENSACH, KHUYENMAI
	FROM CN2.SACH S2, CN2.KHOSACH_NVBH NVBH2
	WHERE S2.MASACH = NVBH2.MASACH AND NHAXUATBAN = 'Kim Dong'
	UNION
	SELECT MACHINHANH, NVBH1.MASACH, TENSACH, KHUYENMAI
	FROM CN1.SACH@cn1_link_nhanvien S1, CN1.KHOSACH_NVBH@cn1_link_nhanvien NVBH1
	WHERE S1.MASACH = NVBH1.MASACH AND NHAXUATBAN = 'Kim Dong') S
GROUP BY S.MASACH, TENSACH;

-- TRUY VẤN MÔI TRƯỜNG
CONN cn2/cn2;
SELECT * FROM cn2.SACH;
SELECT * FROM cn2.CHINHANH;
SELECT * FROM cn2.KHOSACH_QLKHO;
SELECT * FROM cn2.KHOSACH_NVBH;
SELECT * FROM cn2.NHANVIEN;