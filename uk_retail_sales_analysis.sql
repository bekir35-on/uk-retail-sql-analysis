/* ============================================================
   UK Retail Sales — SQL Analysis
   Author : Bekir Onal
   Engine : PostgreSQL 18  (developed in DBeaver)
   Data   : UK Retail Sales — 6,200 orders, Jan 2023 – Dec 2025
            17 columns (orders, customers, products, geography,
            sales, quantity, discount, profit)
   Purpose: Answer core commercial questions a retailer cares
            about — revenue, profit, product mix, geography,
            trend over time, and most valuable customers.
   Note   : # comments describe the business question and the
            key finding for each query.
   ============================================================ */


/* ------------------------------------------------------------
   0) DATA PREPARATION (cleaning / typing)
   Raw CSV was imported into "uk_retail_sales" with every column
   as text. Here we build a clean analysis table "sales" with
   snake_case names and proper DATE types for the date columns.
   (Numeric columns were already imported as numbers.)
   ------------------------------------------------------------ */
DROP TABLE IF EXISTS sales;

CREATE TABLE sales AS
SELECT
  "Order ID"         AS order_id,
  "Order Date"::date AS order_date,
  "Ship Date"::date  AS ship_date,
  "Ship Mode"        AS ship_mode,
  "Customer ID"      AS customer_id,
  "Customer Name"    AS customer_name,
  "Segment"          AS segment,
  "Country"          AS country,
  "Region"           AS region,
  "City"             AS city,
  "Category"         AS category,
  "Sub-Category"     AS sub_category,
  "Product Name"     AS product_name,
  "Sales"            AS sales,
  "Quantity"         AS quantity,
  "Discount"         AS discount,
  "Profit"           AS profit
FROM uk_retail_sales;


/* ------------------------------------------------------------
   1) HEADLINE KPIs
   Q: What are the overall business numbers?
   Finding: Revenue £8.17M, Profit £0.57M (~7% margin),
            6,200 orders, avg order value ~£1,318.
   ------------------------------------------------------------ */
SELECT
  ROUND(SUM(sales))        AS total_revenue,
  ROUND(SUM(profit))       AS total_profit,
  COUNT(DISTINCT order_id) AS total_orders,
  SUM(quantity)            AS total_items,
  ROUND(SUM(sales) / COUNT(DISTINCT order_id)) AS avg_order_value
FROM sales;


/* ------------------------------------------------------------
   2) REVENUE & PROFIT BY CATEGORY
   Q: Which product category drives revenue and profit?
   Finding: Technology leads on both (£5.24M rev / £0.46M profit,
            ~64% of revenue). Furniture sells a lot but margin is
            very thin (~2.9%). Office Supplies is small but the
            healthiest margin (~12%).
   ------------------------------------------------------------ */
SELECT
  category,
  ROUND(SUM(sales))  AS revenue,
  ROUND(SUM(profit)) AS profit,
  COUNT(*)           AS orders
FROM sales
GROUP BY category
ORDER BY revenue DESC;


/* ------------------------------------------------------------
   3) REVENUE & PROFIT BY REGION
   Q: How is performance spread across the UK?
   Finding: Revenue is well balanced across 8 regions
            (£0.93M–£1.09M). South East tops revenue; Scotland is
            the most PROFITABLE region (£83.8K). London is lower
            than expected.
   ------------------------------------------------------------ */
SELECT
  region,
  ROUND(SUM(sales))  AS revenue,
  ROUND(SUM(profit)) AS profit,
  COUNT(*)           AS orders
FROM sales
GROUP BY region
ORDER BY revenue DESC;


/* ------------------------------------------------------------
   4) MONTHLY REVENUE TREND
   Q: How does revenue move over time?
   Finding: 36 months of data (Jan 2023–Dec 2025), ~£183K–£294K
            per month. 2025 months run clearly higher than
            2023/24 — an accelerating upward trend. Peak month:
            March 2025 (£293,666).
   ------------------------------------------------------------ */
SELECT
  DATE_TRUNC('month', order_date) AS month,
  ROUND(SUM(sales)) AS revenue,
  COUNT(*)          AS orders
FROM sales
GROUP BY month
ORDER BY month;


/* ------------------------------------------------------------
   5) TOP 10 MOST VALUABLE CUSTOMERS
   Q: Who are the customers the business most depends on?
   Finding: Oliver Jones is #1 (£161K across 110 orders — high
            spend AND high frequency). Each of the top 10 is worth
            £88K–£161K — a small group drives a large share of
            revenue, so retention of these accounts matters.
   ------------------------------------------------------------ */
SELECT
  customer_name,
  ROUND(SUM(sales))        AS revenue,
  COUNT(DISTINCT order_id) AS orders
FROM sales
GROUP BY customer_name
ORDER BY revenue DESC
LIMIT 10;
