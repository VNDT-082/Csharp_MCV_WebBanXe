using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LapTrinhWeb_QuanLyBanXe.Models
{
    public class TaiKhoan_
    {
        public string TenDangNhap { get; set; }
        public string LoaiAcc { get; set; }
        public string MatKhau { get; set; }
        public TaiKhoan_()
        {
            TenDangNhap = LoaiAcc = MatKhau = "";
        }
        public TaiKhoan_( string Ten,string loai,string mk)
        {
            TenDangNhap = Ten;
            LoaiAcc = loai;
            MatKhau = mk;
        }
    }
}