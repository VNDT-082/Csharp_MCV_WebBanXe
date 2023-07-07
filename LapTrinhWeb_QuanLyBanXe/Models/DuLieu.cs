using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Collections;

namespace LapTrinhWeb_QuanLyBanXe.Models
{
    public class DuLieu
    {
        string strCon { get; set; }
        SqlConnection con;
        public List<HangXe_> ds_hang = new List<HangXe_>();
        public List<LoaiXe_> ds_LoaiXe = new List<LoaiXe_>();
        public List<TaiKhoan_> ds_TaiKhoan = new List<TaiKhoan_>();
        public List<Xe_> ds_Xe = new List<Xe_>();
        public DuLieu()
        {
            //strCon = "Data Source=LAPTOP-QTRBNIQ4 ; database= QuanLyBanXe ; security integrated = True ;";
            strCon = "Data Source=LAPTOP-QTRBNIQ4 ; Initial Catalog=QuanLyBanXe-20221230012255  ; Integrated Security=True ;";
            con = new SqlConnection(strCon);
        }
        public void LoadHangXe()
        {
            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }
            string strSelect = "Select*from HangXe";
            SqlDataAdapter da = new SqlDataAdapter(strSelect, con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            foreach (DataRow dr in dt.Rows)
            {
                string ma = dr["MaNSX"].ToString();
                string ten = dr["TenNSX"].ToString();
                string Anh = dr["AnhBia"].ToString();
                HangXe_ h = new HangXe_(ma, ten, Anh);
                ds_hang.Add(h);
            }
            con.Close();
        }
        public void LoadLoaiXe()
        {
            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }
            string strSelect = "select *from LoaiXe";
            SqlDataAdapter da = new SqlDataAdapter(strSelect, con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            foreach (DataRow dr in dt.Rows)
            {
                string ma = dr["MaLoaiXe"].ToString();
                string ten = dr["TenLoaiXe"].ToString();
                string Anh = dr["Icon"].ToString();
                LoaiXe_ l = new LoaiXe_(ma, ten, Anh);
                ds_LoaiXe.Add(l);
            }
            con.Close();
        }
        public void TaiKhoan()
        {
            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }
            string strSelect = "select *from Accounts";
            SqlDataAdapter da = new SqlDataAdapter(strSelect, con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            foreach (DataRow dr in dt.Rows)
            {
                string ma = dr["TenDangNhap"].ToString();
                string ten = dr["LoaiAcc"].ToString();
                string Anh = dr["MatKhau"].ToString();
                TaiKhoan_ tk = new TaiKhoan_(ma, ten, Anh);
                ds_TaiKhoan.Add(tk);
            }
            con.Close();
        }
        public void LoadXe()
        {
            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }
            string strSelect = "select x.MaXe, lx.TenLoaiXe,h.TenNSX,x.TenXe,x.AnhBia,x.MoTa,x.Gia" +
                  " from Xe x, LoaiXe lx, HangXe h where x.MaLoaiXe = lx.MaLoaiXe and h.MaNSX = x.MaNSX";
            SqlDataAdapter da = new SqlDataAdapter(strSelect, con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            foreach (DataRow dr in dt.Rows)
            {
                string MaXe = dr["MaXe"].ToString();
                string TenLoaiXe = dr["TenLoaiXe"].ToString();
                string TenNSX = dr["TenNSX"].ToString();
                string TenXe = dr["TenXe"].ToString();
                string AnhBia = dr["AnhBia"].ToString();
                string MoTa = dr["MoTa"].ToString();
                string Gia = dr["Gia"].ToString();
                //string GiaOut = InGiaXe(Gia);
                Xe_ x = new Xe_(MaXe, TenLoaiXe, TenNSX, TenXe, AnhBia, MoTa, Gia);
                ds_Xe.Add(x);
            }
            con.Close();
        }


