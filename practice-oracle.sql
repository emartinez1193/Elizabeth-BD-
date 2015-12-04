-- 1.Display details of jobs where the minimum salary is greater than 10000.

select *
from hr.jobs
where hr.jobs.min_salary > 10000;

-- 2.Display the first name and join date of the employees who joined between 2002 and 2005.
select hr.employees.first_name, hr.employees.hire_date
from hr.employees
where TO_CHAR(hr.employees.hire_date, 'YYYY') between 2002 and 2005;

-- 3.Display first name and join date of the employees who is either IT Programmer or Sales Man. 
select hr.employees.first_name, hr.employees.hire_date, hr.employees.job_id
from hr.employees
where hr.employees.job_id in ('SA_MAN', 'IT_PROG');

-- 4.Display employees who joined after 1st January 2008.
select *
from hr.employees
where hr.employees.hire_date > '01-JAN-08';

-- 5.Display details of employee with ID 150 or 160.
select * 
from hr.employees
where hr.employees.employee_id in (150, 160);

-- 6.Display first name, salary, commission pct, and hire date for employees with salary less than 10000.
select hr.employees.first_name, hr.employees.salary, 
        hr.employees.commission_pct, hr.employees.hire_date
from hr.employees
where hr.employees.salary < 10000;

-- 7.Display job Title, the difference between minimum and maximum salaries for jobs with max salary in the range 10000 to 20000.
select hr.jobs.job_title, (hr.jobs.max_salary - hr.jobs.min_salary) as SALARY_DELTA
from hr.jobs
where hr.jobs.max_salary between 10000 and 20000;

-- 8.Display first name, salary, and round the salary to thousands.
select hr.employees.first_name, ROUND(hr.employees.salary, -3)
from hr.employees;

-- 9.Display details of jobs in the descending order of the title.
select *
from hr.jobs
order by hr.jobs.job_title desc;

-- 10.Display employees where the first name or last name starts with S.
select *
from hr.employees
where  hr.employees.first_name like 'S%' 
      or hr.employees.last_name like 'S%';
    
    
-- 11.Display employees who joined in the month of May.
select *
from hr.employees
where TO_CHAR(hr.employees.hire_date, 'MON') = 'MAY';

-- 12.Display details of the employees where commission percentage is null and salary in the range 5000 to 10000 and department is 30.
select *
from hr.employees
where hr.employees.commission_pct is null 
      and hr.employees.salary between 5000 and 10000
      and hr.employees.department_id = 30;
      
-- 13.Display first name and date of first salary of the employees.
select hr.employees.first_name, hr.employees.hire_date, 
        last_day(hr.employees.hire_date) + 1
from hr.employees;

-- 14.Display first name and experience of the employees.
select hr.employees.first_name, 
       floor((SYSDATE - hr.employees.hire_date)/365) as EXP
from hr.employees;

-- Display first name of employees who joined in 2001.
select hr.employees.first_name
from hr.employees
where TO_CHAR(hr.employees.hire_date, 'YYYY') = 2001;

-- 16.Display first name and last name after converting the first letter of each name to upper case and the rest to lower case.
select initcap(hr.employees.first_name) as first_name, 
       initcap(hr.employees.last_name) as last_name
from hr.employees;

--17.Display the first word in job title.
select substr(hr.jobs.job_title, 1, INSTR(hr.jobs.job_title, ' '))
from hr.jobs
where INSTR(hr.jobs.job_title, ' ') > 0
union
select hr.jobs.job_title
from hr.jobs
where INSTR(hr.jobs.job_title, ' ') = 0;

-- 18.Display the length of first name for employees where last name contain character ëbí after 3rd position.
select length(hr.employees.first_name), hr.employees.first_name, hr.employees.last_name
from hr.employees
where hr.employees.last_name like '___%b%';
      
select length(hr.employees.first_name), hr.employees.first_name, hr.employees.last_name
from hr.employees
where instr(hr.employees.last_name, 'b') > 3; 

