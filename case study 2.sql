create database casestudy2;

use casestudy2;

CREATE TABLE LOCATION (
  Location_ID INT PRIMARY KEY,
  City VARCHAR(50)
);

INSERT INTO LOCATION (Location_ID, City)
VALUES (122, 'New York'),
       (123, 'Dallas'),
       (124, 'Chicago'),
       (167, 'Boston');


  CREATE TABLE DEPARTMENT (
  Department_Id INT PRIMARY KEY,
  Name VARCHAR(50),
  Location_Id INT,
  FOREIGN KEY (Location_Id) REFERENCES LOCATION(Location_ID)
);


INSERT INTO DEPARTMENT (Department_Id, Name, Location_Id)
VALUES (10, 'Accounting', 122),
       (20, 'Sales', 124),
       (30, 'Research', 123),
       (40, 'Operations', 167);


CREATE TABLE JOB
(JOB_ID INT PRIMARY KEY,
DESIGNATION VARCHAR(20))

INSERT  INTO JOB VALUES
(667, 'CLERK'),
(668,'STAFF'),
(669,'ANALYST'),
(670,'SALES_PERSON'),
(671,'MANAGER'),
(672, 'PRESIDENT')


CREATE TABLE EMPLOYEE
(EMPLOYEE_ID INT,
LAST_NAME VARCHAR(20),
FIRST_NAME VARCHAR(20),
MIDDLE_NAME CHAR(1),
JOB_ID INT FOREIGN KEY
REFERENCES JOB(JOB_ID),
MANAGER_ID INT,
HIRE_DATE DATE,
SALARY INT,
COMM INT,
DEPARTMENT_ID  INT FOREIGN KEY
REFERENCES DEPARTMENT(DEPARTMENT_ID))

INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','JOHN','Q',667,7902,'17-DEC-84',800,NULL,20),
(7499,'ALLEN','KEVIN','J',670,7698,'20-FEB-84',1600,300,30),
(7505,'DOYLE','JEAN','K',671,7839,'04-APR-85',2850,NULl,30),
(7506,'DENNIS','LYNN','S',671,7839,'15-MAY-85',2750,NULL,30),
(7507,'BAKER','LESLIE','D',671,7839,'10-JUN-85',2200,NULL,40),
(7521,'WARK','CYNTHIA','D',670,7698,'22-FEB-85',1250,500,30)



--Simple Queries:------------------

--1. List all the employee details.
select * from employee;

--2. List all the department details.
select * from department;

--3. List all job details.
select * from job;

--4. List all the locations.
select * from location;

--5. List out the First Name, Last Name, Salary, Commission for all Employees.

select First_Name, Last_Name, Salary, Comm from Employee;

--6. List out the Employee ID, Last Name, Department ID for all employees and alias Employee ID
   -- as "ID of the Employee", Last Name as "Name of the Employee", Department ID as "Dep_id".

select Employee_ID as [ID of the Employee], Last_Name as [Name of the Employee], 
Department_ID as  Dep_id  from employee;

--7. List out the annual salary of the employees with their names only.

select salary*12 as annual_salary, first_Name, Last_Name from employee;


--WHERE Condition:--------------------

--1. List the details about "Smith".

select * from employee where LAST_NAME ='Smith';

--2. List out the employees who are working in department 20.

select * from employee where department_id =20;

--3. List out the employees who are earning salaries between 3000 and 4500.

select * from employee where salary between 3000 and 4500;


--4. List out the employees who are working in department 10 or 20.

select * from employee where department_id =10 or department_id =20;


--5. Find out the employees who are not working in department 10 or 30.

select * from employee where department_id not in(10,30);


--6. List out the employees whose name starts with 'S'.

select * from employee where  last_name like 's%';


--7. List out the employees whose name starts with 'S' and ends with 'H'.

select * from employee where  last_name like 's%h';

--8. List out the employees whose name length is 4 and start with 'S'.

select * from employee where first_name like 's%' and len(first_name)=4;


--9. List out employees who are working in department 10 and draw salaries more than 3500.

select * from employee where department_id= 10 and salary >3500;


--10. List out the employees who are not receiving commission.

select * from employee where comm is null;


--ORDER BY Clause:--------------------

--1. List out the Employee ID and Last Name in ascending order based on the Employee ID.

select Employee_ID, Last_Name from employee order by Employee_ID;

--2. List out the Employee ID and Name in descending order based on salary.

