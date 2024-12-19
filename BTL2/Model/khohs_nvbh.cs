using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ravenDB.Model
{
    internal class khohs_nvbh
    {
        public string Id { get; set; }
        public string Mach { get; set; }
        public string Tinhtrang { get; set; }

        public khohs_nvbh(string id ,string mach, string tinhtrang)
        {
            Id = id;
            this.Mach = mach;
            this.Tinhtrang =  tinhtrang;
        }
    }
}
