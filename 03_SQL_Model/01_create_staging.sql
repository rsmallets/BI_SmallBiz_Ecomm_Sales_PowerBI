/* ==========================================================
   FILE: 01_create_staging.sql
   PROJECT: BI_SmallBiz_Ecomm
   PURPOSE: Create database and raw staging table
   AUTHOR: Ryan Smallets
   DATE: 2026-02
========================================================== */

-- Create database if it does not already exist
IF DB_ID('BI_SmallBiz_Ecomm') IS NULL
BEGIN
    CREATE DATABASE BI_SmallBiz_Ecomm;
END
GO

USE BI_SmallBiz_Ecomm;
GO

-- Create staging schema if missing
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'stg')
    EXEC('CREATE SCHEMA stg');
GO

-- Drop raw table if it exists (for repeatable builds)
IF OBJECT_ID('stg.Raw_EcommSales','U') IS NOT NULL
    DROP TABLE stg.Raw_EcommSales;
GO

-- Create raw staging table
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
GO
