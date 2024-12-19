using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ravenDB.Model
{
    internal class CuaHang
    {
        public CuaHang(string id, string tenCH, string diaChi, string phoneNum)
        {
            this.Id = id;
            this.TenCH = tenCH;
            this.DiaChi = diaChi;
            this.PhoneNum = phoneNum;
        }

        public string Id {  get; set; }
        public string TenCH {  get; set; }
        public string DiaChi { get; set; }
        public string PhoneNum { get; set; }

    }
}
