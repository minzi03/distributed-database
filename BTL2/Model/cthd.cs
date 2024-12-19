using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ravenDB.Model
{
    internal class cthd
    {
        public cthd(string mahd, string mahs, double soluong, string mach)
        {
            this.mahd = mahd;
            this.mahs = mahs;
            this.soluong = soluong;
            this.mach = mach;
        }

        public string mahd {  get; set; }
        public string mahs { get; set; }
        public double soluong { get; set; }
        public string mach { get; set;}

    }
}
