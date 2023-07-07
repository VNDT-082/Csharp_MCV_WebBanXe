using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LapTrinhWeb_QuanLyBanXe.Models
{
    public class GioHang
    {
        An_1DataContext dl = new An_1DataContext();
        //public string MaKhachHang { get; set; }
        public string MaXe { get; set; }
        public string TenXe { get; set; }
        //public string NgayBan { get; set; }
        public int SoLuong { get; set; }
        public double GiaBan { get; set; }
        public string HinhAnh { get; set; }
        public double ThanhTien { get { return SoLuong * GiaBan; } }
        public GioHang(string MaXe)
        {
            this.MaXe = MaXe;
            Xe x = dl.Xes.FirstOrDefault(i => i.MaXe == this.MaXe);
            this.TenXe = x.TenXe;
            this.SoLuong = 1;
            this.HinhAnh = x.AnhBia;
            this.GiaBan = double.Parse(x.Gia.ToString());

        }
        public GioHang(string MaXe, int Soluong)
        {
            this.MaXe = MaXe;
            Xe x = dl.Xes.FirstOrDefault(i => i.MaXe == this.MaXe);
            this.TenXe = x.TenXe;
            this.SoLuong = Soluong;
            this.HinhAnh = x.AnhBia;
            this.GiaBan = double.Parse(x.Gia.ToString());
        }
    }
}