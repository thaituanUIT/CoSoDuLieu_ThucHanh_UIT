﻿

CREATE DATABASE QLBH
GO
USE QLBH

SET FORMAT DMY
-- BUOI 1
-- Q1 CREATE RELATION & DECLARATION OF PRIMARY AND FOREIGN KEY
CREATE TABLE KHACHHANG (
	MAKH	char(4)		NOT NULL					PRIMARY KEY,
	HOTEN	varchar(40),
	DCHI	varchar(50),
	SODT	varchar(20),
	NGSINH	smalldatetime,
	NGDK	smalldatetime,
	DOANHSO money
)

CREATE TABLE NHANVIEN (
	MANV	char(4)		NOT NULL					PRIMARY KEY,
	HOTEN	varchar(40),
	SODT	varchar(20),
	NGVL	smalldatetime
)

CREATE TABLE SANPHAM (
	MASP	char(4)		NOT NULL					PRIMARY KEY,
	TENSP	varchar(40),
	DVT		varchar(20),
	NUOCSX	varchar(40),
	GIA		money
)

CREATE TABLE HOADON (
	SOHD	int			NOT NULL					PRIMARY KEY,
	NGHD	smalldatetime,
	MAKH	char(4),
	MANV	char(4),
	TRIGIA	money
)

CREATE TABLE CTHD (
	SOHD	int,
	MASP	char(4),
	SL		int
)

ALTER TABLE HOADON ADD
CONSTRAINT fk_makh		FOREIGN KEY (MAKH)			REFERENCES KHACHHANG(MAKH),
CONSTRAINT fk_manv		FOREIGN KEY (MANV)			REFERENCES NHANVIEN(MANV)

ALTER TABLE CTHD ADD
CONSTRAINT fk_sohd		FOREIGN KEY (SOHD)			REFERENCES HOADON(SOHD),
CONSTRAINT fk_masp		FOREIGN KEY (MASP)			REFERENCES SANPHAM(MASP),
CONSTRAINT pk_cthd		PRIMARY KEY (SOHD, MASP)

-- Q2 THEM THUOC TINH GHI CHU CO KIEU DU LIEU VARCHAR(20) VAO QUAN HE SANPHAM
ALTER TABLE SANPHAM		ADD GHICHU					varchar(20)

-- Q3 THEM THUOC TINH LOAIKH CO KIEU TINYINT VAO QUAN HE KHACHHANG
ALTER TABLE KHACHHANG	ADD LOAIKH					tinyint

-- Q4 THAY DOI THUOC TINH GHI CHU TRONG QUAN HE SAN PHAM SANPHAM 
-- TU VARCHAR(20) SANG VARCHAR(100)
ALTER TABLE SANPHAM		ALTER COLUMN GHICHU			varchar(100)

-- Q5 XOA THUOC TINH GHICHU O QUAN HE SANPHAM
ALTER TABLE SANPHAM		DROP COLUMN GHICHU

-- Q6 THUOC TINH LOAIKH TRONG QUAN HE KHACH HANG 
-- LUU TRU CAC GIA TRI "VANG LAI", "THUONG XUYEN", "VIP" 

--- ALTER TABLE KHACHHANG ADD ---
--- LOAIKH varchar(50), ---
--- CONSTRAINT chl_loai_kh CHECK (LOAIKH IN ("vang lai", "thuong xuyen", "vip")) ---

CREATE TABLE LOAI_KH (
	MA_LOAIKH	tinyint		NOT NULL				PRIMARY KEY,
	TEN_LOAIKH	varchar(40)
)
INSERT INTO LOAIKH (MA_LOAIKH, TEN_LOAIKH)			VALUES (1, "VANG LAI"), (2, "THUONG XUYEN"), (3, "VIP")

ALTER TABLE KHACHHANG	ADD CONSTRAINT fk_maloaikh	FOREIGN KEY (MAKH)		REFERENCES LOAI_KH(MA_LOAIKH)

