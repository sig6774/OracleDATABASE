-- 형 변환
-- TO_CHAR(), TO_NUMBER(), TO_DATE()

--날짜를 문자로 TO_CHAR(값, 형식)
SELECT
    to_char(sysdate)
FROM
    dual;

SELECT
    to_char(sysdate, 'dd/mm/yy')
FROM
    dual;

SELECT
    to_char(sysdate, 'YYYY-MM-DD HH:MI:SS')
FROM
    dual;

SELECT
    to_char(sysdate, 'YY-MM-DD HH24:MI:ss')
FROM
    dual;
--TO_CHAR를 통해서 날짜를 문자열로 변환하고 내가 원하는 형식대로 바꿀 수 있음

SELECT
    first_name,
    to_char(hire_date, 'YY"년"-MM"월"-DD"일"')
FROM
    employees;
--TO_CHAR()에 들어가는 서식문자에 ""로 묶어 값을 삽입할 수 있음

--숫자를 문자로 변환
SELECT
    to_char(3094, '99999')
FROM
    dual;
    
--숫자를 자리수(9~~)에 맞게 문자열로 변환 
SELECT
    to_char(3094.34, '99999.999')
FROM
    dual;
    
--실수도 가능 
SELECT
    to_char(3094, '9,999')
FROM
    dual;
--원하는 방식대로 변경 가능

SELECT
    to_char(salary, 'L99,999') AS salary
FROM
    employees;

--문자를 숫자로 TO_NUMBER(값, 형식) 
SELECT
    '2000' + 2000
FROM
    dual; -- 자동 형 변환 
--자동으로 형변환을 진행하여 4000이 출력

SELECT
    to_number('2000') + 2000
FROM
    dual; -- 명시적 형 변환 

SELECT
    to_number('$3,300', '$9,999') + 2000
FROM
    dual;
--숫자로 변환할 수 없는 문자는 형식에 포함하여 넣어주면 숫자로 변환 가능

--문자를 날짜로 변환하는 함수 TO_DATE(값, 형식)
SELECT
    to_date('2021-11-25')
FROM
    dual;

--DATE는 연산이 가능함으로 문자를 날짜로 변환해서 연산을 진행 가능
SELECT
    ceil(sysdate - to_date('2021-11-25'))
FROM
    dual;

--문자열로 구성된 날짜를 원하는 DATE형식으로 변환가능
--주어진 문자열을 모두 변환해야 함
SELECT
    TO_DATE('2020/12/25', 'YY-MM-DD')
FROM
    dual;

SELECT
    TO_DATE('2021-03-31 12:23', 'YYYY-MM-DD HH:MI')
FROM
    dual;

/* xxxx년 xx월 xx일 문자열 형식으로 변환해 보세요.
조회 컬럼명은 dateInfo로 하겠습니다. */
SELECT
    TO_CHAR(TO_DATE('20050102', 'YYYY MM DD'), 'YYYY"년" MM"일" DD"월"') AS datainfo
FROM
    dual;

--null 제거 함수 NVL(컬럼, 변환할 값)
SELECT
    first_name,
    nvl(commission_pct, 0)
FROM
    employees;
--commission_pct에 있는 null값을 0으로 변환 

SELECT
    first_name,
    nvl(to_char(commission_pct), '뽀나스 없지롱')
FROM
    employees;
-- NVL()는 만약 컬럼의 값이 숫자면 변환할 값도 숫자이고 컬럼의 값이 문자면 변환 값도 문자로 해줘야함

--null 제거함수 NVL2(컬럼, null이 아닐 경우 값, null일 경우 값)
SELECT
    first_name,
    nvl2(to_char(commission_pct), '올~ 뽀나스 존재', '뽀나스 없지롱~')
FROM
    employees;
SELECT
    first_name,
    nvl2(commission_pct, 'TRUE', 'FALSE')
FROM
    employees;
--commission을 받는 사람과 받지 않는 사람을 구분할 수 있음