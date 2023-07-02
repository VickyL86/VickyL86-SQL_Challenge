-- create all tables & primary keys when applicable 

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR (4)   NOT NULL,
    "emp_no" int   NOT NULL,
    PRIMARY KEY ("emp_no")
);

CREATE TABLE "departments" (
    "dept_no" varchar(4)   NOT NULL,
    "dept_name" varchar(18)   NOT NULL, 
    PRIMARY KEY ("dept_no")
);

CREATE TABLE "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar(4)   NOT NULL,
    id SERIAL,
    PRIMARY KEY ("id")
);

CREATE TABLE "titles" (
    "title_id" VARCHAR(5)   NOT NULL,
    "title" varchar(18)   NOT NULL,
    PRIMARY KEY ("title_id")
);

CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" money   NOT NULL,
    PRIMARY KEY ("emp_no")
);

CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "emp_title_id" varchar(5)   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(14)   NOT NULL,
    "last_name" varchar(16)   NOT NULL,
    "sex" varchar(1)   NOT NULL,
    "hire_date" date   NOT NULL,
    PRIMARY KEY ("emp_no")
);


