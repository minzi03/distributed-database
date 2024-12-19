using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ravenDB.Model
{
    internal class hoadon
    {
        internal NhanVien NhanVien;

        public hoadon(string id, string manv, string makh, string ngaylap, double tongtien, string cuahang)
        {
            this.Id = id;
            this.Manv = manv;
            this.Makh = makh;
            this.Ngaylap = ngaylap;
            this.Tongtien = tongtien;
            this.Mach = cuahang;
        }

        public string Id {  get; set; }
        public string Manv {  get; set; }
        public string Makh { get; set; }
        public string Ngaylap { get; set; }
        public double Tongtien { get; set; }
        public string Mach { get; set; }

    }
}
