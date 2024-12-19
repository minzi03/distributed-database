using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ravenDB.Model
{
    internal class NhanVien
    {
        public NhanVien(string id, string tenNV, string diaChi, string phoneNum, double luong, string maCH)
        {
            this.Id = id;
            this.TenNV = tenNV;
            this.DiaChi = diaChi;
            this.phoneNum = phoneNum;
            this.luong = luong;
            this.MaCH = maCH;
        }
        public string Id { get; set; }
        public string TenNV { get; set; }
        public string DiaChi { get; set; }
        public string phoneNum { get; set; }
        public double luong {  get; set; }
        public string MaCH {  get; set; }

        
    }
}