-- Q7 DON VI TINH CUA SAN PHAM CHI CO THE LA 
-- (“cay”,”hop”,”cai”,”quyen”,”chuc”)
ALTER TABLE SANPHAM		ADD CONSTRAINT chk_dvt		CHECK (DVT IN ("CAY", "HOP", "CAI", "QUYEN", "CHUC"))

-- Q8 GIA BAN PHAI TU 500 DONG TRO LEN
ALTER TABLE SANPHAM		ADD CONSTRAINT chk_giaban	CHECK (GIA >= 500)

-- Q9 MOI LAN MUA HANG KHACH HANG PHAI MUA 1 SAN PHAM TRO LEN
ALTER TABLE CTHD		ADD CONSTRAINT chk_sl		CHECK (SL >= 1)

-- Q10 NGAY DANG KI KHACH HANG PHAI LON HON NGAY SINH
ALTER TABLE KHACHHANG	ADD CONSTRAINT chk_ngaydk	CHECK (NGDK > NGSINH)


--BUOI 2
-- Nhap du lieu QLBH
--KHACH HANG
INSERT INTO KHACHHANG VALUES('KH01','Nguyen Van A','731 Tran Hung Dao, Q5, TpHCM','8823451','22/10/1960','22/07/2006',13060000,null)
INSERT INTO KHACHHANG VALUES('KH02','Tran Ngoc Han','23/5 Nguyen Trai, Q5, TpHCM','908256478','03/04/1974','30/07/2006',280000,null)
INSERT INTO KHACHHANG VALUES('KH03','Tran Ngoc Linh','45 Nguyen Canh Chan, Q1, TpHCM','938776266','12/06/1980','08/05/2006',3860000,null)
INSERT INTO KHACHHANG VALUES('KH04','Tran Minh Long','50/34 Le Dai Hanh, Q10, TpHCM','917325476','09/03/1965','10/02/2006',250000,null)
INSERT INTO KHACHHANG VALUES('KH05','Le Nhat Minh','34 Truong Dinh, Q3, TpHCM','8246108','10/03/1950','28/10/2006',21000,null)
INSERT INTO KHACHHANG VALUES('KH06','Le Hoai Thuong','227 Nguyen Van Cu, Q5, TpHCM','8631738','31/12/1981','24/11/2006',915000,null)
INSERT INTO KHACHHANG VALUES('KH07','Nguyen Van Tam','32/3 Tran Binh Trong, Q5, TpHCM','916783565','06/04/1971','12/01/2006',12500,null)
INSERT INTO KHACHHANG VALUES('KH08','Phan Thi Thanh','45/2 An Duong Vuong, Q5, TpHCM','938435756','10/01/1971','13/12/2006',365000,null)
INSERT INTO KHACHHANG VALUES('KH09','Le Ha Vinh','873 Le Hong Phong, Q5, TpHCM','8654763','03/09/1979','14/01/2007',70000,null)
INSERT INTO KHACHHANG VALUES('KH10','Ha Duy Lap','34/34B Nguyen Trai, Q1, TpHCM','8768904','02/05/1983','16/01/2007',67500,null)

SELECT * FROM KHACHHANG

--NHAN VIEN
INSERT INTO NHANVIEN VALUES('NV01','Nguyen Nhu Nhut','927345678','13/04/2006')
INSERT INTO NHANVIEN VALUES('NV02','Le Thi Phi Yen','987567390','21/04/2006')
INSERT INTO NHANVIEN VALUES('NV03','Nguyen Van B','997047382','27/04/2006')
INSERT INTO NHANVIEN VALUES('NV04','Ngo Thanh Tuan','913758498','24/06/2006')
INSERT INTO NHANVIEN VALUES('NV05','Nguyen Thi Truc Thanh','918590387','20/07/2006')

