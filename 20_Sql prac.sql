use companydb;

CREATE INDEX idx_last_name ON employee(name);
SELECT * FROM employee WHERE name = 'Leo';

select * from Employee;

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL
);

INSERT INTO Departments (DepartmentID, DepartmentName) 
VALUES (1, 'HR'),(2, 'IT'),(3, 'Finance');
    
CREATE TABLE employee (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    DepID INT,
    Salary DECIMAL(10,2),
    Age INT,
    JoiningDate DATE NOT NULL,
    Leaving_Org_Date DATE NULL,
    manager_id INT,
    FOREIGN KEY (DepID) REFERENCES Departments(DepartmentID));

INSERT INTO employee (EmployeeID, Name, DepID, Salary, Age, JoiningDate, Leaving_Org_Date, manager_id)
VALUES
(5, 'Emma', 1, 52000.00, 32, '2021-03-12', '2025-06-15', 1),
(6, 'Frank', 2, 63000.00, 29, '2018-11-20', '2023-02-28', 2),
(7, 'Grace', 3, 58000.00, 33, '2017-07-05', '2022-09-10', 3),
(8, 'Hannah', 1, 49000.00, 27, '2022-01-30', '2026-05-01', 5),
(9, 'Isaac', 2, 75000.00, 42, '2014-06-22', '2019-10-15', NULL), -- Senior employee
(10, 'Jack', 3, 57000.00, 31, '2019-02-15', '2023-07-20', 7),
(11, 'Karen', 1, 51000.00, 29, '2020-09-10', '2024-03-18', 5),
(12, 'Leo', 2, 72000.00, 38, '2016-12-05', '2022-02-10', 9),
(13, 'Mia', 3, 75000.00, 36, '2015-04-25', '2020-08-30', NULL),
(14, 'Noah', 1, 53000.00, 30, '2021-07-14', '2024-12-01', 11),
(15, 'Olivia', 2, 68000.00, 34, '2017-10-03', '2022-05-25', 9),
(16, 'Paul', 3, 60000.00, 40, '2014-08-19', '2019-12-20', NULL),
(17, 'Quinn', 1, 50000.00, 28, '2023-05-22', '2026-09-10', 11),
(18, 'Rachel', 2, 71000.00, 39, '2015-11-07', '2021-03-15', 12),
(19, 'Steve', 3, 56000.00, 32, '2019-06-30', '2024-02-28', 13),
(20, 'Tracy', 1, 54000.00, 33, '2022-02-17', '2025-09-30', 14),
(21, 'Uma', 2, 64000.00, 31, '2018-09-24', '2023-07-15', 15),
(22, 'Victor', 3, 58000.00, 35, '2016-05-18', '2021-11-01', 16),
(23, 'Wendy', 1, 52000.00, 30, '2021-12-29', '2025-08-05', 14),
(24, 'Xander', 2, 76000.00, 45, '2012-03-15', '2017-06-10', NULL);


INSERT INTO employee (EmployeeID, Name, DepID, Salary, Age, JoiningDate, Leaving_Org_Date)  
VALUES  
(101, 'John Doe', NULL, 60000, 30, '2022-05-10', '2026-06-24'),  
(102, 'Jane Smith', NULL, 75000, 28, '2023-03-15', '2025-05-30'); 

SHOW TABLES;

select * from Employee;


alter table Employee drop column Annual_CTC;
select * from department; 

drop table employee;


-- ALTER TABLE employee ADD COLUMN Leaving_Org_Date DATE;

select depid, count(*) as employee_count
from employee
group by depid
having count(*) > 1;

SELECT month(JoiningDate) AS year_extracted FROM employee;

SELECT 
    YEAR(JoiningDate) AS year_extracted,   -- Extract year
    MONTH(JoiningDate) AS month_extracted, -- Extract month
    DAY(JoiningDate) AS day_extracted      -- Extract day
FROM employee;

select datediff(Leaving_Org_Date, JoiningDate) from employee as Total_Work_Duration;

select e.employeeid, e.name,
timestampdiff(month,JoiningDate, Leaving_Org_Date) as month_diff 
from employee e
where timestampdiff(day,JoiningDate, Leaving_Org_Date) > 1500;
-- subquery--- 2nd max salary
SELECT MAX(salary) 
FROM employees 
WHERE salary < (SELECT MAX(salary) FROM employees);

SELECT DISTINCT Salary 
FROM employee 
ORDER BY Salary DESC 
LIMIT 1 OFFSET 2;

-- Self Join
SELECT e1.Name AS Employee1, e2.Name AS Employee2, e1.DepID
FROM employee e1
JOIN employee e2 
ON e1.DepID = e2.DepID 
AND e1.EmployeeID <> e2.EmployeeID;

