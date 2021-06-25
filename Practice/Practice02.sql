--ex01
select count(manager_id)
from employees;

--ex02
select  max(salary) 최고임금,
        min(salary) 최저임금,
        max(salary)-min(salary) "최고임금-최저임금"
from employees;

--ex03
select to_char(max(hire_date),'YYYY"년" MM"월" DD"일"')
from employees;

--ex04
select  avg(salary), 
        max(salary), 
        min(salary), 
        department_id
from employees
group by department_id
order by department_id desc;

--ex05
select  avg(salary), 
        max(salary), 
        min(salary), 
        job_id
from employees
group by job_id
order by min(salary) desc, round(avg(salary), 0) asc;

--ex06
select to_char(min(hire_date),'YYYY-MM-DD DAY')
from employees;

--ex07
select  department_id,
        avg(salary), 
        min(salary), 
        avg(salary)-min(salary)
from employees
group by department_id
having avg(salary)-min(salary) < 2000
order by avg(salary)-min(salary) desc;

--ex08
select  max(max_salary),
        min(min_salary),
        max(max_salary)-min(min_salary)
from jobs
group by job_id
order by max(max_salary)-min(min_salary) desc;



--ex09
select round(avg(salary),0), min(salary), max(salary)
from employees
where hire_date > '2004-12-31'
group by manager_id
having avg(salary)> 5000
order by avg(salary) desc;


/*ex10
아래회사는 보너스 지급을 위해 직원을 입사일 기준으로 나눌려고 합니다. 
입사일이 02/12/31일 이전이면 '창립맴버, 03년은 '03년입사’, 04년은 ‘04년입사’ 
이후입사자는 ‘상장이후입사’ optDate 컬럼의 데이터로 출력하세요.
정렬은 입사일로 오름차순으로 정렬합니다.*/

select  first_name,
        hire_date,
        case when hire_date < '03-01-01' then '창립멤버'
             when hire_date < '04-01-01' then '03년입사'
             when hire_date < '05-01-01' then '04년입사'
             else '상장이후입사'
        end optDate
from employees
order by hire_date asc;

