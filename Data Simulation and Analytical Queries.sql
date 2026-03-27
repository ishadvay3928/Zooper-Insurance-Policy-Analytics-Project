/* =========================================================
   Data Simulation + Analytical Queries
   PostgreSQL Implementation
   ========================================================= */


/* =========================================================
   1. CREATE DATABASE
   ========================================================= */

CREATE DATABASE zooper_assignment;


/* =========================================================
   2. CREATE POLICY SALES TABLE
   Stores simulated policy sales data for 2024
   ========================================================= */

CREATE TABLE policy_sales (
    customer_id INT,
    vehicle_id INT,
    vehicle_value INT,
    policy_tenure INT,
    premium INT,
    policy_purchase_date DATE,
    policy_start_date DATE,
    policy_end_date DATE
);


/* =========================================================
   3. INSERT SIMULATED POLICY DATA
   - Generate 1,000,000 customers
   - Policies distributed across 2024
   - Tenure distribution:
        20% → 1 year
        30% → 2 years
        40% → 3 years
        10% → 4 years
   ========================================================= */

INSERT INTO policy_sales (customer_id,vehicle_id,vehicle_value,policy_tenure,premium,policy_purchase_date,policy_start_date,policy_end_date)

SELECT
    id AS customer_id,
    id AS vehicle_id,

    100000 AS vehicle_value,

    tenure AS policy_tenure,

    tenure * 100 AS premium,

    purchase_date AS policy_purchase_date,

    purchase_date + INTERVAL '365 days' AS policy_start_date,

    purchase_date + INTERVAL '365 days' +
    (tenure || ' years')::INTERVAL AS policy_end_date

FROM (

    SELECT
        generate_series(1,1000000) AS id,

        DATE '2024-01-01' + (generate_series(1,1000000) % 366) AS purchase_date,

        CASE
            WHEN random() < 0.20 THEN 1
            WHEN random() < 0.50 THEN 2
            WHEN random() < 0.90 THEN 3
            ELSE 4
        END AS tenure

) t;


/* =========================================================
   4. VERIFY POLICY DATA
   ========================================================= */

SELECT * FROM policy_sales;


/* =========================================================
   5. CREATE CLAIMS TABLE
   ========================================================= */

CREATE TABLE claims_data (
    claim_id SERIAL PRIMARY KEY,
    customer_id INT,
    vehicle_id INT,
    claim_amount INT,
    claim_date DATE,
    claim_type INT
);


/* =========================================================
   6. INSERT CLAIMS FOR YEAR 2025
   Rules:
   - Vehicles purchased on 7th, 14th, 21st, 28th
   - 30% probability of claim
   - Claim occurs on policy start date
   ========================================================= */

INSERT INTO claims_data (customer_id,vehicle_id,claim_amount,claim_date,claim_type)

SELECT
    customer_id,
    vehicle_id,

    10000 AS claim_amount,

    policy_start_date AS claim_date,

    1 AS claim_type

FROM policy_sales

WHERE EXTRACT(DAY FROM policy_purchase_date) IN (7,14,21,28)
AND random() <= 0.30;


/* =========================================================
   7. INSERT CLAIMS FOR YEAR 2026
   Rules:
   - 10% of vehicles with 4-year tenure
   - Claims between Jan 1 and Feb 28 2026
   ========================================================= */

INSERT INTO claims_data (customer_id,vehicle_id,claim_amount,claim_date,claim_type)

SELECT
    customer_id,
    vehicle_id,

    10000 AS claim_amount,

    DATE '2026-01-01' + (random()*58)::INT AS claim_date,

    2 AS claim_type

FROM policy_sales

WHERE policy_tenure = 4
AND random() <= 0.10;


/* =========================================================
   8. VERIFY CLAIM DATA
   ========================================================= */

SELECT * FROM claims_data;


/* =========================================================
   ANALYTICAL QUERIES
   ========================================================= */


/* =========================================================
   Q1. Calculate the total premium collected during the year 2024
   ========================================================= */

SELECT
    SUM(premium) AS total_premium_2024
FROM policy_sales;



/* =========================================================
   Q2. Calculate the total claim cost for each year (2025 and 2026) with a monthly breakdown.
   ========================================================= */

SELECT
    EXTRACT(YEAR FROM claim_date) AS claim_year,
    EXTRACT(MONTH FROM claim_date) AS claim_month,
    SUM(claim_amount) AS total_claim_cost
FROM claims_data
GROUP BY claim_year, claim_month
ORDER BY claim_year, claim_month;



/* =========================================================
   Q3. Calculate the claim cost to premium ratio for each policy tenure (1, 2, 3, and 4 years).
   ========================================================= */

SELECT
p.policy_tenure,

SUM(c.claim_amount) /
SUM(p.premium) AS claim_ratio

FROM policy_sales p
LEFT JOIN claims_data c
ON p.vehicle_id = c.vehicle_id

GROUP BY p.policy_tenure
ORDER BY p.policy_tenure;



/* =========================================================
   Q4. Calculate the claim cost to premium ratio by the month in which the policy was sold
       (January–December 2024).
   ========================================================= */

SELECT

EXTRACT(MONTH FROM p.policy_purchase_date) AS sale_month,

SUM(c.claim_amount) /
SUM(p.premium) AS claim_ratio

FROM policy_sales p

LEFT JOIN claims_data c
ON p.vehicle_id = c.vehicle_id

GROUP BY sale_month
ORDER BY sale_month;



/* =========================================================
   Q5. If every vehicle that has not yet made a claim eventually files exactly one claim during the
       remaining policy tenure, estimate the total potential claim liability.
   ========================================================= */

SELECT
COUNT(*) * 10000 AS potential_liability

FROM policy_sales p

LEFT JOIN claims_data c
ON p.vehicle_id = c.vehicle_id

WHERE c.vehicle_id IS NULL;

/* =========================================================
   Q6. Calculate the premium already earned by the company up to February 28, 2026
   ========================================================= */

SELECT
SUM(
    premium / (policy_tenure * 365.0)
    *
    GREATEST(
        0,
        LEAST(policy_end_date, DATE '2026-02-28')
        - policy_start_date
    )
) AS earned_premium
FROM policy_sales;


/* =========================================================
   BONUS ANALYSIS
   ========================================================= */


/* LOSS RATIO */

SELECT
    SUM(claim_amount) /
    (SELECT SUM(premium) FROM policy_sales) AS loss_ratio
FROM claims_data;

