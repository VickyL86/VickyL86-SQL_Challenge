-- -------------------------------------------------------------------------------------------------
-- one to one relationship between salaries and employees
ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY ("emp_no") REFERENCES "employees"("emp_no");
-- one to many relationship between departments and dept_emp
ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY ("dept_no") REFERENCES "departments"("dept_no");
-- one to many relationship between departments and dept_manager
ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY ("dept_no") REFERENCES "departments"("dept_no");
-- one to many relationship between totles and employees 
ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY ("emp_title_id") REFERENCES "titles"("title_id");

-- -------------------------------------------------------------------------------------------------
-- Create a new table with columns emp_no (primary key) and dept_no_1
CREATE TABLE dept_emp_unique (
  emp_no INT PRIMARY KEY,
  dept_no_1 VARCHAR(4)
);

-- Insert data into the new table, splitting multiple dept_no values into separate columns
INSERT INTO dept_emp_unique (emp_no, dept_no_1)
SELECT
  emp_no,
  MIN(dept_no) AS dept_no_1
FROM dept_emp
GROUP BY emp_no;

-- Add a new column dept_no_2 to the new table
ALTER TABLE dept_emp_unique ADD COLUMN dept_no_2 VARCHAR(4);

-- Update dept_no_2 values with the additional dept_no values
UPDATE dept_emp_unique
SET dept_no_2 = dept_emp.dept_no
FROM dept_emp
WHERE dept_emp_unique.emp_no = dept_emp.emp_no
  AND dept_emp.dept_no <> dept_emp_unique.dept_no_1;

-- Drop the original table
DROP TABLE dept_emp;

-- Rename the new table to the original table name
ALTER TABLE dept_emp_unique RENAME TO dept_emp;

-- -------------------------------------------------------------------------------------------------

-- view dept_emp table rows where dept_no_2 is not null
SELECT * FROM dept_emp
WHERE dept_no_2 IS NOT NULL;

-- -------------------------------------------------------------------------------------------------

-- create one to one relationship between employees and dept_emp
ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_no" FOREIGN KEY ("emp_no") REFERENCES "dept_emp"("emp_no");

-- create one to one relationship between dept_emp dept_no_1 and departments dept_no
ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no_1" FOREIGN KEY ("dept_no_1") REFERENCES "departments"("dept_no");

-- create one to one relationship between dept_emp dept_no_2 and departments dept_no
ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no_2" FOREIGN KEY ("dept_no_2") REFERENCES "departments"("dept_no");