--NULL
SELECT first_name, salary, commission_pct, salary*commission_pct
FROM employees
WHERE salary BETWEEN 13000 AND 15000;


select first_name, salary, commission_pct
from employees
where commission_pct is null;

--예제) 커미션 비율이 있는 사원의 이름, 연봉, 커미션 비율을 출력하세요
select first_name, salary, commission_pct
from employees
where commission_pct is not null;

--예제) 담당매니저가 없고 커미션 비율이 없는 직원의 이름을 출력하세요
select first_name
from employees
where commission_pct is null 
and manager_id is null;


--order by
select first_name, salary
from employees
order by salary desc; --내림차순

select first_name, salary
from employees
order by salary asc; --오름차순

select first_name, salary
from employees
order by salary asc, first_name asc; --오름차순

--부서번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하세요
select department_id, salary, first_name
from employees
order by department_id asc;

--급여가 10000 이상인 직원의 이름 급여를 급여가 큰직원부터 출력하세요
select first_name, salary
from employees
where salary >=10000
order by salary desc;


--부서번호를 오름차순으로 정렬하고 부서번호가 같으면 급여가 높은 사람부터 부서번호 급여 이름을 출력하세요  
select department_id, salary, first_name
from employees
order by department_id asc, salary desc; 


/*단일행 함수*/
--가상의 테이블 dual
select initcap('aaaaa')
from dual;

--initcap() : 첫글자만 대문자, 나머지 소문자로
select email, initcap(email), department_id 
from employees
where department_id = 100;

--lower(), upper()
select first_name, lower(first_name), upper(first_name)
from employees
where department_id = 100;

--substr(항목, 시작위치, 출력할 글자수)
select substr('abcdefg', 3, 3) 
from dual;

select first_name, substr(first_name, 1, 3), substr(first_name, -3, 3)
from employees
where department_id = 100;

--lpad() rpad()
select first_name,
       lpad(first_name, 10, '*'),
       rpad(first_name, 10, '*')
from employees;

--replace()
select  first_name,
        replace(first_name, 'a', '*'),
        replace(first_name, substr(first_name, 2, 3), '***')
from employees;

select first_name, substr(first_name, 2, 3)
from employees;

/*숫자함수*/
--round 반올림
select  round(123.346, 2) r2,
        round(123.346, 0) r0, --소수점에서 반올림
        round(123.346, -1) "r-1" --1의자리에서 반올림(정수부분)
from dual;

--trunc 버림
select  trunc(123.456, 2),
        trunc(123.956, 0),
        trunc(123.456, -1)
from dual;

/*날짜 함수*/
select sysdate
from dual;

--MONTHS_BETWEEN(d1, d2)
select  sysdate,
        hire_date,
        round(MONTHS_BETWEEN(SYSDATE,hire_date),0)
from employees;

/*변환함수*/
select first_name, salary*12, to_char(salary*12, '$999,999.99') --형식 입력
from employees
where department_id = 110;

select  to_char(9876, '99999'),
        to_char(9876, '099999'),
        to_char(9876, '$99999'),
        to_char(9876, '9999.99'),
        to_char(9876, '99,999')
from dual;

--to_char() 날짜 --> 문자열
select  sysdate, 
        to_char(sysdate, 'YYYY-MM-DD HH:MI:SS'),
        to_char(sysdate, '"YYYY년" "MM월" "DD일"'),

        to_char(sysdate, 'YYYY'),
        to_char(sysdate, 'YY'),
        to_char(sysdate, 'MM'),
        to_char(sysdate, 'MON'),
        to_char(sysdate, 'DAY'),
        to_char(sysdate, 'HH'),
        to_char(sysdate, 'HH24'),
        to_char(sysdate, 'MI'),
        to_char(sysdate, 'SS')
from dual;

--nvl() nvl2()
select  first_name,
        commission_pct,
        nvl(commission_pct, 0),
        nvl2(commission_pct, 100, 0)
from employees;
