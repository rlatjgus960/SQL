--문제1.
select count(salary)
from employees
where salary < (select avg(salary)
                from employees);

--문제2.
select  em.employee_id 직원번호,
        em.first_name 이름,
        em.salary 급여,
        am.asal 평균급여,
        am.msal 최대급여    
from employees em, (select  avg(salary) asal,
                            max(salary) msal
                    from employees)am
where salary >= am.asal
and salary <= am.msal
order by em.salary asc;

--문제3.
select  lo.location_id,
        lo.street_address,
        lo.postal_code,
        lo.city,
        lo.state_province,
        lo.country_id
from departments de, locations lo
where de.department_id = (select department_id
                          from employees
                          where first_name = 'Steven'
                          and last_name = 'King')
and lo.location_id = de.location_id;

--문제4.
select  employee_id,
        first_name,
        salary
from employees
where salary <any (select salary
                   from employees
                   where job_id = 'ST_MAN')
order by salary desc;

--문제5. 조건절 비교
select  employee_id,
        first_name,
        salary,
        department_id
from employees
where (department_id, salary) in (select department_id, max(salary)
                                  from employees
                                  group by department_id)
order by salary desc;

--문제5. 테이블조인
select  em.employee_id,
        em.first_name,
        em.salary,
        em.department_id
from employees em, (select department_id, max(salary) msal
                    from employees
                    group by department_id)dm
where em.department_id = dm.department_id
and em.salary = dm.msal
order by em.salary desc;


--문제6.
select  ss.job_id,
        ss.ssal
from jobs jo, (select job_id, 
                      sum(salary) ssal
               from employees
               group by job_id)ss
where ss.job_id = jo.job_id
order by ss.ssal desc;

--문제7.
select  em.employee_id,
        em.first_name,
        em.salary
from employees em, (select department_id, avg(salary) asal
                    from employees
                    group by department_id) da
where em.department_id = da.department_id
and em.salary > da.asal;

--문제8.
select  rl.rn,
        rl.employee_id,
        rl.first_name,
        rl.salary,
        rl.hire_date
from(select  rownum rn,
             ol.employee_id,
             ol.first_name,
             ol.salary,
             ol.hire_date
     from(select employee_id,
                 first_name,
                 salary,
                 hire_date
          from employees
          order by hire_date asc)ol)rl
where rl.rn between 11 and 15;
