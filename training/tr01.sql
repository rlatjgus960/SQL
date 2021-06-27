select  first_name || ' ' || last_name 이름,
        salary 월급,
        phone_number 전화번호,
        hire_date 입사일
from employees
order by hire_date asc;

select round(avg(salary), 0), min(salary), max(salary)
from employees
where hire_date >= '2005/01/01'
group by manager_id
having avg(salary) >= 5000
order by avg(salary) desc;

select first_name, manager_id, commission_pct, salary
from employees
where manager_id is not null
and commission_pct is null
and salary > 3000;

select to_char(min(hire_date), 'YYYY-MM-DD DAY')
from employees;

select first_name, salary, to_char(hire_date, 'YYYY-MM'), department_id
from employees
where department_id = 10
or department_id = 90
or department_id = 100;

select UPPER(country_name)
from countries
order by country_name asc;

select first_name, salary, REPLACE(phone_number, '.', '-'), hire_date
from employees
where hire_date < '03/12/31';

select count(manager_id)
from employees;

select  max(salary) 최고임금,
        min(salary) 최저임금,
        max(salary) - min(salary) "최고임금 - 최저임금"
from employees;

select to_char(max(hire_date), 'YYYY"년" MM"월" DD"일"')
from employees;

select job_id, round(avg(salary),0), max(salary), min(salary)
from employees
group by job_id
order by min(salary) desc, round(avg(salary),0) asc;


select avg(salary), min(salary), avg(salary) - min(salary)
from employees
group by department_id
having avg(salary) - min(salary) < 2000
order by avg(salary) - min(salary) desc;

select job_id, max(salary) - min(salary)
from employees
group by job_id
order by max(salary) - min(salary) desc;

select job_title, max_salary
from jobs
where max_salary >= 10000
order by max_salary desc;

select first_name, salary
from employees
where first_name like '%S%'
or first_name like '%s%';

select  first_name,
        hire_date,
        case when hire_date <= '02/12/31' then '창립멤버'
             when hire_date <= '03/12/31' then '03년입사'
             when hire_date <= '04/12/31' then '04년입사'
             else '상장이후입사'
        end "otpDate"        
from employees
order by hire_date asc;

select job_title, max_salary
from jobs
order by max_salary desc;

select first_name, salary, nvl(commission_pct, 0)
from employees
where salary < 14000
or salary >= 10000
order by salary desc;

select department_id, avg(salary), max(salary), min(salary)
from employees
group by department_id
order by department_id desc;

select *
from departments
order by length(department_name) desc;