SELECT * FROM NHANVIEN
--SAN PHAM
INSERT INTO SANPHAM VALUES('BC01','But chi','cay','Singapore',3000)
INSERT INTO SANPHAM VALUES('BC02','But chi','cay','Singapore',5000)
INSERT INTO SANPHAM VALUES('BC03','But chi','cay','Viet Nam',3500)
INSERT INTO SANPHAM VALUES('BC04','But chi','hop','Viet Nam',30000)
INSERT INTO SANPHAM VALUES('BB01','But bi','cay','Viet Nam',5000)
INSERT INTO SANPHAM VALUES('BB02','But bi','cay','Trung Quoc',7000)
INSERT INTO SANPHAM VALUES('BB03','But bi','hop','Thai Lan',100000)
INSERT INTO SANPHAM VALUES('TV01','Tap 100 giay mong','quyen','Trung Quoc',2500)
INSERT INTO SANPHAM VALUES('TV02','Tap 200 giay mong','quyen','Trung Quoc',4500)
INSERT INTO SANPHAM VALUES('TV03','Tap 100 giay tot','quyen','Viet Nam',3000)
INSERT INTO SANPHAM VALUES('TV04','Tap 200 giay tot','quyen','Viet Nam',5500)
INSERT INTO SANPHAM VALUES('TV05','Tap 100 trang','chuc','Viet Nam',23000)
INSERT INTO SANPHAM VALUES('TV06','Tap 200 trang','chuc','Viet Nam',53000)
INSERT INTO SANPHAM VALUES('TV07','Tap 100 trang','chuc','Trung Quoc',34000)
INSERT INTO SANPHAM VALUES('ST01','So tay 500 trang','quyen','Trung Quoc',40000)
INSERT INTO SANPHAM VALUES('ST02','So tay loai 1','quyen','Viet Nam',55000)
INSERT INTO SANPHAM VALUES('ST03','So tay loai 2','quyen','Viet Nam',51000)
INSERT INTO SANPHAM VALUES('ST04','So tay','quyen','Thai Lan',55000)
INSERT INTO SANPHAM VALUES('ST05','So tay mong','quyen','Thai Lan',20000)
INSERT INTO SANPHAM VALUES('ST06','Phan viet bang','hop','Viet Nam',5000)
INSERT INTO SANPHAM VALUES('ST07','Phan khong bui','hop','Viet Nam',7000)
INSERT INTO SANPHAM VALUES('ST08','Bong bang','cai','Viet Nam',1000)
INSERT INTO SANPHAM VALUES('ST09','But long','cay','Viet Nam',5000)
INSERT INTO SANPHAM VALUES('ST10','But long','cay','Trung Quoc',7000)

SELECT * FROM SANPHAM

--HOA DON
INSERT INTO HOADON VALUES(1001,'23/07/2006','KH01','NV01',320000)
INSERT INTO HOADON VALUES(1002,'12/08/2006','KH01','NV02',840000)
INSERT INTO HOADON VALUES(1003,'23/08/2006','KH02','NV01',100000)
INSERT INTO HOADON VALUES(1004,'01/09/2006','KH02','NV01',180000)
INSERT INTO HOADON VALUES(1005,'20/10/2006','KH01','NV02',3800000)
INSERT INTO HOADON VALUES(1006,'16/10/2006','KH01','NV03',2430000)
INSERT INTO HOADON VALUES(1007,'28/10/2006','KH03','NV03',510000)
INSERT INTO HOADON VALUES(1008,'28/10/2006','KH01','NV03',440000)
INSERT INTO HOADON VALUES(1009,'28/10/2006','KH03','NV04',200000)
INSERT INTO HOADON VALUES(1010,'01/11/2006','KH01','NV01',5200000)
INSERT INTO HOADON VALUES(1011,'04/11/2006','KH04','NV03',250000)
INSERT INTO HOADON VALUES(1012,'30/11/2006','KH05','NV03',21000)
INSERT INTO HOADON VALUES(1013,'12/12/2006','KH06','NV01',5000)
INSERT INTO HOADON VALUES(1014,'31/12/2006','KH03','NV02',3150000)
INSERT INTO HOADON VALUES(1015,'01/01/2007','KH06','NV01',910000)
INSERT INTO HOADON VALUES(1016,'01/01/2007','KH07','NV02',12500)
INSERT INTO HOADON VALUES(1017,'02/01/2007','KH08','NV03',35000)
INSERT INTO HOADON VALUES(1018,'13/01/2007','KH08','NV03',330000)
INSERT INTO HOADON VALUES(1019,'13/01/2007','KH01','NV03',30000)
INSERT INTO HOADON VALUES(1020,'14/01/2007','KH09','NV04',70000)
INSERT INTO HOADON VALUES(1021,'16/01/2007','KH10','NV03',67500)
INSERT INTO HOADON VALUES(1022,'16/01/2007',Null,'NV03',7000)
INSERT INTO HOADON VALUES(1023,'17/01/2007',Null,'NV01',330000)

