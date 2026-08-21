# E-Commerce Profit Leakage Analysis

## 📌 Project Overview

An end-to-end data analytics project investigating why an e-commerce business generates substantial revenue but experiences significant profit leakage.
The project combines **SQL, Python, and Power BI** to identify loss-making products, investigate discount-driven losses, validate the financial impact, identify the likely root cause, and provide business recommendations

> **Note:** This project uses a synthetic e-commerce dataset created for portfolio and analytical purposes.

---

## 🎯 Business Problem
The business was generating significant sales revenue but experiencing substantial negative profitability.
The investigation focused on answering:

- Why is the company losing money despite generating high revenue?
- Which products contribute most to the losses?
- How do discounts affect profitability?
- At what discount levels does profitability become negative?
- Are high-discount transactions widespread?
- What is the likely root cause of the profit leakage?
- What actions can management take to prevent future losses?

---

## 🛠️ Tools & Technologies
- **Python:** Pandas, NumPy, Matplotlib
- **SQL:** MySQL
- **Visualization:** Power BI
- **Environment:** Google Colab
- **Version Control:** GitHub

---

## 🔍 Analysis Approach

Raw Data
   ↓
Data Cleaning & Validation
   ↓
SQL Analysis
   ↓
Python Exploratory Analysis
   ↓
Product & Profitability Analysis
   ↓
Discount Analysis
   ↓
Root-Cause Investigation
   ↓
Power BI Dashboard
   ↓
Business Recommendations

---

## Overall Financial Performance
Metric	Result
Total Revenue	₹416.15 Cr
Total Profit	-₹137.22 Cr
Overall Profit Margin	-32.97%

Despite generating substantial revenue, the business recorded significant negative profitability.

---

## High-Discount Transactions
Transactions with discounts of 30% or more were analyzed separately.
198,517 high-discount order items
320,138 units
₹246.56 Cr revenue
₹134.69 Cr loss

This indicates that aggressive discounting was widespread rather than limited to a few transactions.

---

## Discount vs Profitability
Average margin after discount:
Discount	Avg. Margin
0%	28.76%
5%	17.99%
10%	23.66%
15%	21.92%
20%	15.74%
25%	1.26%
30%	-6.22%
40%	-24.65%
50%	-54.77%

Although lower discount levels fluctuate because different products have different cost structures, profitability deteriorates sharply from approximately 25–30% discount onwar
At 30% and above, average margins become negative.

---

## Root Cause
Inadequate Margin-Based Discount Governance

The analysis indicates that discount levels were not sufficiently aligned with product-level cost and margin economics.

High discount levels were applied at significant scale even when the resulting selling price could fall below product cost.

The analysis does not claim that the company had no approval system because the dataset does not contain management approval or audit records.

Instead, the evidence indicates that existing discount controls were not effectively preventing or identifying significant negative-margin transactions.

---

## Business Recommendations
1. Introduce Margin-Based Discount Limits
Set maximum allowable discounts based on each product's cost and current margin.

2. Implement Automated Discount Controls
Before applying a discount, calculate the expected selling price after discount and compare it with product cost.
Discounts that result in below-cost selling should be blocked or require additional approval.

3. Monitor High-Discount Transactions
Create automated alerts for products receiving sustained high discounts, particularly 30%+.

4. Strengthen Promotion Controls
Enforce promotion start and end dates automatically so discounts cannot remain active beyond their intended campaign period.

5. Monitor Profitability Alongside Revenue
Management dashboards should monitor:
Revenue → Discount → Cost → Profit → Margin
rather than evaluating discounts based only on sales volume or revenue.

---

## Project Structure

ecommerce-profit-leakage-analysis/
│
├── data/
│   └── ecommerce_dataset.zip
│
├── notebooks/
│   └── E-commerce_Profit_Leakage_Analysis.ipynb
│
├── sql/
│   └── Analysis_Queries.sql
│
├── powerbi/
│   └── E-commerce_Profit_Leakage_Dashboard.pbix
│
├── images/
│   ├── dashboard_page1.png
│   ├── dashboard_page2.png
│   └── dashboard_page3.png
│
└── README.md

---

## Skills Demonstrated

Data Cleaning & Validation
Exploratory Data Analysis
SQL
Python / Pandas
Profitability Analysis
Discount Analysis
Root-Cause Analysis
Power BI
Data Visualization
KPI Development
Business Storytelling
Business Recommendations

---

## Final Takeaway

The investigation shows that significant profit leakage was associated with widespread high-discount transactions.

The key business lesson is:
Discount decisions should be driven by product-level margin economics rather than discount percentage or sales volume alone.








