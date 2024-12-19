using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ravenDB.Model
{
    internal class khachhang
    {
        public khachhang(string id, string tenKH, string diaChi, string phoneNum, string ngaysinh, string gioitinh, string ngaydangki)
        {
            Id = id;
            TenKH = tenKH;
            DiaChi = diaChi;
            this.PhoneNum = phoneNum;
            this.Ngaysinh = ngaysinh;
            this.Gioitinh = gioitinh;
            this.Ngaydangki = ngaydangki;
        }

        public string Id { get; set; }
        public string TenKH { get; set; }
        public string DiaChi { get; set; }
        public string PhoneNum { get; set; }
        public string Ngaysinh { get; set; }
        public string Gioitinh { get; set; }
        public string Ngaydangki { get; set; }

    }
}