SELECT * FROM HOADON

--CTHD
INSERT INTO CTHD VALUES(1001,'TV02',10)
INSERT INTO CTHD VALUES(1001,'ST01',5)
INSERT INTO CTHD VALUES(1001,'BC01',5)
INSERT INTO CTHD VALUES(1001,'BC02',10)
INSERT INTO CTHD VALUES(1001,'ST08',10)
INSERT INTO CTHD VALUES(1002,'BC04',20)
INSERT INTO CTHD VALUES(1002,'BB01',20)
INSERT INTO CTHD VALUES(1002,'BB02',20)
INSERT INTO CTHD VALUES(1003,'BB03',10)
INSERT INTO CTHD VALUES(1004,'TV01',20)
INSERT INTO CTHD VALUES(1004,'TV02',10)
INSERT INTO CTHD VALUES(1004,'TV03',10)
INSERT INTO CTHD VALUES(1004,'TV04',10)
INSERT INTO CTHD VALUES(1005,'TV05',50)
INSERT INTO CTHD VALUES(1005,'TV06',50)
INSERT INTO CTHD VALUES(1006,'TV07',20)
INSERT INTO CTHD VALUES(1006,'ST01',30)
INSERT INTO CTHD VALUES(1006,'ST02',10)
INSERT INTO CTHD VALUES(1007,'ST03',10)
INSERT INTO CTHD VALUES(1008,'ST04',8)
INSERT INTO CTHD VALUES(1009,'ST05',10)
INSERT INTO CTHD VALUES(1010,'TV07',50)
INSERT INTO CTHD VALUES(1010,'ST07',50)
INSERT INTO CTHD VALUES(1010,'ST08',100)
INSERT INTO CTHD VALUES(1010,'ST04',50)
INSERT INTO CTHD VALUES(1010,'TV03',100)
INSERT INTO CTHD VALUES(1011,'ST06',50)
INSERT INTO CTHD VALUES(1012,'ST07',3)
INSERT INTO CTHD VALUES(1013,'ST08',5)
INSERT INTO CTHD VALUES(1014,'BC02',80)
INSERT INTO CTHD VALUES(1014,'BB02',100)
INSERT INTO CTHD VALUES(1014,'BC04',60)
INSERT INTO CTHD VALUES(1014,'BB01',50)
INSERT INTO CTHD VALUES(1015,'BB02',30)
INSERT INTO CTHD VALUES(1015,'BB03',7)
INSERT INTO CTHD VALUES(1016,'TV01',5)
INSERT INTO CTHD VALUES(1017,'TV02',1)
INSERT INTO CTHD VALUES(1017,'TV03',1)
INSERT INTO CTHD VALUES(1017,'TV04',5)
INSERT INTO CTHD VALUES(1018,'ST04',6)
INSERT INTO CTHD VALUES(1019,'ST05',1)
INSERT INTO CTHD VALUES(1019,'ST06',2)
INSERT INTO CTHD VALUES(1020,'ST07',10)
INSERT INTO CTHD VALUES(1021,'ST08',5)
INSERT INTO CTHD VALUES(1021,'TV01',7)
INSERT INTO CTHD VALUES(1021,'TV02',10)
INSERT INTO CTHD VALUES(1022,'ST07',1)
INSERT INTO CTHD VALUES(1023,'ST04',6)

SELECT * FROM CTHD

-- Tuan 2
-- Phan 2 
-- 1. Tao quan he KHACHHANG1 chua toan bo du lieu cua quan he KHACHHANG
SELECT * INTO KHACHHANG1 FROM KHACHHANG

