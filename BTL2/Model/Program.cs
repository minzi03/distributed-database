using Raven.Client.Documents;
using Raven.Client.Documents.Session;
using ravenDB.Model;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace ravenDB
{
    public static class DocumentStoreHolder
    {
        private static readonly Lazy<IDocumentStore> LazyStore1 =
            new Lazy<IDocumentStore>(() =>
            {
                var store = new DocumentStore
                {
                    Urls = new[] { "http://26.200.45.220:8080/" },
                    Database = "CH1"
                };

                return store.Initialize();
            });
        private static readonly Lazy<IDocumentStore> LazyStore2 =
             new Lazy<IDocumentStore>(() =>
            {
                var store = new DocumentStore
                {
                    Urls = new[] { "http://26.212.104.187:8080/" },
                    Database = "CH2"
                };

                return store.Initialize();
            });

        //Node A ket noi CH2 cua Node B
        private static readonly Lazy<IDocumentStore> LazyStore3 =
            new Lazy<IDocumentStore>(() =>
            {
                var store = new DocumentStore
                {
                    Urls = new[] { "http://26.200.45.220:8080/" },
                    Database = "CH2"
                };

                return store.Initialize();
            });
        //Node B ket noi CH1 cua Node A
        private static readonly Lazy<IDocumentStore> LazyStore4 =
            new Lazy<IDocumentStore>(() =>
            {
                var store = new DocumentStore
                {
                    Urls = new[] { "http://26.212.104.187:8080/" },
                    Database = "CH1"
                };

                return store.Initialize();
            });
        public static IDocumentStore Store1 => LazyStore1.Value;
        public static IDocumentStore Store2 => LazyStore2.Value;

        public static IDocumentStore NodeAtoB => LazyStore3.Value;
        public static IDocumentStore NodeBtoA => LazyStore4.Value;
    }
 
    internal class Program
    {   
        //Tao generic de create theo cua hang
        //tao o ch1
        static void createCH1<T>(T obj)
        {
            using (var session = DocumentStoreHolder.Store1.OpenSession())
            {
                session.Store(obj);
                session.SaveChanges();
            }
        }
        //tao ch 2
        static void createCH2<T>(T obj)
        {
            using (var session = DocumentStoreHolder.Store2.OpenSession())
            {
                session.Store(obj);
                session.SaveChanges();
            }
        }
        //Cua hang 1 tao cho ch 2
        static void AcreateB<T>(T obj)
        {
            using (var session = DocumentStoreHolder.NodeAtoB.OpenSession())
            {
                session.Store(obj);
                session.SaveChanges();
            }
        }
        //cua hang 2 tao cho ch1
        static void BcreateA<T>(T obj)
        {
            using (var session = DocumentStoreHolder.NodeBtoA.OpenSession())
            {
                session.Store(obj);
                session.SaveChanges();
            }
        }
        //Tao bang Hai San
        static void createHaiSan(string id, string name, string Loai, string xuatxu ,double gia, string dvt)
        {
            HaiSan haisan = new HaiSan(id, name, Loai, xuatxu, gia, dvt);
            createCH1(haisan);
            createCH2(haisan);
        }
        //Bang Nhan vien
        static void createNhanVien(string id, string TenNV, string diachi, string phone , double luong, string mach)
        {
            NhanVien nhanVien = new NhanVien(id, TenNV, diachi, phone, luong, mach);
            if (nhanVien.MaCH.Equals("CH01")){
                createCH1(nhanVien);
            }else
            {
                createCH2(nhanVien);
            }
 
        }
        //Bang cua hang
        static void createCuaHang(string id, string TenNV, string diachi, string phone)
        {
            CuaHang cuahang = new CuaHang(id, TenNV, diachi, phone);
            if (cuahang.Id.Equals("CH01"))
            {
                createCH1(cuahang);
            }
            else
            {
                createCH2(cuahang);
            }

        }
        //Bang khach hang
        static void createKhachHang(string id, string tenKH, string diaChi, string phoneNum, string ngaysinh, string gioitinh, string ngaydangki)
        {
            khachhang khachhang = new khachhang(id, tenKH, diaChi, phoneNum, ngaysinh, gioitinh, ngaydangki);
            createCH1(khachhang);
            createCH2(khachhang);
        }
        //Bang QLKHO (NVBH duoc tao ra theo quanlykho)
        static void createKhoHS(string mahs, string mach, double soluong, string ngaycapnhat)
        {
            string id_qlkho = mahs + "_qlkho";
            khohs_qlkho qlkho = new khohs_qlkho(id_qlkho, mach, soluong, ngaycapnhat);
            string tinhtrang = "";
            if(qlkho.Soluong == 0)
            {
                tinhtrang = "Het hang";
            }else
            {
                tinhtrang = "Con hang";
            }
            string id_nvbh = mahs + "_nvbh";
            khohs_nvbh nvbh = new khohs_nvbh(id_nvbh, mach, tinhtrang);
            if (qlkho.Mach.Equals("CH01"))
            {
                createCH1(qlkho);
                createCH1(nvbh);
            }
            else
            {
                createCH2(qlkho); createCH2(nvbh);
            }
        }
        //Bang hoa don
        static void createHoaDon(string id, string manv, string makh, string ngaylap, double tongtien, string mach)
        {
            hoadon hoadon = new hoadon(id, manv, makh, ngaylap, tongtien, mach);
            if (hoadon.Mach.Equals("CH01"))
            {
                createCH1(hoadon);
            }
            else
            {
                createCH2(hoadon);
            }
        }
        //Bang cthd
        static void createCthd(string mahd, string mahs, double soluong, string mach)
        {
            cthd cthd = new cthd(mahd,mahs, soluong, mach);
            if (cthd.mach.Equals("CH01"))
            {
                createCH1(cthd);
            }
            else
            {
                createCH2(cthd);
            }
        }
        //CH1 insert NhanVien cho CN2
        static void InsertNhanVienFromAtoB(string id, string TenNV, string diachi, string phone, double luong)
        {
            NhanVien nv = new NhanVien(id, TenNV, diachi, phone, luong, "CH02");
            AcreateB(nv);
            Console.WriteLine($"Them nhan vien {id} thanh cong");
        }
        //CH2 insert NhanVien cho CN3
        static void InsertNhanVienFromBtoA(string id, string TenNV, string diachi, string phone, double luong)
        {
            NhanVien nv = new NhanVien(id, TenNV, diachi, phone, luong, "CH01");
            BcreateA(nv);
            Console.WriteLine($"Them nhan vien {id} thanh cong");
        }

        //CH1 tự update kho
        static void UpdateQLKHOCH1(string mahs, double soluong)
        {
            string id_qlkho = mahs + "_qlkho";
            string id_nvbh = mahs + "_nvbh";
            var todayDate = DateTime.Today;
            Thread.CurrentThread.CurrentCulture = new CultureInfo("fr-FR");
            string strTodayFR = todayDate.ToString(); // converts date to string in DD/MM/YYYY format
            var session = DocumentStoreHolder.Store1.OpenSession();

            var getUpdateKho = session.Load<khohs_qlkho>(id_qlkho);
            var getUpdateKhoNV = session.Load<khohs_nvbh>(id_nvbh);

            if (getUpdateKho == null)
             {
                 throw new Exception("Khong tim thay san pham kho");
             }
             getUpdateKho.Soluong = soluong;
             getUpdateKho.Ngaycapnhat = strTodayFR;
             if (soluong > 0)
             {
                 getUpdateKhoNV.Tinhtrang = "Con hang";
             }
             else
             {
                 getUpdateKhoNV.Tinhtrang = "Het hang";
             }
             session.SaveChanges(); 
  
        }
        //Update QLKHO tu (CH1 update CH2)
        static void UpdateQLKHOFromAtoB(string mahs, double soluong)
        {
            string id_qlkho = mahs + "_qlkho";
            string id_nvbh = mahs + "_nvbh";
            var todayDate = DateTime.Today;
            Thread.CurrentThread.CurrentCulture = new CultureInfo("fr-FR");
            string strTodayFR = todayDate.ToString(); // converts date to string in DD/MM/YYYY format
            var session = DocumentStoreHolder.NodeAtoB.OpenSession();
            var getUpdateKho = session.Load<khohs_qlkho>(id_qlkho);
            var getUpdateKhoNV = session.Load<khohs_nvbh>(id_nvbh);
            if(getUpdateKho == null)
             {
                 throw new Exception("Khong tim thay san pham kho");
             }
             getUpdateKho.Soluong = soluong;
             getUpdateKho.Ngaycapnhat = strTodayFR;
             if(soluong > 0)
             {
                 getUpdateKhoNV.Tinhtrang = "Con hang";
             }else
             {
                 getUpdateKhoNV.Tinhtrang = "Het hang";
             }
             session.SaveChanges();
        }
        //Update QLKHO (CH2 update CH1)
        static void UpdateQLKHOFromBtoA(string mahs, double soluong)
        {
            string id_qlkho = mahs + "_qlkho";
            string id_nvbh = mahs + "_nvbh";
            var todayDate = DateTime.Today;
            Thread.CurrentThread.CurrentCulture = new CultureInfo("fr-FR");
            string strTodayFR = todayDate.ToString(); // converts date to string in DD/MM/YYYY format
            var session = DocumentStoreHolder.NodeBtoA.OpenSession();
            var getUpdateKho = session.Load<khohs_qlkho>(id_qlkho);
            var getUpdateKhoNV = session.Load<khohs_nvbh>(id_nvbh);
            if (getUpdateKho == null)
            {
                throw new Exception("Khong tim thay san pham kho");
            }
            getUpdateKho.Soluong = soluong;
            getUpdateKho.Ngaycapnhat = strTodayFR;
            if (soluong > 0)
            {
                getUpdateKhoNV.Tinhtrang = "Con hang";
            }
            else
            {
                getUpdateKhoNV.Tinhtrang = "Het hang";
            }
            Console.WriteLine("Cap nhat kho thanh cong");
            session.SaveChanges();
        }
        //Ch1 Xoa Hoa Don  to Ch2
        static void XoaHoaDonAtoB(string mahd)
        {
            var session = DocumentStoreHolder.NodeAtoB.OpenSession();
            var getHoaDon = session.Load<hoadon>(mahd);
            if(getHoaDon == null)
            {
                throw new Exception("Khong tim thay hoa don");
            }
            session.Delete(getHoaDon);
            session.SaveChanges();
        }
        //Cua hang 1 tu xoa hoa don
        static void XoaHoaDonCH1(string mahd)
        {
            var session = DocumentStoreHolder.Store1.OpenSession();
            var getHoaDon = session.Load<hoadon>(mahd);
            if (getHoaDon == null)
            {
                throw new Exception("Khong tim thay hoa don");
            }
            session.Delete(getHoaDon);
            session.SaveChanges();
        }
        //Cua hang 2 tu xoa hoa don
        static void XoaHoaDonCH2(string mahd)
        {
            var session = DocumentStoreHolder.Store2.OpenSession();
            var getHoaDon = session.Load<hoadon>(mahd);
            if (getHoaDon == null)
            {
                throw new Exception("Khong tim thay hoa don");
            }
            session.Delete(getHoaDon);
            session.SaveChanges();
        }
        //Query nhan vien co luong tren 10tr
        static void Query()
        {
            var ch1 = DocumentStoreHolder.Store1.OpenSession();
            var ch2 = DocumentStoreHolder.Store2.OpenSession();

            var resultNV1 = ch1.Query<NhanVien>().Include(x => x.luong > 10000000).ToList();
            var resultNV2 = ch2.Query<NhanVien>().Include(x => x.luong > 10000000).ToList();

          

            Console.WriteLine(resultNV1);
            Console.WriteLine(resultNV2);

        }
        //Query nhan vien co luong cao nhat tham gia hoa don
        static void Query2()
        {
            var ch1 = DocumentStoreHolder.Store1.OpenSession();
            var ch2 = DocumentStoreHolder.Store2.OpenSession();

            var resultNV1 = ch1.Query<hoadon>().Include(x => x.Manv).ToList();
            var resultNV2 = ch2.Query<hoadon>().Include(x => x.Manv).ToList();
            foreach(var k in resultNV1)
            {
                k.NhanVien = ch1.Load<NhanVien>(k.Manv);
            }

            var result = resultNV1.Concat(resultNV2).Where(x => x.Manv != null).OrderByDescending(x => x.NhanVien.luong).First();
        }
        static void Main(string[] args)
        {
            //Insert HaiSan
             createHaiSan("HS01", "Tom Hum", "Tom", "Han Quoc" ,900, "kg");
             createHaiSan("HS02", "Tom Cang Xanh", "Tom", "Viet Nam", 450, "kg");
             createHaiSan("HS03", "Cua Bien", "Cua", "Viet Nam", 600, "kg");
             createHaiSan("HS04", "So Diep", "So", "Nhat Ban", 400, "kg");
             createHaiSan("HS05", "Hau Bien", "Hau", "Viet Nam", 150, "kg");
             createHaiSan("HS06", "Ca Hoi", "Ca", "NA Uy", 500, "kg");
             createHaiSan("HS07", "Muc Khong Lo", "Muc", "Han Quoc", 900, "kg");
             createHaiSan("HS08", "Muc Trung", "Muc", "Viet Nam", 700, "kg");
             createHaiSan("HS09", "Ca Chep Rong", "Ca", "Viet Nam", 600, "kg");
             createHaiSan("HS10", "Cua Hoang De", "Cua", "Alaska", 1600, "kg");
             //Insert NhanVien CH01
             createNhanVien("NV01", "Do Huynh My Tam", "Quan 3 HCM", "07699889", 15000000, "CH01");
             createNhanVien("NV03","Luu Vinh Phat", "Quan 2, HCM", "0764484234", 15000000, "CH01");
             createNhanVien("NV05", "Nguyen Minh Duy", "Quan 4, HCM", "0934484233", 1400000, "CH01");
             createNhanVien("NV07", "Tran Van The", "Quan 5, HCM", "0934484235", 1200000, "CH01");
             createNhanVien("NV09", "Nguyen Ngoc Tho", "Quan 6, HCM", "0934484236", 1200000, "CH01");

             //Insert NhanVien CH02
             createNhanVien("NV02", "Nguyen Ngoc Thu", "Quan 7 HCM", "07699889", 15000000, "CH02");
             createNhanVien("NV04", "Tran Thi Thanh", "Quan 8, HCM", "0764484234", 11000000, "CH02");
             createNhanVien("NV06", "Do Ngoc", "Quan 1, HCM", "0934484233", 1200000, "CH02");
             createNhanVien("NV08", "Vo Thi Ha Trang", "Thu Duc", "0934484235", 1700000, "CH02");
             createNhanVien("NV10", "Nguyen Ngoc Anh", "Quan 6, HCM", "0934484236", 9000000, "CH02");

             //Insert KhachHang
             createKhachHang("KH01", "Trum Bom Hang", "Quan 3, HCM", "076888899", "12/12/2000", "Nam", "29/12/2023");
             createKhachHang("KH02", "Trum Quan 6", "Quan 6, HCM", "076888897", "12/09/2000", "Nam", "29/12/2023");
             createKhachHang("KH03", "Nguyen Thanh Tu", "Quan 3, HCM", "076888896", "27/08/1999", "Nu", "28/12/2023");
             createKhachHang("KH04", "Nguyen Van B", "Quan 8, HCM", "076888895", "12/12/1999", "Nam", "27/12/2023");
             createKhachHang("KH05", "Ong Ke", "Quan 7, HCM", "076888894", "03/12/2000", "Nam", "29/11/2023");
             createKhachHang("KH06", "Anh Dep Trai", "Quan 1, HCM", "076888893", "15/12/1998", "Nu", "29/11/2023");
             createKhachHang("KH07", "Cau Be", "Quan 2, HCM", "076888892", "02/12/2002", "Nam", "29/11/2023");
             createKhachHang("KH08", "Mo Hai", "Quan 2, HCM", "076888891", "12/11/2001", "Nu", "29/10/2023");
             createKhachHang("KH09", "Be Ba", "Quan 1, HCM", "076888890", "12/11/2000", "Nam", "29/10/2023");
             createKhachHang("KH10", "Doc La", "Binh Duong", "076888877", "12/11/2000", "Nam", "01/01/2024");

             //Insert KHOHS_QLKHO CH01
             createKhoHS("HS01","CH01", 10,"01/01/2024");
             createKhoHS("HS02","CH01",  9, "01/01/2024");
             createKhoHS("HS03","CH01",  8, "01/01/2024");
             createKhoHS("HS04","CH01",  0, "01/01/2024");
             createKhoHS("HS05","CH01",  5, "01/01/2024");
             createKhoHS("HS06","CH01",  4, "01/01/2024");
             createKhoHS("HS07","CH01",  7, "01/01/2024");
             createKhoHS("HS08","CH01",  0, "01/01/2024");
             //Insert KHOHS_QLKHO CH01
             createKhoHS("HS01", "CH02",  10, "02/01/2024");
             createKhoHS("HS02","CH02",  9, "02/01/2024");
             createKhoHS("HS03","CH02",  8, "02/01/2024");
             createKhoHS("HS04","CH02",  0, "02/01/2024");
             createKhoHS("HS05","CH02",  5, "03/01/2024");
             createKhoHS("HS06","CH02",  4, "03/01/2024");
             createKhoHS("HS07","CH02",  7, "03/01/2024");
             createKhoHS("HS08","CH02",  0, "03/01/2024");
            
            //Insert Cua Hang
            createCuaHang("CH01", "Hai San Good 1", "Quan 7,  HCM", "076584848");
            createCuaHang("CH02", "Hai San Good 2", "Thu Duc,  HCM", "076584849");
            
            //Insert HoaDon
            createHoaDon("HD01", "NV01", "KH01", "02/01/2024", 1350, "CH01");
            createHoaDon("HD03", "NV03", "KH03", "01/01/2024", 1800, "CH01");
            createHoaDon("HD05", "NV05", "KH05", "03/01/2024", 1200, "CH01");
            createHoaDon("HD07", "NV07", "KH07", "03/01/2024", 700, "CH01");

            createHoaDon("HD02", "NV02", "KH02", "03/01/2024", 1400, "CH02");
            createHoaDon("HD04", "NV06", "KH06", "03/01/2024", 900, "CH02");
            createHoaDon("HD06", "NV04", "KH08", "02/01/2024", 1000, "CH02");
            createHoaDon("HD08", "NV08", "KH04", "01/01/2024", 300, "CH02");
            
            //CTHD
            createCthd("HD01", "HS01", 1, "CH01");
            createCthd("HD01", "HS02", 1, "CH01");
            createCthd("HD03", "HS07", 2, "CH01");
            createCthd("HD05", "HS03", 2, "CH01");
            createCthd("HD07", "HS08", 1, "CH01");

            createCthd("HD02", "HS08", 2, "CH02");
            createCthd("HD04", "HS02", 2, "CH02");
            createCthd("HD06", "HS03", 1, "CH02");
            createCthd("HD06", "HS04", 1, "CH02");
            createCthd("HD08", "HS05", 2, "CH02");

            //Cửa hàng 2 cập nhật kho ch1
            UpdateQLKHOFromBtoA("HS06", 7);

            //Cửa hàng 1 insert nhân viên cho ch2
            // InsertNhanVienFromAtoB("NV12", "Nhan Vien Them Moi A cho B", "Quan 2, HCM", "033857373", 9000000);

            //Ch1 xóa hóa đơn bên ch2 
            XoaHoaDonAtoB("HD10");

        }
    }
}
