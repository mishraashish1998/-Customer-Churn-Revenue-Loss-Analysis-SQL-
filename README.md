
# 📉 Customer Churn & Revenue Loss Analysis (SQL + PostgreSQL)

This project analyzes customer churn behavior and its financial impact using real-world style SQL queries. It simulates how a company like **StreamFlow**, a subscription-based digital services company, can use SQL to identify churn patterns, quantify lost revenue, and improve retention strategy.

---

## 📌 Project Overview

**Database Name**: `churn_analysis`  
**Tables Involved**:  
- `customers`  
- `subscriptions`  
- `transactions`

---

## 🎯 Objectives

- Set up a normalized SQL database with customer and transaction data.
- Perform data exploration and identify customer churn patterns.
- Use SQL queries to answer critical business questions.
- Quantify revenue lost due to churn.
- Highlight customer segments and behavior for retention decisions.

---

## 🗂️ Database Setup

### Step 1: Create Tables

```sql
-- Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    signup_date DATE,
    gender VARCHAR(10),
    age INT,
    region VARCHAR(50),
    status VARCHAR(10),
    last_active_date DATE
);

-- Subscriptions Table
CREATE TABLE subscriptions (
    subscription_id VARCHAR(10) PRIMARY KEY,
    customer_id INT,
    plan VARCHAR(20),
    start_date DATE,
    end_date DATE,
    is_active VARCHAR(5)
);

-- Transactions Table
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    amount FLOAT,
    transaction_date DATE,
    product_category VARCHAR(50)
);
