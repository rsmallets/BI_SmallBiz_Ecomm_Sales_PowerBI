README.md
# E-Commerce Sales Performance BI Project

## Project Overview



This project demonstrates the development of an end-to-end Business Intelligence solution for analyzing e-commerce sales performance. The objective was to transform raw transactional sales data into a structured analytics model and deliver an executive-level dashboard for business decision-making.

The workflow includes data ingestion, SQL-based data validation and transformation, dimensional modeling using a star schema, and interactive visualization using Power BI.

This project simulates a common real-world BI workflow used by data analysts and BI developers.

---

# Project Highlights

• Designed a dimensional star schema data model for analytical reporting  
• Built SQL staging, validation, and transformation layers  
• Developed a Power BI executive dashboard for sales performance analysis  
• Implemented KPI tracking including Revenue, Profit, and Margin  
• Created a reusable BI reporting view for dashboard integration

# Dashboard Preview

The final Power BI dashboard provides an executive-level overview of sales performance across time, product categories, regions, and sales channels.

![Dashboard](06_Documentation/SmallBiz_Ecomm_Sales_Dashboard.pdf)

---

# Business Problem

E-commerce companies generate large volumes of transactional data across multiple channels, products, and geographic regions. Without a structured analytics model, it becomes difficult for stakeholders to quickly answer key questions such as:

- How is revenue trending over time?
- Which product categories drive the most sales?
- Which regions generate the highest revenue?
- Which products contribute most to overall performance?
- Which sales channels are most effective?

The goal of this project was to design a data model and dashboard that enables stakeholders to quickly analyze sales performance and identify business insights.

---

# Data Pipeline Architecture

The project follows a simplified Business Intelligence architecture commonly used in analytics environments.

---

Raw CSV Data
│
▼
SQL Staging Table
│
▼
Data Validation Queries
│
▼
Cleaned Staging View
│
▼
Star Schema Data Warehouse
│
▼
Reporting View
│
▼
Power BI Executive Dashboard


---

# Dataset

The dataset represents simulated e-commerce sales transactions and includes fields such as:

- OrderID
- LineID
- OrderDate
- CustomerName
- Region
- Product
- Category
- Quantity
- UnitPrice
- UnitDiscount
- Shipping
- Tax
- SalesChannel
- PaymentMethod
- OrderStatus

Each row represents a single order line item.

---

# SQL Data Modeling

The data model was built using SQL Server and structured into multiple stages to ensure data quality and maintainability.

## Staging Layer

Raw data was imported into a staging table:


stg.Raw_EcommSales


This layer preserves the raw dataset exactly as ingested.

---

## Data Validation

SQL validation queries were used to verify data quality, including:

- Missing values
- Duplicate order lines
- Date range validation
- Field consistency checks

Example validation checks include:


Missing OrderID
Missing OrderDate
Missing SKU
Missing Quantity
Missing UnitPrice
Duplicate OrderID + LineID


---

## Cleaned Staging View

A cleaned staging view was created to standardize data types and prepare the dataset for dimensional modeling.


stg.vw_Clean_EcommSales


Key transformations include:

- Converting string dates to proper date types
- Standardizing numeric fields
- Preparing measures for aggregation

---

# Dimensional Data Model

A **star schema** was implemented to support efficient analytical queries.

---

# Star Schema Model

          Dim_Date
             │
             │

Dim_Product ── Fact_Sales ── Dim_Region

---

Fact_Sales stores transactional metrics while dimension tables provide descriptive attributes used for filtering and grouping during analysis.

---

## Dimension Tables

### Dim_Date

Calendar dimension used for time-based analysis.

Columns include:

- Date
- Year
- Quarter
- Month
- MonthName
- YearMonth

---

### Dim_Product

Product attributes used for category-level analysis.

Columns include:

- SKU
- ProductName
- Category

---

### Dim_Region

Geographic and channel attributes used for filtering and grouping.

Columns include:

- Region
- ShipState
- SalesChannel
- PaymentMethod
- OrderStatus

---

## Fact Table

### Fact_Sales

Contains the transactional sales measures.

Metrics include:

- Quantity
- UnitPrice
- UnitDiscount
- UnitCOGS
- Shipping
- Tax
- NetSales
- COGS
- GrossProfit
- GrossMarginPct

The fact table connects to all dimension tables through surrogate keys.

---

# Reporting Layer

A reporting view was created to simplify Power BI integration.


rpt.vw_Sales_Executive


This view joins the fact and dimension tables into a flattened dataset optimized for BI reporting.

---

# Power BI Dashboard

An executive dashboard was built to provide a high-level overview of sales performance.

## KPI Metrics

- Total Revenue
- Units Sold
- Total Profit
- Profit Margin %

---

## Visualizations

**Revenue Trend**  
Monthly revenue performance over time.

**Revenue by Category**  
Comparison of revenue across product categories.

**Revenue by Region**  
Geographic revenue distribution.

**Top Products by Revenue**  
Top performing products ranked by revenue.

**Revenue by Sales Channel**  
Comparison of performance across sales platforms.

---

## Dashboard Filters

Users can dynamically filter the dashboard using:

- Year
- Region
- Sales Channel
- Product Category

---

# Example Insights

Example insights that stakeholders can derive from the dashboard include:

- The **Wellness category** drives the majority of revenue.
- The **West region** generates the highest total sales.
- **Instagram and Website channels** outperform Amazon in this dataset.
- A small number of products contribute disproportionately to total revenue.

---

# Tools & Technologies

- SQL Server
- Power BI
- Dimensional Modeling
- Data Validation with SQL
- Star Schema Design

---

# Repository Structure

```text
BI_SmallBiz_Ecomm_Sales_PowerBI
│
├── README.md
│
├── 00_Admin
├── 01_Raw_Data
├── 02_Data_Cleanup
├── 03_SQL_Model
│   │
│   ├── 01_create_staging.sql
│   ├── 02_staging_validation_queries.sql
│   ├── 03_cleaned_staging_view.sql
│   ├── 04_star_schema_tables.sql
│   ├── 05_load_star_schema.sql
│   ├── 06_reporting_view.sql
│   │
│   └── validation
│       ├── VerifyStarSchema.sql
│       ├── VerifyTableCounts.sql
│       └── VerifyExecView.sql
│
├── 04_PowerBI
├── 05_Deliverables
├── 06_Documentation
└── 07_Assets


---

# Project Outcome

This project demonstrates the complete BI development lifecycle:

- Raw data ingestion
- Data validation and transformation
- Dimensional modeling
- Data warehouse design
- Executive dashboard creation

The final output is a clean and interactive dashboard enabling stakeholders to quickly evaluate sales performance across multiple business dimensions.

---

# Future Improvements

Possible enhancements to this project include:

- Adding a customer dimension for customer segmentation
- Building cohort or retention analysis
- Implementing incremental data loads
- Deploying the pipeline to a cloud data platform

---

# Author

Ryan Smallets

Business Intelligence & Data Analytics Portfolio Project