select Employee_ID, first_Name, Last_Name, salary from employee order by salary desc;

--3. List out the employee details according to their Last Name in ascending-order.

select * from employee order by last_name;

--4. List out the employee details according to their Last Name in ascending order and then 
    --Department ID in descending order.

select * from employee order by  last_name asc, department_id desc;


--GROUP BY and HAVING Clause:---------------

--1. How many employees are in different departments in the organization?

SELECT Department_Id, COUNT(*) AS Num_Employees from employee group by department_id;

--2. List out  department wise maximum salary, minimum salary and average salary of employees.

select max(salary) as max_salary, min(salary) as min_salary, avg(salary) as avg_salary, 
department_id from employee group by department_id;

--3. List out the job wise maximum salary, minimum salary and average salary of the employees.

select max(salary) as max_salary, min(salary) as min_salary, avg(salary) as avg_salary, 
job_id from employee group by job_id;


--4. List out the number of employees who joined each month in ascending order.

select count(employee_id) as num_employee, datepart(month,hire_date) as month from employee
group by datepart(month,hire_date) order by datepart(month,hire_date); 

--5. List out the number of employees for each month and year in ascending order based on 
    --the year and month.

select count(employee_id) as num_employee, datepart(year,hire_date) as year,
datepart(month,hire_date) as month from employee
group by datepart(year,hire_date),datepart(month,hire_date)
order by datepart(year,hire_date),datepart(month,hire_date); 


--6. List out the Department ID having at least four employees.

select Department_ID, count(employee_id) as 'count of employee' from employee 
group by Department_ID having count(employee_id)>4;

--7. How many employees joined in the month of January?

select  count(employee_id) as num_employee_joined, Month(hire_date) as month from employee 
where Month(hire_date)=1 group by Month(hire_date);


--8. How many employees joined in the month of January or September?

select  count(employee_id) as num_employee_joined, Month(hire_date) as month from employee 
where Month(hire_date)in(1,9) group by Month(hire_date);


--9. How many employees joined in 1985?

select  count(employee_id) as num_employee_joined, Year(hire_date) as year from employee 
where Year(hire_date)=1985 group by Year(hire_date);


--10. How many employees joined each month in 1985?

select  count(employee_id) as num_employee_joined,Month(hire_date) as month,
Year(hire_date) as year from employee 
where Year(hire_date)=1985 group by Year(hire_date),Month(hire_date);


--11. How many employees joined in March 1985?

select  count(employee_id) as num_employee_joined,Month(hire_date) as month,
Year(hire_date) as year from employee 
where Year(hire_date)=1985 and Month(hire_date)=3 group by Year(hire_date),Month(hire_date);


--12. Which is the Department ID having greater than or equal to 3 employees joining in 
    --April 1985?

select  department_id , count(employee_id) as num_employee_joined from employee
where Year(hire_date)=1985 and Month(hire_date)=4 group by department_id
having count(employee_id)>=3;


--Joins:---------------

--1. List out employees with their department names.

select e.*, d.name from employee e 
join department d on e.department_id=d.department_id;

--2. Display employees with their designations.

select e.*, j.designation from employee e 
join job j on e.job_id=j.job_id;


--3. Display the employees with their department names and regional groups.

select e.*, d.name,l.city from employee e 
join department d on e.department_id=d.department_id
join location l on l.location_id=d.location_id;


--4. How many employees are working in different departments? Display with department names.

select count(employee_Id) as num_employee, d.name as department_name from department d
join  employee e  on e.Department_Id=d.Department_Id
group by d.name;


--5. How many employees are working in the sales department?

select count(*) as num_employee_sales  from employee e 
join department d on e.Department_Id=d.Department_Id
where d.name='sales';


--6. Which is the department having greater than or equal to 5 employees? Display the 
   --department names in ascending order.

select count(employee_Id) as num_employee, d.name as department_name from department d
join  employee e  on e.Department_Id=d.Department_Id
group by d.name 
having count(employee_Id) >=5
order by d.name asc;


--7. How many jobs are there in the organization? Display with designations.

select count(e.job_Id) as 'No. of Jobs', designation  from employee e
join  job j  on e.job_id=j.job_id
group by designation;


--8. How many employees are working in "New York"?

select count(*) as 'No. of employees' from department d
join  employee e  on e.Department_Id=d.Department_Id
join  location l on l.location_id=d.location_id
where city='New York';


