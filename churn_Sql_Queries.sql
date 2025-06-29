-- Database: churn_analysis

DROP DATABASE IF EXISTS churn_analysis;

CREATE DATABASE churn_analysis;
    
-- Customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    signup_date DATE,
    gender VARCHAR(10),
    age INT,
    region VARCHAR(50),
    status VARCHAR(10),
    last_active_date DATE
);

-- Subscriptions table
CREATE TABLE subscriptions (
    subscription_id VARCHAR(10) PRIMARY KEY,
    customer_id INT,
    plan VARCHAR(20),
    start_date DATE,
    end_date DATE,
    is_active VARCHAR(5)
);

-- Transactions table
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    amount FLOAT,
    transaction_date DATE,
    product_category VARCHAR(50)
);

select *  from transactions Limit 10;

-- DATA CLEANING

ALTER TABLE customers
ALTER COLUMN age TYPE FLOAT USING age::FLOAT;

-- Remove future signup dates

DELETE FROM customers
WHERE signup_date > CURRENT_DATE;

-- Standardize gender values

UPDATE customers SET gender = 'Male' WHERE TRIM(LOWER(gender)) IN ('male', 'm', ' male');
UPDATE customers SET gender = 'Female' WHERE TRIM(LOWER(gender)) IN ('female', 'fem');

-- Remove invalid or missing age

DELETE FROM customers
WHERE age IS NULL OR age <= 0;

--  Remove NULL values in gender or region

DELETE FROM customers
WHERE gender IS NULL OR region IS NULL;

-- Fix plan typos

UPDATE subscriptions SET plan = 'Standard' WHERE plan ILIKE 'standrd';
UPDATE subscriptions SET plan = 'Premium' WHERE plan ILIKE 'premum';

-- Remove invalid subscription dates (end date before start)

DELETE FROM subscriptions
WHERE end_date < start_date;

DELETE FROM transactions
WHERE amount IS NULL OR amount = 0;

-- Fix typos in product_category

UPDATE transactions SET product_category = 'Streaming' WHERE product_category ILIKE 'streeming';
UPDATE transactions SET product_category = 'Cloud Storage' WHERE product_category ILIKE 'clud storage';

-- What is the overall churn rate?

SELECT 
  COUNT(*) AS total_customers,
  COUNT(*) FILTER (WHERE status = 'Churned') AS churned_customers,
  ROUND(100.0 * COUNT(*) FILTER (WHERE status = 'Churned') / COUNT(*), 2) AS churn_rate_percentage
FROM customers;

-- How many customers churned by subscription plan?

SELECT 
  s.plan,
  COUNT(c.customer_id) AS total_customers,
  COUNT(*) FILTER (WHERE c.status = 'Churned') AS churned_customers
FROM subscriptions s
JOIN customers c ON c.customer_id = s.customer_id
GROUP BY s.plan;
UPDATE subscriptions
SET plan = 'Unknown'
WHERE plan IS NULL;

-- How much revenue did we lose due to churned customers?

SELECT 
  ROUND(SUM(t.amount)::NUMERIC, 2) AS lost_revenue
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
WHERE c.status = 'Churned';

-- Which regions have the highest churn?

SELECT 
  region,
  COUNT(*) AS total_customers,
  COUNT(*) FILTER (WHERE status = 'Churned') AS churned_customers,
  ROUND(100.0 * COUNT(*) FILTER (WHERE status = 'Churned') / COUNT(*), 2) AS churn_rate
FROM customers
WHERE region IS NOT NULL
GROUP BY region
ORDER BY churn_rate DESC;

-- what is Monthly churn trend (How churn changes over time)?

SELECT 
  DATE_TRUNC('month', c.last_active_date) AS month,
  COUNT(*) FILTER (WHERE status = 'Churned') AS churned_customers
FROM customers c
WHERE c.last_active_date IS NOT NULL
GROUP BY month
ORDER BY month;

-- How many Active customers vs churned?

SELECT 
  status,
  COUNT(*) AS total_customers
FROM customers
GROUP BY status;

-- What plans churned the most?

SELECT 
  s.plan,
  COUNT(*) FILTER (WHERE c.status = 'Churned') AS churned_customers
FROM subscriptions s
JOIN customers c ON s.customer_id = c.customer_id
GROUP BY s.plan
ORDER BY churned_customers DESC;

-- Average transaction amount per churned customer

SELECT 
  ROUND(AVG(total_amount)::NUMERIC, 2) AS avg_spent_by_churned
FROM (
  SELECT t.customer_id, SUM(t.amount) AS total_amount
  FROM transactions t
  JOIN customers c ON c.customer_id = t.customer_id
  WHERE c.status = 'Churned'
  GROUP BY t.customer_id
) AS churned_totals;

-- Top 3 most purchased product categories by churned customers

SELECT 
  t.product_category,
  COUNT(*) AS total_transactions
FROM transactions t
JOIN customers c ON c.customer_id = t.customer_id
WHERE c.status = 'Churned'
GROUP BY t.product_category
ORDER BY total_transactions DESC
LIMIT 3;

