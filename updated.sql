-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/VK1Z7r
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Modify this code to update the DB schema diagram.
-- To reset the sample schema, replace everything with
-- two dots ('..' - without quotes).

CREATE TABLE "department" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_department" PRIMARY KEY (
        "dept_no"
     )
);
SELECT * FROM department;


--List all employees in the Sales department, 
--including their employee number, last name, first name, and department name.
SELECT e.emp_no,e.first_name,e.last_name,p.dept_name FROM employees As e
INNER JOIN dept_emp AS d ON
e.emp_no=d.emp_no
INNER JOIN department AS p ON
d.dept_no=p.dept_no
WHERE p.dept_name='Sales';


--List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.
SELECT e.emp_no,e.first_name,e.last_name,p.dept_name FROM employees As e
INNER JOIN dept_emp AS d ON
e.emp_no=d.emp_no
INNER JOIN department AS p ON
d.dept_no=p.dept_no
WHERE p.dept_name='Development' OR p.dept_name ='Sales';


CREATE TABLE "dept_emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);
DROP TABLE dept_emp;
SELECT * FROM dept_emp;
CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INTEGER   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);
SELECT * FROM dept_manager;


--List the manager of each department with the following information: 
--department number, department name, the manager's employee number, 
--last name, first name, and start and end employment dates.
SELECT employees.first_name,employees.last_name,dept_manager.dept_no,dept_manager.from_date,
dept_manager.to_date,department.dept_no,department.dept_name
FROM employees INNER JOIN dept_manager
ON employees.emp_no = dept_manager.emp_no
INNER JOIN department
ON dept_manager.dept_no = department.dept_no;


CREATE TABLE "employees" (
    "emp_no" INTEGER   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);
SELECT * FROM employees;

--List the following details of each employee: employee number
--last name, first name, gender, and salary.
SELECT employees.first_name,employees.last_name,employees.gender,
salaries.salary
FROM employees LEFT JOIN salaries
ON employees.emp_no = salaries.emp_no;


--List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
SELECT employees.emp_no,employees.first_name,employees.last_name,dept_emp.emp_no,
dept_emp.dept_no,department.dept_name
FROM employees INNER JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
INNER JOIN department
ON dept_emp.dept_no = department.dept_no;


--List all employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name,last_name
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';


--In descending order, list the frequency count of employee last names, 
--i.e., how many employees share each last name.
SELECT last_name,COUNT(last_name)AS "frequency count"
FROM employees
GROUP BY last_name
ORDER BY "frequency count" DESC;

--List employees who were hired in 1986.
SELECT first_name,last_name
FROM employees
WHERE hire_date between '1985-12-31' AND '1986-12-31' ;


CREATE TABLE "salaries" (
    "emp_no" INTEGER   NOT NULL,
    "salary" INTEGER   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);
SELECT * FROM salaries;

CREATE TABLE "title" (
    "emp_no" INTEGER   NOT NULL,
    "title" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);
SELECT * FROM title;

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "department" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "department" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "title" ADD CONSTRAINT "fk_title_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");