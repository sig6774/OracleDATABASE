-- 한줄 주석
/*
여러줄 주석 */

/*  employees에 있는 모든 데이터를 선택
    SELECT 컬럼명(여러개 가능) FROM 테이블 이름; */
SELECT * FROM EMPLOYEES;

SELECT employee_id, first_name, last_name FROM employees;
--특정 컬럼들의 이름을 적어 세부적으로 조회가능

SELECT
    employee_id,
    first_name,
    last_name,
    salary,
    salary + salary*0.1
FROM employees;
--컬럼을 조회하는 위치에서 사칙연산 가능 

SELECT department_id, commission_pct
FROM employees;
--null : '데이터가 없다'는 뜻이며 숫자 0이나 공백이랑은 다른 것이고 '데이터가 비어있다'라는 뜻을 말함

SELECT first_name as 이름, last_name as 성, salary as 급여
FROM EMPLOYEES;
--alias or as를 통해 조회할 때 컬럼 or 테이블 명칭을 다른이름으로 붙여서 조회할 수 있음

/* sql에서는 문자열을 연결할 때 ||을 사용하며 
    '사용하여 새로운 문자열을 추가할 수 있음 */
    
SELECT 
FIRST_NAME || '' || LAST_NAME || '''s salary is $' || SALARY as 급여내역
FROM EMPLOYEES;

SELECT DISTINCT DEPARTMENT_ID FROM EMPLOYEES;
--DISTINCT : 조회할 때 중복을 제거하여 출력

/*  ROWNUM ROWID
    (중요)ROWNUM : Query에 의해 반환되는 행 번호 출력
    ROWID : DB에서 행의 주소값을 반환 */
SELECT ROWNUM, ROWID, EMPLOYEE_ID
FROM EMPLOYEES;

SELECT SALARY 
FROM employees
WHERE department_id = 80;

SELECT
    job_id,
    SUM(salary),
    AVG(salary)
FROM
    employees
GROUP BY (
    job_id
)
ORDER BY
    AVG(salary) DESC;
-- ctrl + f7을 누르면 줄개행으로 가독성있는 SQL구문 작성 가능 


