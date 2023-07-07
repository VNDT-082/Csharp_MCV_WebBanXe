using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using LapTrinhWeb_QuanLyBanXe.Models;

namespace LapTrinhWeb_QuanLyBanXe.Controllers
{
    public class AdminController : Controller
    {
        //
        // GET: /Admin/
        An_1DataContext dl = new An_1DataContext();
        //An_1DataContext dl = new An_1DataContext();
        public ActionResult TrangChu()
        {
            return View(dl.Xes.ToList());
        }
        public ActionResult QuanLyNhaSanXuat()
        {
            return View(dl.HangXes.ToList());
        }

        [HttpPost]
        public ActionResult ThemNhaSanXuat(FormCollection colect, HttpPostedFileBase fileUpLoad)
        {
            try
            {
                HangXe h = new HangXe();
                h.MaNSX = colect.Get("MaNSX");
                h.TenNSX = colect.Get("TenNSX");
                h.AnhBia = fileUpLoad.FileName;
                dl.HangXes.InsertOnSubmit(h);
                dl.SubmitChanges();
                string tenFile = Server.MapPath("/HinhAnh/logoHang/" + fileUpLoad.FileName);
                fileUpLoad.SaveAs(tenFile);
                return RedirectToAction("QuanLyNhaSanXuat", "Admin");
            }
            catch(Exception er)
            {
                throw er;
            }
        }


        [HttpPost]
        public ActionResult SuaNSX(FormCollection colect, HttpPostedFileBase fileUpLoad)
        {
            string mansx = colect.Get("MaNSX");
            HangXe h = dl.HangXes.FirstOrDefault(i => i.MaNSX == mansx);
            if(h!=null)
            {
                h.TenNSX = colect.Get("TenNSX");
                if(fileUpLoad!=null)
                {
                    h.AnhBia = fileUpLoad.FileName;
                    string tenFile = Server.MapPath("/HinhAnh/logoHang/" + fileUpLoad.FileName);
                    fileUpLoad.SaveAs(tenFile);
                }
                foreach (HangXe item in dl.HangXes.ToList())
                {
                    if(item.MaNSX==h.MaNSX)
                    {
                        item.TenNSX = h.TenNSX;
                        item.AnhBia = h.AnhBia;
                        dl.SubmitChanges();
                        return RedirectToAction("QuanLyNhaSanXuat", "Admin");
                    }
                }
            }
            ViewBag.deleteErr = "Sửa thất bại";
            return RedirectToAction("QuanLyNhaSanXuat", "Admin");
        }
        public ActionResult XoaNhaSanXuat(string id)
        {
            HangXe h = dl.HangXes.FirstOrDefault(i => i.MaNSX == id);
            if(h!=null)
            {
                dl.HangXes.DeleteOnSubmit(h);
                dl.SubmitChanges();
                return RedirectToAction("QuanLyNhaSanXuat", "Admin");
            }
            ViewBag.deleteErr = "Xóa thất bại";
            return RedirectToAction("QuanLyNhaSanXuat", "Admin");
        }

        public ActionResult XoaXe(string id)
        {
            Xe h = dl.Xes.FirstOrDefault(i => i.MaXe == id);
            if (h != null)
            {
                dl.Xoa_1Xe(id);
                return RedirectToAction("TrangChu", "Admin");
            }
            ViewBag.deleteErr = "Xóa thất bại";
            return RedirectToAction("FormEditInfo_Xe", "Admin", new { id = h.MaXe });
        }

        [HttpPost]
        public ActionResult TimXe(FormCollection colect)
        {
            string MaXe = colect.Get("MaXe");
            if(MaXe!=null)
            {
                return RedirectToAction("FormEditInfo_Xe", "Admin", new { id = MaXe }); 
            }
            return RedirectToAction("TrangChu", "Admin");
        }
        public ActionResult FormEditInfo_Xe(string id)
        {
            Xe x = dl.Xes.FirstOrDefault(i => i.MaXe == id);
            return View(x);
        }
        [HttpPost]
        public ActionResult UpDate_Add_Xe(FormCollection colect, HttpPostedFileBase fileUpLoad)
        {
            string MaXe1= colect.Get("MaXe");
           
            Xe x = dl.Xes.FirstOrDefault(i => i.MaXe == MaXe1);
            if(x==null)
            {
                x = new Xe();
                x.MaXe = MaXe1;
                x.TenXe = colect.Get("TenXe");
                x.MaLoaiXe = int.Parse(colect.Get("MaLoaiXe"));
                x.MaNSX = colect.Get("MaNSX");
                string gia = colect.Get("Gia");
                x.Gia = double.Parse(gia);
                x.MoTa = colect.Get("MoTa");
                if(fileUpLoad!=null)
                {
                    x.AnhBia = fileUpLoad.FileName;
                    string tenFile = Server.MapPath("/HinhAnh/AnhBia/" + fileUpLoad.FileName);
                    fileUpLoad.SaveAs(tenFile);
                }
                else
                {
                    x.AnhBia = "";
                }
                dl.Xes.InsertOnSubmit(x);
                dl.SubmitChanges();
                return RedirectToAction("TrangChu", "Admin");
            }
            else
            {
                foreach(var item in dl.Xes.ToList())
                {
                    if(item.MaXe==x.MaXe)
                    {
                        item.TenXe = colect.Get("TenXe");
                        item.MaLoaiXe = int.Parse(colect.Get("MaLoaiXe"));
                        item.MaNSX = colect.Get("MaNSX");
                        string gia = colect.Get("Gia");
                        item.Gia = double.Parse(gia);
                        item.MoTa = colect.Get("MoTa");
                        if (fileUpLoad != null)
                        {
                            item.AnhBia = fileUpLoad.FileName;
                            string tenFile = Server.MapPath("/HinhAnh/logoHang/" + fileUpLoad.FileName);
                            fileUpLoad.SaveAs(tenFile);
                        }
                        dl.SubmitChanges();
                        return RedirectToAction("TrangChu", "Admin");
                    }
                }
            }
            return RedirectToAction("TrangChu", "Admin");
        }
        public ActionResult QuanLyHoaDon()
        {
            return View(dl.PhieuBanHangs.ToList());
        }
        public ActionResult QuanLyChiTietHD(int id)
        {
            List<ChiTietPhieuBan> ds_ctPhieuBan = dl.ChiTietPhieuBans.Where(i => i.id_PhieuBan == id).ToList();
            return PartialView(ds_ctPhieuBan);
        }
        public ActionResult LocHoaHon()
        {
            dl.LocHoaDonQuaHan();
            return RedirectToAction("QuanLyHoaDon","Admin", dl.PhieuBanHangs.ToList());
        }
    }
}
