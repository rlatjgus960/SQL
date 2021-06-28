--문제1.
select  em.employee_id,
        em.first_name,
        em.last_name,
        de.department_name
from employees em, departments de
where em.department_id = de.department_id
order by de.department_name asc, em.employee_id desc;

--문제2.
select  em.employee_id,
        em.first_name,
        em.salary,
        de.department_name,
        jo.job_title       
from employees em, departments de, jobs jo
where em.job_id = jo.job_id
and em.department_id = de.department_id
order by em.employee_id asc;

--문제2-1.
select  em.employee_id,
        em.first_name,
        em.salary,
        de.department_name,
        jo.job_title       
from employees em ,departments de, jobs jo
where em.job_id = jo.job_id(+)
and em.department_id = de.department_id(+)
order by em.employee_id asc;

--문제3.
select  lo.location_id,
        lo.city,
        de.department_name,
        de.department_id
from locations lo, departments de
where lo.location_id = de.location_id
order by lo.location_id asc;

--문제3-1.
select  lo.location_id,
        lo.city,
        de.department_name,
        de.department_id
from locations lo, departments de
where lo.location_id = de.location_id(+)
order by lo.location_id asc;

--문제4.
select  re.region_name,
        co.country_name
from regions re, countries co
where re.region_id = co.region_id
order by re.region_name asc, co.country_name desc;

--문제5.
select  em.employee_id,
        em.first_name,
        em.hire_date,
        ma.first_name,
        ma.hire_date
from employees em, employees ma
where em.manager_id = ma.employee_id
and em.hire_date < ma.hire_date;

--문제6.
select  co.country_name,
        co.country_id,
        lo.city,
        lo.location_id,
        de.department_name,
        de.department_name
from countries co, locations lo, departments de
where co.country_id = lo.country_id
and lo.location_id = de.location_id
order by co.country_name asc;

--문제7.
select  em.employee_id,
        em.first_name || ' ' || em.last_name,
        em.job_id,
        jo.start_date,
        jo.end_date
from job_history jo, employees em
where jo.employee_id = em.employee_id
and jo.job_id = 'AC_ACCOUNT';

--문제8.
select  de.department_id,
        de.department_name,
        em.first_name,
        lo.city,
        co.country_name,
        re.region_name
from departments de, employees em, locations lo, countries co, regions re
where em.department_id = de.department_id
and lo.location_id = de.location_id
and lo.country_id = co.country_id
and re.region_id = co.region_id
and de.manager_id = em.employee_id;

--문제9.
select  em.employee_id,
        em.first_name,
        de.department_name,
        ma.first_name
from employees em, employees ma, departments de
where em.manager_id = ma.employee_id
and em.department_id = de.department_id(+);