-- 19.Display first name in upper case and email address in lower case for 
-- employees where the first name and email address are same irrespective of the case.
select upper(hr.employees.first_name), lower(hr.employees.email)
from hr.employees
where lower(hr.employees.first_name) = 
      lower(hr.employees.email);
      
-- Display employees who joined in the current year.
select *
from hr.employees
where TO_CHAR(SYSDATE, 'YYYY') = TO_CHAR(hr.employees.hire_date, 'YYYY'); 

-- 21.Display the number of days between system date and 1st January 2011.
select FLOOR((SYSDATE - TO_DATE('01-JAN-2011')))
from DUAL;

-- 22.Display how many employees joined in each month of the current year.
select TO_CHAR(hr.employees.hire_date, 'MONTH'), COUNT(*)
from hr.employees
where TO_CHAR(hr.employees.hire_date, 'YYYY') = 2003
group by TO_CHAR(hr.employees.hire_date, 'MONTH');

-- 23.	Display manager ID and number of employees managed by the manager.
select hr.employees.manager_id, count(*)
from hr.employees
group by hr.employees.manager_id
order by hr.employees.manager_id;

-- 24.	Display employee ID and the date on which he ended his previous job.
select hr.job_history.employee_id, MAX(hr.job_history.end_date)
from hr.job_history
group by hr.job_history.employee_id;

-- 26.	Display the country ID and number of cities we have in the country.
select hr.locations.country_id, COUNT(*)
from hr.locations
group by hr.locations.country_id;

-- 27.Display average salary of employees in each department who have commission percentage.
select hr.employees.department_id, ROUND(AVG(hr.employees.salary), 2)
from hr.employees
where hr.employees.department_id is not null 
      and hr.employees.commission_pct is not null
group by hr.employees.department_id;

-- 28.Display job ID, number of employees, sum of salary, and difference between highest salary and lowest salary of the employees of the job.
select hr.employees.job_id, COUNT(*), SUM(hr.employees.salary), 
       MAX(hr.employees.salary) - MIN(hr.employees.salary) as SALARY_DELTA
from hr.employees
group by hr.employees.job_id;

-- 29.Display job ID for jobs with average salary more than 10000.
select hr.employees.job_id, AVG(hr.employees.salary)
from hr.employees
group by hr.employees.job_id
having AVG(hr.employees.salary) > 10000;

-- 30.Display years in which more than 10 employees joined.
select TO_CHAR(hr.employees.hire_date, 'YYYY'), COUNT(*)
from hr.employees
group by TO_CHAR(hr.employees.hire_date, 'YYYY')
having COUNT(*) > 10;

-- 31.Display departments in which more than five employees have commission percentage.
select hr.employees.department_id, COUNT(hr.employees.commission_pct)
from hr.employees
group by hr.employees.department_id
having COUNT(hr.employees.commission_pct) > 5;

select hr.employees.department_id, COUNT(*)
from hr.employees
where hr.employees.commission_pct is not null
group by hr.employees.department_id
having COUNT(*) > 5;

-- 32.Display employee ID for employees who did more than one job in the past.
select hr.job_history.employee_id, COUNT(*)
from hr.job_history
group by hr.job_history.employee_id
having COUNT(*) > 1;

-- 33.Display job ID of jobs that were done by more than 3 employees for more than 100 days.
select hr.job_history.job_id, COUNT(*)
from hr.job_history
where hr.job_history.end_date - hr.job_history.start_date > 100
group by hr.job_history.job_id
having COUNT(*) > 3;

-- 34.Display department ID, year, and Number of employees joined.
select hr.employees.employee_id, 
      TO_CHAR(hr.employees.hire_date, 'YYYY'),
      COUNT(*)
from hr.employees
group by hr.employees.employee_id,
         TO_CHAR(hr.employees.hire_date, 'YYYY');

-- 35.Display departments where any manager is managing more than 5 employees.
select distinct hr.employees.department_id
from hr.employees
group by hr.employees.department_id, hr.employees.manager_id
having COUNT(hr.employees.employee_id) > 5;

-- 60.Display employees who did not do any job in the past.
SELECT *
FROM HR.EMPLOYEES
WHERE EMPLOYEE_ID NOT IN (SELECT DISTINCT EMPLOYEE_ID FROM HR.JOB_HISTORY);