        public Xe_ LoadXe(string id)
        {
            try
            {
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                string strSelect = "select x.MaXe, lx.TenLoaiXe,h.TenNSX, x.TenXe,x.AnhBia,x.MoTa,x.Gia" +
                  " from Xe x, LoaiXe lx, HangXe h where x.MaLoaiXe = lx.MaLoaiXe and h.MaNSX = x.MaNSX and x.MaXe = '" + id + "'";
                SqlDataAdapter da = new SqlDataAdapter(strSelect, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                Xe_ x = new Xe_();
                foreach (DataRow dr in dt.Rows)
                {
                    x.MaXe = dr["MaXe"].ToString();
                    x.TenLoaiXe = dr["TenLoaiXe"].ToString();
                    x.TenNSX = dr["TenNSX"].ToString();
                    x.TenXe = dr["TenXe"].ToString();
                    x.AnhBia = dr["AnhBia"].ToString();
                    x.MoTa = dr["MoTa"].ToString();
                    x.Gia = dr["Gia"].ToString();
                }
                con.Close();
                return x;
            }
            catch(Exception)
            {
                return null;
            }
        }
        public string LoadBackground(string id_DanhMucHinh)
        {
            try
            {
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                string fileName;
                string strSelect = "select TenHinh from HinhAnh where Id_DanhMucHinh = '"+id_DanhMucHinh+"' and MaLoaiHinh = 'BG'";
                SqlDataAdapter da = new SqlDataAdapter(strSelect, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                if(dt.Rows.Count<2)
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        fileName = dr["TenHinh"].ToString();
                        return fileName;
                    }
                    con.Close();
                }
                return "0";
            }
            catch (Exception)
            {
                return null;
            }
        }


       
        public DataTable LoadAnhGioiThieu(string id_DanhMucHinh)
        {
            try
            {
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                
                string strSelect = "select TenHinh from HinhAnh where Id_DanhMucHinh = '" + id_DanhMucHinh + "' and MaLoaiHinh = 'A_SP'";
                SqlDataAdapter da = new SqlDataAdapter(strSelect, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                con.Close();
                return dt;
                
            }
            catch (Exception)
            {
                return null;
            }
        }



            public string InGiaXe(string index)
        {
            Stack chuoi = new Stack();
            string ouput = "";
            int dem=0;
            for(int i=0;i<index.Length;i++)
            {
                chuoi.Push(index[i]);
            }
            for(int i=0;i<chuoi.Count;i++)
            {
                dem++;
                if (dem == 3)
                {
                    ouput += ".";
                    dem = 0;
                }
                ouput += chuoi.Pop();
            }
            return ouput;
            
        }
        public DataTable LoadChiTietXe(string id_ChiTietXe)
        {
            try
            {
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                string strSelect = "select *from ChiTietXe where id_ChiTietXe='"+id_ChiTietXe+"';";
                SqlDataAdapter da = new SqlDataAdapter(strSelect, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                con.Close();
                return dt;

            }
            catch (Exception)
            {
                return null;
            }
        }

        public DataTable LoadMauXe(string id_DanhMucHinh, string MaLoaiHinh)
        {
            try
            {
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                string strSelect = "select *from HinhAnh where Id_DanhMucHinh = '"+id_DanhMucHinh+"' and MaLoaiHinh = '"+MaLoaiHinh+"'";
                SqlDataAdapter da = new SqlDataAdapter(strSelect, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                con.Close();
                return dt;

            }
            catch (Exception)
            {
                return null;
            }
        }
        public DataTable LoadXeNoiBac()
        {
            try
            {
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                string strSelect = "select *from Xe where Gia = (select MAX(Gia) from Xe) and MaLoaiXe = 1 or MaLoaiXe = 2 or MaLoaiXe = 3 or MaLoaiXe = 4";
                SqlDataAdapter da = new SqlDataAdapter(strSelect, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                con.Close();
                return dt;

            }
            catch (Exception)
            {
                return null;
            }
        }
        public DataTable LoadXeTuongTu(string TenLoaiXe,string gia)
        {
            try
            {
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                double GiaXe = double.Parse(gia);
                string strSelect = "select x.MaXe, lx.TenLoaiXe,h.TenNSX,x.TenXe,x.AnhBia,x.MoTa,x.Gia from Xe x, LoaiXe lx, HangXe h"+
                    " where x.MaLoaiXe = lx.MaLoaiXe and h.MaNSX = x.MaNSX and lx.TenLoaiXe='"+TenLoaiXe+"' and " +
                    " Gia<"+GiaXe+"+10000000 and Gia> "+GiaXe+" - 10000000";
                SqlDataAdapter da = new SqlDataAdapter(strSelect, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                con.Close();
                return dt;

            }
            catch (Exception)
            {
                return null;
            }
        }
    }
}