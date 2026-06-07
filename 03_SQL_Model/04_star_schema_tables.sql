/* ==========================================================
   FILE: 04_star_schema_tables.sql
   PROJECT: BI_SmallBiz_Ecomm
   PURPOSE: Create dimensional model (star schema)
========================================================== */

USE BI_SmallBiz_Ecomm;
GO

-- Create dw schema if missing
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'dw')
    EXEC('CREATE SCHEMA dw');
GO

/* -----------------------------
   Drop tables (rerunnable)
--------------------------------*/
IF OBJECT_ID('dw.Fact_Sales','U') IS NOT NULL DROP TABLE dw.Fact_Sales;
IF OBJECT_ID('dw.Dim_Product','U') IS NOT NULL DROP TABLE dw.Dim_Product;
IF OBJECT_ID('dw.Dim_Region','U')  IS NOT NULL DROP TABLE dw.Dim_Region;
IF OBJECT_ID('dw.Dim_Date','U')    IS NOT NULL DROP TABLE dw.Dim_Date;
GO

/* -----------------------------
   Dim_Date
   DateKey format: YYYYMMDD
--------------------------------*/
CREATE TABLE dw.Dim_Date (
    DateKey     INT         NOT NULL PRIMARY KEY,   -- e.g., 20250115
    [Date]      DATE        NOT NULL,
    [Year]      SMALLINT    NOT NULL,
    [Quarter]   TINYINT     NOT NULL,
    [Month]     TINYINT     NOT NULL,
    MonthName   VARCHAR(20) NOT NULL,
    YearMonth   CHAR(7)     NOT NULL,               -- YYYY-MM
    WeekOfYear  TINYINT     NOT NULL
);
GO

/* -----------------------------
   Dim_Product
   Natural key: SKU
--------------------------------*/
CREATE TABLE dw.Dim_Product (
    ProductKey   INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    SKU          VARCHAR(50)  NOT NULL,
    ProductName  VARCHAR(200) NOT NULL,
    Category     VARCHAR(100) NOT NULL,
    CONSTRAINT UQ_Dim_Product UNIQUE (SKU)
);
GO

/* -----------------------------
   Dim_Region
   Simple small-business region dimension
--------------------------------*/
CREATE TABLE dw.Dim_Region (
    RegionKey  INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Region     VARCHAR(50) NOT NULL,
    ShipState  VARCHAR(10) NOT NULL,
    CONSTRAINT UQ_Dim_Region UNIQUE (Region, ShipState)
);
GO

/* -----------------------------
   Fact_Sales
   Grain: one row per order line
--------------------------------*/
CREATE TABLE dw.Fact_Sales (
    SalesKey       BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    OrderID        VARCHAR(50) NOT NULL,
    LineID         INT NOT NULL,

    DateKey        INT NOT NULL,
    ProductKey     INT NOT NULL,
    RegionKey      INT NOT NULL,

    SalesChannel   VARCHAR(50) NULL,
    PaymentMethod  VARCHAR(50) NULL,
    OrderStatus    VARCHAR(50) NULL,

    Quantity       INT NOT NULL,
    UnitPrice      DECIMAL(12,2) NOT NULL,
    UnitDiscount   DECIMAL(12,2) NOT NULL,
    UnitCOGS       DECIMAL(12,2) NOT NULL,
    Shipping       DECIMAL(12,2) NOT NULL,
    Tax            DECIMAL(12,2) NOT NULL,

    -- Stored calculations for simple reporting (min DAX)
    NetSales       DECIMAL(12,2) NOT NULL,   -- (UnitPrice - UnitDiscount) * Quantity
    COGS           DECIMAL(12,2) NOT NULL,   -- UnitCOGS * Quantity
    GrossProfit    DECIMAL(12,2) NOT NULL    -- NetSales - COGS
);
GO

/* -----------------------------
   Foreign Keys
--------------------------------*/
ALTER TABLE dw.Fact_Sales
  ADD CONSTRAINT FK_FactSales_Date
  FOREIGN KEY (DateKey) REFERENCES dw.Dim_Date(DateKey);

ALTER TABLE dw.Fact_Sales
  ADD CONSTRAINT FK_FactSales_Product
  FOREIGN KEY (ProductKey) REFERENCES dw.Dim_Product(ProductKey);

ALTER TABLE dw.Fact_Sales
  ADD CONSTRAINT FK_FactSales_Region
  FOREIGN KEY (RegionKey) REFERENCES dw.Dim_Region(RegionKey);
GO