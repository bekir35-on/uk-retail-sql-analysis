# UK Retail Sales — SQL Analysis (PostgreSQL)

End-to-end SQL analysis of a UK retail dataset (**6,200 orders, Jan 2023 – Dec 2025**),
written in **PostgreSQL** and developed in **DBeaver**. The project cleans the raw data,
then answers the core commercial questions a retailer cares about: revenue, profit,
product mix, geography, trend over time, and most valuable customers.

**Author:** Bekir Onal
**Tools:** PostgreSQL 18 · DBeaver · SQL

---

## Dataset

| | |
|---|---|
| Rows | 6,200 orders |
| Period | January 2023 – December 2025 |
| Columns | 17 — order & ship dates, ship mode, customer, segment, country, region, city, category, sub-category, product, **sales, quantity, discount, profit** |

The raw CSV was imported with all columns as text. A clean analysis table
(`sales`) was created with tidy `snake_case` names and proper `DATE` types
(see section 0 of the SQL file).

## How to run

1. Create a PostgreSQL database and import the source CSV into a table named `uk_retail_sales`.
2. Open `uk_retail_sales_analysis.sql` and run it top to bottom in DBeaver (or any PostgreSQL client).
3. Section 0 builds the clean `sales` table; sections 1–5 are the analyses.

---

## Business questions & key findings

### 1. Headline KPIs
- **Revenue: £8.17M** · **Profit: £0.57M** → overall margin **~7%**
- **6,200 orders**, average order value **~£1,318**

### 2. Revenue & profit by category
| Category | Revenue | Profit | Margin |
|---|--:|--:|--:|
| Technology | £5.24M | £460K | ~8.8% |
| Furniture | £2.66M | £78K | **~2.9%** |
| Office Supplies | £0.27M | £33K | **~12.2%** |

**Technology is the engine** (≈64% of revenue and the most profit). **Furniture**
sells heavily but on a very thin margin. **Office Supplies** is small but the
healthiest margin.

### 3. Revenue & profit by region
Revenue is **well balanced** across the 8 UK regions (£0.93M–£1.09M each).
**South East** leads on revenue; **Scotland** is the **most profitable** region
(£83.8K); **London** is lower than expected.

### 4. Monthly revenue trend
36 months of data, ~£183K–£294K per month. **2025 runs clearly higher than 2023–24**
— an accelerating upward trend. **Peak month: March 2025 (£293,666).**

### 5. Top 10 most valuable customers
Led by **Oliver Jones (£161K across 110 orders)**. Each of the top 10 is worth
**£88K–£161K** — a small group drives a large share of revenue.

---

## Recommendations
- **Double down on Technology** — it is both the biggest and most profitable category.
- **Fix Furniture margins** — strong revenue but ~3% margin; review pricing, discounting and cost of the worst sub-categories.
- **Grow Office Supplies volume** — best margin (~12%) but low revenue; room to scale.
- **Protect top accounts** — the top 10 customers are disproportionately valuable; prioritise retention.
- **Ride the 2025 momentum** — growth is accelerating; invest into the strongest months/regions (e.g. learn from Scotland's profitability).

---

*Analysis in `uk_retail_sales_analysis.sql`. Visual dashboards (Tableau / Power BI) accompany this repo.*
