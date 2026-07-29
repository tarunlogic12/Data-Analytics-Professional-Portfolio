-- ============================================================
-- SQL FUNCTIONS ASSIGNMENT - CASE STUDY & QUERY SOLUTIONS
-- Student Name : Tarun Das
-- Course Name  : Data Analytics with Generative AI
-- Dataset Name : Student_Performance
-- ============================================================

-- ------------------------------------------------------------
-- STEP 1: CORRECTED TABLE CREATION & DATA INSERTION
-- ------------------------------------------------------------

CREATE TABLE Student_Performance (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    course VARCHAR(50),
    score INT,
    attendance INT,
    mentor VARCHAR(50),
    join_date DATE,
    city VARCHAR(50)
);

INSERT INTO Student_Performance 
(student_id, name, course, score, attendance, mentor, join_date, city)
VALUES 
(101, 'Aarav Mehta', 'Data Science', 88, 92, 'Dr. Sharma', '2023-06-12', 'Mumbai'),
(102, 'Riya Singh', 'Data Science', 76, 85, 'Dr. Sharma', '2023-07-01', 'Delhi'),
(103, 'Kabir Khanna', 'Python', 91, 96, 'Ms. Nair', '2023-05-20', 'Mumbai'),
(104, 'Tanvi Patel', 'SQL', 84, 89, 'Mr. Iyer', '2023-05-30', 'Bengaluru'),
(105, 'Ayesha Khan', 'Python', 67, 81, 'Ms. Nair', '2023-07-10', 'Hyderabad'),
(106, 'Dev Sharma', 'SQL', 75, 78, 'Mr. Iyer', '2023-05-28', 'Pune'),
(107, 'Arjun Verma', 'Tableau', 95, 98, 'Ms. Kapoor', '2023-06-15', 'Delhi'),
(108, 'Meera Pillai', 'Tableau', 82, 87, 'Ms. Kapoor', '2023-06-18', 'Kochi'), -- Attendance corrected to 87
(109, 'Nikhil Rao', 'Data Science', 79, 88, 'Dr. Sharma', '2023-07-05', 'Chennai'),
(110, 'Priya Desai', 'SQL', 92, 94, 'Mr. Iyer', '2023-06-22', 'Bengaluru'),
(111, 'Siddharth Jain', 'Python', 85, 88, 'Ms. Nair', '2023-07-02', 'Mumbai'),
(112, 'Sneha Kulkarni', 'Tableau', 74, 85, 'Ms. Kapoor', '2023-06-10', 'Pune'),
(113, 'Rohan Gupta', 'SQL', 89, 91, 'Mr. Iyer', '2023-05-25', 'Delhi'),
(114, 'Ishita Joshi', 'Data Science', 95, 97, 'Dr. Sharma', '2023-06-25', 'Bengaluru'), -- Score corrected to 95
(115, 'Yuvraj Rao', 'Python', 71, 84, 'Ms. Nair', '2023-07-12', 'Hyderabad');


-- ------------------------------------------------------------
-- STEP 2: ALL 10 QUESTIONS WITH EASY ENGLISH CASE STUDIES
-- ------------------------------------------------------------

/*
Q1: Create a ranking of students based on score (highest first).
--------------------------------------------------------------------------------
BUSINESS CASE STUDY:
EdTech platforms like PW Skills or Coursera need leaderboard rankings to give 
merit scholarships and certificates to top-performing students.
*/
SELECT 
    student_id, 
    name, 
    score,
    DENSE_RANK() OVER (ORDER BY score DESC) AS score_rank
FROM Student_Performance;


/*
Q2: Show each student's score and the previous student's score (based on score order).
--------------------------------------------------------------------------------
BUSINESS CASE STUDY:
Score Margin Analysis - Used by teachers to see the score gap between two consecutive 
rankers and analyze exam difficulty.
*/
SELECT 
    name, 
    score,
    LAG(score, 1) OVER (ORDER BY score DESC) AS previous_student_score
FROM Student_Performance;


/*
Q3: Convert all student names to uppercase and extract the month name from join_date.
--------------------------------------------------------------------------------
BUSINESS CASE STUDY:
Data Cleaning & Monthly Trends - Names are converted to UPPERCASE for official 
certificates, and month names help track monthly enrollment trends.
*/
SELECT 
    UPPER(name) AS student_name_uppercase,
    join_date,
    MONTHNAME(join_date) AS join_month
FROM Student_Performance;


/*
Q4: Show each student's name and the next student's attendance (ordered by attendance).
--------------------------------------------------------------------------------
BUSINESS CASE STUDY:
Attendance Progression Benchmark - Shows students the attendance percentage of the 
person right above them to motivate them to improve.
*/
SELECT 
    name, 
    attendance,
    LEAD(attendance, 1) OVER (ORDER BY attendance ASC) AS next_student_attendance
FROM Student_Performance;


/*
Q5: Assign students into 4 performance groups using NTILE().
--------------------------------------------------------------------------------
BUSINESS CASE STUDY:
Student Cohort Segmentation - Divides students into 4 groups (Top 25% to Bottom 25%). 
This helps arrange extra remedial classes for Group 4 (low performers).
*/
SELECT 
    name, 
    score,
    NTILE(4) OVER (ORDER BY score DESC) AS performance_group
FROM Student_Performance;


/*
Q6: For each course, assign a row number based on attendance (highest first).
--------------------------------------------------------------------------------
BUSINESS CASE STUDY:
Course-Wise Attendance Awards - Ranks students inside each course based on attendance 
so the company can give 'Best Attendance' badges for each subject.
*/
SELECT 
    course, 
    name, 
    attendance,
    ROW_NUMBER() OVER (PARTITION BY course ORDER BY attendance DESC) AS attendance_row_num
FROM Student_Performance;


/*
Q7: Calculate the number of days each student has been enrolled (from join_date to today). (Assume current date = 2025-01-01).
--------------------------------------------------------------------------------
BUSINESS CASE STUDY:
Student Tenure Analysis - Calculates total active days on the platform to check 
student engagement and course completion speed.
*/
SELECT 
    name, 
    join_date,
    DATEDIFF('2025-01-01', join_date) AS enrolled_days
FROM Student_Performance;


/*
Q8: Format join_date as "Month Year" (e.g., "June 2023").
--------------------------------------------------------------------------------
BUSINESS CASE STUDY:
Executive Reporting Format - Converts raw dates (2023-06-12) into clean "June 2023" 
format for easy reading on management dashboards.
*/
SELECT 
    name, 
    join_date,
    DATE_FORMAT(join_date, '%M %Y') AS formatted_join_date
FROM Student_Performance;


/*
Q9: Replace the city 'Mumbai' with 'MUM' for display purposes.
--------------------------------------------------------------------------------
BUSINESS CASE STUDY:
Mobile UI Optimization - Shortens city names to 3-letter codes (like Mumbai -> MUM) 
to save screen space on mobile dashboards.
*/
SELECT 
    name, 
    city,
    REPLACE(city, 'Mumbai', 'MUM') AS display_city
FROM Student_Performance;


/*
Q10: For each course, find the highest score using FIRST_VALUE().
--------------------------------------------------------------------------------
BUSINESS CASE STUDY:
Topper Comparison Benchmark - Shows the highest score of each course next to every 
student's score so they can see how far they are from the course topper.
*/
SELECT 
    course, 
    name, 
    score,
    FIRST_VALUE(score) OVER (
        PARTITION BY course 
        ORDER BY score DESC 
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS highest_course_score
FROM Student_Performance;