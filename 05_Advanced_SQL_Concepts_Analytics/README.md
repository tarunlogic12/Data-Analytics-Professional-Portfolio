# 📊 Advanced SQL & Database Automation Case Study

## 📌 Business Overview
In a retail store, managing inventory manually leads to missing data, slower reporting, and operational delays. This case study applies Advanced SQL techniques—such as Common Table Expressions (CTEs), Views, Stored Procedures, and Triggers—on store `Products` and `Sales` datasets to automate daily business tracking and data protection.

---

## 💡 Key Business Solutions & Queries

### 1. High-Revenue Product Filter (`CTE`)
* **Goal:** Calculate total sales revenue (`Price * Quantity`) for each item and filter products earning above ₹3,000.
* **Business Value:** Instantly highlights top-performing products for store managers to plan stock inventory better.

### 2. Category Summary Dashboard (`vw_CategorySummary`)
* **Goal:** Create a saved summary report showing total product count and average price per category.
* **Business Value:** Gives executives a 1-second view of inventory distribution and average price points.

### 3. Safe Price Updater (`vw_UpdatableProducts`)
* **Goal:** Create an easy, updatable view for updating item prices safely without touching primary backend tables.
* **Business Value:** Shields core tables while allowing retail staff to update prices during sales or price drops.

### 4. Dynamic Category Finder (`GetProductsByCategory`)
* **Goal:** Build a single reusable command that fetches all products under any requested category (e.g., 'Electronics').
* **Business Value:** Saves app developers from writing repetitive code and speeds up product searches on mobile apps.

### 5. Automatic Backup on Item Delete (`trg_AfterDeleteProduct`)
* **Goal:** Create an automatic background trigger that copies deleted item details into an audit archive table with exact timestamps.
* **Business Value:** Prevents accidental data loss, maintains audit logs, and supports fraud management.

---

## 📁 Repository Files
* `05_Advanced_SQL_Concepts_Analytics.sql`: Executable MySQL script with schema creation, data inserts, and all 10 solutions.
* `README.md`: Non-technical business case study breakdown.
