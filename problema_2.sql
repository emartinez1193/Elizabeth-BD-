select employee_id, last_name, job_id
from employees
where employee_id in
(select employee_id
from job_history
group by employee_id
having count (*) >= 2);