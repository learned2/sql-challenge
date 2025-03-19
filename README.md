# sql-challenge

# Entity Relationship Diagram (ERD) Sketch:

## Departments
- Attributes: dept_no (PK), dept_name
- Related to:
  dept_emp (Many-to-Many with Employees)

## Employees
- Attributes: emp_no (PK), emp_title_id, first_name, last_name, sex, birth_date, hire_date
- Related to:
  dept_emp (Many-to-Many with Departments)
  salaries (One-to-Many with salary data)
  titles (One-to-Many with employee titles)

## Dept_Emp (Employee-Department Assignment)
- Attributes: emp_no, dept_no
- Primary Key: Composite key (emp_no, dept_no) since one employee can belong to multiple departments.
- Foreign Keys:
  emp_no references Employees(emp_no)
  dept_no references Departments(dept_no)

## Dept_Manager (Department Manager Assignment)
- Attributes: emp_no, dept_no
- Primary Key: Composite key (emp_no, dept_no) since one department can have one manager.
- Foreign Keys:
  emp_no references Employees(emp_no)
  dept_no references Departments(dept_no)

## Salaries
- Attributes: emp_no, salary
- Primary Key: emp_no (assuming one salary per employee for simplicity)
- Foreign Key: emp_no references Employees(emp_no)

## Titles
- Attributes: title_id, title
- Primary Key: title_id
- Related to:
  Employees (Each employee has a title)
