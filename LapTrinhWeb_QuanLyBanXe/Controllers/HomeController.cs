using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.Mvc;

using LapTrinhWeb_QuanLyBanXe.Models;

namespace LapTrinhWeb_QuanLyBanXe.Controllers
{
    public class HomeController : Controller
    {
        //
        // GET: /Home/
        public DuLieu dl = new DuLieu();
        An_1DataContext an = new An_1DataContext();

        public ActionResult LoadingPage()
        {
            return View();
        }
        public ActionResult TrangChu()
        {
            //dl.LoadXe();
            //List<Xe_> Ds_xe = dl.ds_Xe;
            List<Xe> ds_Xe = an.Xes.ToList();
            return View(ds_Xe);
        }
        public ActionResult HangXe()
        {
            //dl.LoadHangXe();
            //List<HangXe_> ds_hang = dl.ds_hang;
            List<HangXe> ds_Hang = an.HangXes.ToList();
            return PartialView(ds_Hang);
        }
        public ActionResult LoaiXe()
        {
            //dl.LoadLoaiXe();
            //List<LoaiXe_> ds_LoaiXe = dl.ds_LoaiXe;
            List<LoaiXe> ds_LoaiXe = an.LoaiXes.ToList();
            return PartialView(ds_LoaiXe);
        }

        public ActionResult DangKyThongTinCaNhan()
        {
            return View();
        }
        
        [HttpPost]
        public ActionResult DangKyThongTinCaNhan(FormCollection colect)
        {
            List<KhachHang> ds_KhachHang = an.KhachHangs.ToList();
            List<int> MaKhach = new List<int>();
            KhachHang Khach_DK = new KhachHang();
            foreach (var item in ds_KhachHang)
            {
                string k_max = item.MaKhachHang;
                string so_MaID = "";
                for (int i = 2; i < k_max.Length; i++)
                {
                    so_MaID += k_max[i];
                }
                int x = int.Parse(so_MaID);
                MaKhach.Add(x);
            }

            int maxid = MaKhach.Max()+1;
            if (maxid < 10)
            {
                Khach_DK.MaKhachHang = "KH0" + maxid.ToString();
            }
            else
            {
                Khach_DK.MaKhachHang = "KH" + maxid.ToString();
            }
            Khach_DK.TenKhach = colect.Get("TenKhach");
            Khach_DK.NgaySinh = DateTime.Parse(colect.Get("NgaySinh"));
            Khach_DK.GioiTinh = colect.Get("inlineRadioOptions");
            Khach_DK.SDT = colect.Get("SDT");
            Khach_DK.DiaChi = colect.Get("DiaChi");
            Khach_DK.HinhAnh = "";
            if(!string.IsNullOrEmpty(Khach_DK.TenKhach) && !string.IsNullOrEmpty(Khach_DK.MaKhachHang) && !string.IsNullOrEmpty(Khach_DK.NgaySinh.ToString())
                && !string.IsNullOrEmpty(Khach_DK.GioiTinh) && !string.IsNullOrEmpty(Khach_DK.SDT)&& !string.IsNullOrEmpty(Khach_DK.DiaChi))
            {
                Session["KhachHangDK"] = Khach_DK;
                return RedirectToAction("DangKy", "Home");
            }
            ViewBag.ttcn = "Hãy đảm bảo rằng bạn đã nhập đầy đủ thông tin.";
            return RedirectToAction("DangKyThongTinCaNhan", "Home");
        }
        public ActionResult DangKy()
        {
            return View();
        }
        [HttpPost]
        public ActionResult DangKy(FormCollection colect)
        {
            Account a = new Account();
            a.LoaiAcc = 2;
            a.TenDangNhap = colect.Get("TenDangNhap");
            a.MatKhau = colect.Get("MatKhau");
            string mk_xn = colect.Get("XNMatKhau");
            if(!string.IsNullOrEmpty(a.TenDangNhap) && !string.IsNullOrEmpty(a.MatKhau))
            {
                Account temp = an.Accounts.FirstOrDefault(i => i.TenDangNhap == a.TenDangNhap);
                if (temp == null)
                {
                    if (a.MatKhau == mk_xn)
                    {
                        if (Session["KhachHangDK"] != null)
                        {
                            KhachHang KhachHangDK = (KhachHang)Session["KhachHangDK"];
                            KhachHangDK.TenDangNhap = a.TenDangNhap;
                            an.Accounts.InsertOnSubmit(a);
                            an.SubmitChanges();
                            an.KhachHangs.InsertOnSubmit(KhachHangDK);
                            an.SubmitChanges();
                            return RedirectToAction("DangNhap", "Home");
                        }

                    }
                }
                else
                {
                    ViewBag.dk_err = "Tên đăng nhập đã tồn tại.";
                    return RedirectToAction("DangKy", "Home");
                }
               
            }
            ViewBag.dk_err = "Xác nhân lại mật khẩu của bạn.";
            return RedirectToAction("DangKy", "Home");
        }
    