-- 2. Tao quan he SANPHAM1 chua toan bo du lieu cua quan he SANPHAM
SELECT * INTO SANPHAM1 FROM SANPHAM

-- 3. Cap nhat gia tang 5% doi voi san pham xuat xu tu "Thai Lan" cho quan he SANPHAM1
UPDATE SANPHAM1
SET GIA = GIA * 1.05
WHERE NUOCSX = 'Thai Lan'

-- 4. Cap nhat gia tang 5% doi voi san pham xuat xu tu "Trung Quoc" va 
-- co gia duoi 10000 cho quan he SANPHAM1
UPDATE SANPHAM1
SET GIA = GIA * 1.05 
WHERE NUOCSX = 'Trung Quoc' AND GIA <= 10000

-- 5. Cap nhat LOAIKH thanh "Vip" doi voi khach hang dang ki truoc 1/1/2007 co doanh so tren 10000000
-- hoac sau 1/1/2007 co doanh so tren 2000000 cho quan he KHACHHANG1
UPDATE KHACHHANG1
SET LOAIKH = 'Vip'
WHERE (NGDK < '1/1/2007' AND DOANHSO >= 10000000)
   OR (NGDK > '1/1/2007' AND DOANHSO >= 2000000)

-- BUOI 3
-- 1. In ra danh sach cac san pham co xuat xu tu "Trung Quoc"
SELECT MASP, TENSP FROM SANPHAM1
WHERE NUOCSX = 'Trung Quoc'

-- 2. In ra danh sach cac san pham co don vi tinh la "cay", "quyen"
SELECT MASP, TENSP FROM SANPHAM1
WHERE DVT = 'cay' or DVT = 'quyen'

-- 3. In ra danh sach cac san pham co ma san pham bat dau bang "B" va ket thuc bang "01"
SELECT MASP, TENSP
FROM SANPHAM1
WHERE MASP LIKE 'B%01';

-- 4. In ra danh sach cac san pham xuat xu tu "Trung Quoc" co gia ban
-- tu 30000 den 40000
SELECT MASP, TENSP
FROM SANPHAM1
WHERE NUOCSX = 'Trung Quoc' AND GIA BETWEEN 30000 AND 40000

-- 5. In ra danh sach cac san pham xuat xu tu "Thai Lan" hoac "Trung Quoc" co gia gia ban
-- tu 30000 den 40000
SELECT MASP, TENSP
FROM SANPHAM1
WHERE NUOCSX IN ('Thai Lan', 'Trung Quoc') 
AND GIA BETWEEN 30000 AND 40000

-- 6. In ra cac so hoa don, tri gia hoa don tu 1/1/2007 den 2/1/2007
SELECT SOHD, TRIGIA
FROM HOADON
WHERE NGHD IN ('2007-01-01', '2007-01-02')

-- 7. In ra cac so hoa don, tri gia hoa don trong thang 1/2007
-- sap xep theo ngay tang dan va tri gia giam dan
SELECT SOHD, TRIGIA
FROM HOADON
WHERE NGHD BETWEEN '2007-01-01' AND '2007-01-31'
ORDER BY NGHD ASC, TRIGIA DESC

-- 8. In ra danh sach cac khach hang da mua hang vao ngay 1/1/2007
SELECT DISTINCT KHACHHANG1.MAKH, KHACHHANG1.HOTEN 
FROM KHACHHANG1
JOIN HOADON ON KHACHHANG1.MAKH = HOADON.MAKH
WHERE HOADON.NGAYHD = '1/1/2007'

-- 9. In ra ra so hoa don, tri gia cua cac hoa don cua nhan vien "Nguyen Van B" lap vao ngay 28/10/2006
SELECT SOHD, TRIGIA
FROM HOADON
WHERE MANV = 'NV03' AND NGHD = '28/10/2006'

-- 10. In ra danh sach cac san pham duoc khach hang co ten "Nguyen Van A" mua vao trong thang 10/2006
SELECT SANPHAM1.MASP, SANPHAM1.TENSP
FROM SANPHAM1
JOIN CTHD ON SANPHAM1.MASP = CTHD.MASP
JOIN HOADON ON CTHD.SOHD = HOADON.SOHD
JOIN KHACHHANG1 ON HOADON.MAKH = KHACHHANG1.MAKH
WHERE KHACHHANG1.HOTEN = 'Nguyen Van A' AND HOADON.NGHD BETWEEN '01/10/2006' AND '31/10/2006'

