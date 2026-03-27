# 🚗 Zooper-Insurance-Policy-Analytics-Project

A comprehensive end-to-end insurance analytics project simulating a **1,000,000-policy automobile insurance portfolio** using PostgreSQL, with analytical insights visualized through an interactive Power BI dashboard.

---

## 📁 Repository Structure

```
├── Data_Simulation_and_Analytical_Queries.sql   # PostgreSQL data simulation + analytical queries
├── Claims_Dataset.csv                           # Exported claims data (~42,900 records)
├── policy sales dataset.zip                     # Exported policy data (~1,000,000 records)
├── Insurance_Policy_Sales___Claims_Performance_Dashboard__2024_2026_.zip  # Power BI dashboard
└── Insurance_Report.pdf                         # Full analytical report
```

---

## 📋 Project Overview

This project simulates a real-world automobile insurance portfolio to evaluate:
- **Premium revenue** generated across policy tenures
- **Claims behavior** by year, month, and tenure segment
- **Portfolio risk exposure** including future claim liabilities
- **Earned vs. unearned premium** recognition

The pipeline runs entirely in PostgreSQL for data generation and querying, with Power BI handling visualization.

---

## 🗄️ Data Simulation Methodology

### Policy Sales (`policy_sales` table)
- **1,000,000** synthetic vehicle insurance policies sold in 2024
- Policies distributed evenly across all 366 days of 2024
- Each policy has a unique `customer_id` and `vehicle_id`

| Field | Value |
|---|---|
| Vehicle Value | ₹1,00,000 |
| Premium | ₹100 × policy tenure (years) |
| Policy Start Date | Purchase Date + 365 days |
| Policy End Date | Start Date + Tenure |

**Tenure Distribution:**

| Tenure | Share |
|--------|-------|
| 1 Year | 20% |
| 2 Years | 30% |
| 3 Years | 40% |
| 4 Years | 10% |

### Claims (`claims_data` table)

**2025 Claims (Type 1)**
- Eligible vehicles: purchased on the **7th, 14th, 21st, or 28th** of any month
- **30%** of eligible vehicles file a claim
- Claim date = policy start date; claim amount = ₹10,000

**2026 Claims (Type 2)**
- Eligible vehicles: **4-year tenure policies only**
- **10%** of eligible vehicles file a claim
- Claims distributed randomly between **Jan 1 – Feb 28, 2026**

---

## 🔍 Analytical Queries

The SQL file contains 6 analytical queries plus a bonus loss ratio calculation:

| Query | Description |
|-------|-------------|
| **Q1** | Total premium collected during 2024 |
| **Q2** | Monthly claim cost breakdown for 2025 and 2026 |
| **Q3** | Claim cost-to-premium ratio by policy tenure |
| **Q4** | Claim cost-to-premium ratio by policy purchase month |
| **Q5** | Estimated total potential claim liability (unclaimed policies) |
| **Q6** | Earned premium as of February 28, 2026 |
| **Bonus** | Overall portfolio loss ratio |

---

## 📊 Key Results

| Metric | Value |
|--------|-------|
| Total Premium Collected (2024) | ₹223.9 Million |
| Total Claim Amount (2025–2026) | ₹429 Million |
| Claim Loss Ratio | **1.92** |
| Earned Premium (as of Feb 28, 2026) | ₹65.9 Million |
| Estimated Future Claim Liability | ₹9.57 Billion |

> ⚠️ A loss ratio > 1 indicates total claims exceed total premium collected — a signal for repricing or reserve adjustments.

---

## 📈 Power BI Dashboard

The `.pbix` file delivers an interactive **Insurance Policy Sales & Claims Performance Dashboard (2024–2026)** with:

- **KPI Cards** — Total Claim Amount, Total Premium, Claim Loss Ratio
- **Claims by Policy Tenure** — Bar chart comparing claim exposure across tenure segments
- **Claim Ratio by Policy Purchase Month** — Line chart across Jan–Dec 2024
- **Monthly Claims Trend** — Time series from Jan 2025 to Feb 2026
- **Claim Type Distribution** — Pie chart (Type 1 vs Type 2 claims)

**Interactive Slicers:** Policy Tenure · Claim Year · Claim Type · Purchase Month

---

## 🗂️ Dataset: Claims_Dataset.csv

Exported claims records with the following schema:

| Column | Type | Description |
|--------|------|-------------|
| `claim_id` | INT | Unique claim identifier |
| `customer_id` | INT | Customer reference |
| `vehicle_id` | INT | Vehicle reference |
| `claim_amount` | INT | Fixed at ₹10,000 per claim |
| `claim_date` | DATE | Date the claim was filed |
| `claim_type` | INT | 1 = 2025 claim, 2 = 2026 claim |

**Total Records:** ~42,900 claims

---

## 🚀 Getting Started

### Prerequisites
- PostgreSQL 13+
- Power BI Desktop (for `.pbix` file)

### Running the SQL
```sql
-- 1. Create the database
CREATE DATABASE zooper_assignment;

-- 2. Connect to the database, then run the full script
\c zooper_assignment
\i Data_Simulation_and_Analytical_Queries.sql
```

> ⚠️ The INSERT statements generate 1,000,000 rows using `generate_series`. Execution may take a few minutes depending on hardware.

---

## 💡 Key Insights

- **3-year policies** contribute the largest share of premium income due to their 40% portfolio share
- **Monthly claims in 2025** remain stable between ₹31M–₹33M, reflecting consistent claim patterns
- **Claim ratios are broadly consistent** across purchase months, suggesting low seasonality in claims
- **4-year and 1-year tenure policies** exhibit relatively higher claim exposure per premium rupee
- The **₹9.57B potential liability** underscores the importance of actuarial reserves for long-tail exposure

---

## 🛠️ Tech Stack

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-336791?style=flat&logo=postgresql&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=flat&logo=powerbi&logoColor=black)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=flat&logo=mysql&logoColor=white)

---

## 📄 Report

A full written analysis is available in [`Insurance_Report.pdf`](./Insurance_Report.pdf), covering the simulation methodology, analytical framework, dashboard overview, and business insights.
