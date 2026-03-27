# 🚗 Zooper-Insurance-Policy-Analytics-Project

[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15+-336791?style=flat&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?style=flat&logo=powerbi&logoColor=black)](https://powerbi.microsoft.com/)
[![License](https://img.shields.io/badge/License-MIT-green?style=flat)](LICENSE)

A complete end-to-end automobile insurance portfolio simulation and analytics project — from data generation in PostgreSQL to interactive Power BI dashboards. Built to evaluate premium revenue, claims behavior, and portfolio risk exposure across a simulated book of **1,000,000 policies**.

---

## 📁 Repository Structure

```
├── Data_Simulation_and_Analytical_Queries.sql   # PostgreSQL data simulation + all analytical queries
├── Claims_Dataset.csv                           # Exported claims data (2025–2026)
├── Policy_Sales_Dataset.zip                     # Exported policy sales data (2024)
├── Insurance_Policy_Sales___Claims_Performance_Dashboard__2024_2026_.zip  # Power BI dashboard file (.pbix)
└── Insurance_Report.pdf                         # Full project report with findings and methodology
```

---

## 📌 Project Overview

This project simulates a realistic automobile insurance dataset and performs key actuarial and business analytics on it. The workflow covers:

1. **Data Simulation** — Generating 1M synthetic insurance policies and claim events using PostgreSQL
2. **Analytical Queries** — SQL queries answering six business-critical questions
3. **Visualization** — An interactive Power BI dashboard with slicers for dynamic analysis

---

## 🗄️ Data Simulation Methodology

### Policy Sales (`policy_sales` table)

| Attribute | Rule |
|---|---|
| Policies | 1,000,000 unique customers & vehicles |
| Policy Period | Distributed across all days of 2024 |
| Vehicle Value | ₹1,00,000 (fixed) |
| Premium | ₹100 × policy tenure (years) |
| Policy Start Date | Purchase Date + 365 days |
| Policy End Date | Start Date + Tenure |

**Tenure Distribution:**

| Tenure | Share |
|---|---|
| 1 Year | 20% |
| 2 Years | 30% |
| 3 Years | 40% |
| 4 Years | 10% |

### Claims (`claims_data` table)

**2025 Claims (Type 1)**
- Eligible vehicles: purchased on the **7th, 14th, 21st, or 28th** of any month
- **30%** of eligible vehicles filed a claim
- Claim date = Policy start date
- Claim amount = ₹10,000

**2026 Claims (Type 2)**
- Eligible policies: **4-year tenure** only
- **10%** of eligible policies filed a claim
- Claim period: **Jan 1 – Feb 28, 2026** (random date)
- Claim amount = ₹10,000

---

## 📊 Analytical Queries

The SQL file contains six analytical queries covering:

| # | Question |
|---|---|
| Q1 | Total premium collected during 2024 |
| Q2 | Total claim cost per year (2025–2026) with monthly breakdown |
| Q3 | Claim cost-to-premium ratio by policy tenure |
| Q4 | Claim cost-to-premium ratio by policy purchase month |
| Q5 | Estimated total potential claim liability (vehicles with no claim yet) |
| Q6 | Earned premium as of February 28, 2026 |

**Bonus:** Overall loss ratio calculation.

---

## 📈 Key Results

| Metric | Value |
|---|---|
| Total Premium Collected (2024) | ₹223.9 Million |
| Monthly Claims in 2025 | ₹31M – ₹33M |
| Earned Premium (as of Feb 28, 2026) | ₹65.9 Million |
| Estimated Future Claim Liability | ₹9.57 Billion |
| Total Claim Amount | ₹429 Million |
| Claim Loss Ratio | **1.92** |

---

## 📉 Dashboard

The Power BI dashboard (`Insurance_Policy_Sales___Claims_Performance_Dashboard__2024_2026_.zip`) provides an interactive view of portfolio performance.

**Visualizations included:**
- Claims by Policy Tenure
- Claim Ratio by Policy Purchase Month
- Monthly Claims Trend (2025–2026)
- Claim Type Distribution (Type 1 vs Type 2)

**Interactive Filters / Slicers:**
- Policy Tenure
- Claim Year
- Claim Type
- Purchase Month

---

## 🔍 Key Insights

- **Longer tenure → higher premium revenue.** 3-year policies contribute the largest share of income due to their 40% portfolio weight.
- **Monthly claim values in 2025 are stable**, indicating consistent claim occurrence patterns throughout the year.
- **Claim ratios are balanced across purchase months**, suggesting limited seasonal impact on claims.
- **Loss ratio of 1.92** indicates total claims significantly exceed premiums collected — highlighting the long-term risk exposure of multi-year policies.
- **₹9.57B in potential future liability** underscores the importance of actuarial reserves and risk management.

---

## 🛠️ Tech Stack

- **Database:** PostgreSQL 15+
- **Visualization:** Microsoft Power BI
- **Language:** SQL (PostgreSQL dialect)

---

## 🚀 Getting Started

### 1. Set up the database

```sql
CREATE DATABASE zooper_assignment;
```

### 2. Run the simulation & queries

Connect to `zooper_assignment` and execute `Data_Simulation_and_Analytical_Queries.sql` in order:

```bash
psql -U <your_user> -d zooper_assignment -f Data_Simulation_and_Analytical_Queries.sql
```

> ⚠️ Generating 1,000,000 rows may take a few minutes depending on your hardware.

### 3. Open the Dashboard

1. Unzip `Insurance_Policy_Sales___Claims_Performance_Dashboard__2024_2026_.zip`
2. Open the `.pbix` file in **Power BI Desktop**
3. Refresh the data source if prompted

---

## 📄 Report

See `Insurance_Report.pdf` for the complete write-up including methodology, findings, and dashboard screenshots.

---

## 📬 Contact

👩‍💻 **Isha Chaudhary**

📧 [ishachaudhary3928@gmail.com](mailto:ishachaudhary3928@gmail.com)

🔗 [LinkedIn](https://linkedin.com)

📍 Noida, India

