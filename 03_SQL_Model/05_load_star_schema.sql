/* ==========================================================
   FILE: 05_load_star_schema.sql
   PROJECT: BI_SmallBiz_Ecomm
   PURPOSE: Populate star schema tables
========================================================== */

USE BI_SmallBiz_Ecomm;
GO

/* ---------------------------------------------------------
   0. Reset tables so script is rerunnable
--------------------------------------------------------- */
DELETE FROM dw.Fact_Sales;
DELETE FROM dw.Dim_Region;
DELETE FROM dw.Dim_Product;
DELETE FROM dw.Dim_Date;
GO

/* ---------------------------------------------------------
   1. Populate Dim_Date
--------------------------------------------------------- */
INSERT INTO dw.Dim_Date
(
    DateKey,
    [Date],
    [Year],
    [Quarter],
    [Month],
    MonthName,
    YearMonth,
    WeekOfYear
)
SELECT DISTINCT
    CONVERT(INT, FORMAT(OrderDate, 'yyyyMMdd')) AS DateKey,
    OrderDate,
    YEAR(OrderDate) AS [Year],
    DATEPART(QUARTER, OrderDate) AS [Quarter],
    MONTH(OrderDate) AS [Month],
    DATENAME(MONTH, OrderDate) AS MonthName,
    FORMAT(OrderDate, 'yyyy-MM') AS YearMonth,
    DATEPART(WEEK, OrderDate) AS WeekOfYear
FROM stg.vw_Clean_EcommSales
WHERE OrderDate IS NOT NULL;
GO

/* ---------------------------------------------------------
   2. Populate Dim_Product
   One row per SKU
--------------------------------------------------------- */
INSERT INTO dw.Dim_Product
(
    SKU,
    ProductName,
    Category
)
SELECT
    SKU,
    MAX(ProductName) AS ProductName,
    MAX(Category) AS Category
FROM stg.vw_Clean_EcommSales
WHERE SKU IS NOT NULL
GROUP BY SKU;
GO

/* ---------------------------------------------------------
   3. Populate Dim_Region
--------------------------------------------------------- */
INSERT INTO dw.Dim_Region
(
    Region,
    ShipState
)
SELECT DISTINCT
    Region,
    ShipState
FROM stg.vw_Clean_EcommSales
WHERE Region IS NOT NULL
  AND ShipState IS NOT NULL;
GO

/* ---------------------------------------------------------
   4. Populate Fact_Sales
--------------------------------------------------------- */
INSERT INTO dw.Fact_Sales
(
    OrderID,
    LineID,
    DateKey,
    ProductKey,
    RegionKey,
    SalesChannel,
    PaymentMethod,
    OrderStatus,
    Quantity,
    UnitPrice,
    UnitDiscount,
    UnitCOGS,
    Shipping,
    Tax,
    NetSales,
    COGS,
    GrossProfit
)
SELECT
    s.OrderID,
    s.LineID,
    CONVERT(INT, FORMAT(s.OrderDate, 'yyyyMMdd')) AS DateKey,
    p.ProductKey,
    r.RegionKey,
    s.SalesChannel,
    s.PaymentMethod,
    s.OrderStatus,
    s.Quantity,
    s.UnitPrice,
    s.UnitDiscount,
    s.UnitCOGS,
    s.Shipping,
    s.Tax,
    (s.UnitPrice - s.UnitDiscount) * s.Quantity AS NetSales,
    s.UnitCOGS * s.Quantity AS COGS,
    ((s.UnitPrice - s.UnitDiscount) * s.Quantity) - (s.UnitCOGS * s.Quantity) AS GrossProfit
FROM stg.vw_Clean_EcommSales s
JOIN dw.Dim_Product p
    ON s.SKU = p.SKU
JOIN dw.Dim_Region r
    ON s.Region = r.Region
   AND s.ShipState = r.ShipState
WHERE s.OrderDate IS NOT NULL;
GO