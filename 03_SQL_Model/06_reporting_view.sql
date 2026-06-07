/* ==========================================================
   FILE: 06_reporting_view.sql
   PROJECT: BI_SmallBiz_Ecomm
   PURPOSE: Create reporting layer for Power BI dashboard
========================================================== */

USE BI_SmallBiz_Ecomm;
GO

-- Drop if exists so script is rerunnable
IF OBJECT_ID('rpt.vw_Sales_Executive','V') IS NOT NULL
    DROP VIEW rpt.vw_Sales_Executive;
GO

-- Create reporting schema if missing
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'rpt')
    EXEC('CREATE SCHEMA rpt');
GO

CREATE VIEW rpt.vw_Sales_Executive AS

SELECT

    f.OrderID,
    f.LineID,

    d.Date,
    d.Year,
    d.Quarter,
    d.Month,
    d.MonthName,
    d.YearMonth,

    p.SKU,
    p.ProductName,
    p.Category,

    r.Region,
    r.ShipState,

    f.SalesChannel,
    f.PaymentMethod,
    f.OrderStatus,

    f.Quantity,
    f.UnitPrice,
    f.UnitDiscount,
    f.UnitCOGS,
    f.Shipping,
    f.Tax,

    f.NetSales,
    f.COGS,
    f.GrossProfit,

    CASE 
        WHEN f.NetSales = 0 THEN 0
        ELSE f.GrossProfit / f.NetSales
    END AS GrossMarginPct

FROM dw.Fact_Sales f

JOIN dw.Dim_Date d
    ON f.DateKey = d.DateKey

JOIN dw.Dim_Product p
    ON f.ProductKey = p.ProductKey

JOIN dw.Dim_Region r
    ON f.RegionKey = r.RegionKey;
GO