-- 11. Tim ra cac hoa don da mua cac san pham "BB01" va "BB02"
SELECT HOADON.SOHD
FROM HOADON
JOIN CTHD ON HOADON.SOHD = CTHD.SOHD
WHERE CTHD.MASP IN ('BB01', 'BB02')

-- Tuan 3
-- 12. Tim cac so hoa don da mua san pham BB01 hoac BB02, moi san pham so luong tu 10 den 20
SELECT DISTINCT SOHD 
FROM CTHD 
WHERE MASP IN ('BB01', 'BB02') AND (SL >= 10 AND SL <= 20)

-- 13. Tim cac so hoa don da mua san pham BB01 va BB02, moi san pham so luong tu 10 den 20
(SELECT SOHD 
FROM CTHD 
WHERE MASP ='BB01' AND (SL >= 10 AND SL <= 20))
INTERSECT
(SELECT SOHD 
FROM CTHD 
WHERE MASP ='BB02')

-- 14. In ra danh sach cac san pham (MASP, TENSP) do "Trung Quoc" san xuat
-- hoac duoc ban ratrong ngay 1/1/2007
SELECT MASP, TENSP FROM SANPHAM WHERE NUOCSX = 'Trung Quoc'
UNION
SELECT SANPHAM.MASP, SANPHAM.TENSP 
FROM SANPHAM JOIN CTHD ON SANPHAM.MASP = CTHD.MASP 
			 JOIN HOADON ON CTHD.SOHD = HOADON.SOHD 
WHERE HOADON.NGHD = '01/01/2007'

-- 15. In ra danh sach cac san pham (MASP,TENSP) khong ban duoc
SELECT MASP, TENSP
FROM SANPHAM
WHERE NOT EXISTS (
    SELECT 1
    FROM CTHD
    WHERE CTHD.MASP = SANPHAM.MASP
)
-- 16. In ra danh sach cac san pham (MASP,TENSP) khong ban duoc trong nam 2006
SELECT MASP, TENSP
FROM SANPHAM
WHERE NOT EXISTS (
    SELECT 1
    FROM CTHD
    JOIN HOADON ON CTHD.SOHD = HOADON.SOHD
    WHERE CTHD.MASP = SANPHAM.MASP
    AND YEAR(HOADON.NGHD) = 2006
)

-- 17. In ra danh sach cac san pham (MASP, TENSP) do "Trung Quoc san xuat nhung khong ban duoc trong namw 2006.
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc'
AND NOT EXISTS (
    SELECT 1
    FROM CTHD
    JOIN HOADON ON CTHD.SOHD = HOADON.SOHD
    WHERE CTHD.MASP = SANPHAM.MASP
    AND YEAR(HOADON.NGHD) = 2006
)

-- 18. Tim so hoa don da mua tat ca cac san pham do Singapore san xuat
SELECT HOADON.SOHD
FROM HOADON
JOIN CTHD ON HOADON.SOHD = CTHD.SOHD
JOIN SANPHAM ON CTHD.MASP = SANPHAM.MASP
WHERE SANPHAM.NUOCSX = 'Singapore'
GROUP BY HOADON.SOHD
HAVING COUNT(DISTINCT SANPHAM.MASP) = (
    SELECT COUNT(DISTINCT MASP)
    FROM SANPHAM
    WHERE NUOCSX = 'Singapore'
)

-- 19. Tim so ha don trong nam 2006 da mua it nhat tat ca san pham do Singapore san xuat
SELECT HOADON.SOHD
FROM HOADON
JOIN CTHD ON HOADON.SOHD = CTHD.SOHD
JOIN SANPHAM ON CTHD.MASP = SANPHAM.MASP
WHERE YEAR(HOADON.NGHD) = 2006
  AND SANPHAM.NUOCSX = 'Singapore'
