using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ravenDB.Model
{
    internal class khohs_qlkho
    {
        public string Id { get; set; }
        public string Mach { get; set; }
        public double Soluong { get; set; }
        public string Ngaycapnhat { get; set; }

        public khohs_qlkho(string id, string mach, double soluong, string ngaycapnhat)
        {
            this.Id = id;
            this.Mach = mach;
            this.Soluong = soluong;
            this.Ngaycapnhat = ngaycapnhat;
        }

    }
}