-- 61.Display job title and average salary for employees who did a job in the past.
SELECT JOB_TITLE, AVG(SALARY)
FROM HR.EMPLOYEES JOIN HR.JOBS USING (JOB_ID)
WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM HR.JOB_HISTORY)
GROUP BY JOB_TITLE;

-- 62.Display country name, city, and number of departments where department has more than 5 employees.
SELECT COUNTRY_NAME, CITY, COUNT(*)
FROM HR.DEPARTMENTS
     JOIN HR.LOCATIONS USING (LOCATION_ID)
     JOIN HR.COUNTRIES USING (COUNTRY_ID)
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID 
                         FROM HR.EMPLOYEES
                         GROUP BY DEPARTMENT_ID
                         HAVING COUNT(*) > 5)  
GROUP BY COUNTRY_NAME, CITY;

-- 63.Display details of manager who manages more than 5 employees.
SELECT * FROM HR.EMPLOYEES
WHERE EMPLOYEE_ID IN (SELECT M.EMPLOYEE_ID
FROM HR.EMPLOYEES M JOIN HR.EMPLOYEES E ON M.EMPLOYEE_ID = E.MANAGER_ID
GROUP BY M.EMPLOYEE_ID
HAVING COUNT(*) > 5);

-- 64.Display employee name, job title, start date, and end date of past jobs of all employees with commission percentage null.
SELECT FIRST_NAME, JOB_TITLE, START_DATE, END_DATE FROM (HR.JOB_HISTORY JH
JOIN HR.EMPLOYEES USING (EMPLOYEE_ID))
JOIN HR.JOBS J ON JH.JOB_ID = J.JOB_ID
WHERE COMMISSION_PCT IS NULL;

-- 65.Display the departments into which no employee joined in last two years.
SELECT * FROM HR.DEPARTMENTS 
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
FROM HR.EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING MAX(HIRE_DATE) - MIN(HIRE_DATE) > 2*365);

-- 66.Display the details of departments in which the max salary is greater than 10000 for employees who did a job in the past.
SELECT DISTINCT * FROM HR.DEPARTMENTS 
WHERE DEPARTMENT_ID IN (
SELECT DEPARTMENT_ID FROM HR.EMPLOYEES
WHERE EMPLOYEE_ID = ANY(SELECT EMPLOYEE_ID FROM HR.JOB_HISTORY)
GROUP BY DEPARTMENT_ID
HAVING MAX(SALARY) > 10000);

-- 67.Display details of current job for employees who worked as IT Programmers in the past.
SELECT J.* FROM HR.JOBS J
JOIN HR.EMPLOYEES E ON J.JOB_ID = E.JOB_ID
WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM HR.JOB_HISTORY
WHERE JOB_ID = 'IT_PROG');

-- 68.Display the details of employees drawing the highest salary in the department.
SELECT E.*
FROM (SELECT DEPARTMENT_ID, MAX(SALARY) MAX_SALARY
FROM HR.EMPLOYEES
GROUP BY DEPARTMENT_ID) D
JOIN HR.EMPLOYEES E ON E.DEPARTMENT_ID = D.DEPARTMENT_ID AND E.SALARY = D.MAX_SALARY;

SELECT DEPARTMENT_ID,FIRST_NAME, SALARY FROM HR.EMPLOYEES OUTER WHERE SALARY = 
    (SELECT MAX(SALARY) FROM HR.EMPLOYEES WHERE DEPARTMENT_ID = OUTER.DEPARTMENT_ID);

-- 69.Display the city of employee whose employee ID is 105.
SELECT CITY FROM HR.LOCATIONS
WHERE LOCATION_ID = (SELECT LOCATION_ID FROM HR.DEPARTMENTS 
                     WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM HR.EMPLOYEES
                                            WHERE EMPLOYEE_ID = 105));

-- 70.Display third highest salary of all employees
select salary 
from hr.employees main
where  2 = (select count( distinct salary ) 
            from hr.employees
            where  salary > main.salary);