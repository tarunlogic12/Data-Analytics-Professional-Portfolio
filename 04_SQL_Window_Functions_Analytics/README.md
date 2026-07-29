# 📊 SQL Functions & Student Performance Analytics

## 📌 Project Overview
This project uses MySQL Window Functions, Date-Time Functions, and String Operations on the `Student_Performance` dataset to solve real-world EdTech operational problems.

---

## 💡 Key Business Case Studies & Queries

### 1. Leaderboard Ranking (`DENSE_RANK`)
* **Goal:** Rank students by total score (highest first).
* **Business Value:** Automatically creates leaderboards to award scholarships to top performers.

### 2. Score Gap Analysis (`LAG`)
* **Goal:** Compare each student's score with the score of the person right above them.
* **Business Value:** Helps teachers see score margins and check exam difficulty levels.

### 3. Data Cleaning & Trends (`UPPER`, `MONTHNAME`)
* **Goal:** Convert student names to UPPERCASE and extract enrollment month names.
* **Business Value:** Cleans names for printing official certificates and tracks monthly enrollment trends.

### 4. Peer Attendance Target (`LEAD`)
* **Goal:** Show each student the attendance percentage of the next ranker.
* **Business Value:** Motivates students to increase platform attendance to reach the next level.

### 5. Student Grouping (`NTILE`)
* **Goal:** Divide students into 4 equal performance groups (Top 25% to Bottom 25%).
* **Business Value:** Helps arrange extra doubt-clearing sessions for Group 4 (low performers).

### 6. Course-Wise Attendance Rank (`ROW_NUMBER`)
* **Goal:** Rank students inside each course based on attendance.
* **Business Value:** Helps award 'Best Attendance' badges for each individual subject.

### 7. Active Enrollment Days (`DATEDIFF`)
* **Goal:** Calculate total active days of each student from join date to reference date.
* **Business Value:** Tracks student retention and course completion speed.

### 8. Executive Date Format (`DATE_FORMAT`)
* **Goal:** Convert raw dates (`2023-06-12`) into clean text (`June 2023`).
* **Business Value:** Makes dates easy to read on executive business dashboards.

### 9. Mobile UI Optimization (`REPLACE`)
* **Goal:** Shorten city names (e.g., 'Mumbai' to 'MUM').
* **Business Value:** Saves screen space on mobile dashboards and user cards.

### 10. Topper Benchmark Comparison (`FIRST_VALUE`)
* **Goal:** Display the highest course score next to every student's score.
* **Business Value:** Allows students to see how far they are from their course topper.

---

## 📁 Repository Files
* `04_SQL_Functions_Analytics.sql`: Clean MySQL script with database schema and queries.
* `README.md`: Business case studies and analytical insights.
