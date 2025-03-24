CREATE DATABASE department_management;

CREATE TABLE departments (
    dept_no VARCHAR(10) PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
    emp_no INT PRIMARY KEY,
    emp_title_id VARCHAR(10),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    sex CHAR(1) CHECK (sex IN ('M', 'F')),
    birth_date DATE,
    hire_date DATE NOT NULL,
    FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);

CREATE TABLE dept_emp (
    emp_no INT,
    dept_no VARCHAR(10),
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE dept_manager (
    emp_no INT,
    dept_no VARCHAR(10),
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE salaries (
    emp_no INT,
    salary INT NOT NULL,
    PRIMARY KEY (emp_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE titles (
    title_id VARCHAR(10) PRIMARY KEY,
    title VARCHAR(100) NOT NULL
);

-- Import data into departments table
COPY departments(dept_no, dept_name)
FROM '/path/to/departments.csv' DELIMITER ',' CSV HEADER;

-- Import data into titles table
COPY titles(title_id, title)
FROM '/path/to/titles.csv' DELIMITER ',' CSV HEADER;

-- Import data into employees table
COPY employees(emp_no, emp_title_id, first_name, last_name, sex, birth_date, hire_date)
FROM '/path/to/employees.csv' DELIMITER ',' CSV HEADER;

-- Import data into dept_emp table
COPY dept_emp(emp_no, dept_no)
FROM '/path/to/dept_emp.csv' DELIMITER ',' CSV HEADER;

-- Import data into dept_manager table
COPY dept_manager(emp_no, dept_no)
FROM '/path/to/dept_manager.csv' DELIMITER ',' CSV HEADER;

-- Import data into salaries table
COPY salaries(emp_no, salary)
FROM '/path/to/salaries.csv' DELIMITER ',' CSV HEADER;

-- QUESTIONS

-- Employee number, last name, first name, sex, and salary of each employee:
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no;

-- First name, last name, and hire date for employees hired in 1986:
SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

-- Manager of each department along with department number, department name, employee number, last name, and first name:
SELECT d.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name
FROM dept_manager dm
JOIN departments d ON dm.dept_no = d.dept_no
JOIN employees e ON dm.emp_no = e.emp_no;

-- Department number for each employee along with employee number, last name, first name, and department name:
SELECT e.emp_no, e.last_name, e.first_name, d.dept_no, d.dept_name
FROM dept_emp de
JOIN departments d ON de.dept_no = d.dept_no
JOIN employees e ON de.emp_no = e.emp_no;

-- First name, last name, and sex of employees whose first name is Hercules and last name starts with B:
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- Each employee in the Sales department, including employee number, last name, and first name:
SELECT e.emp_no, e.last_name, e.first_name
FROM dept_emp de
JOIN departments d ON de.dept_no = d.dept_no
JOIN employees e ON de.emp_no = e.emp_no
WHERE d.dept_name = 'Sales';

-- Each employee in the Sales and Development departments, including employee number, last name, first name, and department name:
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
JOIN departments d ON de.dept_no = d.dept_no
JOIN employees e ON de.emp_no = e.emp_no
WHERE d.dept_name IN ('Sales', 'Development');

-- Frequency counts of employee last names (descending order):
SELECT last_name, COUNT(*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;