--9. Display the employee details with salary grades. Use conditional statement to create 
   --a grade column.

select *,
  case
      when salary>=2000 then 'high grade'
	  when salary<2000 and salary>=1000  then 'medium grade'
	  else 'low grade'
  end as salary_grade
from employee;


--10. List out the number of employees grade wise. Use conditional statement to create 
    --a grade column.

SELECT GRADE, COUNT(*) AS NUM_OF_EMPLOYEES 
FROM (
		SELECT *, 
			case
               when salary>=2000 then 'high grade'
	           when salary<2000 and salary>=1000  then 'medium grade'
	           else 'low grade'
            end as grade
		FROM EMPLOYEE ) AS GRADE
GROUP BY GRADE;


--11.Display the employee salary grades and the number of employees between 2000 to 5000 
    --range of salary.

SELECT GRADE, COUNT(employee_id) AS NUM_OF_EMPLOYEES 
FROM (
		SELECT *, 
			case
               when salary>=2000 then 'high grade'
	           when salary<2000 and salary>=1000  then 'medium grade'
	           else 'low grade'
            end as grade
		FROM EMPLOYEE ) AS GRADE
where salary between 2000 and 5000
GROUP BY GRADE;

--12. Display all employees in sales or operation departments.

select employee_id, d.name from employee e join department d on e.department_id=d.department_id
where d.name in ('sales', 'operations');


--SET Operators:------------

--1. List out the distinct jobs in sales and accounting departments.

select distinct designation,name  from job j
join employee e on j.job_id=e.job_id
join department d on e.department_id=d.department_id
where name in ('sales','accounting');


--2. List out all the jobs in sales and accounting departments.

select designation,name  from job j
join employee e on j.job_id=e.job_id
join department d on e.department_id=d.department_id
where name in ('sales','accounting');


--3. List out the common jobs in research and accounting departments in ascending order.

select designation,name  from job j
join employee e on j.job_id=e.job_id
join department d on e.department_id=d.department_id
where name='research'
intersect
select designation,name  from job j
join employee e on j.job_id=e.job_id
join department d on e.department_id=d.department_id
where name='accounting' 
order by name asc;


--Subqueries:--------------

--1. Display the employees list who got the maximum salary.

select first_name,middle_name, last_name from employee where salary=(select max(salary) from employee);

--2. Display the employees who are working in the sales department.

select first_name,middle_name, last_name, department_id from employee 
where department_id=(select department_id from department where name='sales');

--3. Display the employees who are working as 'Clerk'.

select * from employee 
where job_id=(select job_id from job where designation='clerk');

--4. Display the list of employees who are living in "New York".

select * from employee 
where department_id in(select department_id from department  where
      location_id in(select location_id from location where city='New York'));

--5. Find out the number of employees working in the sales department.

select count(employee_id) as num_employee from employee 
where department_id in(select department_id from department  where name='sales');


--6. Update the salaries of employees who are working as clerks on the basis of 10%.

begin transaction
update employee 
   set salary= salary+salary*0.10
   where department_id = (select department_id from department where name='clerk')
rollback transaction;

--7. Delete the employees who are working in the accounting department.

begin transaction
delete from employee where department_id in (select department_id from department where name='accounting')
rollback transaction;

--8. Display the second highest salary drawing employee details.

select * from employee 
where salary=(select max(salary) from employee
         where salary<(select max(salary) from employee));


--9. Display the nth highest salary drawing employee details.

DECLARE @N INT = 3; -- Change the value of N to the desired nth highest salary

SELECT TOP 1 Employee_Id, Last_Name, First_Name, Middle_Name, Job_Id, Hire_Date, Salary, Comm, Department_Id
FROM (
    SELECT Employee_Id, Last_Name, First_Name, Middle_Name, Job_Id, Hire_Date, Salary, Comm, Department_Id,
           DENSE_RANK() OVER (ORDER BY Salary DESC) AS RowNum
    FROM Employee
) AS EmpWithRowNum
WHERE RowNum = @N;

--10. List out the employees who earn more than every employee in department 30.

select * from employee where salary > All(select salary from employee where department_id=30);


--11. List out the employees who earn more than the lowest salary in department 30.

select * from employee 
where salary > any(select min(salary) from employee where department_id=30);

--12. Find out which department has no employees.

select * from department where department_id not in (select department_id from employee);

--13. Find out the employees who earn greater than the average salary for their department.

select * from employee
where salary > (select avg(salary) from employee );
