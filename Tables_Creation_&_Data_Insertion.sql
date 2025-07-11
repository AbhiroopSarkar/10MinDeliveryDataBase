-- 1. User TABLE
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber NVARCHAR(15),
    CreatedAt DATETIME DEFAULT GETDATE()
);

--2. Addresses
CREATE TABLE Addresses (
    AddressID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT FOREIGN KEY REFERENCES Users(UserID),
    AddressLine NVARCHAR(300),
    City NVARCHAR(50),
    State NVARCHAR(50),
    Pincode NVARCHAR(10),
    CreatedAt DATETIME DEFAULT GETDATE()
);

--3. Vendors
Create Table Vendors (
    VendorID INT IDENTITY(1,1) PRIMARY KEY,
    VendorName NVARCHAR(100),
    ContactEmail NVARCHAR(100),
    CreatedAt DATETIME DEFAULT GETDATE()
);

--4. ProductCategories
Create Table ProductCategories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL,
);

--5. Products
Create Table Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255),
    CategoryID int Foreign Key
    references ProductCategories(CategoryID),
    Price decimal(10,2),
    CreatedAt DATETIME DEFAULT GETDATE()
);

--6. Inventory
Create Table Inventory (
    InventoryID INT IDENTITY(1,1) PRIMARY KEY,
    VendorID int Foreign Key references Vendors(VendorID),
    ProductID int Foreign Key references Products(ProductID),
    QuantityAvailable int,
    LastUpdated DATETIME DEFAULT GETDATE()
);

--7. Orders
Create Table Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    UserID int Foreign Key references Users(UserID),
    VendorID int Foreign Key references Vendors(VendorID),
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount decimal(10,2),
);

--8. OrderItems
Create Table OrderItems (
    OrderItemID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID int Foreign Key references Orders(OrderID),
    ProductID int Foreign Key references Products(ProductID),
    Quantity int,
    Price decimal(10,2),
);

--9. Payments
Create Table Payments (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID int Foreign Key references Orders(OrderID),
    PaymentMode NVARCHAR(50),
    PaymentStatus NVARCHAR(50),
    PaidAt DATETIME DEFAULT GETDATE()
);

--10. DeliveryPartners
Create Table DeliveryPartners (
    PartnerID INT IDENTITY(1,1) PRIMARY KEY,
    PartnerName NVARCHAR(100),
    PhoneNumber NVARCHAR(15)
);

--11. Status
Create Table Status (
    StatusID INT IDENTITY(1,1) PRIMARY KEY,
    StatusName NVARCHAR(100)
);

--12. DeliveryStatus
Create Table DeliveryStatus (
    DeliveryID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID int Foreign Key references Orders(OrderID),
    StatusID int Foreign Key references Status(StatusID),
    UpdatedAt DATETIME DEFAULT GETDATE()
);

