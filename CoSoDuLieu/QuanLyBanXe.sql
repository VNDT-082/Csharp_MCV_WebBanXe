USE [master]
GO
/****** Object:  Database [QuanLyBanXe-20221230012255]    Script Date: 7/8/2023 12:50:44 AM ******/
CREATE DATABASE [QuanLyBanXe-20221230012255]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuanLyBanXe-20221230012255_Data', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.VNDT\MSSQL\DATA\QuanLyBanXe-20221230012255.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QuanLyBanXe-20221230012255_Log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.VNDT\MSSQL\DATA\QuanLyBanXe-20221230012255.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [QuanLyBanXe-20221230012255] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLyBanXe-20221230012255].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLyBanXe-20221230012255] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLyBanXe-20221230012255] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLyBanXe-20221230012255] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLyBanXe-20221230012255] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLyBanXe-20221230012255] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLyBanXe-20221230012255] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QuanLyBanXe-20221230012255] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLyBanXe-20221230012255] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyBanXe-20221230012255] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLyBanXe-20221230012255] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLyBanXe-20221230012255] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLyBanXe-20221230012255] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLyBanXe-20221230012255] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLyBanXe-20221230012255] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLyBanXe-20221230012255] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QuanLyBanXe-20221230012255] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLyBanXe-20221230012255] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLyBanXe-20221230012255] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLyBanXe-20221230012255] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLyBanXe-20221230012255] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLyBanXe-20221230012255] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLyBanXe-20221230012255] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLyBanXe-20221230012255] SET RECOVERY FULL 
GO
ALTER DATABASE [QuanLyBanXe-20221230012255] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLyBanXe-20221230012255] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLyBanXe-20221230012255] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLyBanXe-20221230012255] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLyBanXe-20221230012255] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QuanLyBanXe-20221230012255] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QuanLyBanXe-20221230012255] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'QuanLyBanXe-20221230012255', N'ON'
GO
ALTER DATABASE [QuanLyBanXe-20221230012255] SET QUERY_STORE = OFF
GO
USE [QuanLyBanXe-20221230012255]
GO
/****** Object:  User [user1]    Script Date: 7/8/2023 12:50:44 AM ******/
CREATE USER [user1] FOR LOGIN [login2] WITH DEFAULT_SCHEMA=[user1]
GO
/****** Object:  User [admin1]    Script Date: 7/8/2023 12:50:44 AM ******/
CREATE USER [admin1] FOR LOGIN [login1] WITH DEFAULT_SCHEMA=[admin1]
GO
/****** Object:  DatabaseRole [QuanLy]    Script Date: 7/8/2023 12:50:44 AM ******/
CREATE ROLE [QuanLy]
GO
/****** Object:  DatabaseRole [KhachHang]    Script Date: 7/8/2023 12:50:44 AM ******/
CREATE ROLE [KhachHang]
GO
ALTER ROLE [KhachHang] ADD MEMBER [user1]
GO
ALTER ROLE [QuanLy] ADD MEMBER [admin1]
GO
/****** Object:  Schema [admin1]    Script Date: 7/8/2023 12:50:44 AM ******/
CREATE SCHEMA [admin1]
GO
/****** Object:  Schema [KhachHang]    Script Date: 7/8/2023 12:50:44 AM ******/
CREATE SCHEMA [KhachHang]
GO
/****** Object:  Schema [QuanLy]    Script Date: 7/8/2023 12:50:44 AM ******/
CREATE SCHEMA [QuanLy]
GO
/****** Object:  Schema [user1]    Script Date: 7/8/2023 12:50:44 AM ******/
CREATE SCHEMA [user1]
GO
/****** Object:  UserDefinedFunction [dbo].[GiamGia]    Script Date: 7/8/2023 12:50:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GiamGia](@MaKH varchar(5))
returns int
as 
begin
	declare @PhanTramGiam int
	if exists(select *from KhachHangThanThiet where MaKhachHang=@MaKH)
	begin 
		set @PhanTramGiam=(select l.PhanTramUuDai 
						from LoaiKhachHang l, (select LoaiKhach from KhachHangThanThiet where MaKhachHang=@MaKH) tb1
								where l.LoaiKhach=tb1.LoaiKhach)
		return @PhanTramGiam
	end
	else
	begin 
		set @PhanTramGiam=0
	end
	return @PhanTramGiam
end
GO
/****** Object:  UserDefinedFunction [dbo].[KiemTra_KH_ThanThiet]    Script Date: 7/8/2023 12:50:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[KiemTra_KH_ThanThiet](@maKH varchar(5))
returns nvarchar(40)
as
begin
	declare @LoaiKhachHang nvarchar(40)
	if exists(select*from KhachHangThanThiet where MaKhachHang = @maKH)
	begin
		set @LoaiKhachHang=(select l.TenLoai from LoaiKhachHang l, (select LoaiKhach from KhachHangThanThiet where MaKhachHang=@maKH) tb1
							where l.LoaiKhach=tb1.LoaiKhach)
		return @LoaiKhachHang
	end
	else
	begin
		set @LoaiKhachHang=N''
	end
	return @LoaiKhachHang
end
GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 7/8/2023 12:50:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accounts](
	[TenDangNhap] [varchar](30) NOT NULL,
	[LoaiAcc] [int] NOT NULL,
	[MatKhau] [varchar](30) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTietPhieuBan]    Script Date: 7/8/2023 12:50:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietPhieuBan](
	[id_ChiTietPhieuBan] [int] IDENTITY(1,1) NOT NULL,
	[id_PhieuBan] [int] NOT NULL,
	[MaXe] [varchar](5) NULL,
	[SoLuong] [int] NULL,
	[DonGia] [float] NULL,
	[ThanhTien] [float] NULL,
 CONSTRAINT [pk_ChiTietPhieuBan] PRIMARY KEY CLUSTERED 
(
	[id_ChiTietPhieuBan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTietXe]    Script Date: 7/8/2023 12:50:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietXe](
	[id_ChiTietXe] [varchar](5) NOT NULL,
	[MucTieuThuNhienLieu] [nvarchar](100) NULL,
	[HopSo] [nvarchar](100) NULL,
	[LoaiTruyenDong] [nvarchar](200) NULL,
	[MoMentCucDai] [nvarchar](200) NULL,
	[DungTichXiLanh] [nvarchar](200) NULL,
	[KhoiLuong] [nvarchar](200) NULL,
	[ChieuDai] [nvarchar](200) NULL,
	[CheuRong] [nvarchar](200) NULL,
	[ChieuCao] [nvarchar](200) NULL,
	[KhoangCachHaiTrucBanh] [nvarchar](200) NULL,
	[DoCaoYen] [nvarchar](200) NULL,
	[KhoangSangGam] [nvarchar](200) NULL,
	[DungTichBinhXang] [nvarchar](200) NULL,
	[KichThuocLopTruoc] [nvarchar](200) NULL,
	[KichThuocLopSau] [nvarchar](200) NULL,
	[CongSuatToiDa] [nvarchar](200) NULL,
	[PhuocTruoc] [nvarchar](200) NULL,
	[PhuocSau] [nvarchar](200) NULL,
	[DungTichNhotMay] [nvarchar](200) NULL,
	[LoaiDongCo] [nvarchar](200) NULL,
 CONSTRAINT [PK_CHITIETXE] PRIMARY KEY CLUSTERED 
(
	[id_ChiTietXe] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HangXe]    Script Date: 7/8/2023 12:50:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HangXe](
	[MaNSX] [varchar](5) NOT NULL,
	[TenNSX] [nvarchar](30) NULL,
	[AnhBia] [varchar](30) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HinhAnh]    Script Date: 7/8/2023 12:50:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HinhAnh](
	[MaHinh] [int] IDENTITY(1,1) NOT NULL,
	[Id_DanhMucHinh] [varchar](5) NULL,
	[MaLoaiHinh] [varchar](10) NULL,
	[TenHinh] [nvarchar](30) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HinhThucThanhToan]    Script Date: 7/8/2023 12:50:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HinhThucThanhToan](
	[MaHinhThuc] [int] IDENTITY(1,1) NOT NULL,
	[TenHinhThuc] [nvarchar](40) NULL,
 CONSTRAINT [pk_HinhThucThanhToan] PRIMARY KEY CLUSTERED 
(
	[MaHinhThuc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 7/8/2023 12:50:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHang](
	[MaKhachHang] [varchar](5) NOT NULL,
	[TenDangNhap] [varchar](30) NOT NULL,
	[TenKhach] [nvarchar](50) NULL,
	[NgaySinh] [date] NULL,
	[GioiTinh] [nvarchar](3) NULL,
	[DiaChi] [nvarchar](200) NULL,
	[SDT] [varchar](10) NULL,
	[HinhAnh] [varchar](30) NULL,
	[SoLuotMua] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhachHangThanThiet]    Script Date: 7/8/2023 12:50:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHangThanThiet](
	[MaKhachHang] [varchar](5) NOT NULL,
	[LoaiKhach] [int] NULL,
 CONSTRAINT [pk_KHThanThiet] PRIMARY KEY CLUSTERED 
(
	[MaKhachHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiAcc]    Script Date: 7/8/2023 12:50:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiAcc](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[TenLoaiAcc] [nvarchar](30) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiHinhAnh]    Script Date: 7/8/2023 12:50:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiHinhAnh](
	[MaLoaiHinh] [varchar](10) NOT NULL,
	[TenLoaiHinh] [nvarchar](30) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiKhachHang]    Script Date: 7/8/2023 12:50:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiKhachHang](
	[LoaiKhach] [int] IDENTITY(1,1) NOT NULL,
	[TenLoai] [nvarchar](40) NULL,
	[PhanTramUuDai] [int] NULL,
 CONSTRAINT [pk_LoaiKhachHang] PRIMARY KEY CLUSTERED 
(
	[LoaiKhach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiXe]    Script Date: 7/8/2023 12:50:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiXe](
	[MaLoaiXe] [int] IDENTITY(1,1) NOT NULL,
	[TenLoaiXe] [nvarchar](50) NULL,
	[Icon] [varchar](30) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 7/8/2023 12:50:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVien](
	[MaNhanVien] [varchar](5) NOT NULL,
	[TenDangNhap] [varchar](30) NOT NULL,
	[TenNhanVien] [nvarchar](50) NULL,
	[NgaySinh] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhanXet]    Script Date: 7/8/2023 12:50:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanXet](
	[id_nhanXet] [int] IDENTITY(1,1) NOT NULL,
	[MaXe] [varchar](5) NULL,
	[NguoiBinhLuan] [nvarchar](30) NULL,
	[BinhLuan] [nvarchar](500) NULL,
 CONSTRAINT [pk_NhanXet] PRIMARY KEY CLUSTERED 
(
	[id_nhanXet] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhieuBanHang]    Script Date: 7/8/2023 12:50:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuBanHang](
	[MaKhachHang] [varchar](5) NOT NULL,
	[NgayBan] [date] NULL,
	[ThanhToan] [bigint] NULL,
	[id_PhieuBan] [int] IDENTITY(1,1) NOT NULL,
	[HT_ThanhToan] [int] NULL,
	[TrangThai] [bit] NULL,
 CONSTRAINT [PK_PHIEUBANHANG] PRIMARY KEY CLUSTERED 
(
	[id_PhieuBan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Xe]    Script Date: 7/8/2023 12:50:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Xe](
	[MaXe] [varchar](5) NOT NULL,
	[MaLoaiXe] [int] NULL,
	[MaNSX] [varchar](5) NULL,
	[TenXe] [nvarchar](50) NULL,
	[AnhBia] [varchar](30) NULL,
	[MoTa] [ntext] NULL,
	[Gia] [float] NULL,
	[SoLuong] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[Accounts] ([TenDangNhap], [LoaiAcc], [MatKhau]) VALUES (N'ronaldo', 2, N'456')
INSERT [dbo].[Accounts] ([TenDangNhap], [LoaiAcc], [MatKhau]) VALUES (N'duytan123', 2, N'123')
INSERT [dbo].[Accounts] ([TenDangNhap], [LoaiAcc], [MatKhau]) VALUES (N'duytan', 2, N'456')
INSERT [dbo].[Accounts] ([TenDangNhap], [LoaiAcc], [MatKhau]) VALUES (N'vonguyenduytan', 1, N'123')
GO
INSERT [dbo].[ChiTietXe] ([id_ChiTietXe], [MucTieuThuNhienLieu], [HopSo], [LoaiTruyenDong], [MoMentCucDai], [DungTichXiLanh], [KhoiLuong], [ChieuDai], [CheuRong], [ChieuCao], [KhoangCachHaiTrucBanh], [DoCaoYen], [KhoangSangGam], [DungTichBinhXang], [KichThuocLopTruoc], [KichThuocLopSau], [CongSuatToiDa], [PhuocTruoc], [PhuocSau], [DungTichNhotMay], [LoaiDongCo]) VALUES (N'hd01', N'2,16 lít/100km', N'Null', N'Tự động, vô cấp', N'11,7 N.m/5000 vòng/phút', N'124,8 cc', N'116 kg', N'1.950', N'669', N'1.100', N'1.304 mm', N'765 mm', N'130 mm', N'5,6 lít', N'Lốp trước 80/90-16M/C 43P', N'Lốp sau 100/90-14M/C 57P', N'8,2kW/8500 vòng/phút', N'Ống lồng, giảm chấn thủy lực', N'Phuộc đơn', N'Sau khi xả 0,8 L, Sau khi rã máy 0,9 L', N'4 kỳ, 4 van, làm mát bằng dịch')
INSERT [dbo].[ChiTietXe] ([id_ChiTietXe], [MucTieuThuNhienLieu], [HopSo], [LoaiTruyenDong], [MoMentCucDai], [DungTichXiLanh], [KhoiLuong], [ChieuDai], [CheuRong], [ChieuCao], [KhoangCachHaiTrucBanh], [DoCaoYen], [KhoangSangGam], [DungTichBinhXang], [KichThuocLopTruoc], [KichThuocLopSau], [CongSuatToiDa], [PhuocTruoc], [PhuocSau], [DungTichNhotMay], [LoaiDongCo]) VALUES (N'hd02', N'1,90 l/100km', N'Hộp số 4 cấp', N'không', N'8,44 N・m (5.500rmp)', N'109,1 cm3', N'97 kg', N'1.914 mm', N'688 mm', N'1.075 mm', N'1.224 mm', N'769 mm', N'138 mm', N'3,7 L', N'Lốp trước 70/90-17M/C 38P', N'Lốp sau 80/90-17M/C 50P', N'6,12kW/7.500rpm', N'Ống lồng, giảm chấn thủy lực', N'Lò xo trụ, giảm chấn thủy lực', N'Sau khi xả 0,8 L, Sau khi rã máy 1,0 L', N'4 kỳ, 1 xilanh, làm mát bằng không khí')
INSERT [dbo].[ChiTietXe] ([id_ChiTietXe], [MucTieuThuNhienLieu], [HopSo], [LoaiTruyenDong], [MoMentCucDai], [DungTichXiLanh], [KhoiLuong], [ChieuDai], [CheuRong], [ChieuCao], [KhoangCachHaiTrucBanh], [DoCaoYen], [KhoangSangGam], [DungTichBinhXang], [KichThuocLopTruoc], [KichThuocLopSau], [CongSuatToiDa], [PhuocTruoc], [PhuocSau], [DungTichNhotMay], [LoaiDongCo]) VALUES (N'hd03', N'2,26l/100km', N'Vô cấp', N'Dây đai, biến thiên vô cấp', N'11,3Nm/6.500 vòng/phút', N'124,8 cc', N'113 kg', N'1.887 mm', N'687 mm', N'1.092 mm', N'1.286 mm', N'775 mm', N'141 mm', N'4,4 lít', N'Lốp trước 80/90', N'Lốp sau 90/90', N'8,75kW/8.500 vòng/phút', N'Ống lồng, giảm chấn thủy lực', N'Lò xo trụ, giảm chấn thủy lực', N'0,8 lít khi thay nhớt, 0,9 lít khi rã máy', N'Xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung dịch')
INSERT [dbo].[ChiTietXe] ([id_ChiTietXe], [MucTieuThuNhienLieu], [HopSo], [LoaiTruyenDong], [MoMentCucDai], [DungTichXiLanh], [KhoiLuong], [ChieuDai], [CheuRong], [ChieuCao], [KhoangCachHaiTrucBanh], [DoCaoYen], [KhoangSangGam], [DungTichBinhXang], [KichThuocLopTruoc], [KichThuocLopSau], [CongSuatToiDa], [PhuocTruoc], [PhuocSau], [DungTichNhotMay], [LoaiDongCo]) VALUES (N'hd04', N'2,3l/100km', N'Vô cấp', N'Dây đai, biến thiên vô cấp', N'14,6Nm/6.500 vòng/phút', N'156,9 cc', N'114 kg', N'1.887 mm', N'687 mm', N'1.092 mm', N'1.286 mm', N'775 mm', N'142 mm', N'4,4 lít', N'Lốp trước 80/90', N'Lốp sau 90/90', N'11,2kW/8.000 vòng/phút', N'Ống lồng, giảm chấn thủy lực', N'Lò xo trụ, giảm chấn thủy lực', N'0,8 lít khi thay nhớt, 0,9 lít khi rã máy', N'Xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung dịch')
INSERT [dbo].[ChiTietXe] ([id_ChiTietXe], [MucTieuThuNhienLieu], [HopSo], [LoaiTruyenDong], [MoMentCucDai], [DungTichXiLanh], [KhoiLuong], [ChieuDai], [CheuRong], [ChieuCao], [KhoangCachHaiTrucBanh], [DoCaoYen], [KhoangSangGam], [DungTichBinhXang], [KichThuocLopTruoc], [KichThuocLopSau], [CongSuatToiDa], [PhuocTruoc], [PhuocSau], [DungTichNhotMay], [LoaiDongCo]) VALUES (N'hd05', N'1,88 (L/100km)', N'Vô cấp', N'Đai', N'9,29Nm/6.000 vòng/phút', N'109,5cm3', N' 96kg', N'1.871mm', N'686mm', N'1.101mm', N'1.255mm', N'761mm', N'120mm', N'4,9 lít', N'80/90-14M/C 40P', N'90/90-14M/C 46P', N'6,59kW/7.500 vòng/phút', N'Ống lồng, giảm chấn thủy lực', N'Lò xo trụ đơn, giảm chấn thủy lực', N'0,65 lít khi thay dầu, 0,8 lít khi rã máy', N'Xăng, 4 kỳ, 1 xi-lanh, làm mát bằng không khí')
INSERT [dbo].[ChiTietXe] ([id_ChiTietXe], [MucTieuThuNhienLieu], [HopSo], [LoaiTruyenDong], [MoMentCucDai], [DungTichXiLanh], [KhoiLuong], [ChieuDai], [CheuRong], [ChieuCao], [KhoangCachHaiTrucBanh], [DoCaoYen], [KhoangSangGam], [DungTichBinhXang], [KichThuocLopTruoc], [KichThuocLopSau], [CongSuatToiDa], [PhuocTruoc], [PhuocSau], [DungTichNhotMay], [LoaiDongCo]) VALUES (N'hd06', N'2,16 lít/100km', N'Vô cấp', N'Dây đai, biến thiên vô cấp', N'14,6Nm/6.500 vòng/phút', N'124,8 cc', N'113 kg', N'1.844 mm ', N'680 mm', N'1.130 mm', N'1.273 mm', N'760 mm', N'120 mm', N'6,0 lít', N'Lốp trước 90/90-12 44JJ', N'Lốp sau 100/90-10 56J', N'8,22 kw / 8.500 rpm', N'Ống lồng, giảm chấn thủy lực', N'Lò xo trụ, giảm chấn thủy lực', N'0,8 lít khi thay nhớt, 0,9 lít khi rã máy', N'Xăng, 4 kỳ, làm mát bằng chất lỏng')
INSERT [dbo].[ChiTietXe] ([id_ChiTietXe], [MucTieuThuNhienLieu], [HopSo], [LoaiTruyenDong], [MoMentCucDai], [DungTichXiLanh], [KhoiLuong], [ChieuDai], [CheuRong], [ChieuCao], [KhoangCachHaiTrucBanh], [DoCaoYen], [KhoangSangGam], [DungTichBinhXang], [KichThuocLopTruoc], [KichThuocLopSau], [CongSuatToiDa], [PhuocTruoc], [PhuocSau], [DungTichNhotMay], [LoaiDongCo]) VALUES (N'su01', N'1,1,65 lít/100km', N' 6 cấp', N'4 số', N'15,6Nm/7.000 vòng/phút', N'125 cc', N'113 kg', N'1.824 mm ', N'630 mm', N'1.130 mm', N'2.273 mm', N'560 mm', N'220 mm', N'4,0 lít', N'Lốp trước 90/90-12 44JJ', N'Lốp sau 100/90-10 56J', N'8,22 kw / 8.500 rpm', N'Ống lồng, giảm chấn thủy lực', N'Lò xo trụ, giảm chấn thủy lực', N'2,8 lít khi thay nhớt, 1,9 lít khi rã máy', N'Xăng, 4 kỳ, làm mát bằng chất lỏng')
INSERT [dbo].[ChiTietXe] ([id_ChiTietXe], [MucTieuThuNhienLieu], [HopSo], [LoaiTruyenDong], [MoMentCucDai], [DungTichXiLanh], [KhoiLuong], [ChieuDai], [CheuRong], [ChieuCao], [KhoangCachHaiTrucBanh], [DoCaoYen], [KhoangSangGam], [DungTichBinhXang], [KichThuocLopTruoc], [KichThuocLopSau], [CongSuatToiDa], [PhuocTruoc], [PhuocSau], [DungTichNhotMay], [LoaiDongCo]) VALUES (N'su02', N'2,60 lít/100km', N' 4cấp', N'4 số', N'15,6Nm/3.000 vòng/phút', N'125 cc', N'113 kg', N'1.434 mm ', N'630 mm', N'1.130 mm', N'2.273 mm', N'560 mm', N'120 mm', N'7,0 lít', N'Lốp trước 90/90-12 44JJ', N'Lốp sau 100/90-10 56J', N'8,22 kw / 8.500 rpm', N'Ống lồng, giảm chấn thủy lực', N'Lò xo trụ, giảm chấn thủy lực', N'3,8 lít khi thay nhớt, 2,9 lít khi rã máy', N'	2 thì, 4 van, SOHC, làm mát bằng không khí')
INSERT [dbo].[ChiTietXe] ([id_ChiTietXe], [MucTieuThuNhienLieu], [HopSo], [LoaiTruyenDong], [MoMentCucDai], [DungTichXiLanh], [KhoiLuong], [ChieuDai], [CheuRong], [ChieuCao], [KhoangCachHaiTrucBanh], [DoCaoYen], [KhoangSangGam], [DungTichBinhXang], [KichThuocLopTruoc], [KichThuocLopSau], [CongSuatToiDa], [PhuocTruoc], [PhuocSau], [DungTichNhotMay], [LoaiDongCo]) VALUES (N'sy01', N'3,20 lít/100km', N' 6 cấp', N'Côn tay 6 số', N'15,6Nm/5.000 vòng/phút', N'125 cc', N'113 kg', N'1.844 mm ', N'680 mm', N'1.130 mm', N'1.273 mm', N'760 mm', N'120 mm', N'7,0 lít', N'Lốp trước 90/90-12 44JJ', N'Lốp sau 100/90-10 56J', N'8,22 kw / 8.500 rpm', N'Ống lồng, giảm chấn thủy lực', N'Lò xo trụ, giảm chấn thủy lực', N'1,8 lít khi thay nhớt, 1 lít khi rã máy', N'Xăng, 4 kỳ, làm mát bằng chất lỏng')
INSERT [dbo].[ChiTietXe] ([id_ChiTietXe], [MucTieuThuNhienLieu], [HopSo], [LoaiTruyenDong], [MoMentCucDai], [DungTichXiLanh], [KhoiLuong], [ChieuDai], [CheuRong], [ChieuCao], [KhoangCachHaiTrucBanh], [DoCaoYen], [KhoangSangGam], [DungTichBinhXang], [KichThuocLopTruoc], [KichThuocLopSau], [CongSuatToiDa], [PhuocTruoc], [PhuocSau], [DungTichNhotMay], [LoaiDongCo]) VALUES (N'sy02', N'2,60 lít/100km', N' 4cấp', N'4 số', N'15,6Nm/3.000 vòng/phút', N'125 cc', N'113 kg', N'1.434 mm ', N'330 mm', N'1.130 mm', N'2.273 mm', N'560 mm', N'120 mm', N'7,0 lít', N'Lốp trước 90/90-12 44JJ', N'Lốp sau 100/90-10 56J', N'8,22 kw / 8.500 rpm', N'Ống lồng, giảm chấn thủy lực', N'Lò xo trụ, giảm chấn thủy lực', N'3,8 lít khi thay nhớt, 2,9 lít khi rã máy', N'	2 thì, 4 van, SOHC, làm mát bằng không khí')
INSERT [dbo].[ChiTietXe] ([id_ChiTietXe], [MucTieuThuNhienLieu], [HopSo], [LoaiTruyenDong], [MoMentCucDai], [DungTichXiLanh], [KhoiLuong], [ChieuDai], [CheuRong], [ChieuCao], [KhoangCachHaiTrucBanh], [DoCaoYen], [KhoangSangGam], [DungTichBinhXang], [KichThuocLopTruoc], [KichThuocLopSau], [CongSuatToiDa], [PhuocTruoc], [PhuocSau], [DungTichNhotMay], [LoaiDongCo]) VALUES (N'ya01', N'2,20 lít/100km', N'Vô cấp', N'Dây đai, biến thiên vô cấp', N'14,6Nm/6.000 vòng/phút', N'125 cc', N'113 kg', N'1.844 mm ', N'680 mm', N'1.130 mm', N'1.273 mm', N'760 mm', N'120 mm', N'7,0 lít', N'Lốp trước 90/90-12 44JJ', N'Lốp sau 100/90-10 56J', N'8,22 kw / 8.500 rpm', N'Ống lồng, giảm chấn thủy lực', N'Lò xo trụ, giảm chấn thủy lực', N'1,8 lít khi thay nhớt, 1 lít khi rã máy', N'Xăng, 4 kỳ, làm mát bằng chất lỏng')
INSERT [dbo].[ChiTietXe] ([id_ChiTietXe], [MucTieuThuNhienLieu], [HopSo], [LoaiTruyenDong], [MoMentCucDai], [DungTichXiLanh], [KhoiLuong], [ChieuDai], [CheuRong], [ChieuCao], [KhoangCachHaiTrucBanh], [DoCaoYen], [KhoangSangGam], [DungTichBinhXang], [KichThuocLopTruoc], [KichThuocLopSau], [CongSuatToiDa], [PhuocTruoc], [PhuocSau], [DungTichNhotMay], [LoaiDongCo]) VALUES (N'ya02', N'1,60 lít/100km', N' 6 cấp', N'4 số', N'15,6Nm/7.000 vòng/phút', N'125 cc', N'113 kg', N'1.824 mm ', N'630 mm', N'1.130 mm', N'2.273 mm', N'560 mm', N'220 mm', N'7,0 lít', N'Lốp trước 90/90-12 44JJ', N'Lốp sau 100/90-10 56J', N'8,22 kw / 8.500 rpm', N'Ống lồng, giảm chấn thủy lực', N'Lò xo trụ, giảm chấn thủy lực', N'2,8 lít khi thay nhớt, 1,9 lít khi rã máy', N'	4 thì, 2 van, SOHC, làm mát bằng không khí')
GO
INSERT [dbo].[HangXe] ([MaNSX], [TenNSX], [AnhBia]) VALUES (N'NSX01', N'HONDA', N'Honda.png')
INSERT [dbo].[HangXe] ([MaNSX], [TenNSX], [AnhBia]) VALUES (N'NSX02', N'YAMAHA', N'Yamaha.png')
INSERT [dbo].[HangXe] ([MaNSX], [TenNSX], [AnhBia]) VALUES (N'NSX03', N'SYM', N'sym.png')
INSERT [dbo].[HangXe] ([MaNSX], [TenNSX], [AnhBia]) VALUES (N'NSX04', N'SUZUKI', N'Suzuki.png')
INSERT [dbo].[HangXe] ([MaNSX], [TenNSX], [AnhBia]) VALUES (N'NSX05', N'OSAKAR', N'Osakar.png')
INSERT [dbo].[HangXe] ([MaNSX], [TenNSX], [AnhBia]) VALUES (N'NSX06', N'DUCATI', N'Ducati.png')
INSERT [dbo].[HangXe] ([MaNSX], [TenNSX], [AnhBia]) VALUES (N'NSX07', N'DETECH', N'Detech.png')
GO
SET IDENTITY_INSERT [dbo].[HinhAnh] ON 

INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (2, N'hd01', N'A_SP', N'ShMode_125cc_2023_h1.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (3, N'hd01', N'A_SP', N'ShMode_125cc_2023_h2.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (4, N'hd01', N'A_SP', N'ShMode_125cc_2023_h3.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (5, N'hd01', N'A_SP', N'ShMode_125cc_2023_h4.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (6, N'hd01', N'A_SP', N'ShMode_125cc_2023_h5.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (7, N'hd01', N'BG', N'ShMode_125cc_2023_bg.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (8, N'hd01', N'PBCC', N'ShMode_125cc_2023_m1.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (9, N'hd01', N'PBCC', N'ShMode_125cc_2023_m2.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (10, N'hd01', N'PBDB', N'ShMode_125cc_2023_m3.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (11, N'hd01', N'PBDB', N'ShMode_125cc_2023_m4.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (12, N'hd01', N'PBTT', N'ShMode_125cc_2023_m5.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (13, N'hd01', N'PBTC', N'ShMode_125cc_2023_m6.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (14, N'hd01', N'PBTC', N'ShMode_125cc_2023_m7.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (15, N'hd01', N'PBTC', N'ShMode_125cc_2023_m8.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (56, N'hd05', N'A_SP', N'Vision_h1.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (57, N'hd05', N'A_SP', N'Vision_h2.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (58, N'hd05', N'A_SP', N'Vision_h3.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (59, N'hd05', N'A_SP', N'Vision_h4.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (60, N'hd05', N'A_SP', N'Vision_h5.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (55, N'hd03', N'BG', N'AirBlade125_160_bg.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (61, N'hd05', N'A_SP', N'Vision_h6.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (62, N'hd05', N'BG', N'Vision_bg.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (63, N'hd05', N'PBCC', N'Vision_h7.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (64, N'hd05', N'PBCC', N'Vision_h8.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (76, N'ya01', N'PBTT', N'YamahaMT-03_m1.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (77, N'ya01', N'PBTT', N'YamahaMT-03_m2.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (78, N'ya01', N'PBTT', N'YamahaMT-03_m3.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (79, N'ya01', N'BG', N'yamaha_mt15_bg.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (30, N'hd02', N'A_SP', N'WaveAlpha_110cc_2023_h1.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (31, N'hd02', N'A_SP', N'WaveAlpha_110cc_2023_h2.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (32, N'hd02', N'A_SP', N'WaveAlpha_110cc_2023_h3.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (33, N'hd02', N'BG', N'WaveAlpha_110cc_bg.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (34, N'hd02', N'PBDB', N'WaveAlpha_110cc_2023_m1.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (35, N'hd02', N'PBTC', N'WaveAlpha_110cc_2023_m2.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (36, N'hd02', N'PBTC', N'WaveAlpha_110cc_2023_m3.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (37, N'hd02', N'PBTC', N'WaveAlpha_110cc_2023_m4.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (38, N'hd03', N'A_SP', N'AirBlade125_160_h1.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (39, N'hd03', N'A_SP', N'AirBlade125_160_h2.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (40, N'hd03', N'A_SP', N'AirBlade125_160_h3.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (42, N'hd03', N'PBTC', N'AirBlade125_160_m2.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (43, N'hd03', N'PBTC', N'AirBlade125_160_m3.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (44, N'hd03', N'A_SP', N'AirBlade125_160_h1.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (45, N'hd03', N'A_SP', N'AirBlade125_160_h2.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (46, N'hd03', N'A_SP', N'AirBlade125_160_h3.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (47, N'hd03', N'BG', N'AirBlade125_160_bg.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (51, N'hd04', N'PBDB', N'AirBlade160_m1.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (52, N'hd04', N'PBTC', N'AirBlade160_m2.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (53, N'hd04', N'PBTC', N'AirBlade160_m3.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (54, N'hd04', N'PBTC', N'AirBlade160_m4.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (80, N'ya01', N'PBDB', N'YamahaMT-03_PBDB.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (81, N'ya01', N'PBTC', N'YamahaMT-03_pbtc_1.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (82, N'ya01', N'PBTC', N'YamahaMT-03_pbtc_2.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (83, N'ya01', N'PBTC', N'YamahaMT-03_pbtc_3.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (84, N'sy01', N'PBTT', N'ATTILA50-1.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (85, N'sy01', N'PBTT', N'ATTILA50-2.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (86, N'sy01', N'PBTT', N'ATTILA50-3.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (87, N'sy01', N'BG', N'ATTILA50-bg.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (88, N'sy01', N'PBDB', N'ATTILA50_PBDB.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (89, N'sy01', N'PBTC', N'ATTILA50_pbtc_1.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (90, N'sy01', N'PBTC', N'ATTILA50_pbtc_2.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (91, N'sy01', N'PBTC', N'ATTILA50_pbtc_3.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (92, N'su01', N'PBTT', N'BurgmanStreet-1.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (93, N'su01', N'PBTT', N'BurgmanStreet-2.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (94, N'su01', N'PBTT', N'BurgmanStreet-3.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (95, N'su01', N'BG', N'suzuki_Burgman_street_bg.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (96, N'su01', N'PBDB', N'BurgmanStreet_PBDB.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (97, N'su01', N'PBTC', N'BurgmanStreet_pbtc_1.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (98, N'su01', N'PBTC', N'BurgmanStreet_pbtc_2.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (99, N'su01', N'PBTC', N'BurgmanStreet_pbtc_3.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (103, N'ya02', N'PBTT', N'SIRIUSFI-1.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (104, N'ya02', N'PBTT', N'SIRIUSFI-2.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (105, N'ya02', N'PBTT', N'SIRIUSFI-3.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (106, N'ya02', N'BG', N'Suris_bg.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (107, N'ya02', N'PBDB', N'SIRIUSFI_PBDB.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (108, N'ya02', N'PBTC', N'SIRIUSFI_pbtc_1.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (109, N'ya02', N'PBTC', N'SIRIUSFI_pbtc_2.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (110, N'ya02', N'PBTC', N'SIRIUSFI_pbtc_3.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (111, N'su02', N'PBTT', N'SATRIAF150-1.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (112, N'su02', N'PBTT', N'SATRIAF150-2.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (113, N'su02', N'PBTT', N'SATRIAF150-3.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (114, N'su02', N'BG', N'suzuki_satria150_bg.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (115, N'su02', N'PBDB', N'SATRIAF150_PBDB.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (116, N'su02', N'PBTC', N'SATRIAF150_pbtc_1.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (117, N'su02', N'PBTC', N'SATRIAF150_pbtc_2.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (118, N'su02', N'PBTC', N'SATRIAF150_pbtc_2.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (119, N'sy02', N'PBTT', N'Husky125Classic-1.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (120, N'sy02', N'PBTT', N'Husky125Classic-2.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (121, N'sy02', N'PBTT', N'Husky125Classic-3.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (122, N'sy02', N'BG', N'Husky125Classic-bg.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (123, N'sy02', N'PBDB', N'Husky125Classic_PBDB.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (124, N'sy02', N'PBTC', N'Husky125Classic_pbtc_1.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (125, N'sy02', N'PBTC', N'Husky125Classic_pbtc_2.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (126, N'sy02', N'PBTC', N'usky125Classic_pbtc_3.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (127, N'ya02', N'A_SP', N'Sirius_sp1.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (128, N'ya02', N'A_SP', N'Sirius_sp2.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (129, N'ya02', N'A_SP', N'Sirius_sp3.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (130, N'ya02', N'A_SP', N'Sirius_sp4.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (131, N'ya01', N'A_SP', N'yamaha_mt15_h1.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (132, N'ya01', N'A_SP', N'yamaha_mt15_h2.png')
GO
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (133, N'ya01', N'A_SP', N'yamaha_mt15_h3.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (134, N'ya01', N'A_SP', N'yamaha_mt15_h4.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (135, N'ya01', N'A_SP', N'yamaha_mt15_h5.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (136, N'sy01', N'A_SP', N'sym_atila50_h1.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (137, N'sy01', N'A_SP', N'sym_atila50_h2.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (138, N'sy01', N'A_SP', N'sym_atila50_h3.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (139, N'su01', N'A_SP', N'suzuki_Burgman_street_h1.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (140, N'su01', N'A_SP', N'suzuki_Burgman_street_h2.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (141, N'su01', N'A_SP', N'suzuki_Burgman_street_h3.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (65, N'hd05', N'PBDB', N'Vision_h9.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (66, N'hd05', N'PBTC', N'Vision_h10.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (67, N'hd06', N'A_SP', N'6_LEAD_125cc_h1.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (68, N'hd06', N'A_SP', N'6_LEAD_125cc_h2.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (69, N'hd06', N'A_SP', N'6_LEAD_125cc_h3.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (70, N'hd06', N'BG', N'6_LEAD_125cc_bg.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (71, N'hd06', N'PBCC', N'6_LEAD_125cc_m1.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (72, N'hd06', N'PBCC', N'6_LEAD_125cc_m2.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (73, N'hd06', N'PBDB', N'6_LEAD_125cc_m3.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (74, N'hd06', N'PBDB', N'6_LEAD_125cc_m4.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (75, N'hd06', N'PBTC', N'6_LEAD_125cc_m5.png')
INSERT [dbo].[HinhAnh] ([MaHinh], [Id_DanhMucHinh], [MaLoaiHinh], [TenHinh]) VALUES (142, N'su02', N'A_SP', N'suzuki_satria150_h1.png')
SET IDENTITY_INSERT [dbo].[HinhAnh] OFF
GO
SET IDENTITY_INSERT [dbo].[HinhThucThanhToan] ON 

INSERT [dbo].[HinhThucThanhToan] ([MaHinhThuc], [TenHinhThuc]) VALUES (1, N'Thanh toán trực tiếp tại cửa hàng')
INSERT [dbo].[HinhThucThanhToan] ([MaHinhThuc], [TenHinhThuc]) VALUES (2, N'Chuyển khoản')
SET IDENTITY_INSERT [dbo].[HinhThucThanhToan] OFF
GO
INSERT [dbo].[KhachHang] ([MaKhachHang], [TenDangNhap], [TenKhach], [NgaySinh], [GioiTinh], [DiaChi], [SDT], [HinhAnh], [SoLuotMua]) VALUES (N'KH01', N'duytan', N'Võ Nguyễn Duy Tân', CAST(N'2002-02-08' AS Date), N'Nam', N'Châu Thành-Tiền Giang', N'0339836389', N'user01.png', 6)
INSERT [dbo].[KhachHang] ([MaKhachHang], [TenDangNhap], [TenKhach], [NgaySinh], [GioiTinh], [DiaChi], [SDT], [HinhAnh], [SoLuotMua]) VALUES (N'KH02', N'ronaldo', N'Cristiano Ronaldo', CAST(N'1985-05-02' AS Date), N'Nam', N'Bồ đào nha', N'0339836390', N'', 0)
INSERT [dbo].[KhachHang] ([MaKhachHang], [TenDangNhap], [TenKhach], [NgaySinh], [GioiTinh], [DiaChi], [SDT], [HinhAnh], [SoLuotMua]) VALUES (N'KH03', N'duytan123', N'Duy Tân', CAST(N'2002-02-02' AS Date), N'Nam', N'Tiền Giang', N'0339837389', N'', 0)
GO
INSERT [dbo].[KhachHangThanThiet] ([MaKhachHang], [LoaiKhach]) VALUES (N'KH01', 1)
GO
SET IDENTITY_INSERT [dbo].[LoaiAcc] ON 

INSERT [dbo].[LoaiAcc] ([id], [TenLoaiAcc]) VALUES (1, N'Admin')
INSERT [dbo].[LoaiAcc] ([id], [TenLoaiAcc]) VALUES (2, N'Khách')
INSERT [dbo].[LoaiAcc] ([id], [TenLoaiAcc]) VALUES (3, N'Admin')
INSERT [dbo].[LoaiAcc] ([id], [TenLoaiAcc]) VALUES (4, N'Khách')
SET IDENTITY_INSERT [dbo].[LoaiAcc] OFF
GO
INSERT [dbo].[LoaiHinhAnh] ([MaLoaiHinh], [TenLoaiHinh]) VALUES (N'BG', N'Background')
INSERT [dbo].[LoaiHinhAnh] ([MaLoaiHinh], [TenLoaiHinh]) VALUES (N'A_SP', N'Ảnh sản phẩm')
INSERT [dbo].[LoaiHinhAnh] ([MaLoaiHinh], [TenLoaiHinh]) VALUES (N'PBCC', N'Phiên bản cao cấp')
INSERT [dbo].[LoaiHinhAnh] ([MaLoaiHinh], [TenLoaiHinh]) VALUES (N'PBDB', N'Phiên bản đặc biệt')
INSERT [dbo].[LoaiHinhAnh] ([MaLoaiHinh], [TenLoaiHinh]) VALUES (N'PBTC', N'Phiên bản tiêu chuẩn')
INSERT [dbo].[LoaiHinhAnh] ([MaLoaiHinh], [TenLoaiHinh]) VALUES (N'PBTT', N'Phiên bản thể thao')
GO
SET IDENTITY_INSERT [dbo].[LoaiKhachHang] ON 

INSERT [dbo].[LoaiKhachHang] ([LoaiKhach], [TenLoai], [PhanTramUuDai]) VALUES (1, N'Khách hàng thân thiết', 5)
INSERT [dbo].[LoaiKhachHang] ([LoaiKhach], [TenLoai], [PhanTramUuDai]) VALUES (2, N'Khách hàng Vip', 20)
SET IDENTITY_INSERT [dbo].[LoaiKhachHang] OFF
GO
SET IDENTITY_INSERT [dbo].[LoaiXe] ON 

INSERT [dbo].[LoaiXe] ([MaLoaiXe], [TenLoaiXe], [Icon]) VALUES (1, N'Xe tay ga', N'h2.png')
INSERT [dbo].[LoaiXe] ([MaLoaiXe], [TenLoaiXe], [Icon]) VALUES (2, N'Xe số', N'h1.png')
INSERT [dbo].[LoaiXe] ([MaLoaiXe], [TenLoaiXe], [Icon]) VALUES (3, N'Phân khối lớn', N'h4.png')
INSERT [dbo].[LoaiXe] ([MaLoaiXe], [TenLoaiXe], [Icon]) VALUES (4, N'Xe điện', N'h5.png')
SET IDENTITY_INSERT [dbo].[LoaiXe] OFF
GO
INSERT [dbo].[Xe] ([MaXe], [MaLoaiXe], [MaNSX], [TenXe], [AnhBia], [MoTa], [Gia], [SoLuong]) VALUES (N'hd01', 1, N'NSX01', N'Sh mode 125cc', N'1_ShMode_125cc_2023.png', N'Thuộc phân khúc xe ga cao cấp 
và thừa hưởng thiết kế sang trọng nổi tiếng của dòng xe SH, Sh mode luôn được đánh
giá cao nhờ kiểu dáng sang trọng, tinh tế tới từng đường nét, động cơ tiên tiến và 
các tiện nghi cao cấp xứng tầm phong cách sống thời thượng, đẳng cấp.', 61648363, NULL)
INSERT [dbo].[Xe] ([MaXe], [MaLoaiXe], [MaNSX], [TenXe], [AnhBia], [MoTa], [Gia], [SoLuong]) VALUES (N'hd02', 2, N'NSX01', N'Wave Alpha 110cc', N'2_WaveAlpha_110cc_2023.png', N'Wave Alpha phiên bản 2023 trẻ trung và năng động với màu đen mờ hoàn toàn mới
cùng thiết kế bộ tem mới ấn tượng, thu hút ánh nhìn, cho bạn tự tin thể hiện cá tính
của mình trên mọi hành trình.', 17859273, NULL)
INSERT [dbo].[Xe] ([MaXe], [MaLoaiXe], [MaNSX], [TenXe], [AnhBia], [MoTa], [Gia], [SoLuong]) VALUES (N'hd03', 1, N'NSX01', N'Air Blade 125cc', N'4_AirBlade_125cc.png', N'Xứng danh mẫu xe tay ga thể thao tầm trung hàng đầu trong suốt hơn một thập kỷ qua,
AIR BLADE hoàn toàn mới nay được nâng cấp động cơ eSP+ 4 van độc quyền, tiên tiến nhất
giúp mang trong mình mãnh lực tiên phong.', 41324727, NULL)
INSERT [dbo].[Xe] ([MaXe], [MaLoaiXe], [MaNSX], [TenXe], [AnhBia], [MoTa], [Gia], [SoLuong]) VALUES (N'hd04', 1, N'NSX01', N'Air Blade 160cc', N'4_AirBlade_125cc.png', N'Xứng danh mẫu xe tay ga thể thao tầm trung hàng đầu trong suốt hơn một thập kỷ qua,
AIR BLADE hoàn toàn mới nay được nâng cấp động cơ eSP+ 4 van độc quyền, tiên tiến nhất
giúp mang trong mình mãnh lực tiên phong.', 49324727, NULL)
INSERT [dbo].[Xe] ([MaXe], [MaLoaiXe], [MaNSX], [TenXe], [AnhBia], [MoTa], [Gia], [SoLuong]) VALUES (N'hd05', 1, N'NSX01', N'Vision 110cc', N'5_Vision.png', N'Thuộc phân khúc xe tay ga phổ thông,Vision luôn là mẫu xe quốc dân được yêu thích, đặc biệt trong giới trẻ nhờ kiểu dángthời trang, trẻ trung và nhỏ gọn, khả năng tiết kiệm nhiên liệu vượt trội và vô cùng bền bỉ.', 30721091, NULL)
INSERT [dbo].[Xe] ([MaXe], [MaLoaiXe], [MaNSX], [TenXe], [AnhBia], [MoTa], [Gia], [SoLuong]) VALUES (N'hd06', 1, N'NSX01', N'LEAD 125cc', N'6_LEAD_125cc.png', N'Phiên bản đặc biệt nay được bổ sung
thêm tông xám mờ - màu sắc mang sắc thái thời đại giúp tôn lên hình ảnh và phong cách
sống thanh lịch, trang nhã nhưng không kém phần thời thượng. Phiên bản cao cấp tạo điểm
nhấn với 4 màu sắc thu hút Trắng, Đỏ, Xanh, Xám, đa dạng dải màu sắc cũng như lựa chọn
cho khách hàng. Bản Tiêu chuẩn với 2 màu Trắng, Đỏ tinh tế nhưng không kém phần nổi bật.
-LEAD 125cc sở hữu thiết kế hiện đại với những đường nét thon gọn, ôm sát người lái. 
Dọc hai bên thân là những đường gờ được chạm khắc tinh tế, tạo khối 3D mang đến cho 
mẫu xe một diện mạo thực sự khác biệt. Mặt trước được điểm xuyết tinh tế các chi tiết 
mạ chrome cao cấp phối hợp hài hòa cùng màu sắc chủ đạo trên thân xe, gây được ấn tượng 
mạnh mẽ cho người đối diện, nổi bật nét khác biệt không thể hòa lẫn trong tổng thể 
ngoại hình của mẫu xe. Đèn pha LED (*) đem đến giải pháp chiếu sáng hiệu quả.
Ngoài ra, đèn chiếu sáng phía trước luôn sáng giúp nâng cao khả năng hiện diện của xe 
khi lưu thông trên đường phố.
(*): Áp dụng cho Phiên bản đặc biệt và cao cấp', 39066545, NULL)
INSERT [dbo].[Xe] ([MaXe], [MaLoaiXe], [MaNSX], [TenXe], [AnhBia], [MoTa], [Gia], [SoLuong]) VALUES (N'ya01', 1, N'NSX02', N'Yamaha MT-03', N'YamahaMT-03_pbtc_3.png', N'MT-03 ABS được trang bị động cơ 
làm mát bằng dung dịch 4 thì, 2 xylanh thẳng hàng, DOHC 4 van, phun xăng điện tử, dung tích 321cc, hộp số 
6 cấp. Với đường kính và hành trình piston 68.0 mm x 44.1 mm cùng tỉ số nén 11.2:1, khối động cơ sản sinh ra
 công suất cực đại đại 30,9kW tại 10.750v/p và mômen xoắn cực đại 29,6 Nm ở 9.000v/p. 
Đây cũng là khối động cơ được sử dụng trên mẫu sport bike YZF-R3.', 50000000, NULL)
INSERT [dbo].[Xe] ([MaXe], [MaLoaiXe], [MaNSX], [TenXe], [AnhBia], [MoTa], [Gia], [SoLuong]) VALUES (N'sy01', 1, N'NSX03', N'ATTILA50', N'ATTILA50_pbtc_2.png', N'Nắp bình xăng được giấu ở phía cốp trước rất an toàn. 
Thao tác mở nắp xăng thật nhẹ nhàng nhờ cơ chế nắp xăng tự bung khi xoay chìa khóa sang phải.Hộc chứa đồ dưới yên xe siêu lớn,
 có thể chứa hai nón bảo hiểm loại 3/4 đầu và để thêm những vật dụng khác.Tay nắm sau bằng inox bo tròn theo đuôi xe,
  tạo vẻ chắc chắn, tư thế dựng xe thoải mái và tôn thêm vẻ cao cấp cho xe.', 16000000, NULL)
INSERT [dbo].[Xe] ([MaXe], [MaLoaiXe], [MaNSX], [TenXe], [AnhBia], [MoTa], [Gia], [SoLuong]) VALUES (N'su01', 1, N'NSX04', N'Burgman Street', N'BurgmanStreet_pbtc_2.png', N'Burgman Street được trang bị hàng loạt tiện ích 
và chức năng ƯU VIỆT nhằm mang lại tiện nghi và sự thoải mái cho khách hàng khi điều khiển xe.
Các thông số kỹ thuật được tối ưu hóa cả về tính năng vận hành hiệu quả và mang lại sự tiện nghi và thoải mái cho 
khách hàng.
Công Nghệ Phun Xăng Điện Tử Tiên Tiến đảm bảo hiệu quả và tiết kiệm nhiên liệu, dễ khởi động động cơ và góp phần 
giảm thiểu khí thải ra môi trường. Hệ thống phanh kết hợp chỉ cho phép vận hành cả hai phanh bằng cần phanh bên trái. 
Nó giúp giữ cân bằng tốt giữa lực phanh trước và sau. Hỗ trợ an toàn cho người sử dụng.', 49999999, NULL)
INSERT [dbo].[Xe] ([MaXe], [MaLoaiXe], [MaNSX], [TenXe], [AnhBia], [MoTa], [Gia], [SoLuong]) VALUES (N'ya02', 1, N'NSX02', N'Yamaha SIRIUS FI', N'SIRIUSFI_pbtc_2.png', N'Thay đổi lớn nhất chính là hai đèn định vị được gom lại đặt kề với cụm đèn pha, 
không chỉ làm cho phần đầu xe trở nên thanh thoát mà còn làm diện mạo xe thêm thu hút, giúp nhận ra nét độc đáo của xe ngay khi nhìn lướt qua.
Thay đổi lớn nhất chính là hai đèn định vị được gom lại đặt kề với cụm đèn pha, không chỉ làm cho phần đầu xe trở nên thanh thoát mà còn làm diện mạo 
xe thêm thu hút, giúp nhận ra nét độc đáo của xe ngay khi nhìn lướt qua. ', 23000000, NULL)
INSERT [dbo].[Xe] ([MaXe], [MaLoaiXe], [MaNSX], [TenXe], [AnhBia], [MoTa], [Gia], [SoLuong]) VALUES (N'su02', 4, N'NSX04', N'Suzuki SATRIA F150', N'SATRIAF150_pbtc_2.png', N'TThể thao, mạnh mẽ với thiết kế thân xe khí động
học, Satria F150 sẵn sàng cùng bạn chinh phục mọi thử thách trên đường. Tương tự Raider R150, Satria F150 được
trang bị động cơ mạnh mẽ, thừa hưởng công nghệ tiên tiến của Suzuki chế tạo cho các dòng xe đua nổi tiếng.
Công suất tối đa mạnh mẽ kết hợp cùng trọng lượng thân xe tối ưu giúp cho Satria có khả năng tăng tốc nhanh và
mạnh mẽ nhất phân khúc xe 150cc.
Giống như Raider R150, Suzuki Satria F150 F/i sở hữu kiểu dáng Hyper-Underbone, và các đặc tính làm nên tên tuổi
của dòng xe underbone côn tay 150cc như nhanh, gọn và linh hoạt. Các yếu tố khác biệt của SATRIA F150 và 
RAIDER R150 tạo nên sự độc đáo của “Ông Vua Tốc Độ” phân khúc 150cc. ', 50000000, NULL)
INSERT [dbo].[Xe] ([MaXe], [MaLoaiXe], [MaNSX], [TenXe], [AnhBia], [MoTa], [Gia], [SoLuong]) VALUES (N'sy02', 3, N'NSX03', N'Sym Husky 125 Classic', N'Husky125Classic_.png', N'Mẫu xe Husky 125 của hãng xe SYM đến từ Đài Loan vừa được ra mắt vào trung tuần tháng 12 
vừa qua tại thị trường Việt Nam. Mẫu xe SYM Husky 125 nằm trong phân khác xe côn tay giá rẻ đánh vào nhóm khách hàng đem mê đi phượt, thích trải nghiệm những cung 
đường và cạnh tranh trực tiếp với GD110 vừa ra mắt trong thời gian gần đây.SYM Husky Classic 125 được sự quan tâm của khá hhiều người từ khi vừa được giới thiệu bởi 
kiểu dáng hoài cổ, bụi bặm pha chút nét hiện đại phù hợp với những biker thích  “ Phượt ” , giá bán mềm hợp lý và đặc biệt có thể tùy ý độ chế theo ý thích của mình.
Xe côn tay Husky 125 2018 được giới thiệu lần đầu tiên vào tháng 5/2017 tại khuôn khổ Triển lãm Mô tô Xe máy Việt Nam 2017 với tên gọi Wolf 125 với rất ít thông tin 
chi tiết, mãi cho đến tận hôm nay mới chính thức trình làng tại Việt Nam khi mà các dòng xe cộn tay giá rẻ đang có sự cạnh tranh sôi nổi, đa dạng thì việc xuất hiện 
Husky 125 đã giúp có thêm nhiều sự lựa chọn phong phú.', 70000000, NULL)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PK_ACCOUNTS]    Script Date: 7/8/2023 12:50:44 AM ******/
ALTER TABLE [dbo].[Accounts] ADD  CONSTRAINT [PK_ACCOUNTS] PRIMARY KEY NONCLUSTERED 
(
	[TenDangNhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PK_HANGXE]    Script Date: 7/8/2023 12:50:44 AM ******/
ALTER TABLE [dbo].[HangXe] ADD  CONSTRAINT [PK_HANGXE] PRIMARY KEY NONCLUSTERED 
(
	[MaNSX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK_HinhAnh]    Script Date: 7/8/2023 12:50:44 AM ******/
ALTER TABLE [dbo].[HinhAnh] ADD  CONSTRAINT [PK_HinhAnh] PRIMARY KEY NONCLUSTERED 
(
	[MaHinh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PK_KHACHHANG]    Script Date: 7/8/2023 12:50:44 AM ******/
ALTER TABLE [dbo].[KhachHang] ADD  CONSTRAINT [PK_KHACHHANG] PRIMARY KEY NONCLUSTERED 
(
	[MaKhachHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK_LOAIACC]    Script Date: 7/8/2023 12:50:44 AM ******/
ALTER TABLE [dbo].[LoaiAcc] ADD  CONSTRAINT [PK_LOAIACC] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PK_LoaiHinhAnh]    Script Date: 7/8/2023 12:50:44 AM ******/
ALTER TABLE [dbo].[LoaiHinhAnh] ADD  CONSTRAINT [PK_LoaiHinhAnh] PRIMARY KEY NONCLUSTERED 
(
	[MaLoaiHinh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK_LOAIXE]    Script Date: 7/8/2023 12:50:44 AM ******/
ALTER TABLE [dbo].[LoaiXe] ADD  CONSTRAINT [PK_LOAIXE] PRIMARY KEY NONCLUSTERED 
(
	[MaLoaiXe] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PK_NHANVIEN]    Script Date: 7/8/2023 12:50:44 AM ******/
ALTER TABLE [dbo].[NhanVien] ADD  CONSTRAINT [PK_NHANVIEN] PRIMARY KEY NONCLUSTERED 
(
	[MaNhanVien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PK_XE]    Script Date: 7/8/2023 12:50:44 AM ******/
ALTER TABLE [dbo].[Xe] ADD  CONSTRAINT [PK_XE] PRIMARY KEY NONCLUSTERED 
(
	[MaXe] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ChiTietXe] ADD  CONSTRAINT [df1]  DEFAULT (N'Chưa xác định') FOR [MucTieuThuNhienLieu]
GO
ALTER TABLE [dbo].[ChiTietXe] ADD  CONSTRAINT [df2]  DEFAULT (N'Chưa xác định') FOR [HopSo]
GO
ALTER TABLE [dbo].[ChiTietXe] ADD  CONSTRAINT [df3]  DEFAULT (N'Chưa xác định') FOR [LoaiTruyenDong]
GO
ALTER TABLE [dbo].[ChiTietXe] ADD  CONSTRAINT [df4]  DEFAULT (N'Chưa xác định') FOR [MoMentCucDai]
GO
ALTER TABLE [dbo].[ChiTietXe] ADD  CONSTRAINT [df5]  DEFAULT (N'Chưa xác định') FOR [DungTichXiLanh]
GO
ALTER TABLE [dbo].[ChiTietXe] ADD  CONSTRAINT [df6]  DEFAULT (N'Chưa xác định') FOR [KhoiLuong]
GO
ALTER TABLE [dbo].[ChiTietXe] ADD  CONSTRAINT [df7]  DEFAULT (N'Chưa xác định') FOR [ChieuDai]
GO
ALTER TABLE [dbo].[ChiTietXe] ADD  CONSTRAINT [df8]  DEFAULT (N'Chưa xác định') FOR [CheuRong]
GO
ALTER TABLE [dbo].[ChiTietXe] ADD  CONSTRAINT [df9]  DEFAULT (N'Chưa xác định') FOR [ChieuCao]
GO
ALTER TABLE [dbo].[ChiTietXe] ADD  CONSTRAINT [df10]  DEFAULT (N'Chưa xác định') FOR [KhoangCachHaiTrucBanh]
GO
ALTER TABLE [dbo].[ChiTietXe] ADD  CONSTRAINT [df11]  DEFAULT (N'Chưa xác định') FOR [DoCaoYen]
GO
ALTER TABLE [dbo].[ChiTietXe] ADD  CONSTRAINT [df12]  DEFAULT (N'Chưa xác định') FOR [KhoangSangGam]
GO
ALTER TABLE [dbo].[ChiTietXe] ADD  CONSTRAINT [df13]  DEFAULT (N'Chưa xác định') FOR [DungTichBinhXang]
GO
ALTER TABLE [dbo].[ChiTietXe] ADD  CONSTRAINT [df14]  DEFAULT (N'Chưa xác định') FOR [KichThuocLopTruoc]
GO
ALTER TABLE [dbo].[ChiTietXe] ADD  CONSTRAINT [df15]  DEFAULT (N'Chưa xác định') FOR [KichThuocLopSau]
GO
ALTER TABLE [dbo].[ChiTietXe] ADD  CONSTRAINT [df16]  DEFAULT (N'Chưa xác định') FOR [CongSuatToiDa]
GO
ALTER TABLE [dbo].[ChiTietXe] ADD  CONSTRAINT [df17]  DEFAULT (N'Chưa xác định') FOR [PhuocTruoc]
GO
ALTER TABLE [dbo].[ChiTietXe] ADD  CONSTRAINT [df18]  DEFAULT (N'Chưa xác định') FOR [PhuocSau]
GO
ALTER TABLE [dbo].[ChiTietXe] ADD  CONSTRAINT [df19]  DEFAULT (N'Chưa xác định') FOR [DungTichNhotMay]
GO
ALTER TABLE [dbo].[ChiTietXe] ADD  CONSTRAINT [df20]  DEFAULT (N'Chưa xác định') FOR [LoaiDongCo]
GO
ALTER TABLE [dbo].[KhachHang] ADD  DEFAULT ((0)) FOR [SoLuotMua]
GO
ALTER TABLE [dbo].[NhanXet] ADD  DEFAULT (N'Không tên') FOR [NguoiBinhLuan]
GO
ALTER TABLE [dbo].[PhieuBanHang] ADD  CONSTRAINT [df_ThanhTien]  DEFAULT ((0)) FOR [ThanhToan]
GO
ALTER TABLE [dbo].[PhieuBanHang] ADD  CONSTRAINT [df_HinhThucThanhToan]  DEFAULT ((1)) FOR [HT_ThanhToan]
GO
ALTER TABLE [dbo].[PhieuBanHang] ADD  DEFAULT ((0)) FOR [TrangThai]
GO
ALTER TABLE [dbo].[Accounts]  WITH CHECK ADD  CONSTRAINT [FK_Acc_LoaiAcc] FOREIGN KEY([LoaiAcc])
REFERENCES [dbo].[LoaiAcc] ([id])
GO
ALTER TABLE [dbo].[Accounts] CHECK CONSTRAINT [FK_Acc_LoaiAcc]
GO
ALTER TABLE [dbo].[ChiTietPhieuBan]  WITH CHECK ADD  CONSTRAINT [fk_PhieuBanHang] FOREIGN KEY([id_PhieuBan])
REFERENCES [dbo].[PhieuBanHang] ([id_PhieuBan])
GO
ALTER TABLE [dbo].[ChiTietPhieuBan] CHECK CONSTRAINT [fk_PhieuBanHang]
GO
ALTER TABLE [dbo].[ChiTietPhieuBan]  WITH CHECK ADD  CONSTRAINT [fk_Xe_ChiTietPhieuBan] FOREIGN KEY([MaXe])
REFERENCES [dbo].[Xe] ([MaXe])
GO
ALTER TABLE [dbo].[ChiTietPhieuBan] CHECK CONSTRAINT [fk_Xe_ChiTietPhieuBan]
GO
ALTER TABLE [dbo].[ChiTietXe]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietXe_Xe] FOREIGN KEY([id_ChiTietXe])
REFERENCES [dbo].[Xe] ([MaXe])
GO
ALTER TABLE [dbo].[ChiTietXe] CHECK CONSTRAINT [FK_ChiTietXe_Xe]
GO
ALTER TABLE [dbo].[HinhAnh]  WITH CHECK ADD  CONSTRAINT [fk_LoaiHinhAnh] FOREIGN KEY([MaLoaiHinh])
REFERENCES [dbo].[LoaiHinhAnh] ([MaLoaiHinh])
GO
ALTER TABLE [dbo].[HinhAnh] CHECK CONSTRAINT [fk_LoaiHinhAnh]
GO
ALTER TABLE [dbo].[HinhAnh]  WITH CHECK ADD  CONSTRAINT [fk_Xe_HinhAnh] FOREIGN KEY([Id_DanhMucHinh])
REFERENCES [dbo].[Xe] ([MaXe])
GO
ALTER TABLE [dbo].[HinhAnh] CHECK CONSTRAINT [fk_Xe_HinhAnh]
GO
ALTER TABLE [dbo].[KhachHang]  WITH CHECK ADD  CONSTRAINT [FK_Khachhang_Acc] FOREIGN KEY([TenDangNhap])
REFERENCES [dbo].[Accounts] ([TenDangNhap])
GO
ALTER TABLE [dbo].[KhachHang] CHECK CONSTRAINT [FK_Khachhang_Acc]
GO
ALTER TABLE [dbo].[KhachHangThanThiet]  WITH CHECK ADD  CONSTRAINT [fk_KhachHang_ThanThiet] FOREIGN KEY([MaKhachHang])
REFERENCES [dbo].[KhachHang] ([MaKhachHang])
GO
ALTER TABLE [dbo].[KhachHangThanThiet] CHECK CONSTRAINT [fk_KhachHang_ThanThiet]
GO
ALTER TABLE [dbo].[KhachHangThanThiet]  WITH CHECK ADD  CONSTRAINT [fk_KhachHangThanThiet_LoaiKhach] FOREIGN KEY([LoaiKhach])
REFERENCES [dbo].[LoaiKhachHang] ([LoaiKhach])
GO
ALTER TABLE [dbo].[KhachHangThanThiet] CHECK CONSTRAINT [fk_KhachHangThanThiet_LoaiKhach]
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD  CONSTRAINT [FK_NhanVien_Acc] FOREIGN KEY([TenDangNhap])
REFERENCES [dbo].[Accounts] ([TenDangNhap])
GO
ALTER TABLE [dbo].[NhanVien] CHECK CONSTRAINT [FK_NhanVien_Acc]
GO
ALTER TABLE [dbo].[NhanXet]  WITH CHECK ADD  CONSTRAINT [fk_Xe] FOREIGN KEY([MaXe])
REFERENCES [dbo].[Xe] ([MaXe])
GO
ALTER TABLE [dbo].[NhanXet] CHECK CONSTRAINT [fk_Xe]
GO
ALTER TABLE [dbo].[PhieuBanHang]  WITH CHECK ADD  CONSTRAINT [fk_HinhThucThanhToan] FOREIGN KEY([HT_ThanhToan])
REFERENCES [dbo].[HinhThucThanhToan] ([MaHinhThuc])
GO
ALTER TABLE [dbo].[PhieuBanHang] CHECK CONSTRAINT [fk_HinhThucThanhToan]
GO
ALTER TABLE [dbo].[PhieuBanHang]  WITH CHECK ADD  CONSTRAINT [FK_KhachMua] FOREIGN KEY([MaKhachHang])
REFERENCES [dbo].[KhachHang] ([MaKhachHang])
GO
ALTER TABLE [dbo].[PhieuBanHang] CHECK CONSTRAINT [FK_KhachMua]
GO
ALTER TABLE [dbo].[Xe]  WITH CHECK ADD  CONSTRAINT [FK_XE_HANG] FOREIGN KEY([MaNSX])
REFERENCES [dbo].[HangXe] ([MaNSX])
GO
ALTER TABLE [dbo].[Xe] CHECK CONSTRAINT [FK_XE_HANG]
GO
ALTER TABLE [dbo].[Xe]  WITH CHECK ADD  CONSTRAINT [FK_Xe_loaiXe] FOREIGN KEY([MaLoaiXe])
REFERENCES [dbo].[LoaiXe] ([MaLoaiXe])
GO
ALTER TABLE [dbo].[Xe] CHECK CONSTRAINT [FK_Xe_loaiXe]
GO
/****** Object:  StoredProcedure [dbo].[Insert_ChiTietPhieuBan]    Script Date: 7/8/2023 12:50:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Insert_ChiTietPhieuBan] (@id_PhieuBan int, @MaXe varchar(5), @SoLuong int)
as 
begin
	insert into ChiTietPhieuBan(id_PhieuBan, MaXe, SoLuong) values
	(@id_PhieuBan,@MaXe,@SoLuong)
	end
GO
/****** Object:  StoredProcedure [dbo].[Insert_PhieuBanHang]    Script Date: 7/8/2023 12:50:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Insert_PhieuBanHang]( @MaKhachHang varchar(5), @HT_ThanhToan int)
as 
begin
	declare  @id_PhieuBan int;
	insert into PhieuBanHang(MaKhachHang, NgayBan, HT_ThanhToan) values
	(@MaKhachHang, getdate(), @HT_ThanhToan)
	
	set @id_PhieuBan=(select Max(id_PhieuBan) from PhieuBanHang)
	return @id_PhieuBan
end
GO
/****** Object:  StoredProcedure [dbo].[LocHoaDonQuaHan]    Script Date: 7/8/2023 12:50:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[LocHoaDonQuaHan]
as
begin
	declare PhieuBanHang_cursor cursor for select id_PhieuBan, NgayBan, TrangThai from PhieuBanHang where TrangThai=0
	open PhieuBanHang_cursor
	declare @ngayBan date, @id_PhieuBan int, @TrangThai int
	fetch next from PhieuBanHang_cursor into @id_PhieuBan, @ngayBan, @TrangThai
	while @@FETCH_STATUS = 0
	begin
		if(DATEADD(dd,2,@ngayBan)<getdate())
		begin
			delete ChiTietPhieuBan where id_PhieuBan=@id_PhieuBan
			delete PhieuBanHang where id_PhieuBan=@id_PhieuBan
		end
		fetch next from PhieuBanHang_cursor into @id_PhieuBan, @ngayBan, @TrangThai
	end
	close PhieuBanHang_cursor
	deallocate PhieuBanHang_cursor
end
GO
/****** Object:  StoredProcedure [dbo].[Xoa_1Xe]    Script Date: 7/8/2023 12:50:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Xoa_1Xe](@MaXe varchar(5))
as
begin
	if exists(select *from HinhAnh where Id_DanhMucHinh=@MaXe)
	begin
		delete HinhAnh where Id_DanhMucHinh=@MaXe
	end
	if exists(Select*from ChiTietXe where id_ChiTietXe=@MaXe)
	begin
		delete ChiTietXe where id_ChiTietXe=@MaXe
	end
	delete Xe where MaXe=@MaXe
end
GO
USE [master]
GO
ALTER DATABASE [QuanLyBanXe-20221230012255] SET  READ_WRITE 
GO