SELECT e1.Name AS Employee1, e2.Name AS Employee2, e1.DepID
FROM employee e1
JOIN employee e2 
ON e1.DepID = e2.DepID 
AND e1.EmployeeID > e2.EmployeeID;
-- ------------------------------------------

select e.name, e.DepID, e.salary,
      rank() over (order by salary desc) as Ranck_Pos,
      dense_rank() over (order by salary desc) as Dense_Rank_Pos,
      row_number() over (order by salary desc) as Row_Num_Pos
from employee e;

SELECT Name, Salary, Rank_Pos
FROM (
    SELECT Name, Salary, RANK() OVER (ORDER BY Salary DESC) AS Rank_Pos
    FROM employee
) AS RankedEmployees
WHERE Rank_Pos <= 3;

SELECT * FROM employee WHERE Name = 'Emma';

CREATE INDEX idx_name ON employee (Name);

SHOW INDEXES FROM employee;

DROP INDEX idx_last_name  ON employee;

SELECT e.DepID, SUM(e.Salary) AS TotalSalary
FROM employee e
WHERE e.salary > 50000    
GROUP BY depid   
HAVING SUM(salary) > 450000;

SELECT DepID, COUNT(*) AS EmployeeCount
FROM employee
GROUP BY DepID
HAVING COUNT(*) > 1;

-- Select the names of employees who have a salary greater than 50,000.
select e.name, e.salary
from employee e
where e.salary > 50000;

-- Find the total number of employees in the employees table.
select count(*) as Employee_Count from employee;

-- Retrieve unique departments from the employees table.
select distinct DepID from employee;

select distinct e.depid, d.DepartmentName
from employee e 
join department d on e.DepID=d.DepartmentID;

-- Display employees ordered by their joining date in descending order.
select e.name, datediff(Leaving_Org_Date,JoiningDate) as working_days
from employee e
order by JoiningDate desc;

-- Write a query to find the total salary paid in each department.
select e.DepID,sum(e.salary) as Total_Salary_Paid_byeac_Dep
from employee e
group by DepID;
-- Find the average salary of employees.
select DepID, avg(salary) as Avg_Sa
from employee
group by depid;
-- Count the number of employees in each department and show only those with more than 5 employees.
select d.DepartmentID, d.DepartmentName, count(EmployeeID)
from employee e
join department d
on d.DepartmentID = e.DepID
group by d.DepartmentID
having count(e.EmployeeID) > 5;
-- Retrieve the maximum and minimum salaries from the employees table.
select DepID, max(Salary) as Max_Sal, min(Salary)
from employee
group by DepID;

--  Find the department with the highest total salary expense.
select d.DepartmentID, d.DepartmentName, sum(e.salary) as Total_Sal_Expences
from employee e
inner join department d
on d.DepartmentID = e.DepID
group by DepartmentID, DepartmentName
order by Total_Sal_Expences Desc
Limit 1
;
--  Write a query to fetch employee names and their department names using a JOIN.
select e.Name,d.DepartmentName
from employee e
join department d
on d.DepartmentID = e.DepID;
-- Retrieve employees who earn more than the average salary of all employees.
select e.name,e.salary
from employee e
where e.salary > (select avg(Salary) from employee)
;
-- Get employees who have the same salary as another employee (using a SELF JOIN).
select e1.EmployeeID, e1.name, e1.salary
from employee e1
join employee e2
on e1.Salary = e2.Salary AND e1.EmployeeID <> e2.EmployeeID;
-- Display employees who have not been assigned a department (use LEFT JOIN).
select e.EmployeeID, e.Name, e.salary, d.DepartmentID
from employee e
Left Join department d 
on e.DepID = d.DepartmentID
where e.DepID is null;

select * from employee;

delete from employee
where employee.EmployeeID in (102,101);

-- Find employees who joined before their manager (assuming a manager_id column exists).
select e1.EmployeeID, e1.Name, e1.JoiningDate, e1.manager_id, e2.Name as Manager_Name, e2.JoiningDate as Manager_Joining_Date
from employee e1
join employee e2
on e1.manager_id = e2.EmployeeID
where e1.JoiningDate < e2.JoiningDate;
-- Use RANK() to rank employees based on salary in descending order
SELECT 
    EmployeeID, 
    Name, 
    Salary, 
    RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM employee;

select max(Salary) from employee;
-- Find the second highest salary without using LIMIT.
select max(Salary) as Second_Max_Salary 
from employee 
where salary < (select max(Salary) from Employee);
-- 
select * from department e
left join employee d
on e.DepartmentID = d.DepID
order by age desc
limit 10 offset 2;


select * from Employee;
















-- WHERE TIMESTAMPDIFF(DAY, JoiningDate, Leaving_Org_Date) > 1900;