/* ==========================================================
   FILE: 03_cleaned_staging_view.sql
   PROJECT: BI_SmallBiz_Ecomm
   PURPOSE: Standardize and convert raw staging data
========================================================== */

USE BI_SmallBiz_Ecomm;
GO

-- Drop view if it already exists
IF OBJECT_ID('stg.vw_Clean_EcommSales','V') IS NOT NULL
    DROP VIEW stg.vw_Clean_EcommSales;
GO

CREATE VIEW stg.vw_Clean_EcommSales AS

SELECT
    OrderID,
    LineID,

    -- Convert OrderDate to proper DATE
    TRY_CONVERT(DATE, OrderDate) AS OrderDate,

    -- Convert ShipDate to proper DATE
    TRY_CONVERT(DATE, ShipDate) AS ShipDate,

    CustomerName,
    ShipState,
    Region,
    SKU,
    ProductName,
    Category,

    -- Convert Quantity to INT
    TRY_CONVERT(INT, Quantity) AS Quantity,

    -- Remove $ and convert to DECIMAL
    TRY_CONVERT(DECIMAL(12,2),
        REPLACE(UnitPrice,'$','')
    ) AS UnitPrice,

    TRY_CONVERT(DECIMAL(12,2),
        REPLACE(UnitDiscount,'$','')
    ) AS UnitDiscount,

    TRY_CONVERT(DECIMAL(12,2),
        REPLACE(UnitCOGS,'$','')
    ) AS UnitCOGS,

    TRY_CONVERT(DECIMAL(12,2),
        REPLACE(Shipping,'$','')
    ) AS Shipping,

    TRY_CONVERT(DECIMAL(12,2),
        REPLACE(Tax,'$','')
    ) AS Tax,

    SalesChannel,
    PaymentMethod,
    OrderStatus

FROM stg.Raw_EcommSales;
GO
