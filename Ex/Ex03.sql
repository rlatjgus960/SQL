/*그룹함수*/

--단일행함수
select first_name, round(salary, -4)
from employees;

--그룹함수 --> 오류발생(반드시 이유를 확인할 것)
select first_name, avg(salary)
from employees;

--그룹함수 count() row의 수를 세어줌(데이터 수)
select  count(*),
        count(first_name), --컬럼명 사용시 null을 제외한 count
        count(commission_pct) --컬럼명 사용시 null을 제외한 count
from employees;

    --조건절 추가
select count(*), salary --> salary는 row가 3개이기 때문에 함께 사용할 수 없다.
from employees
where salary > 16000;

--그룹함수 sum
select sum(salary), count(*) --> 이런 경우에는 한 열에 표현 가능하므로 사용가능
from employees;

--그룹함수 avg() null일때 0으로 변환해서 사용
select  count(*),
        count(commission_pct), --35 commission_pct 값이 있는 직원
        sum(commission_pct), --전체합계
        avg(nvl(commission_pct,0)),  -- avg(commission_pct) : commission_pct가 null인 사람 포함 여부 --> null은 포함하지 않는다.
        sum(commission_pct)/count(*),  --null 포함
        sum(commission_pct)/count(commission_pct) --null 제외
from employees;

select  count(*),
        sum(salary),
        avg(salary),
        sum(salary)/count(*)
from employees;


--그룹함수 max() min()
select max(salary), min(salary)
from employees;

select first_name, salary
from employees
order by salary desc;

/*groub by 절*/
select department_id, salary
from employees
order by department_id asc;

--부서번호, 부서별 평균
select department_id, avg(salary)
from employees
group by department_id
order by department_id asc;


--group by절 사용시 주의 : 그룹바이에 참여한 컬럼이나 함수만 쓸 수 있다
--되는 경우
select department_id, count(*), sum(salary)
from employees
group by department_id;

---안되는 경우
select department_id, job_id, count(*), sum(salary)
from employees
group by department_id;


--그룹을 더 세분화
select department_id, job_id, avg(salary)
from employees
group by department_id,job_id;

--예제)
select department_id, count(*),sum(salary)
from employees
group by department_id;

--그룹 함수는 where 절에서 사용할 수 없다.
select department_id, count(*),sum(salary)
from employees
where sum(salary)>=20000
group by department_id;

--그룹전용 where 절 --> having 절 
select department_id, count(*), sum(salary)
from employees
group by department_id
having sum(salary) >= 20000;

-- sum (salary) > 20000 이상이면서 부서코드 100인 숫자, 급여합계
select department_id ,count(*),sum(salary)
from employees
where department_id =100
group by department_id
having sum(salary)>=20000;

--그룹전용 where 절 --> having절
select department_id, count(*), sum(salary)
from employees
group by department_id
having sum(salary)>= 20000;

--case ~ end 문
select employee_id, 
            job_id, 
            salary, 
            case
                when job_id = 'AC_ACCOUNT' then salary+salary*0.1
                when job_id = 'SE_REP' then salary+salary*0.2
                when job_id = 'ST_CLERK' then salary+salary*0.3
                else salary
            end rSalary
from employees;

--decode()
select  employee_id,
        job_id,
        salary,
        decode(
            job_id, 'AC_ACCOUNT', salary+salary*0.1,
                    'SE_REP', salary+salary*0.2,
                    'ST_CLERK', salary+salary*0.3,
            salary) as rSalary
from employees


--Join
select *
from employees;

select * 
from departments;

select  first_name, 
        hire_date,
        department_name,
        em.department_id,
        de.manager_id
from employees em, departments de
where em.department_id = de.department_id; -->서로 연결해주기 