        public ActionResult DangNhap()
        {
            return PartialView();
        }
        [HttpPost]
        public ActionResult DangNhap(FormCollection colect)
        {

            List<Account> ds_Tk = an.Accounts.ToList();
            Account temp = new Account();
            temp.TenDangNhap = colect.Get("TenDangNhap");
            temp.MatKhau = colect.Get("MatKhau");
            temp = an.Accounts.FirstOrDefault(i => i.TenDangNhap == temp.TenDangNhap && i.MatKhau == temp.MatKhau);
            if(temp==null)
            {
                return RedirectToAction("DangNhap");
            }
            else if(temp.LoaiAcc==2)
            {
                foreach (var item in ds_Tk)
                {
                    if (item.TenDangNhap == temp.TenDangNhap && item.MatKhau == temp.MatKhau)
                    {
                        KhachHang k = an.KhachHangs.FirstOrDefault(i => i.TenDangNhap == item.TenDangNhap);
                        Session["k"] = k;
                        return RedirectToAction("TrangChu","Home");
                    }
                }
            }
            else if(temp.LoaiAcc == 1)
            {
                foreach (var item in ds_Tk)
                {
                    if (item.TenDangNhap == temp.TenDangNhap && item.MatKhau == temp.MatKhau)
                    {
                        KhachHang k = an.KhachHangs.FirstOrDefault(i => i.TenDangNhap == item.TenDangNhap);
                        Session["k"] = k;
                        return RedirectToAction("TrangChu","Admin");
                    }
                }
            }
            return RedirectToAction("DangNhap");
        }
        public ActionResult ChiTietXe(string id)
        {
            Xe x = an.Xes.FirstOrDefault(i => i.MaXe == id);
            //background xe
            
            //hinh anh gioi thieu xe
            HinhAnh bg = an.HinhAnhs.FirstOrDefault(i => i.MaLoaiHinh == "BG" && i.Id_DanhMucHinh == x.MaXe);
            List<HinhAnh> ds_AnhGioiThieu = an.HinhAnhs.Where(i => i.MaLoaiHinh == "A_SP" &&i.Id_DanhMucHinh==x.MaXe).ToList();
            List<HinhAnh> ds_PBCC = an.HinhAnhs.Where(i => i.MaLoaiHinh == "PBCC" && i.Id_DanhMucHinh == x.MaXe).ToList();
            List<HinhAnh> ds_PBTT = an.HinhAnhs.Where(i => i.MaLoaiHinh == "PBTT" && i.Id_DanhMucHinh == x.MaXe).ToList();
            List<HinhAnh> ds_PBDB = an.HinhAnhs.Where(i => i.MaLoaiHinh == "PBDB" && i.Id_DanhMucHinh == x.MaXe).ToList();
            List<HinhAnh> ds_PBTC = an.HinhAnhs.Where(i => i.MaLoaiHinh == "PBTC" && i.Id_DanhMucHinh == x.MaXe).ToList();
            ChiTietXe ct = an.ChiTietXes.FirstOrDefault(i => i.id_ChiTietXe == x.MaXe);
            string fileName = "";
            if (bg!=null)
            {
                fileName = bg.TenHinh;
            }
            

            if (ds_AnhGioiThieu == null || ds_AnhGioiThieu.Count == 0)
            {
                ViewBag.NULL = "Chưa có sản phẩm tương tự.";
            }
            else if (ds_AnhGioiThieu.Count>0 && ds_AnhGioiThieu != null)
            {

                ViewBag.ds_AnhSP = ds_AnhGioiThieu;
            }
            //hinh anh phien ban cao cap
            if (ds_PBCC.Count == null|| ds_PBCC==null)
            {
                ViewBag.NULL = "Chưa có sản phẩm tương tự.";
            }
            else if(ds_PBCC.Count>0 && ds_PBCC!=null)
            {
                ViewBag.PBCC = ds_PBCC;
            }
            //hinh anh phien ban tdac biet
            if (ds_PBDB == null || ds_PBDB.Count == 0)
            {
                ViewBag.NULL = "Chưa có sản phẩm tương tự.";
            }
            else if (ds_PBDB.Count > 0 && ds_PBDB != null)
            {
                ViewBag.PBDB = ds_PBDB;
            }
            // hinh anh phien ban the thao
            if (ds_PBTT == null || ds_PBTT.Count == 0)
            {
                ViewBag.NULL = "Chưa có sản phẩm tương tự.";
            }
            else if (ds_PBTT.Count > 0 && ds_PBTT != null)
            {
                ViewBag.PBTT = ds_PBTT;
            }
            //hinh anh phien ban tieu chuan
            if (ds_PBTC == null || ds_PBTC.Count == 0)
            {
                ViewBag.NULL = "Chưa có sản phẩm tương tự.";
            }
            else if (ds_PBTC.Count > 0 && ds_PBTC != null)
            {
                ViewBag.PBTC = ds_PBTC;
            }

            //load list xe noi bac
            //List<Xe> List_XeNoiBac=an.Xes.Where(i=>i.MaLoaiXe)
            DataTable ds_XeNoiBac = dl.LoadXeNoiBac();
            if (ds_XeNoiBac == null || ds_XeNoiBac.Rows.Count == 0)
            {
                ViewBag.NULL = "Chưa có sản phẩm tương tự.";
            }
            else if (ds_XeNoiBac.Rows.Count>0)
            {
                List<Xe_> List_XeNoiBac = new List<Xe_>();
                foreach(DataRow dr in ds_XeNoiBac.Rows)
                {
                    Xe_ item = new Xe_();
                    item.MaXe = dr["MaXe"].ToString();
                    item.TenLoaiXe = dr["MaLoaiXe"].ToString();
                    item.TenNSX = dr["MaNSX"].ToString();
                    item.TenXe = dr["TenXe"].ToString();
                    item.AnhBia = dr["AnhBia"].ToString();
                    item.MoTa = dr["MoTa"].ToString();
                    item.Gia = dr["Gia"].ToString();
                    List_XeNoiBac.Add(item);
                }
                ViewBag.List_XeNoiBac = List_XeNoiBac;
            }

            //load list xe tuong tu
            LoaiXe lx = an.LoaiXes.FirstOrDefault(i => i.MaLoaiXe == x.MaLoaiXe);
            DataTable ds_XeTuongTu = dl.LoadXeTuongTu(lx.TenLoaiXe, x.Gia.ToString());
            if (ds_XeTuongTu == null || ds_XeTuongTu.Rows.Count == 0)
            {
                ViewBag.NULL_ = "Chưa có sản phẩm tương tự.";
            }
            else if (ds_XeTuongTu.Rows.Count > 0)
            {
                List<Xe_> List_XeTuongTu = new List<Xe_>();
                foreach (DataRow dr in ds_XeTuongTu.Rows)
                {
                    Xe_ item = new Xe_();
                    item.MaXe = dr[0].ToString();
                    item.TenLoaiXe = dr[1].ToString();
                    item.TenNSX = dr[2].ToString();
                    item.TenXe = dr[3].ToString();
                    item.AnhBia = dr[4].ToString();
                    item.MoTa = dr[5].ToString();
                    item.Gia = dr[6].ToString();
                    List_XeTuongTu.Add(item);
                }
                ViewBag.ListXeTuongtu = List_XeTuongTu;
            }
            //truyen chi tiet xe
            ViewBag.ChiTietXe = ct;
            //truyen danh dnah anh gioi thieu san pham
            ViewBag.ds_AnhSP = ds_AnhGioiThieu;

            //ViewBag.chiTietXe = "none";
            ViewBag.bg = fileName;
            return View(x);
        }
        public ActionResult HienThiAnhGioiThieu()
        {
            string fileName;
            fileName = "whileNull.png";
            return PartialView(fileName);
        }
        public ActionResult HienThiAnhGioiThieu(string id)
        {
            string fileName;
            if (id == "")
            {
                fileName = "whileNull.png";
            }
            else
            {
                fileName = id;
            }
            return PartialView(fileName);
        }
        public List<GioHang> LayGioHang()
        {
            List<GioHang> List_GioHang = Session["Giohang"] as List<GioHang>;
            if(List_GioHang==null)
            {
                List_GioHang = new List<GioHang>();
                Session["GioHang"] = List_GioHang;
            }
            return List_GioHang;
        }
        public ActionResult ThemVaoGioHang(string id)
        {
            List<GioHang> List_GioHang = LayGioHang();
            GioHang sanPham = List_GioHang.Find(i => i.MaXe == id);
            if(sanPham==null)
            {
                sanPham = new GioHang(id);
                List_GioHang.Add(sanPham);
                return RedirectToAction("TrangChu", "Home");
            }
            sanPham.SoLuong += 1;
            return RedirectToAction("TrangChu", "Home");
        }
        public ActionResult GioHang()
        {
            if(Session["GioHang"]==null)
            {
                ViewBag.GioHangRong = "Giỏ hàng rỗng";
            }
            List<GioHang> List_GioHang = Session["GioHang"] as List<GioHang>;
            return View(List_GioHang);
        }
        public ActionResult XacNhanDonHang()
        {
            if (Session["GioHang"] == null)
            {
                ViewBag.GioHangRong = "Giỏ hàng rỗng";
            }
            List<GioHang> List_GioHang = Session["GioHang"] as List<GioHang>;
            if(Session["k"]!=null)
            {
                KhachHang k = (KhachHang)Session["k"];
                ViewBag.KH = k;
            }
            else
            {
                ViewBag.KH_err = "Khach hang chua dang nhap";
            }
            List<HinhThucThanhToan> ht_ThanhToan = an.HinhThucThanhToans.ToList();
            ViewBag.HT_ThanhToan = ht_ThanhToan;
            return View(List_GioHang);
        }
        //------------------------------------------------------------
        [HttpPost]
        public ActionResult XacNhanDonHang(FormCollection colect)
        {
            if(Session["k"]!=null)
            {
                KhachHang k = (KhachHang)Session["k"];
                if(Session["GioHang"]!=null)
                {
                    List<GioHang> ds_GioHang = Session["GioHang"] as List<GioHang>;

                    PhieuBanHang p = new PhieuBanHang();
                    p.MaKhachHang = k.MaKhachHang;
                    p.HT_ThanhToan = int.Parse(colect.Get("HinhThucThanhToan"));
                    int MaPhieu=0;
                    MaPhieu=an.Insert_PhieuBanHang(p.MaKhachHang,p.HT_ThanhToan);
                    foreach(var item in ds_GioHang)
                    {
                        an.Insert_ChiTietPhieuBan(MaPhieu, item.MaXe, item.SoLuong);                    
                    }
                    return RedirectToAction("TrangChu", "Home");
                }
                
            }
            ViewBag.LoiDatHang = "Xác nhận đơn hàng thất bại.";
            return RedirectToAction("GioHang", "Home");
        }



