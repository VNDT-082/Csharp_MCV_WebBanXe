using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LapTrinhWeb_QuanLyBanXe.Models
{
    public class LoaiXe_
    {
        public string ma {get;set;}
        public string ten{get;set;}
        public string Anh { get; set; }
        public LoaiXe_()
        {
            ma = ten = Anh = "";
        }
        public LoaiXe_(string ma,string ten ,string anh)
        {
            this.ma = ma;
            this.ten = ten;
            this.Anh = anh;
        }

    }
}