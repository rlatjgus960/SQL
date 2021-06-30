--문제1.
select  first_name, 
        manager_id,
        commission_pct
from employees
where manager_id is not null
and commission_pct is null
and salary > 3000;


--문제2.
select  employee_id 직원번호,
        first_name 이름,
        salary 급여,
        to_char(hire_date, 'YYYY-MM-DD') 입사일,
        replace(phone_number, '.','-') 전화번호,
        department_id 부서번호
from employees
where (department_id, salary) in (select department_id, max(salary)
                                  from employees
                                  group by department_id);

                                  

--문제3.
select  ma.manager_id,
        em.first_name,
        ma.avgsal,
        ma.minsal,
        ma.maxsal
from employees em, (select  manager_id,
                            round(avg(salary),0) avgsal,
                            min(salary) minsal,
                            max(salary) maxsal
                    from employees 
                    where hire_date >= '2005/01/01'
                    group by manager_id
                    having avg(salary) >= 5000) ma
where ma.manager_id = em.employee_id
order by ma.avgsal desc;


--문제4.
select  em.employee_id,
        em.first_name,
        de.department_name,
        ma.first_name
from employees em, employees ma, departments de
where em.department_id = de.department_id(+)
and em.manager_id = ma.employee_id;


--문제5.
select  rl.rn,
        rl.employee_id,
        rl.first_name,
        rl.department_id,
        rl.salary,
        rl.hire_date
from (select  rownum rn,
              ol.employee_id,
              ol.first_name,
              ol.department_id,
              ol.salary,
              ol.hire_date
      from (select employee_id,
                   first_name,
                   department_id,
                   salary,
                   hire_date
            from employees
            where hire_date >= '2005/01/01'
            order by hire_date) ol) rl
where rl.rn between 11 and 20;



--문제6.
select  em.first_name || ' ' || em.last_name 이름,
        em.salary 연봉,
        de.department_name 부서이름,
        em.hire_date
from employees em, departments de
where em.department_id = de.department_id
and em.hire_date = (select max(hire_date)
                      from employees);

                      
--문제7~10 다시 보고 정리해보기
--문제7.
select em.employee_id, em.first_name, em.last_name, jo.job_title, em.salary
from employees em, jobs jo,
    (select department_id
     from (select max(asal.avgsal) maxsal
           from(select department_id, avg(salary) avgsal
                from employees
                group by department_id) asal ) msal,
           (select department_id, avg(salary) avgsal
           from employees
           group by department_id) bsal
     where bsal.avgsal = msal.maxsal) md
where md.department_id = em.department_id
and em.job_id = jo.job_id;
           




--문제8.
select de.department_name
from departments de,
    (select department_id
     from (select max(asal.avgsal) maxsal
           from(select department_id, avg(salary) avgsal
                from employees
                group by department_id) asal ) msal,
           (select department_id, avg(salary) avgsal
           from employees
           group by department_id) bsal
     where bsal.avgsal = msal.maxsal) md
where de.department_id = md.department_id;


--문제9.
select re.region_name
from 
     regions re,
     (select region_id
      from (select max(asal.avgsal) maxsal
            from(select re.region_id, avg(em.salary) avgsal
                 from employees em, departments de, locations lo, countries co, regions re
                 where em.department_id = de.department_id
                 and de.location_id = lo.location_id
                 and lo.country_id = co.country_id
                 and co.region_id = re.region_id
                 group by re.region_id) asal ) msal,
                 
            (select re.region_id, avg(em.salary) avgsal
             from employees em, departments de, locations lo, countries co, regions re
             where em.department_id = de.department_id
             and de.location_id = lo.location_id
             and lo.country_id = co.country_id
             and co.region_id = re.region_id
             group by re.region_id) bsal
             
      where bsal.avgsal = msal.maxsal) md
where re.region_id = md.region_id;



--문제10.
select jo.job_title
from jobs jo,
    (select job_id
     from (select max(asal.avgsal) maxsal
           from(select job_id, avg(salary) avgsal
                from employees
                group by job_id) asal ) msal,
           (select job_id, avg(salary) avgsal
           from employees
           group by job_id) bsal
     where bsal.avgsal = msal.maxsal) md
where jo.job_id = md.job_id;
