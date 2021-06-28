/*equi join*/
select  e.employee_id,
        e.first_name,
        e.department_id
from employees e, departments d
where e.department_id = d.department_id;

select  em.first_name,
        de.department_name,
        jo.job_title
from employees em, departments de, jobs jo
where em.department_id = de.department_id
and jo.job_id = em.job_id;


/*outer join*/
--left join
select  em.employee_id,
        em.first_name,
        em.department_id,
        de.department_name
from employees em left outer join departments de
on em.department_id = de.department_id;

select  em.employee_id,
        em.first_name,
        em.department_id,
        de.department_name
from employees em , departments de
where em.department_id = de.department_id(+);

--right join
select  em.employee_id,
        em.first_name,
        em.department_id,
        de.department_name
from employees em right outer join departments de
on em.department_id = de.department_id;


select  em.employee_id,
        em.first_name,
        em.department_id,
        de.department_name
from employees em , departments de
where em.department_id(+) = de.department_id;


--right join --> left join
select  em.employee_id,
        em.first_name,
        em.department_id,
        de.department_name
from departments de left outer join employees em
on de.department_id = em.department_id;

--full outer join
select *
from employees em full outer join departments de
on em.department_id = de.department_id;

--self join
select  em.employee_id,
        em.first_name,
        em.phone_number,
        em.manager_id,
        em.department_id,
        ma.employee_id,
        ma.first_name,
        ma.phone_number
from employees em, employees ma
where em.manager_id = ma.employee_id;

select *
from employees em, locations lo
where em.salary = lo.location_id;


-- 'Den' 보다 높은 급여를 받는 직원(11000 이상)
select *
from employees
where salary >= (select salary
                 from employees
                 where first_name = 'Den');

--  'Den'의 급여 --> 11000
select first_name, salary
from employees
where first_name = 'Den';

-- 급여가 11000 이상인 직원
select first_name, salary
from employees
where salary >= 11000;


