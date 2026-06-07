CREATE DATABASE BI_SmallBiz_Ecomm;
GO
USE BI_SmallBiz_Ecomm;
GO

CREATE SCHEMA stg;
GO

CREATE TABLE stg.Raw_EcommSales (
    OrderID VARCHAR(50),
    LineID INT,
    OrderDate VARCHAR(50),
    ShipDate VARCHAR(50),
    CustomerName VARCHAR(200),
    ShipState VARCHAR(10),
    Region VARCHAR(50),
    SKU VARCHAR(50),
    ProductName VARCHAR(200),
    Category VARCHAR(100),
    Quantity VARCHAR(20),
    UnitPrice VARCHAR(50),
    UnitDiscount VARCHAR(50),
    UnitCOGS VARCHAR(50),
    Shipping VARCHAR(50),
    Tax VARCHAR(50),
    SalesChannel VARCHAR(50),
    PaymentMethod VARCHAR(50),
    OrderStatus VARCHAR(50)
);