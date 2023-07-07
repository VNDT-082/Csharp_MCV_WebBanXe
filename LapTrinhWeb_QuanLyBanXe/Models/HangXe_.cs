using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LapTrinhWeb_QuanLyBanXe.Models
{
    public class HangXe_
    {
        public string MaNSX { get; set; }
        public string TenNSX { get; set; }
        public string AnhBia { get; set; }
        public HangXe_()
        {
            MaNSX = TenNSX = AnhBia = "";
        }
        public HangXe_(string ma, string ten, string anh)
        {
            MaNSX = ma;
            TenNSX = ten;
            AnhBia = anh;
        }
    }
}