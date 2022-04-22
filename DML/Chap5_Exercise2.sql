/* 문제 1
    EMPLOYEES 테이블에서 이름, 입사일자 컬럼을 변경해서 이름순으로 오름차순 출력합니다.
    조건1) 이름 컬럼은 first_name, last_name을 붙여서 출력합니다.
    조건2) 입사일자 컬럼은 xx/xx/xx로 저장되어 있습니다. xxxxxx형태로 변경해서 출력합니다.
*/
SELECT
    first_name
    || ' '
    || last_name                AS 이름,
    replace(hire_date, '/', '') AS 입사일자
FROM
    employees
ORDER BY
    이름 ASC;

SELECT
    concat(first_name, last_name) AS 이름,
    replace(hire_date, '/', '')   AS 입사일자
FROM
    employees
ORDER BY
    이름 ASC;

/* 문제 2 
    EMPLOYEES 테이블에서 phone_number 컬럼은 ###.###.###형태로 저장되어 있다
    여기서 처음 세자리 숫자 대신 서울 지역번호(02)를 붙여 전화 번호를 출력하도록 쿼리를 작성하세요.
*/
SELECT
    replace(phone_number, substr(phone_number, 1, 3), '(02)') AS 전화번호
FROM
    employees;
    
SELECT
    concat('(02)', substr(phone_number, 4, length(phone_number))) AS phone_number
FROM
    employees;

/* 문제 3
    EMPLOYEES 테이블에서 JOB_ID가 it_prog인 사원의 이름(first_name)과 급여(salary)를 출력하세요
    조건1. 비교하기 위한 값은 소문자로 입력
    조건2. 이름은 앞 3문자까지 출력하고 나머지는 *로 출력 이열의 별칭은 name
    조건3. 급여는 전체 10자리로 출력하되 나머지 자리는 *로 출력합니다. 이열의 열 별칭은 salary입니다
    */
SELECT
    rpad(substr(first_name, 1, 3), length(first_name), '*') AS name,
    lpad(salary, 10, '*')                                   AS salary
FROM
    employees
WHERE
    lower(job_id) = 'it_prog';