GROUP BY HOADON.SOHD
HAVING COUNT(DISTINCT SANPHAM.MASP) = (
    SELECT COUNT(DISTINCT MASP)
    FROM SANPHAM
    WHERE NUOCSX = 'Singapore'
)

-- 20. Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua?
SELECT COUNT(*)
FROM HOADON
JOIN KHACHHANG ON HOADON.MAKH = KHACHHANG.MAKH
WHERE KHACHHANG.LOAIKH IS NULL

-- 21. Có bao nhiêu sản phẩm khác nhau được bán ra trong năm 2006.
SELECT COUNT(DISTINCT MASP)
FROM CTHD
JOIN HOADON ON CTHD.SOHD = HOADON.SOHD
WHERE YEAR(HOADON.NGHD) = 2006

-- 22. Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu ?
SELECT MAX(TRIGIA), MIN(TRIGIA)
FROM HOADON

-- 23. Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006 là bao nhiêu?
SELECT AVG(TRIGIA)
FROM HOADON
WHERE YEAR(NGHD) = 2006

-- 24. Tính doanh thu bán hàng trong năm 2006.
SELECT SUM(TRIGIA)
FROM HOADON
WHERE YEAR(NGHD) = 2006

-- 25. Tìm số hóa đơn có trị giá cao nhất trong năm 2006.
SELECT COUNT(*)
FROM HOADON
WHERE TRIGIA = (
	SELECT MAX(TRIGIA)
	FROM HOADON
	WHERE YEAR(NGHD) = 2006
)
-- 26. Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006.
SELECT KH.HOTEN
FROM KHACHHANG KH
JOIN HOADON HD ON KH.MAKH = HD.MAKH
WHERE HD.TRIGIA = (
	SELECT MAX(TRIGIA)
	FROM HOADON
	WHERE YEAR(NGHD) = 2006
)
-- 27. In ra danh sách 3 khách hàng (MAKH, HOTEN) có doanh số cao nhất.
SELECT TOP 3 MAKH, HOTEN
FROM KHACHHANG
ORDER BY DOANHSO DESC

-- 28. In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất.
SELECT SP.MASP, SP.TENSP
FROM SANPHAM SP
WHERE SP.GIA IN (
	SELECT TOP 3 GIA
	FROM SANPHAM
	ORDER BY GIA DESC
)

-- 29. In ra danh sách các sản phẩm (MASP, TENSP) do “Thai Lan” sản xuất có giá bằng 1 trong 3 mức
-- giá cao nhất (của tất cả các sản phẩm).
SELECT SP.MASP, SP.TENSP
FROM SANPHAM SP
WHERE SP.NUOCSX = 'Thai Lan'
	AND SP.GIA IN (
		SELECT TOP 3 GIA
		FROM SANPHAM
		ORDER BY GIA DESC
	)

-- 30. In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quoc” sản xuất có giá bằng 1 trong 3 mức
-- giá cao nhất (của sản phẩm do “Trung Quoc” sản xuất).
SELECT SP.MASP, SP.TENSP
FROM SANPHAM SP
WHERE SP.NUOCSX = 'Trung Quoc'
	AND SP.GIA IN (
		SELECT TOP 3 GIA
		FROM SANPHAM
		WHERE NUOCSX = 'Trung Quoc'
		ORDER BY GIA DESC
	)

-- 31. * In ra danh sách 3 khách hàng có doanh số cao nhất (sắp xếp theo kiểu xếp hạng).
SELECT TOP 3 MAKH, HOTEN, DOANHSO
FROM KHACHHANG
ORDER BY DOANHSO DESC

-- 32. Tính tổng số sản phẩm do “Trung Quoc” sản xuất.
SELECT SUM(1)
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc'

-- 33. Tính tổng số sản phẩm của từng nước sản xuất.
SELECT NUOCSX, SUM(1)
FROM SANPHAM
GROUP BY NUOCSX

-- 34. Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm.
SELECT MAX(GIA), MIN(GIA), AVG(GIA), NUOCSX
FROM SANPHAM
GROUP BY NUOCSX

