--1. List the employee number, last name, first name, sex, and salary of each employee.

CREATE VIEW employee_salary_view AS
SELECT emp.emp_no, emp.last_name, emp.first_name, emp.sex, sal.salary
FROM employees emp
JOIN salaries sal ON emp.emp_no = sal.emp_no;

SELECT * FROM employee_salary_view;

--2. List the first name, lastname, and hire date for the employees who were hired in 1986.

CREATE VIEW employees_hired_1986_view AS
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

SELECT * FROM employees_hired_1986_view;

--3. List the manager of each department along with their department number, department name, employee number, last name, and first name.

CREATE VIEW manager_department_view AS
SELECT dm.emp_no, dm.dept_no, d.dept_name, e.last_name, e.first_name
FROM dept_manager dm
JOIN departments d ON dm.dept_no = d.dept_no
JOIN employees e ON dm.emp_no = e.emp_no;

SELECT * FROM manager_department_view;

--4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

CREATE VIEW combined_emp_dept_view AS
SELECT e.emp_no, e.last_name, e.first_name,
       ed1.dept_no_1, d1.dept_name AS dept_no_1_name,
       ed2.dept_no_2, d2.dept_name AS dept_no_2_name
FROM employees e
LEFT JOIN (
  SELECT de.emp_no, de.dept_no_1 AS dept_no_1
  FROM dept_emp de
) ed1 ON e.emp_no = ed1.emp_no
LEFT JOIN (
  SELECT de.emp_no, de.dept_no_2 AS dept_no_2
  FROM dept_emp de
) ed2 ON e.emp_no = ed2.emp_no
LEFT JOIN departments d1 ON ed1.dept_no_1 = d1.dept_no
LEFT JOIN departments d2 ON ed2.dept_no_2 = d2.dept_no;

select * from combined_emp_dept_view

--5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
CREATE VIEW hercules_employees_view AS
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

select * from hercules_employees_view


-- 6. List each employee in the Sales department, including their employee number, last name, and first name.

CREATE VIEW emp_dept_sales_view AS
SELECT de.emp_no, e.last_name, e.first_name
FROM dept_emp de
JOIN employees e ON de.emp_no = e.emp_no
WHERE de.dept_no_1 = 'd007' OR de.dept_no_2 = 'd007';

select * from emp_dept_sales_view

--7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

CREATE VIEW emp_dept_sales_dev_view AS
SELECT de.emp_no, e.last_name, e.first_name,
       COALESCE(d1.dept_name, '') AS dept_no_1_name,
       COALESCE(d2.dept_name, '') AS dept_no_2_name
FROM dept_emp de
JOIN employees e ON de.emp_no = e.emp_no
LEFT JOIN departments d1 ON de.dept_no_1 = d1.dept_no
LEFT JOIN departments d2 ON de.dept_no_2 = d2.dept_no
WHERE de.dept_no_1 IN ('d007', 'd005')
   OR de.dept_no_2 IN ('d007', 'd005');

select * from emp_dept_sales_dev_view

--8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

CREATE VIEW last_name_counts_view AS
SELECT last_name, COUNT(*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;

SELECT * FROM last_name_counts_view;



