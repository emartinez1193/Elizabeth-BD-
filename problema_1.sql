select a.EMPLOYEE_ID, a.MANAGER_ID, a.DEPARTMENT_ID
from hr.employees a 
where a.DEPARTMENT_ID in 
(select DEPARTMENT_ID
from hr.employees
where EMPLOYEE_ID = 174 or EMPLOYEE_ID = 199)
union
select b.EMPLOYEE_ID, b.MANAGER_ID, b.DEPARTMENT_ID
from hr.employees b
where b.MANAGER_ID in
(select MANAGER_ID
from hr.employees
where EMPLOYEE_ID = 174 or EMPLOYEE_ID = 199);

