SELECT* FROM employees
SELECT* FROM salaries

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



