/*
You are given a table with the following columns: 
Emp_ID, Emp_Name, Manager_ID, and Department. 
Your task is to determine the hierarchy of employees and classify each employee into one of the 
following roles:
1. CEO – An employee who has no manager (i.e., Manager_ID is NULL).
2. Manager – An employee who manages at least one other employee (i.e., their Emp_ID appears as a 
   Manager_ID for other employees).
3. Employee – An employee who reports to a manager but does not have any subordinates.

Write an SQL query to classify each employee as 'CEO', 'Manager', or 'Employee' based on the reporting 
structure.

SUPPORT QUERY:
*/
CREATE TABLE Employees (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(100),
    Manager_ID INT,
    Manager_Name VARCHAR(100),
    Department VARCHAR(50)
);
INSERT INTO Employees (Emp_ID, Emp_Name, Manager_ID, Manager_Name, Department) 
VALUES (1, 'Alice Johnson', NULL, NULL, 'Executive'),
    (2, 'Bob Smith', 1, 'Alice Johnson', 'Engineering'),
    (3, 'Carol Davis', 1, 'Alice Johnson', 'HR'),
    (4, 'David Wilson', 1, 'Alice Johnson', 'Finance'),
    (5, 'Emma Brown', 1, 'Alice Johnson', 'Sales'),
    (6, 'Frank White', 2, 'Bob Smith', 'Engineering'),
    (7, 'Grace Lee', 2, 'Bob Smith', 'Engineering'),
    (8, 'Henry Adams', 2, 'Bob Smith', 'Engineering'),
    (9, 'Ivy Turner', 2, 'Bob Smith', 'Engineering'),
    (10, 'Jack Hall', 2, 'Bob Smith', 'Engineering'),
    (11, 'Kevin Harris', 3, 'Carol Davis', 'HR'),
    (12, 'Lily Young', 3, 'Carol Davis', 'HR'),
    (13, 'Michael King', 3, 'Carol Davis', 'HR'),
    (14, 'Nancy Scott', 3, 'Carol Davis', 'HR'),
    (15, 'Oscar Wright', 3, 'Carol Davis', 'HR'),
    (16, 'Paul Baker', 4, 'David Wilson', 'Finance'),
    (17, 'Quinn Martinez', 4, 'David Wilson', 'Finance'),
    (18, 'Rachel Lewis', 4, 'David Wilson', 'Finance'),
    (19, 'Samuel Clark', 4, 'David Wilson', 'Finance'),
    (20, 'Tina Walker', 4, 'David Wilson', 'Finance'),
    (21, 'Uma Allen', 5, 'Emma Brown', 'Sales'),
    (22, 'Victor Green', 5, 'Emma Brown', 'Sales'),
    (23, 'Wendy Nelson', 5, 'Emma Brown', 'Sales'),
    (24, 'Xavier Carter', 5, 'Emma Brown', 'Sales'),
    (25, 'Yvonne Rodriguez', 5, 'Emma Brown', 'Sales');

/* ANSWER QUERY */
SELECT *,
    CASE
        WHEN Manager_ID IS NULL THEN 'CEO'
        WHEN Emp_ID IN (
            SELECT DISTINCT Manager_ID
            FROM employees
            WHERE Manager_ID IS NOT NULL
        ) THEN 'Manager'
        ELSE 'Employee'
    END AS Role
FROM employees;