--13. Reviews
Create Table Reviews (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    UserID int Foreign Key references Users(UserID),
    ProductID int Foreign Key references Products(ProductID),
    Comment NVARCHAR(250),
    Rating int Check (Rating BETWEEN 1 AND 5),
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- Users
INSERT INTO Users (FullName, Email, PhoneNumber) VALUES
('Ananya Mehta', 'ananya@example.com', '9876543210'),
('Ravi Kumar', 'ravi@example.com', '9123456780'),
('Meera Shah', 'meera@example.com', '9321456780'),
('Aditya Jain', 'aditya@example.com', '9887654321'),
('Priya Singh', 'priya@example.com', '9988776655'),
('Rahul Verma', 'rahul@example.com', '9765432109'),
('Ishita Rao', 'ishita@example.com', '9845612370'),
('Kunal Patel', 'kunal@example.com', '9687456231'),
('Sneha Kapoor', 'sneha@example.com', '9786543214'),
('Arjun Nair', 'arjun@example.com', '9678452310');

-- Vendors
INSERT INTO Vendors (VendorName, ContactEmail) VALUES
('FreshMart', 'contact@freshmart.com'),
('DailyGroceries', 'support@dailygroceries.com'),
('GreenBasket', 'hello@greenbasket.com'),
('QuickBuy', 'sales@quickbuy.com'),
('HyperLocalHub', 'help@hyperlocalhub.com');

-- Product Categories
-- Note: Initially inserted duplicate records in table with IDENTITY PK (ItemID).
-- After DELETE, reinserted data but IDs started from 16 due to auto-increment.
-- Needed to reset identity seed using: DBCC CHECKIDENT ('Table_Name', RESEED, 0);
-- Table is referenced by other tables (FKs), but no data inserted yet in those.

/*
DELETE FROM ProductCategories;
DBCC CHECKIDENT ('ProductCategories', RESEED, 0);

SELECT * FROM ProductCategories;
SELECT IDENT_CURRENT('ProductCategories') AS CurrentIdentity;
*/

-- Product Categories Insertion
INSERT INTO ProductCategories (CategoryName) VALUES
('Fruits & Vegetables'),
('Dairy'),
('Bakery'),
('Snacks'),
('Beverages');

--SELECT * FROM ProductCategories;


-- Products
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 1', 'Description for product 1', 2, 15.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 2', 'Description for product 2', 3, 20.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 3', 'Description for product 3', 4, 25.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 4', 'Description for product 4', 5, 30.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 5', 'Description for product 5', 1, 35.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 6', 'Description for product 6', 2, 40.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 7', 'Description for product 7', 3, 45.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 8', 'Description for product 8', 4, 50.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 9', 'Description for product 9', 5, 55.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 10', 'Description for product 10', 1, 10.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 11', 'Description for product 11', 2, 15.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 12', 'Description for product 12', 3, 20.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 13', 'Description for product 13', 4, 25.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 14', 'Description for product 14', 5, 30.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 15', 'Description for product 15', 1, 35.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 16', 'Description for product 16', 2, 40.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 17', 'Description for product 17', 3, 45.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 18', 'Description for product 18', 4, 50.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 19', 'Description for product 19', 5, 55.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 20', 'Description for product 20', 1, 10.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 21', 'Description for product 21', 2, 15.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 22', 'Description for product 22', 3, 20.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 23', 'Description for product 23', 4, 25.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 24', 'Description for product 24', 5, 30.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 25', 'Description for product 25', 1, 35.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 26', 'Description for product 26', 2, 40.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 27', 'Description for product 27', 3, 45.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 28', 'Description for product 28', 4, 50.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 29', 'Description for product 29', 5, 55.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 30', 'Description for product 30', 1, 10.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 31', 'Description for product 31', 2, 15.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 32', 'Description for product 32', 3, 20.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 33', 'Description for product 33', 4, 25.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 34', 'Description for product 34', 5, 30.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 35', 'Description for product 35', 1, 35.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 36', 'Description for product 36', 2, 40.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 37', 'Description for product 37', 3, 45.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 38', 'Description for product 38', 4, 50.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 39', 'Description for product 39', 5, 55.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 40', 'Description for product 40', 1, 10.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 41', 'Description for product 41', 2, 15.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 42', 'Description for product 42', 3, 20.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 43', 'Description for product 43', 4, 25.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 44', 'Description for product 44', 5, 30.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 45', 'Description for product 45', 1, 35.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 46', 'Description for product 46', 2, 40.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 47', 'Description for product 47', 3, 45.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 48', 'Description for product 48', 4, 50.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 49', 'Description for product 49', 5, 55.00);
INSERT INTO Products (ProductName, Description, CategoryID, Price) VALUES ('Product 50', 'Description for product 50', 1, 10.00);

-- Issue: Inserted duplicate rows in table with IDENTITY (auto-increment) primary key.
-- After DELETE, identity value continued from last number (e.g., started from 16).
-- Fix: Reset identity seed to start from 1 using DBCC CHECKIDENT after deleting rows.
-- Applies only when table has no dependent data yet (foreign key references exist, but no inserts made).
-- Command used: 
--   DELETE FROM Products;
--   DBCC CHECKIDENT ('Products', RESEED, 0);

/*
SELECT * FROM Products;
SELECT IDENT_CURRENT('Products') AS CurrentIdentity;
*/

-- Inventory
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (2, 1, 51);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (3, 2, 52);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (4, 3, 53);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (5, 4, 54);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (1, 5, 55);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (2, 6, 56);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (3, 7, 57);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (4, 8, 58);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (5, 9, 59);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (1, 10, 60);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (2, 11, 61);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (3, 12, 62);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (4, 13, 63);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (5, 14, 64);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (1, 15, 65);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (2, 16, 66);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (3, 17, 67);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (4, 18, 68);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (5, 19, 69);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (1, 20, 50);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (2, 21, 51);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (3, 22, 52);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (4, 23, 53);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (5, 24, 54);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (1, 25, 55);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (2, 26, 56);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (3, 27, 57);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (4, 28, 58);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (5, 29, 59);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (1, 30, 60);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (2, 31, 61);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (3, 32, 62);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (4, 33, 63);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (5, 34, 64);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (1, 35, 65);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (2, 36, 66);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (3, 37, 67);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (4, 38, 68);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (5, 39, 69);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (1, 40, 50);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (2, 41, 51);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (3, 42, 52);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (4, 43, 53);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (5, 44, 54);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (1, 45, 55);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (2, 46, 56);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (3, 47, 57);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (4, 48, 58);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (5, 49, 59);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (1, 50, 60);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (2, 51, 61);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (3, 52, 62);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (4, 53, 63);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (5, 54, 64);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (1, 55, 65);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (2, 56, 66);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (3, 57, 67);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (4, 58, 68);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (5, 59, 69);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (1, 60, 50);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (2, 61, 51);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (3, 62, 52);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (4, 63, 53);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (5, 64, 54);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (1, 65, 55);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (2, 66, 56);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (3, 67, 57);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (4, 68, 58);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (5, 69, 59);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (1, 70, 60);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (2, 71, 61);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (3, 72, 62);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (4, 73, 63);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (5, 74, 64);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (1, 75, 65);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (2, 76, 66);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (3, 77, 67);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (4, 78, 68);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (5, 79, 69);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (1, 80, 50);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (2, 81, 51);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (3, 82, 52);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (4, 83, 53);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (5, 84, 54);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (1, 85, 55);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (2, 86, 56);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (3, 87, 57);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (4, 88, 58);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (5, 89, 59);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (1, 90, 60);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (2, 91, 61);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (3, 92, 62);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (4, 93, 63);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (5, 94, 64);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (1, 95, 65);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (2, 96, 66);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (3, 97, 67);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (4, 98, 68);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (5, 99, 69);
INSERT INTO Inventory (VendorID, ProductID, QuantityAvailable) VALUES (1, 100, 50);

--Select * from Inventory;

--SELECT * FROM Inventory;
--SELECT IDENT_CURRENT('Inventory') AS CurrentIdentity;


-- Addresses
INSERT INTO Addresses (UserID, AddressLine, City, State, Pincode) VALUES (2, 'Address 1', 'City 1', 'State 1', '40001');
INSERT INTO Addresses (UserID, AddressLine, City, State, Pincode) VALUES (3, 'Address 2', 'City 2', 'State 2', '40002');
INSERT INTO Addresses (UserID, AddressLine, City, State, Pincode) VALUES (4, 'Address 3', 'City 3', 'State 3', '40003');
INSERT INTO Addresses (UserID, AddressLine, City, State, Pincode) VALUES (5, 'Address 4', 'City 4', 'State 4', '40004');
INSERT INTO Addresses (UserID, AddressLine, City, State, Pincode) VALUES (6, 'Address 5', 'City 5', 'State 5', '40005');
INSERT INTO Addresses (UserID, AddressLine, City, State, Pincode) VALUES (7, 'Address 6', 'City 6', 'State 6', '40006');
INSERT INTO Addresses (UserID, AddressLine, City, State, Pincode) VALUES (8, 'Address 7', 'City 7', 'State 7', '40007');
INSERT INTO Addresses (UserID, AddressLine, City, State, Pincode) VALUES (9, 'Address 8', 'City 8', 'State 8', '40008');
INSERT INTO Addresses (UserID, AddressLine, City, State, Pincode) VALUES (10, 'Address 9', 'City 9', 'State 9', '40009');
INSERT INTO Addresses (UserID, AddressLine, City, State, Pincode) VALUES (1, 'Address 10', 'City 10', 'State 10', '400010');
INSERT INTO Addresses (UserID, AddressLine, City, State, Pincode) VALUES (2, 'Address 11', 'City 11', 'State 11', '400011');
INSERT INTO Addresses (UserID, AddressLine, City, State, Pincode) VALUES (3, 'Address 12', 'City 12', 'State 12', '400012');
INSERT INTO Addresses (UserID, AddressLine, City, State, Pincode) VALUES (4, 'Address 13', 'City 13', 'State 13', '400013');
INSERT INTO Addresses (UserID, AddressLine, City, State, Pincode) VALUES (5, 'Address 14', 'City 14', 'State 14', '400014');
INSERT INTO Addresses (UserID, AddressLine, City, State, Pincode) VALUES (6, 'Address 15', 'City 15', 'State 15', '400015');
INSERT INTO Addresses (UserID, AddressLine, City, State, Pincode) VALUES (7, 'Address 16', 'City 16', 'State 16', '400016');
INSERT INTO Addresses (UserID, AddressLine, City, State, Pincode) VALUES (8, 'Address 17', 'City 17', 'State 17', '400017');
INSERT INTO Addresses (UserID, AddressLine, City, State, Pincode) VALUES (9, 'Address 18', 'City 18', 'State 18', '400018');
INSERT INTO Addresses (UserID, AddressLine, City, State, Pincode) VALUES (10, 'Address 19', 'City 19', 'State 19', '400019');
INSERT INTO Addresses (UserID, AddressLine, City, State, Pincode) VALUES (1, 'Address 20', 'City 20', 'State 20', '400020');



-- Orders
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (2, 2, GETDATE(), 110.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (3, 3, GETDATE(), 120.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (4, 4, GETDATE(), 130.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (5, 5, GETDATE(), 140.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (6, 1, GETDATE(), 150.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (7, 2, GETDATE(), 160.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (8, 3, GETDATE(), 170.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (9, 4, GETDATE(), 180.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (10, 5, GETDATE(), 190.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (1, 1, GETDATE(), 200.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (2, 2, GETDATE(), 210.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (3, 3, GETDATE(), 220.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (4, 4, GETDATE(), 230.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (5, 5, GETDATE(), 240.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (6, 1, GETDATE(), 250.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (7, 2, GETDATE(), 260.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (8, 3, GETDATE(), 270.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (9, 4, GETDATE(), 280.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (10, 5, GETDATE(), 290.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (1, 1, GETDATE(), 100.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (2, 2, GETDATE(), 110.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (3, 3, GETDATE(), 120.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (4, 4, GETDATE(), 130.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (5, 5, GETDATE(), 140.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (6, 1, GETDATE(), 150.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (7, 2, GETDATE(), 160.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (8, 3, GETDATE(), 170.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (9, 4, GETDATE(), 180.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (10, 5, GETDATE(), 190.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (1, 1, GETDATE(), 200.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (2, 2, GETDATE(), 210.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (3, 3, GETDATE(), 220.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (4, 4, GETDATE(), 230.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (5, 5, GETDATE(), 240.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (6, 1, GETDATE(), 250.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (7, 2, GETDATE(), 260.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (8, 3, GETDATE(), 270.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (9, 4, GETDATE(), 280.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (10, 5, GETDATE(), 290.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (1, 1, GETDATE(), 100.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (2, 2, GETDATE(), 110.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (3, 3, GETDATE(), 120.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (4, 4, GETDATE(), 130.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (5, 5, GETDATE(), 140.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (6, 1, GETDATE(), 150.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (7, 2, GETDATE(), 160.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (8, 3, GETDATE(), 170.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (9, 4, GETDATE(), 180.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (10, 5, GETDATE(), 190.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (1, 1, GETDATE(), 200.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (2, 2, GETDATE(), 210.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (3, 3, GETDATE(), 220.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (4, 4, GETDATE(), 230.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (5, 5, GETDATE(), 240.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (6, 1, GETDATE(), 250.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (7, 2, GETDATE(), 260.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (8, 3, GETDATE(), 270.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (9, 4, GETDATE(), 280.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (10, 5, GETDATE(), 290.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (1, 1, GETDATE(), 100.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (2, 2, GETDATE(), 110.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (3, 3, GETDATE(), 120.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (4, 4, GETDATE(), 130.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (5, 5, GETDATE(), 140.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (6, 1, GETDATE(), 150.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (7, 2, GETDATE(), 160.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (8, 3, GETDATE(), 170.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (9, 4, GETDATE(), 180.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (10, 5, GETDATE(), 190.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (1, 1, GETDATE(), 200.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (2, 2, GETDATE(), 210.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (3, 3, GETDATE(), 220.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (4, 4, GETDATE(), 230.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (5, 5, GETDATE(), 240.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (6, 1, GETDATE(), 250.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (7, 2, GETDATE(), 260.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (8, 3, GETDATE(), 270.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (9, 4, GETDATE(), 280.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (10, 5, GETDATE(), 290.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (1, 1, GETDATE(), 100.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (2, 2, GETDATE(), 110.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (3, 3, GETDATE(), 120.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (4, 4, GETDATE(), 130.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (5, 5, GETDATE(), 140.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (6, 1, GETDATE(), 150.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (7, 2, GETDATE(), 160.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (8, 3, GETDATE(), 170.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (9, 4, GETDATE(), 180.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (10, 5, GETDATE(), 190.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (1, 1, GETDATE(), 200.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (2, 2, GETDATE(), 210.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (3, 3, GETDATE(), 220.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (4, 4, GETDATE(), 230.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (5, 5, GETDATE(), 240.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (6, 1, GETDATE(), 250.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (7, 2, GETDATE(), 260.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (8, 3, GETDATE(), 270.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (9, 4, GETDATE(), 280.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (10, 5, GETDATE(), 290.00);
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount) VALUES (1, 1, GETDATE(), 100.00);


-- OrderItems
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (2, 2, 2, 15.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (3, 3, 3, 20.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (4, 4, 1, 25.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (5, 5, 2, 30.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (6, 6, 3, 35.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (7, 7, 1, 40.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (8, 8, 2, 45.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (9, 9, 3, 50.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (10, 10, 1, 55.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (11, 11, 2, 10.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (12, 12, 3, 15.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (13, 13, 1, 20.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (14, 14, 2, 25.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (15, 15, 3, 30.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (16, 16, 1, 35.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (17, 17, 2, 40.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (18, 18, 3, 45.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (19, 19, 1, 50.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (20, 20, 2, 55.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (21, 21, 3, 10.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (22, 22, 1, 15.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (23, 23, 2, 20.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (24, 24, 3, 25.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (25, 25, 1, 30.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (26, 26, 2, 35.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (27, 27, 3, 40.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (28, 28, 1, 45.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (29, 29, 2, 50.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (30, 30, 3, 55.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (31, 31, 1, 10.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (32, 32, 2, 15.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (33, 33, 3, 20.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (34, 34, 1, 25.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (35, 35, 2, 30.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (36, 36, 3, 35.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (37, 37, 1, 40.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (38, 38, 2, 45.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (39, 39, 3, 50.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (40, 40, 1, 55.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (41, 41, 2, 10.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (42, 42, 3, 15.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (43, 43, 1, 20.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (44, 44, 2, 25.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (45, 45, 3, 30.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (46, 46, 1, 35.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (47, 47, 2, 40.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (48, 48, 3, 45.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (49, 49, 1, 50.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (50, 50, 2, 55.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (51, 1, 3, 10.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (52, 2, 1, 15.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (53, 3, 2, 20.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (54, 4, 3, 25.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (55, 5, 1, 30.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (56, 6, 2, 35.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (57, 7, 3, 40.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (58, 8, 1, 45.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (59, 9, 2, 50.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (60, 10, 3, 55.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (61, 11, 1, 10.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (62, 12, 2, 15.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (63, 13, 3, 20.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (64, 14, 1, 25.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (65, 15, 2, 30.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (66, 16, 3, 35.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (67, 17, 1, 40.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (68, 18, 2, 45.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (69, 19, 3, 50.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (70, 20, 1, 55.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (71, 21, 2, 10.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (72, 22, 3, 15.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (73, 23, 1, 20.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (74, 24, 2, 25.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (75, 25, 3, 30.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (76, 26, 1, 35.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (77, 27, 2, 40.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (78, 28, 3, 45.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (79, 29, 1, 50.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (80, 30, 2, 55.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (81, 31, 3, 10.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (82, 32, 1, 15.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (83, 33, 2, 20.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (84, 34, 3, 25.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (85, 35, 1, 30.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (86, 36, 2, 35.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (87, 37, 3, 40.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (88, 38, 1, 45.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (89, 39, 2, 50.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (90, 40, 3, 55.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (91, 41, 1, 10.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (92, 42, 2, 15.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (93, 43, 3, 20.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (94, 44, 1, 25.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (95, 45, 2, 30.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (96, 46, 3, 35.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (97, 47, 1, 40.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (98, 48, 2, 45.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (99, 49, 3, 50.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (100, 50, 1, 55.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (1, 1, 2, 10.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (2, 2, 3, 15.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (3, 3, 1, 20.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (4, 4, 2, 25.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (5, 5, 3, 30.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (6, 6, 1, 35.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (7, 7, 2, 40.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (8, 8, 3, 45.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (9, 9, 1, 50.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (10, 10, 2, 55.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (11, 11, 3, 10.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (12, 12, 1, 15.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (13, 13, 2, 20.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (14, 14, 3, 25.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (15, 15, 1, 30.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (16, 16, 2, 35.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (17, 17, 3, 40.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (18, 18, 1, 45.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (19, 19, 2, 50.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (20, 20, 3, 55.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (21, 21, 1, 10.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (22, 22, 2, 15.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (23, 23, 3, 20.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (24, 24, 1, 25.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (25, 25, 2, 30.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (26, 26, 3, 35.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (27, 27, 1, 40.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (28, 28, 2, 45.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (29, 29, 3, 50.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (30, 30, 1, 55.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (31, 31, 2, 10.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (32, 32, 3, 15.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (33, 33, 1, 20.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (34, 34, 2, 25.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (35, 35, 3, 30.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (36, 36, 1, 35.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (37, 37, 2, 40.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (38, 38, 3, 45.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (39, 39, 1, 50.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (40, 40, 2, 55.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (41, 41, 3, 10.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (42, 42, 1, 15.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (43, 43, 2, 20.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (44, 44, 3, 25.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (45, 45, 1, 30.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (46, 46, 2, 35.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (47, 47, 3, 40.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (48, 48, 1, 45.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (49, 49, 2, 50.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (50, 50, 3, 55.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (51, 1, 1, 10.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (52, 2, 2, 15.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (53, 3, 3, 20.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (54, 4, 1, 25.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (55, 5, 2, 30.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (56, 6, 3, 35.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (57, 7, 1, 40.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (58, 8, 2, 45.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (59, 9, 3, 50.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (60, 10, 1, 55.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (61, 11, 2, 10.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (62, 12, 3, 15.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (63, 13, 1, 20.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (64, 14, 2, 25.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (65, 15, 3, 30.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (66, 16, 1, 35.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (67, 17, 2, 40.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (68, 18, 3, 45.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (69, 19, 1, 50.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (70, 20, 2, 55.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (71, 21, 3, 10.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (72, 22, 1, 15.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (73, 23, 2, 20.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (74, 24, 3, 25.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (75, 25, 1, 30.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (76, 26, 2, 35.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (77, 27, 3, 40.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (78, 28, 1, 45.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (79, 29, 2, 50.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (80, 30, 3, 55.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (81, 31, 1, 10.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (82, 32, 2, 15.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (83, 33, 3, 20.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (84, 34, 1, 25.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (85, 35, 2, 30.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (86, 36, 3, 35.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (87, 37, 1, 40.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (88, 38, 2, 45.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (89, 39, 3, 50.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (90, 40, 1, 55.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (91, 41, 2, 10.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (92, 42, 3, 15.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (93, 43, 1, 20.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (94, 44, 2, 25.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (95, 45, 3, 30.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (96, 46, 1, 35.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (97, 47, 2, 40.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (98, 48, 3, 45.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (99, 49, 1, 50.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (100, 50, 2, 55.00);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (1, 1, 3, 10.00);


-- Payments
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (1, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (2, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (3, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (4, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (5, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (6, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (7, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (8, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (9, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (10, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (11, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (12, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (13, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (14, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (15, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (16, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (17, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (18, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (19, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (20, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (21, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (22, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (23, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (24, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (25, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (26, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (27, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (28, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (29, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (30, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (31, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (32, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (33, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (34, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (35, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (36, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (37, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (38, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (39, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (40, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (41, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (42, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (43, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (44, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (45, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (46, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (47, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (48, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (49, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (50, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (51, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (52, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (53, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (54, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (55, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (56, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (57, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (58, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (59, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (60, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (61, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (62, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (63, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (64, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (65, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (66, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (67, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (68, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (69, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (70, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (71, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (72, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (73, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (74, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (75, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (76, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (77, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (78, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (79, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (80, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (81, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (82, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (83, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (84, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (85, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (86, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (87, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (88, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (89, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (90, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (91, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (92, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (93, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (94, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (95, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (96, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (97, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (98, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (99, 'UPI', 'Paid', GETDATE());
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus, PaidAt) VALUES (100, 'UPI', 'Paid', GETDATE());


-- Delivery Partners
INSERT INTO DeliveryPartners (PartnerName, PhoneNumber) VALUES
('Aman Yadav', '9999999999'),
('Sushil Reddy', '8888888888'),
('Kiran Mehta', '7777777777'),
('Divya Patil', '5454545456'),
('Rohit Singh', '9876543210');


-- Status
INSERT INTO Status (StatusName) VALUES
('Assigned'),
('Picked'),
('Out for Delivery'),
('Delivered'),
('Cancelled');


-- DeliveryStatus
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (1, 2, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (2, 3, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (3, 4, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (4, 5, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (5, 1, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (6, 2, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (7, 3, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (8, 4, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (9, 5, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (10, 1, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (11, 2, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (12, 3, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (13, 4, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (14, 5, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (15, 1, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (16, 2, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (17, 3, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (18, 4, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (19, 5, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (20, 1, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (21, 2, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (22, 3, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (23, 4, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (24, 5, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (25, 1, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (26, 2, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (27, 3, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (28, 4, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (29, 5, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (30, 1, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (31, 2, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (32, 3, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (33, 4, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (34, 5, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (35, 1, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (36, 2, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (37, 3, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (38, 4, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (39, 5, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (40, 1, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (41, 2, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (42, 3, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (43, 4, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (44, 5, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (45, 1, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (46, 2, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (47, 3, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (48, 4, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (49, 5, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (50, 1, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (51, 2, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (52, 3, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (53, 4, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (54, 5, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (55, 1, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (56, 2, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (57, 3, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (58, 4, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (59, 5, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (60, 1, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (61, 2, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (62, 3, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (63, 4, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (64, 5, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (65, 1, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (66, 2, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (67, 3, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (68, 4, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (69, 5, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (70, 1, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (71, 2, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (72, 3, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (73, 4, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (74, 5, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (75, 1, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (76, 2, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (77, 3, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (78, 4, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (79, 5, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (80, 1, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (81, 2, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (82, 3, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (83, 4, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (84, 5, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (85, 1, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (86, 2, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (87, 3, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (88, 4, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (89, 5, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (90, 1, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (91, 2, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (92, 3, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (93, 4, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (94, 5, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (95, 1, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (96, 2, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (97, 3, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (98, 4, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (99, 5, GETDATE());
INSERT INTO DeliveryStatus (OrderID, StatusID, UpdatedAt) VALUES (100, 1, GETDATE());


-- Reviews
INSERT INTO Reviews (UserID, ProductID, Rating, Comment) VALUES (2, 2, 2, 'Review comment 1');
INSERT INTO Reviews (UserID, ProductID, Rating, Comment) VALUES (3, 3, 3, 'Review comment 2');
INSERT INTO Reviews (UserID, ProductID, Rating, Comment) VALUES (4, 4, 4, 'Review comment 3');
INSERT INTO Reviews (UserID, ProductID, Rating, Comment) VALUES (5, 5, 5, 'Review comment 4');
INSERT INTO Reviews (UserID, ProductID, Rating, Comment) VALUES (6, 6, 1, 'Review comment 5');
INSERT INTO Reviews (UserID, ProductID, Rating, Comment) VALUES (7, 7, 2, 'Review comment 6');
INSERT INTO Reviews (UserID, ProductID, Rating, Comment) VALUES (8, 8, 3, 'Review comment 7');
INSERT INTO Reviews (UserID, ProductID, Rating, Comment) VALUES (9, 9, 4, 'Review comment 8');
INSERT INTO Reviews (UserID, ProductID, Rating, Comment) VALUES (10, 10, 5, 'Review comment 9');
INSERT INTO Reviews (UserID, ProductID, Rating, Comment) VALUES (1, 11, 1, 'Review comment 10');
INSERT INTO Reviews (UserID, ProductID, Rating, Comment) VALUES (2, 12, 2, 'Review comment 11');
INSERT INTO Reviews (UserID, ProductID, Rating, Comment) VALUES (3, 13, 3, 'Review comment 12');
INSERT INTO Reviews (UserID, ProductID, Rating, Comment) VALUES (4, 14, 4, 'Review comment 13');
INSERT INTO Reviews (UserID, ProductID, Rating, Comment) VALUES (5, 15, 5, 'Review comment 14');
INSERT INTO Reviews (UserID, ProductID, Rating, Comment) VALUES (6, 16, 1, 'Review comment 15');
INSERT INTO Reviews (UserID, ProductID, Rating, Comment) VALUES (7, 17, 2, 'Review comment 16');
INSERT INTO Reviews (UserID, ProductID, Rating, Comment) VALUES (8, 18, 3, 'Review comment 17');
INSERT INTO Reviews (UserID, ProductID, Rating, Comment) VALUES (9, 19, 4, 'Review comment 18');
INSERT INTO Reviews (UserID, ProductID, Rating, Comment) VALUES (10, 20, 5, 'Review comment 19');
INSERT INTO Reviews (UserID, ProductID, Rating, Comment) VALUES (1, 21, 1, 'Review comment 20');
INSERT INTO Reviews (UserID, ProductID, Rating, Comment) VALUES (2, 22, 2, 'Review comment 21');
INSERT INTO Reviews (UserID, ProductID, Rating, Comment) VALUES (3, 23, 3, 'Review comment 22');
INSERT INTO Reviews (UserID, ProductID, Rating, Comment) VALUES (4, 24, 4, 'Review comment 23');
INSERT INTO Reviews (UserID, ProductID, Rating, Comment) VALUES (5, 25, 5, 'Review comment 24');
INSERT INTO Reviews (UserID, ProductID, Rating, Comment) VALUES (6, 26, 1, 'Review comment 25');
INSERT INTO Reviews (UserID, ProductID, Rating, Comment) VALUES (7, 27, 2, 'Review comment 26');
INSERT INTO Reviews (UserID, ProductID, Rating, Comment) VALUES (8, 28, 3, 'Review comment 27');
INSERT INTO Reviews (UserID, ProductID, Rating, Comment) VALUES (9, 29, 4, 'Review comment 28');
INSERT INTO Reviews (UserID, ProductID, Rating, Comment) VALUES (10, 30, 5, 'Review comment 29');
INSERT INTO Reviews (UserID, ProductID, Rating, Comment) VALUES (1, 31, 1, 'Review comment 30');


--SOME IMPORTANT QUERIES

-- 1. Get All Orders by a User (Customer or Vendor)
-- What we need: User table, Orders Table, Vendor Table
-- Customer Query
SELECT o.OrderID, o.OrderDate, o.TotalAmount, o.UserID, u.FullName
FROM Orders o JOIN Users u
ON o.UserID = u.UserID WHERE o.UserID = 6;

-- Vendor Query
SELECT o.OrderID, o.OrderDate, o.TotalAmount, o.UserID, v.VendorName
FROM Orders o JOIN Vendors v
ON o.VendorID = v.VendorID WHERE o.VendorID = 3;

-- 2. Order Summary with Items (Orders, OrderItems, Products)
SELECT o.OrderID, p.ProductName, oi.Quantity, oi.Price
FROM Orders o JOIN OrderItems oi 
ON o.OrderID = oi.OrderID
JOIN Products p
ON p.ProductID = oi.ProductID;

-- 3. Total Revenue Generated by Each Vendor
SELECT v.VendorName AS 'Vendor Name', SUM(o.TotalAmount) as 'Total Revenue'
FROM Orders o JOIN Vendors v
ON o.VendorID = v.VendorID
GROUP BY v.VendorName
ORDER BY 'Total Revenue' DESC;

-- 4. Top 5 Bestselling Products
SELECT TOP 5 p.ProductName, SUM(oi.Quantity) AS TotalSold -- Using TOP
FROM OrderItems oi JOIN Products p
ON oi.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalSold DESC;

--OR

SELECT p.ProductName, SUM(oi.Quantity) AS TotalSold 
FROM OrderItems oi JOIN Products p
ON oi.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalSold DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY; -- Using Pagination


-- 6. Delivery Status of a Particular Order
SELECT o.OrderID, s.StatusName, ds.UpdatedAt
FROM DeliveryStatus ds JOIN Status s
ON ds.StatusID = s.StatusID
JOIN Orders o
ON o.OrderID = ds.OrderID
WHERE o.OrderID = 5;

-- 7. Daily Order Count  --IMP
SELECT CAST(OrderDate AS DATE) AS OrderDay, COUNT(*) AS TotalOrders FROM Orders
GROUP BY CAST(OrderDate AS DATE);

-- 8. Top Customers by Order Value
SELECT TOP 1 u.FullName, SUM(o.TotalAmount) AS TotalSpent
FROM Orders o JOIN Users u
ON o.UserID = u.UserID
GROUP BY u.FullName
ORDER BY TotalSpent DESC;

-- 9. Low Stock Products Per Vendor   --IMP
SELECT v.VendorName, p.ProductName, i.QuantityAvailable
FROM Inventory i JOIN Vendors v
ON i.VendorID = v.VendorID
JOIN Products p 
ON i.ProductID = p.ProductID
WHERE i.QuantityAvailable < 50
ORDER BY i.QuantityAvailable;


-- 10. Search Products by Keyword (Flexible Query)
SELECT * FROM Products
WHERE ProductName LIKE '%4';