        public ActionResult XoaSanPhamKhoiGioHang(string id)
        {
            if (Session["GioHang"] == null)
            {
                return RedirectToAction("Index", "Home");
            }
            List<GioHang> ds_gioHang = Session["GioHang"] as List<GioHang>;
            foreach (var item in ds_gioHang)
            {
                if (item.MaXe == id)
                {
                    ds_gioHang.Remove(item);
                    return RedirectToAction("GioHang", "Home", ds_gioHang);
                }
            }
            return View("GioHang", ds_gioHang);
        }
        [HttpPost]
        public ActionResult LuuGioHang(FormCollection colect, string id)
        {
            if (Session["GioHang"] == null)
            {
                return RedirectToAction("Index", "Home");
            }
            int soluong = int.Parse(colect.Get("sl"));
            List<GioHang> ds_gioHang = Session["GioHang"] as List<GioHang>;
            foreach (var item in ds_gioHang)
            {
                if (item.MaXe == id)
                {
                    item.SoLuong = soluong;
                    return RedirectToAction("GioHang", "Home", ds_gioHang);
                }
            }
            return View("GioHang", ds_gioHang);
        }

        [HttpPost]
        public ActionResult TimKiem(FormCollection colect)
        {
            string TimKiem = colect.Get("TimKiem_");
            List<Xe> ds_xe = an.Xes.Where(i => i.TenXe.Contains(TimKiem)).ToList();
            return View("TrangChu", ds_xe);
        }

