/* =============================================
   STAGING VALIDATION QUERIES
   Project: BI_SmallBiz_Ecomm
   Purpose: Validate raw staging data quality
============================================= */

-- 1. Row Count Validation
SELECT COUNT(*) AS Row_Count
FROM stg.Raw_EcommSales;
GO

-- 2. Null Check – Critical Fields
SELECT
  SUM(CASE WHEN OrderID IS NULL OR LTRIM(RTRIM(OrderID)) = '' THEN 1 ELSE 0 END) AS Missing_OrderID,
  SUM(CASE WHEN OrderDate IS NULL OR LTRIM(RTRIM(OrderDate)) = '' THEN 1 ELSE 0 END) AS Missing_OrderDate,
  SUM(CASE WHEN SKU IS NULL OR LTRIM(RTRIM(SKU)) = '' THEN 1 ELSE 0 END) AS Missing_SKU,
  SUM(CASE WHEN Quantity IS NULL OR LTRIM(RTRIM(Quantity)) = '' THEN 1 ELSE 0 END) AS Missing_Quantity,
  SUM(CASE WHEN UnitPrice IS NULL OR LTRIM(RTRIM(UnitPrice)) = '' THEN 1 ELSE 0 END) AS Missing_UnitPrice
FROM stg.Raw_EcommSales;
GO

-- 3. Duplicate Detection (Grain Validation)
SELECT OrderID, LineID, COUNT(*) AS DupCount
FROM stg.Raw_EcommSales
GROUP BY OrderID, LineID
HAVING COUNT(*) > 1
ORDER BY DupCount DESC;
GO

-- 4. Date Range Validation
SELECT 
    MIN(OrderDate) AS Min_OrderDate,
    MAX(OrderDate) AS Max_OrderDate
FROM stg.Raw_EcommSales;
GO
