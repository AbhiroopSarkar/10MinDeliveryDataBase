-- Get the Order Summary details
CREATE VIEW vw_OrderSummary AS
SELECT o.OrderID, u.FullName AS 'Customer Name', v.VendorName ' Vendor Name',
o.OrderDate, o.TotalAmount, s.StatusName
FROM Orders o JOIN Users u ON o.UserID = u.UserID
JOIN Vendors v ON o.VendorID = v.VendorID
JOIN DeliveryStatus ds ON o.OrderID = ds.OrderID
JOIN Status s ON s.StatusID = ds.StatusID;


-- Product Sales Summary
CREATE VIEW vw_ProductSalesSummary AS
SELECT p.ProductName AS 'Product Name', SUM(oi.Quantity) AS 'Total Product Sold'
FROM OrderItems oi JOIN Products p
ON oi.ProductID = p.ProductID
GROUP BY p.ProductName;

CREATE NONCLUSTERED INDEX idx_ProductName ON Products(ProductName);

select * from Products where ProductName like '%2%';

CREATE NONCLUSTERED INDEX idx_OrderItems_Order_Product
ON OrderItems(OrderID, ProductID);

-- Triggers - automate the inventory stock automatically when product is ordered.
-- When orderitem in inserted then inventory quantity should be updated.
CREATE TRIGGER trg_UpdateInventoryOnOrder
ON OrderItems 
AFTER INSERT
AS
BEGIN
	UPDATE i 
	SET i.QuantityAvailable = i.QuantityAvailable - ins.Quantity
	FROM Inventory i 
	INNER JOIN inserted ins ON i.ProductID = ins.ProductID
END;
GO  -- 🔹 Required separator

-- Stored procedure- Place new order
-- Step 1: Define custom table type (only once)
CREATE TYPE dbo.OrderItemType AS TABLE (
	ProductID INT,
	Quantity INT,
	Price DECIMAL(10,2)
);
GO  -- 🔹 Required separator

-- Step 2: Create stored procedure
CREATE PROCEDURE sp_PlaceOrder
	@UserID INT, 
	@VendorID INT, 
	@TotalAmount DECIMAL(10,2), 
	@OrderItemsList dbo.OrderItemType READONLY
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @NewOrderID INT;

	-- 1. Insert into Orders Table
	INSERT INTO Orders(UserID, VendorID, OrderDate, TotalAmount)
	VALUES (@UserID, @VendorID, GETDATE(), @TotalAmount);

	-- 2. Get the newly created OrderID
	SET @NewOrderID = SCOPE_IDENTITY();

	-- 3. Insert into OrderItems Table
	INSERT INTO OrderItems(OrderID, ProductID, Quantity, Price)
	SELECT @NewOrderID, ProductID, Quantity, Price
	FROM @OrderItemsList;
END;
GO  -- 🔹 Required separator


SELECT * FROM INVENTORY WHERE ProductID = 1;


-- OPTIMIZE PERFORMANCE (It counts the time of the operation)
--SET STATISTICS TIME ON;
--SET STATISTICS IO ON;
