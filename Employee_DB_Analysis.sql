--CREATE TABLES AND IMPORT CSVs

drop table if exists employees;

create table employees(
	emp_no int primary key,
	birth_date date,
	first_name varchar,
	last_name varchar,
	gender varchar,
	hire_date date);
	
select * from employees

---------------------------------------------
drop table if exists dept_emp;

create table dept_emp(
	emp_no int NOT NULL,
	dept_no varchar(4),
	from_date date,
	to_date date,
	foreign key (emp_no) references employees(emp_no),
	foreign key (dept_no) references departments(dept_no)
	);
	
select * from dept_emp;
-----------------------------------------------
drop table if exists departments;

create table departments(
	dept_no varchar(4) primary key not null,
	dept_name varchar
);

select * from departments
----------------------------------------------
drop table if exists dept_manager;

create table dept_manager(
	dept_no varchar(4),
	emp_no int NOT NULL,
	from_date date,
	to_date date,
	foreign key (emp_no) references employees(emp_no),
	foreign key (dept_no) references departments(dept_no)
	);
	
select * from dept_manager;

--------------------------------------------

drop table if exists salaries;

create table salaries(
	emp_no int NOT NULL,
	salary int,
	from_date date,
	to_date date,
	foreign key (emp_no) references employees(emp_no)
);

select * from salaries;

-----------------------------------------

drop table if exists titles;

create table titles(
	emp_no int NOT NULL,
	title varchar,
	from_date date,
	to_date date,
	foreign key (emp_no) references employees(emp_no)
);

select * from titles;

--1: List the following of each employee:
-- employee number, last name, first name, gender, and salary.

select e.emp_no, e.last_name, e.first_name, e.gender, s.salary
from employees as e
inner join salaries as s on e.emp_no = s.emp_no


--2: Employees who were hired in 1986 

select * from employees
where hire_date >= '1986-01-01' and hire_date < '1987-01-01';


--3: List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, 
--first name, and start and end employment dates

select d.dept_no, d.dept_name, m.emp_no, e.last_name, e.first_name, m.from_date, m.to_date
from departments as d
inner join dept_manager as m on d.dept_no = m.dept_no
inner join employees as e on m.emp_no = e.emp_no

--4: List the department of each employee with the following information: 
--employee number, last name, first name, and department name.

select e.emp_no, e.last_name, e.first_name, d.dept_name
from departments as d
inner join dept_manager as m on d.dept_no = m.dept_no
inner join employees as e on m.emp_no = e.emp_no;

--5: List all employees whose first name is "Hercules" and last names begin with "B."

select * from employees
where first_name = 'Hercules' and last_name like 'B%';

--6: List all employees in the Sales department, including their employee number, 
--last name, first name, and department name.

select e.emp_no, e.last_name, e.first_name, d.dept_name 
from departments as d
inner join dept_manager as m on d.dept_no = m.dept_no
inner join employees as e on m.emp_no = e.emp_no
where dept_name = 'Sales';

--7: List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.

select e.emp_no, e.last_name, e.first_name, d.dept_name 
from departments as d
inner join dept_manager as m on d.dept_no = m.dept_no
inner join employees as e on m.emp_no = e.emp_no
where dept_name = 'Sales' or dept_name = 'Development';

--8: In descending order, list the frequency count of employee last names, 
--i.e., how many employees share each last name.

select last_name, count(emp_no) as "Last Name Frequency" from employees
group by last_name
order by "Last Name Frequency" desc;