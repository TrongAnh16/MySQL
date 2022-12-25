CREATE DATABASE QuanLyBanHang;
USE QuanLyBanHang;
CREATE TABLE Customers
(
    cID    INTEGER PRIMARY KEY AUTO_INCREMENT,
    cName  VARCHAR(255) NOT NULL,
    cAge   INTEGER      NOT NULL,
    VALUES int          not null
);
CREATE TABLE `Orders`
(
    oID         INTEGER PRIMARY KEY AUTO_INCREMENT,
    cID         INTEGER NOT NULL,
    oDate       DATE,
    oTotalPrice DECIMAL,
    FOREIGN KEY (cID) REFERENCES Customers (cID)
);
CREATE TABLE Products
(
    pID    INTEGER PRIMARY KEY AUTO_INCREMENT,
    pName  VARCHAR(255) NOT NULL,
    pPrice DECIMAL
);
CREATE TABLE OrderDetails
(
    oID   INT NOT NULL,
    pID   INT NOT NULL,
    odQTY INT NOT NULL,
    FOREIGN KEY (oID) REFERENCES `Orders` (oID),
    FOREIGN KEY (pID) REFERENCES Products (pID),
    PRIMARY KEY (oID, pID)
);

INSERT INTO Customers
VALUES (1, 'Minh Quan', 10);
INSERT INTO Customers
VALUES (2, 'Ngoc Oanh', 20);
INSERT INTO Customers
VALUES (3, 'Hong Ha', 50);

INSERT INTO Orders
VALUES (2, 2, '2006-3-23', NULL);
INSERT INTO Orders
VALUES (3, 1, '2006-3-16', NULL);

INSERT INTO Products
VALUES (1, 'May Giat', 3),
       (2, 'Tu lanh', 5),
       (3, 'Dieu hoa', 7),
       (4, 'Quat', 1),
       (5, 'Bep dien', 2)
;

INSERT INTO OrderDetails
VALUES (1, 1, 3),
       (1, 3, 7),
       (1, 4, 2),
       (2, 1, 1),
       (3, 1, 8),
       (2, 5, 4),
       (2, 3, 3)
    ;
-- Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order
SELECT oID, oDate, oTotalPrice FROM Orders;

-- Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
SELECT Customers.cName, Products.pName
FROM (Orders
    INNER JOIN Customers on Customers.cID = Orders.cID
    INNER JOIN OrderDetails OD on Orders.oID = OD.oID
    INNER JOIN Products ON Products.pID = OD.pID
     );

-- Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
SELECT cName, cID FROM Customers
WHERE NOT EXISTS (SELECT oID FROM Orders WHERE Orders.cID = Customers.cID);

-- Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn (giá một hóa đơn được tính bằng
-- tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn. Giá bán của từng loại được tính = odQTY*pPrice)
SELECT Orders.oID, oDate, SUM(Products.pPrice * OrderDetails.odQTY) AS `TotalPrice`
FROM `Orders` INNER JOIN OrderDetails on `Orders`.oID = OrderDetails.oID
            INNER JOIN Products ON OrderDetails.pID = Products.pID
            GROUP BY Orders.oID,oDate;











