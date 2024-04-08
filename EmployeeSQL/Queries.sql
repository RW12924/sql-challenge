-- Returns employee number, last name, first name, sex, and salary of each
-- employee
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees as e
INNER JOIN salaries as s ON
e.emp_no=s.emp_no;

-- Returns the first name, last name, and hire date for employees
-- hired in 1986
SELECT first_name, last_name, hire_date 
FROM employees
WHERE hire_date >= '1986-01-01'
AND hire_date <= '1986-12-31'

-- Returns a list of managers' names and their respective department number/name
-- and employee number
SELECT m.dept_no, d.dept_name, m.emp_no, e.last_name, e.first_name FROM dept_manager as m
JOIN departments as d
	ON m.dept_no=d.dept_no
JOIN employees as e
	ON m.emp_no=e.emp_no

-- Returns a list containing each employee's first name, last name, employee number,
-- department number, and department name
SELECT de.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees as e
JOIN dept_emp as de
	ON e.emp_no=de.emp_no
JOIN departments as d
	ON de.dept_no=d.dept_no

-- Returns a list of first names, last names, and sex for all employees with
-- the first name Hercules and last name that starts with the letter B
SELECT first_name, last_name, sex
FROM employees
WHERE first_name='Hercules'
AND last_name LIKE 'B%'

-- Returns a list of all employees in the Sales department and their
-- respective employee numbers, last names, and first names
SELECT emp_no, last_name, first_name FROM employees
WHERE emp_no IN
(
	(
	SELECT emp_no FROM dept_emp
	WHERE dept_no IN
		(
		SELECT dept_no FROM departments
		WHERE dept_name='Sales'
		)
	)
);

-- Returns a list of each employee in the Sales and Development 
-- departments as well as their respective employee number,
-- last name, first name, and department name
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS de
ON (e.emp_no=de.emp_no)
JOIN departments AS d
ON (de.dept_no=d.dept_no)
WHERE e.emp_no IN
	(
	SELECT de.emp_no FROM dept_emp
	WHERE de.dept_no IN
		(
		SELECT d.dept_no FROM departments
		WHERE d.dept_name='Sales'
		OR d.dept_name='Development'
		)
	);

-- Returns frequency counts of all employee last names in
-- descending order
SELECT COUNT (last_name) AS count, last_name
FROM employees
GROUP BY last_name
ORDER BY "count" DESC