CREATE DATABASE PRODUCT;
USE PRODUCT;

CREATE TABLE PRODUCT (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`productCode` INT NOT NULL,
`productName` VARCHAR(255) NOT NULL,
`productAmount` DECIMAL(10),
`productDescription` VARCHAR(255) NOT NULL,
`productStatus` INT NOT NULL
);

-- Tạo Unique Index trên bảng Products (sử dụng cột productCode để tạo chỉ mục)
ALTER TABLE product ADD INDEX idx_customerName(productCode);

-- Tạo Composite Index trên bảng Products (sử dụng 2 cột productName và productPrice)
CREATE INDEX composite_index
    ON product (productName, productAmount);

-- Sử dụng câu lệnh EXPLAIN để biết được câu lệnh SQL của bạn thực thi như nào
EXPLAIN SELECT * FROM product WHERE productName = 'Bia';

-- So sánh câu truy vấn trước và sau khi tạo index
EXPLAIN SELECT * FROM product WHERE productName = 'Bánh';

ALTER TABLE product DROP INDEX idx_customerName;
ALTER TABLE product DROP INDEX composite_index;

EXPLAIN SELECT * FROM product WHERE productName = 'Bia';

-- Tạo view lấy về các thông tin: productCode, productName, productAmount, productStatus từ bảng products.
CREATE VIEW PRODUCT_views AS
SELECT productCode,productName, productAmount, productStatus
FROM  product;
select * from PRODUCT_views;

-- Tiến hành sửa đổi view
CREATE OR REPLACE VIEW PRODUCT_views AS
SELECT productCode,productName, productAmount, productStatus
FROM product
WHERE productName = 'Bia';
select * from PRODUCT_views;

-- Tiến hành xoá view
DROP VIEW PRODUCT_views;

-- Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product
DELIMITER //
CREATE PROCEDURE findAllProducts()
BEGIN
    SELECT * FROM product;
END //
DELIMITER ;
call findAllProducts();


-- Tạo store procedure thêm một sản phẩm mới
DELIMITER //
DROP PROCEDURE IF EXISTS `createProduct`//
CREATE PROCEDURE createProduct(
    cCode int,
    cName varchar(255),
    cAmount int,
    cDescription varchar(255),
    cStatus BIT
)
BEGIN
    INSERT INTO product (productCode, productName, productAmount, productDescription, productStatus)
        VALUES (cCode,cName,cAmount,cDescription,cStatus);
END //

-- Tạo store procedure sửa thông tin sản phẩm theo id
DELIMITER //
DROP PROCEDURE IF EXISTS `editById`//
CREATE PROCEDURE editById(
    IN pID INT,
    IN pCode INT,
    IN pName VARCHAR(255),
    IN pAmount DECIMAL,
    IN pDesc VARCHAR(255),
    IN pStatus BIT
)
BEGIN
    UPDATE product
        SET productCode = pCode,
            productName = pName,
            productAmount = pAmount,
            productDescription = pDesc,
            productStatus = pStatus
    WHERE id = pID;
END //
DELIMITER ;

-- Tạo store procedure xoá sản phẩm theo id
DELIMITER //
DROP PROCEDURE IF EXISTS `dropById`//
CREATE PROCEDURE dropById(
dId int
)
BEGIN
    Delete from product
    WHERE id = dId;
END //
DELIMITER ;


call editById(5,669,'iphone', 6000,'Ultra',1);
call findAllProducts();
call createProduct(700,'ipod', 6500,'pro',0);
call createProduct(701,'Quần',4000,'Jean',1);
call editById(1,111,'Bánh',5000,'Oreo',1);
call dropById(2);
