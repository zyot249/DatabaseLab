create table "MatHang"(
	"MSMH" char(8) primary key not null,
	"TenMH" varchar(30),
	"DonGia" numeric,
	"SoTon" integer);
	
create table "HoaDon"(
	"MSHD" char(8) primary key not null,
	"NgayLap" date);
	
create table "CTHD"(
	"MSHD" char(8),
	"MSMH" char(8),
	"SoLuong" integer,
	"DonGiaHD" numeric,
	constraint pk_ctdh primary key("MSHD","MSMH"));
	
alter table "CTHD" add
constraint cthd_fk_mathang foreign key("MSMH") references "MatHang"("MSMH");

alter table "CTHD" add
constraint cthd_fk_hoadon foreign key("MSHD") references "HoaDon"("MSHD");

alter table "MatHang" 

alter table "MatHang" add constraint pk_mathang_ten primary key("TenMH");  