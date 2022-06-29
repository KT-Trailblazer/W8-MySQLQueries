USE employees;

-- 1. I want to know how many employees with each title were born after 1965-01-01.

SELECT DISTINCT titles.title, COUNT(titles.emp_no)
FROM employees
INNER JOIN titles
ON employees.emp_no = titles.emp_no
WHERE birth_date > '1965-01-01'
GROUP BY
titles.title;

-- 2. I want to know the average salary per title.

SELECT titles.title as "Job Title", FORMAT(avg(salaries.salary),2) AS "Average Salary"
FROM salaries
INNER JOIN titles
ON titles.emp_no = salaries.emp_no
GROUP BY titles.title;

-- 3. How much money was spent on salary for the marketing department between the years 1990 and 1992?

SELECT departments.dept_name AS "Department", FORMAT(SUM(salaries.salary),2) AS "Total Spent"
FROM departments
INNER JOIN dept_emp on dept_emp.dept_no = departments.dept_no
INNER JOIN salaries on salaries.emp_no = dept_emp.emp_no
	AND dept_emp.dept_no = (SELECT dept_no FROM departments WHERE dept_name = 'Marketing')
	AND dept_emp.from_date >= '1990-01-01'
    AND dept_emp.to_date <= '1992-12-31'
GROUP BY departments.dept_name
