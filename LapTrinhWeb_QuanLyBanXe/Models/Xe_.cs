using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LapTrinhWeb_QuanLyBanXe.Models
{
    public class Xe_
    {
        public string MaXe { get; set; }
        public string TenLoaiXe { get; set; }
        public string TenNSX { get; set; }
        public string TenXe { get; set; }
        public string AnhBia { get; set; }
        public string MoTa { get; set; }
        public string Gia { get; set; }
        public Xe_()
        {
            MaXe = TenLoaiXe = TenNSX = TenXe = AnhBia = MoTa = Gia = "";
        }
        public Xe_(string maxe,string tenloaixe, string tennsx, string tenxe,string anhbia,string moto,string gia)
        {
            MaXe = maxe;
            TenLoaiXe = tenloaixe;
            TenNSX = tennsx;
            TenXe = tenxe;
            AnhBia = anhbia;
            MoTa = moto;
            Gia = gia;
        }
    }
}