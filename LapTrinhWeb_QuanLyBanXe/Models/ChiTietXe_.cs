using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LapTrinhWeb_QuanLyBanXe.Models
{
    public class ChiTietXe_
    {
        string id, mucTieuThuNhienLieu, hopSo, loaiTruyenDong, moMentCucDai, dungTichXiLanh, khoiLuong, chieuDai, chieuRong,
            chieuCao, khoangCachHaiTrucBanh, doCaoYen, khoangSangGam, dungTichBinhXang, kichThuocLopTruoc, kichThuocLopSau,
            congXuatToiDa, phuocTruoc, phuocSau, dungTichNhotMay, loaiDongCo;

        public string Id { get => id; set => id = value; }
        public string MucTieuThuNhienLieu 
        { get => mucTieuThuNhienLieu;
            set 
            {
                if (value == "" || value == null)
                {
                    mucTieuThuNhienLieu = "chưa rõ";
                }
                else
                {
                    mucTieuThuNhienLieu = value;
                }
            } 
        }
        public string HopSo { get => hopSo;
            set
            {
                if (value == "" || value == null)
                {
                    hopSo = "chưa rõ";
                }
                else
                {
                    hopSo = value;
                }
            }
        }
        public string LoaiTruyenDong { get => loaiTruyenDong;
            set
            {
                if (value == "" || value == null)
                {
                    loaiTruyenDong = "chưa rõ";
                }
                else
                {
                    loaiTruyenDong = value;
                }
            }
        }
        public string MoMentCucDai { get => moMentCucDai;
            set
            {
                if (value == "" || value == null)
                {
                    moMentCucDai = "chưa rõ";
                }
                else
                {
                    moMentCucDai = value;
                }
            }
        }
        public string DungTichXiLanh { get => dungTichXiLanh;
            set
            {
                if (value == "" || value == null)
                {
                    dungTichXiLanh = "chưa rõ";
                }
                else
                {
                    dungTichXiLanh = value;
                }
            }
        }
        public string KhoiLuong { get => khoiLuong;
            set
            {
                if (value == "" || value == null)
                {
                    khoiLuong = "chưa rõ";
                }
                else
                {
                    khoiLuong = value;
                }
            }
        }
        public string ChieuDai { get => chieuDai;
            set
            {
                if (value == "" || value == null)
                {
                    chieuDai = "chưa rõ";
                }
                else
                {
                    chieuDai = value;
                }
            }
        }
        public string ChieuRong { get => chieuRong; set
            {
                if (value == "" || value == null)
                {
                    chieuRong = "chưa rõ";
                }
                else
                {
                    chieuRong = value;
                }
            }
        }
        public string ChieuCao { get => chieuCao; set
            {
                if (value == "" || value == null)
                {
                    chieuCao = "chưa rõ";
                }
                else
                {
                    chieuCao = value;
                }
            }
        }
        public string KhoangCachHaiTrucBanh { get => khoangCachHaiTrucBanh; set
            {
                if (value == "" || value == null)
                {
                    khoangCachHaiTrucBanh = "chưa rõ";
                }
                else
                {
                    khoangCachHaiTrucBanh = value;
                }
            }
        }
        public string DoCaoYen { get => doCaoYen; set
            {
                if (value == "" || value == null)
                {
                    doCaoYen = "chưa rõ";
                }
                else
                {
                    doCaoYen = value;
                }
            }
        }
        public string KhoangSangGam { get => khoangSangGam; set
            {
                if (value == "" || value == null)
                {
                    khoangSangGam = "chưa rõ";
                }
                else
                {
                    khoangSangGam = value;
                }
            }       
        }
        public string DungTichBinhXang { get => dungTichBinhXang;
            set
            {
                if (value == "" || value == null)
                {
                    dungTichBinhXang = "chưa rõ";
                }
                else
                {
                    dungTichBinhXang = value;
                }
            }
        }
        public string KichThuocLopTruoc { get => kichThuocLopTruoc; set
            {
                if (value == "" || value == null)
                {
                    kichThuocLopTruoc = "chưa rõ";
                }
                else
                {
                    kichThuocLopTruoc = value;
                }
            }
        }
        public string KichThuocLopSau { get => kichThuocLopSau; set
            {
                if (value == "" || value == null)
                {
                    kichThuocLopSau = "chưa rõ";
                }
                else
                {
                    kichThuocLopSau = value;
                }
            }
        }
        public string CongXuatToiDa { get => congXuatToiDa; set
            {
                if (value == "" || value == null)
                {
                    congXuatToiDa = "chưa rõ";
                }
                else
                {
                    congXuatToiDa = value;
                }
            }
        }
        public string PhuocTruoc { get => phuocTruoc; set
            {
                if (value == "" || value == null)
                {
                    phuocTruoc = "chưa rõ";
                }
                else
                {
                    phuocTruoc = value;
                }
            }
        }
        public string PhuocSau { get => phuocSau; set
            {
                if (value == "" || value == null)
                {
                    phuocSau = "chưa rõ";
                }
                else
                {
                    phuocSau = value;
                }
            }
        }
        public string DungTichNhotMay { get => dungTichNhotMay; set
            {
                if (value == "" || value == null)
                {
                    dungTichNhotMay = "chưa rõ";
                }
                else
                {
                    dungTichNhotMay = value;
                }
            }
        }
        public string LoaiDongCo { get => loaiDongCo; set
            {
                if (value == "" || value == null)
                {
                    loaiDongCo = "chưa rõ";
                }
                else
                {
                    loaiDongCo = value;
                }
            }
        }
        public ChiTietXe_()
        {
            Id = MucTieuThuNhienLieu = HopSo = LoaiTruyenDong = MoMentCucDai = DungTichXiLanh = KhoiLuong = ChieuDai = ChieuRong
            = ChieuCao = KhoangCachHaiTrucBanh = DoCaoYen = KhoangSangGam = DungTichBinhXang = KichThuocLopTruoc = KichThuocLopSau
            = CongXuatToiDa = PhuocTruoc = PhuocSau = DungTichNhotMay = LoaiDongCo = "";
        }
        public ChiTietXe_(string id,string  mucTieuThuNhienLieu,string  hopSo,string  loaiTruyenDong,string  moMentCucDai,
            string  dungTichXiLanhstring ,string  khoiLuong,string  chieuDai, string chieuRong,string  chieuCao,
            string  khoangCachHaiTrucBanh,string  doCaoYen,string  khoangSangGam,string  dungTichBinhXang,string  kichThuocLopTruoc,
            string  kichThuocLopSau, string congXuatToiDa,string  phuocTruoc,string  phuocSau,string  dungTichNhotMay,string  loaiDongCo)
        {
            Id = id;
            MucTieuThuNhienLieu = mucTieuThuNhienLieu;
            HopSo = hopSo;
            LoaiTruyenDong = loaiTruyenDong;
            MoMentCucDai = moMentCucDai;
            DungTichXiLanh = dungTichXiLanh;
            KhoiLuong = khoiLuong;
            ChieuDai = ChieuDai;
            ChieuRong = chieuRong;
            ChieuCao = chieuCao;
            KhoangCachHaiTrucBanh = khoangCachHaiTrucBanh;
            DoCaoYen = doCaoYen;
            KhoangSangGam = khoangSangGam;
            DungTichBinhXang = dungTichBinhXang;
            KichThuocLopTruoc = kichThuocLopTruoc;
            KichThuocLopSau = kichThuocLopSau;
            CongXuatToiDa = congXuatToiDa;
            PhuocTruoc = phuocTruoc;
            PhuocSau = phuocSau;
            DungTichNhotMay = dungTichNhotMay;
            LoaiDongCo = loaiDongCo;
        }
    }
}