        public ActionResult XeTheoHang(string id)
        {
            List<Xe> ds_xe = an.Xes.Where(i => i.MaNSX == id).ToList();
            return View("TrangChu", ds_xe);
        }
        public ActionResult XeTheoLoai(int id)
        {
            List<Xe> ds_xe = an.Xes.Where(i => i.MaLoaiXe == id).ToList();
            return View("TrangChu", ds_xe);
        }


        //trang ca nhan
        public ActionResult TrangCaNhan()
        {
            KhachHang k = new KhachHang();
            if (Session["k"]!=null)
            {
                k = (KhachHang)Session["k"];
                string LoaiKhachHang = an.KiemTra_KH_ThanThiet(k.MaKhachHang);
                ViewBag.LoaiKhach = LoaiKhachHang;
                List<PhieuBanHang> ds_PhieuBanHang = an.PhieuBanHangs.Where(i => i.MaKhachHang == k.MaKhachHang).ToList();
                if (ds_PhieuBanHang != null &&ds_PhieuBanHang.Count>0)
                {
                    List<ChiTietPhieuBan> ds_ChiTietPhieuBan = new List<ChiTietPhieuBan>();
                    foreach (var item in ds_PhieuBanHang)
                    {
                        ds_ChiTietPhieuBan.AddRange(an.ChiTietPhieuBans.Where(i => i.id_PhieuBan == item.id_PhieuBan).ToList());
                    }
                    if(ds_ChiTietPhieuBan!=null&&ds_ChiTietPhieuBan.Count>0)
                    {
                        ViewBag.Ds_ChiTietHD = ds_ChiTietPhieuBan;
                        ViewBag.Ds_HD = ds_PhieuBanHang;

                    }
                }
                
            }
            return View(k);
        }
        //===============================================================================
        //          ADMIN
        //===============================================================================

    }
}
