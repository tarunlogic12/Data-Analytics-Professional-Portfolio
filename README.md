# Data Analytics Portfolio

This repository contains my data analytics projects and technical audits.

## Projects

### 01_Revenue_Assurance_Audit
* **Objective:** Identifying billing errors to prevent revenue loss.
* **My Approach:**
    * Used SQL to analyze and clean billing logs.
    * Wrote scripts to identify data discrepancies.
* **Result:** Improved data accuracy and streamlined the audit process.
* [🔗 View Full Project](01_Revenue_Assurance_Audit/)


### 02. SQL World Data Analysis
* **Tools:** SQL (MySQL), CTEs
* **Goal:** Analyzing global trends to help with business planning.
* **Result:** Turned raw data into clear benchmarks for market comparison and resource planning.
* [🔗 View Full Project](02_SQL_Case_Study_World_Data/)


### 03. Sales & Human Capital Performance Analytics

* **Tools:** SQL (MySQL - Subqueries)
* **Goal:** Analyzing employee salaries and company sales performance.
* **Result:** Identified top sales performers, high-earning departments, and key revenue contributors using subqueries.
* 🔗 [View Full Project](./03_SQL_Enterprise_Case_Study_Subqueries)


---

### 04. EdTech Student Analytics & Performance Benchmarking Engine
* **Tech Stack:** MySQL (`DENSE_RANK`, `LAG/LEAD`, `NTILE`, `FIRST_VALUE`, `DATEDIFF`)
* **Business Problem:** Manual student evaluations, lack of peer-performance visibility, and difficulty in identifying students needing academic intervention.
* **Pro-Analyst Solution & Technical Approach:**
  * **Relative Ranking:** Calculated subject-level student standings using `DENSE_RANK()` partitioned by course modules.
  * **Score Gap Analysis:** Applied `LAG()` window functions to measure score margins between adjacent rankers for competitive benchmarking.
  * **Cohort Segmentation:** Divided overall scores into performance quartiles using `NTILE(4)` to dynamically assign targeted doubt-clearing sessions.
* **Business Impact:** Automated evaluation workflows, eliminated grading bias, and enabled data-driven student mentoring.
* 🔗 [View Full Project](./04_SQL_Window_Functions_Analytics)

---

### 05. Retail Inventory Automation & Zero-Data-Loss Audit Framework
* **Tech Stack:** MySQL (CTEs, Updatable/Analytical Views, Stored Procedures, `AFTER DELETE` Triggers)
* **Business Problem:** Inventory reporting delays, risk of accidental record deletion, and unauthorized direct database updates in retail backend.
* **Pro-Analyst Solution & Technical Approach:**
  * **Multi-Stage Aggregation:** Built modular Common Table Expressions (CTEs) to isolate high-performing inventory driving revenue above ₹3,000.
  * **Data Abstraction & Security:** Created single-table updatable views (`vw_UpdatableProducts`) to allow safe price updates without exposing master tables.
  * **Automated Audit Logging:** Engineered an `AFTER DELETE` trigger (`trg_AfterDeleteProduct`) that instantly captures deleted catalog items into an immutable `ProductArchive` table with automatic timestamps.
* **Business Impact:** Established a 100% fail-safe audit trail for inventory compliance, reduced query latency using pre-compiled stored procedures, and protected core database schemas.
* 🔗 [View Full Project](./05_Advanced_SQL_Concepts_Analytics)
