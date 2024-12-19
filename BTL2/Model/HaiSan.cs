using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ravenDB.Model
{
    internal class HaiSan
    {
        public string Id {  get; set; }
        public string TenHS { get; set; }
        public string Loai {  get; set; }
        public string XuatXu { get; set; }
        public double GiaBan { get; set; }
        public string Dvt {  get; set; }
        public HaiSan(string id, string tenhs, string loai, string xuatxu, double gia, string dvt)
        {
            this.Id = id;
            this.TenHS = tenhs;
            this.Loai = loai;
            this.XuatXu = xuatxu;
            this.GiaBan = gia;
            this.Dvt = dvt; 
        }

    }
}
