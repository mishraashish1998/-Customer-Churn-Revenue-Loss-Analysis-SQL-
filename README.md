# 📊 Customer Churn & Revenue Loss Analysis (SQL + PostgreSQL)

This project analyzes customer churn behavior and its financial impact using real-world style SQL queries. It simulates how a company like **StreamFlow**, a SaaS-based subscription business, can use data to identify churn patterns and drive retention strategies.

---

## 🧠 Project Objectives

- Analyze churn patterns using real SQL datasets (customers, subscriptions, transactions)
- Calculate churn rate, lost revenue, and high-risk customer segments
- Perform SQL-based data cleaning and transformation
- Generate actionable business insights using beginner-friendly SQL queries

---

## 🛠️ Tech Stack

- **Database**: PostgreSQL
- **Tools Used**: pgAdmin, SQL
- **Dataset**: 3 tables (customers, subscriptions, transactions) – simulated real-world churn dataset

---

## 📁 Dataset Description

| Table           | Description                                                       |
|-----------------|-------------------------------------------------------------------|
| `customers`     | Customer profiles: demographics, sign-up date, status (churned)  |
| `subscriptions` | Subscription details: plan type, start/end dates                 |
| `transactions`  | Purchase behavior: transaction amount, category, and dates       |

---

## 🧹 Data Cleaning Highlights

- Removed customers with future signup dates or missing region/gender
- Standardized gender and subscription plan values
- Removed invalid subscription dates and null transaction amounts
- Fixed typos in product categories (`"streeming"` → `"Streaming"`, etc.)

---

## 📊 Business Questions Answered

1. ✅ What is the overall churn rate?
2. ✅ What is churn rate by subscription plan?
3. ✅ How much revenue has been lost due to churn?
4. ✅ Which region has the highest churn rate?
5. ✅ Top 5 churned customers who spent the most
6. ✅ Monthly churn trend (churn over time)
7. ✅ Active customers vs churned customers
8. ✅ Which plans have the most churn?
9. ✅ Average spend per churned customer
10. ✅ Most common product categories purchased by churned customers

---

## 📊 Key Findings

- **Churn Rate**: 34.5% of users have churned.
- **Lost Revenue**: ₹23,000+ lost from churned customers.
- **Highest Churn Region**: North Zone (45.3% churn).
- **Top Spender Who Churned**: Customer #104 – ₹2,835 spent.
- **Most Common Plan Among Churners**: Premium-Monthly.
- **Popular Products Among Churned Users**: Streaming, Gaming.

