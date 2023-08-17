/*Merge both first and last name of the employees into a column and show their employee ID*/
SELECT emp_no,
	CONCAT(first_name, ' ', last_name) AS full_name
FROM employees

/*How many employees work in this company?*/
SELECT COUNT(emp_no) 
AS number_of_employees
FROM employees;

/*Which employee receives the highest salary and what is the value?*/
SELECT e.first_name, MAX(s.salary)
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no
GROUP BY e.first_name
ORDER BY MAX(s.salary) DESC
LIMIT 1

--OR

SELECT e.first_name, s.salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no
ORDER BY s.salary DESC
LIMIT 1

/*What is the total amount of salary paid?*/
SELECT CONCAT('$', (SUM(salary))) AS total_salary
FROM salaries

/*What is the average salary for the company?*/
SELECT ROUND(AVG(salary), 2) AS avg_salary
FROM salaries

/*What year was the youngest person born in the company?*/
SELECT MAX(EXTRACT(YEAR FROM birth_date))
FROM employees

/*A list of all female employees in the company*/
SELECT first_name, gender
FROM employees
WHERE gender = 'F'

/*Calculate the age of each female employee*/
SELECT gender, first_name, EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM birth_date) AS age
FROM employees
WHERE gender = 'F'

/*The name and age of the employees that earn less than 50,000*/
SELECT first_name, salary, EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM e.birth_date) AS age
	FROM employees e
	JOIN salaries s
	ON e.emp_no = s.emp_no
	AND s.salary <= 50000;

/*All employees named Saniya and Mary*/
SELECT * FROM employees 
WHERE first_name IN ('Saniya', 'Mary')

SELECT * FROM employees
WHERE first_name iLIKE '%s%'

/*what is the sum of salaries for individual employee and the total sum of salary by gender*/

SELECT e.first_name, e.gender, SUM(s.salary) AS total_salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no
GROUP BY GROUPING SETS (e.first_name, e.gender)

--OR

SELECT e.first_name, e.gender, SUM(s.salary) AS total_salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no
GROUP BY e.first_name, e.gender

UNION ALL

SELECT e.first_name, NULL, SUM(s.salary) AS total_salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no
GROUP BY e.first_name;

--OR
/*What is the total sum of salaries the company has spent on salaries & what is the sum of salary that each employee has received*/
SELECT e.first_name, e.gender, SUM(s.salary) AS total_salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no
GROUP BY ROLLUP (e.first_name, e.gender);

/*what is the sum of salaries for employees named as Saniya based on their gender*/
SELECT e.first_name, e.last_name, e.gender, SUM(s.salary) AS total_salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no
GROUP BY e.first_name, e.last_name, e.gender
HAVING first_name = 'Saniya';

/*Compare employee salary with the highest salary of each employee*/
SELECT *, MAX(s.salary)
	OVER()
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no;

/*Rank the top 10 highest salary earners in the company by their IDs*/
SELECT *,
	RANK() 
	OVER(ORDER BY salary DESC) AS rank_of_salary
FROM salaries
LIMIT 10;

/*Write a query to find the total salary amount for each employee, department and job title, along with the overall total salary.*/
SELECT e.first_name, d.dept_name, tl.title, SUM(s.salary)
FROM departments d
JOIN dept_emp de
ON d.dept_no = de.dept_no
JOIN employees e
ON de.emp_no = e.emp_no
JOIN titles tl
ON e.emp_no = tl.emp_no
JOIN salaries s
ON s.emp_no = e.emp_no
GROUP BY GROUPING SETS (e.first_name, d.dept_name, tl.title);

/*What is the sum of salary paid distributed by the different departments*/
SELECT d.dept_name, SUM(s.salary)
FROM departments d
JOIN dept_emp de
ON d.dept_no = de.dept_no
JOIN employees e
ON de.emp_no = e.emp_no
JOIN salaries s
ON s.emp_no = e.emp_no
GROUP BY ROLLUP (d.dept_name);

--or

SELECT COALESCE(dept_name, 'Total'), SUM(s.salary) AS salary                  
FROM departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
JOIN employees e ON de.emp_no = e.emp_no
JOIN salaries s ON s.emp_no = e.emp_no
GROUP BY ROLLUP (d.dept_name)
ORDER BY salary ASC; 

/*What is the number of employees compared to employees in each department*/
SELECT d.dept_name, SUM(s.salary)
	OVER()
FROM departments d
	JOIN dept_emp de
	ON d.dept_no = de.dept_no
	JOIN employees e
	ON de.emp_no = e.emp_no
	JOIN salaries s
	ON s.emp_no = e.emp_no

/*Write a query to find the total salary amount for each employee, department and job title, along with the overall total salary.*/
SELECT e.first_name, d.dept_name, tl.title, SUM(s.salary)
FROM departments d
JOIN dept_emp de
ON d.dept_no = de.dept_no
JOIN employees e
ON de.emp_no = e.emp_no
JOIN titles tl
ON e.emp_no = tl.emp_no
JOIN salaries s
ON s.emp_no = e.emp_no
GROUP BY GROUPING SETS (e.first_name, d.dept_name, tl.title);

/*What is the sum of salary paid distributed by the different departments*/
SELECT d.dept_name, SUM(s.salary)
FROM departments d
JOIN dept_emp de
ON d.dept_no = de.dept_no
JOIN employees e
ON de.emp_no = e.emp_no
JOIN salaries s
ON s.emp_no = e.emp_no
GROUP BY ROLLUP (d.dept_name);

--or

SELECT COALESCE(dept_name, 'Total'), SUM(s.salary) AS salary                  
FROM departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
JOIN employees e ON de.emp_no = e.emp_no
JOIN salaries s ON s.emp_no = e.emp_no
GROUP BY ROLLUP (d.dept_name)
ORDER BY salary ASC; 

/*What is the number of employees compared to employees in each department*/

SELECT d.dept_name, SUM(s.salary)
	OVER()
FROM departments d
	JOIN dept_emp de
	ON d.dept_no = de.dept_no
	JOIN employees e
	ON de.emp_no = e.emp_no
	JOIN salaries s
	ON s.emp_no = e.emp_no

/*Rank the top earning departments and rank based top earners using 1-10*/
SELECT d.dept_name, 
	SUM(s.salary) AS total_sum,
	RANK()
	OVER(ORDER BY SUM(s.salary) DESC) AS salary_rank
FROM departments d
JOIN dept_emp de 
ON d.dept_no = de.dept_no
JOIN employees e 
ON de.emp_no = e.emp_no
JOIN salaries s 
ON s.emp_no = e.emp_no
GROUP BY d.dept_name

/* Show the top 3 highest paid employees in each department*/				 
WITH RankedSalaries AS (
    SELECT
        e.first_name,
        e.last_name,
        d.dept_name,
        MAX(s.salary) AS total_salary,
        DENSE_RANK() OVER (PARTITION BY d.dept_name ORDER BY MAX(s.salary) DESC) AS dense_salary_rank
    FROM departments d
    JOIN dept_emp de ON d.dept_no = de.dept_no
    JOIN employees e ON de.emp_no = e.emp_no
    JOIN salaries s ON s.emp_no = e.emp_no
    GROUP BY d.dept_no, e.first_name, e.last_name, d.dept_name
)
SELECT
    first_name,
    last_name,
    dept_name,
    total_salary,
    dense_salary_rank
FROM
    RankedSalaries
WHERE
dense_salary_rank IN (1, 2, 3);					 
					 
