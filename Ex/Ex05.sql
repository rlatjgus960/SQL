/*
-EQUI Join --> null 포함되지 않는다
-OUTER Join(left right full) --> null 포함시켜야 할 때
 (+) <-- 오라클
-Self Join
*/

select  emp.employee_id,
        emp.first_name,
        emp.manager_id,
        man.first_name
from employees emp, employees man
where emp.manager_id = man.employee_id;


/*SubQuery*/

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


select first_name, salary, employee_id
from employees
where salary = (select min(salary)
                from employees);
                

select first_name, salary
from employees
where salary < (select avg(salary)
                from employees);
                
                
/*다중행 SubQuery*/
-- 부서번호 110인 직원의 급여 리스트를 구한다. shelley 12008, william 8300
select first_name, salary
from employees
where department_id = 110;

-- 급여가 12008, 8300인 직원 리스트를 구한다.
select *
from employees
where salary in (12008, 8300);

select first_name, salary
from employees
where salary in (select salary
                from employees
                where department_id = 110);


--예제) 각 부서별로 최고급여를 받는 사원을 출력하세요              
-- 그룹별 최고급여를 구한다
select max(salary)
from employees
group by department_id;

-- 사원 테이블에서 그룹번호와 급여가 같은 직원의 정보를 구한다.
select  first_name,
        salary,
        department_id
from employees
order by department_id;

select  first_name,
        salary,
        department_id
from employees
where (department_id, salary) in (select department_id, max(salary)
                                 from employees
                                 group by department_id);
                                 


--예제) 부서번호가 110인 직원의 급여 보다 큰 모든 직원의 사번, 이름, 급여를 출력하세요
--(or 연산 --> 8300보다 큰)

--1. 부서번호가 110인 직원 리스트 12008, 8300
select salary
from employees
where department_id = 110;


--2. 12008, 8300 보다 급여가 큰 직원 리스트를 구하시오
select  employee_id,
        first_name,
        salary
from employees emp
where salary > 12008
or salary > 8300;

select  employee_id,
        first_name,
        salary
from employees
where salary >any (select salary
                   from employees
                   where department_id = 110);

--all <--> any와 비교
select  employee_id,
        first_name,
        salary
from employees
where salary >all (select salary
                   from employees
                   where department_id = 110);


--예제
--각 부서별로 최고급여를 받는 사원을 출력하세요
--1. 각 부서별 최고 급여 리스트 구하기
select department_id, max(salary)
from employees
group by department_id;

--2. 직원테이블 부서코드, 급여가 동시에 같은 직원 리스트 출력하기
select  first_name, 
        department_id,
        salary
from employees
where (nvl(department_id,0), salary) in (select nvl(department_id,0), max(salary)
                                  from employees
                                  group by department_id);
                                  
                                  
                                  
--예제(join)
--각 부서별로 최고급여를 받는 사원을 출력하세요
--1. 각 부서별 최고 급여 테이블 s
    select department_id, max(salary)
    from employees
    group by department_id;
    
--2. 직원 테이블과 조인한다 e
    --e.부서번호 = s.부서번호     e.급여 = s.급여(최고급여)
    select  e.employee_id,
            e.first_name,
            e.department_id,
            e.salary,
            s.department_id, --추가된 컬럼
            s.msalary --추가된 컬럼
    from employees e, (select department_id, max(salary) mSalary
                       from employees
                       group by department_id) s
    where e.department_id = s.department_id
    and e.salary = s.msalary;

/******************
roenum
*******************/
--예) 급여를 가장 많이 받는 5명의 직원의 이름을 출력하시오.
--정렬을 하면 rownum이 섞인다. (x) --> 정렬을 하고 rownum 한다
select  rownum,
        employee_id,
        first_name,
        salary
from employees
where rownum >= 1
and rownum <= 5
order by salary desc;

--> 정렬을 하고 rownum 한다
select  rownum
        employee_id,
        first_name,
        salary        
from (select employee_id,
             first_name,
             salary
      from employees
      order by salary desc) -- 정렬되어있는 테이블이면?
where rownum >= 1 --rownum >= 2 --> 데이터가 없다
and rownum <= 3;

----> (1)정렬을 하고, rownum하고 where절을 한다

select  ort.rn,
        ort.employee_id,
        ort.first_name,
        ort.salary
from (select  rownum rn,
        ot.employee_id,
        ot.first_name,
        ot.salary
      from (select  employee_id,
                    first_name,
                    salary
            from employees
            order by salary desc) ot) ort
where rn >= 2
and rn <= 5;



select  rownum,
        ot.employee_id,
        ot.first_name,
        ot.salary
from (select  employee_id,
              first_name,
              salary
      from employees
      order by salary desc) ot;

(select  employee_id,
        first_name,
        salary
from employees
order by salary desc) ot ; --(1)


-- 07년에 입사한 직원중 급여가 많은 직원의 3-7등 이름 급여 입사일

select  ort.rn,
        ort.first_name,
        ort.salary,
        ort.hire_date
from (select  rownum rn,
              ot.first_name,
              ot.salary,
              ot.hire_date
      from (select  first_name,
                    salary,
                    hire_date
            from employees
            where to_char(hire_date, 'YY') = 07
            order by salary desc) ot) ort
where ort.rn >= 3
and ort.rn <= 7;




select  first_name,
        salary,
        hire_date
from employees
where to_char(hire_date, 'YY') = 07
order by salary desc;