-- 35. Tính doanh thu bán hàng mỗi ngày.
SELECT NGHD, SUM(TRIGIA)
FROM HOADON
GROUP BY NGHD
-- 36. Tính tổng số lượng của từng sản phẩm bán ra trong tháng 10/2006.
SELECT MASP, SUM(SL)
FROM CTHD
JOIN HOADON ON CTHD.SOHD = HOADON.SOHD
WHERE MONTH(HOADON.NGHD) = 10 AND YEAR(HOADON.NGHD) = 2006
GROUP BY MASP

-- 37. Tính doanh thu bán hàng của từng tháng trong năm 2006.
SELECT MONTH(NGHD) AS THANG, SUM(TRIGIA) AS DOANHSO
FROM HOADON
WHERE YEAR(NGHD) = 2006
GROUP BY MONTH(NGHD)

-- 38. Tìm hóa đơn có mua ít nhất 4 sản phẩm khác nhau.
SELECT SOHD
FROM CTHD
GROUP BY SOHD
HAVING COUNT(DISTINCT MASP) >= 4

-- 39. Tìm hóa đơn có mua 3 sản phẩm do “Viet Nam” sản xuất (3 sản phẩm khác nhau).
SELECT CTHD.SOHD
FROM CTHD
JOIN SANPHAM SP ON CTHD.MASP = SP.MASP
WHERE SP.NUOCSX = 'Viet Nam'
GROUP BY CTHD.SOHD
HAVING COUNT(DISTINCT CTHD.MASP) = 3

-- 40. Tìm khách hàng (MAKH, HOTEN) có số lần mua hàng nhiều nhất.
SELECT KH.MAKH, KH.HOTEN
FROM KHACHHANG KH
JOIN HOADON HD ON KH.MAKH = HD.MAKH
GROUP BY KH.MAKH, KH.HOTEN
HAVING COUNT(HD.SOHD) = (
	SELECT MAX(SO_LAN_MUA)
	FROM (
		SELECT COUNT(SOHD) AS SO_LAN_MUA
		FROM HOADON
		GROUP BY MAKH
	) AS Subquery
)

-- 41. Tháng mấy trong năm 2006, doanh số bán hàng cao nhất ?
SELECT TOP 1 MONTH(NGHD) AS THANG, SUM(TRIGIA) AS DOANHSO
FROM HOADON
WHERE YEAR(NGHD) = 2006
GROUP BY MONTH(NGHD)
ORDER BY DOANHSO DESC 


-- 42. Tìm sản phẩm (MASP, TENSP) có tổng số lượng bán ra thấp nhất trong năm 2006.
SELECT SP.MASP, SP.TENSP

FROM SANPHAM SP
JOIN CTHD ON SP.MASP = CTHD.MASP
JOIN HOADON HD ON CTHD.SOHD = HD.SOHD
WHERE YEAR(HD.NGHD) = 2006
GROUP BY SP.MASP, SP.TENSP
HAVING SUM(CTHD.SL) = (
	SELECT MIN(TONG_SL)
	FROM (
		SELECT SUM(SL) AS TONG_SL
		FROM CTHD
		JOIN HOADON ON CTHD.SOHD = HOADON.SOHD
		WHERE YEAR(HOADON.NGHD) = 2006
		GROUP BY MASP
	) AS Subquery
)

-- 43. *Mỗi nước sản xuất, tìm sản phẩm (MASP,TENSP) có giá bán cao nhất.
SELECT NUOCSX, MASP, TENSP, GIA
FROM SANPHAM SP
WHERE GIA = (
    SELECT MAX(GIA)
    FROM SANPHAM
    WHERE NUOCSX = SP.NUOCSX
)
ORDER BY NUOCSX

-- 44. Tìm nước sản xuất sản xuất ít nhất 3 sản phẩm có giá bán khác nhau.
SELECT NUOCSX
FROM SANPHAM
GROUP BY NUOCSX
HAVING COUNT(DISTINCT GIA) >= 3

-- 45. *Trong 10 khách hàng có doanh số cao nhất, tìm khách hàng có số lần mua hàng nhiều nhất
