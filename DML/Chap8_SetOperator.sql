-- 집합 연산자
-- union(합집합 중복X), union all(합집합 중복O), minus(차집합), intersect(교집합)
-- 비교하고자 하는 table의 위, 아래 column 개수가 정확하게 일치해야함

SELECT
    employee_id,
    first_name
FROM
    employees
WHERE
    hire_date LIKE '04%'
UNION
SELECT
    employee_id,
    first_name
FROM
    employees
WHERE
    department_id = 20;
--두개의 조회 쿼리를 합쳐서 조회 결과를 출력해줌 하지만 UNION은 중복된 결과는 제외함 

SELECT
    employee_id,
    first_name
FROM
    employees
WHERE
    hire_date LIKE '04%'
UNION ALL
SELECT
    employee_id,
    first_name
FROM
    employees
WHERE
    department_id = 20;
--중복 허용

SELECT
    employee_id,
    first_name
FROM
    employees
    
WHERE
    hire_date LIKE '04%'
INTERSECT
SELECT
    employee_id,
    first_name
FROM
    employees
WHERE
    department_id = 20;
--각 조회 쿼리 결과에서 공통으로 겹치는 부분을 출력

SELECT
    employee_id,
    first_name
FROM
    employees
WHERE
    hire_date LIKE '04%'
MINUS
SELECT
    employee_id,
    first_name
FROM
    employees
WHERE
    department_id = 20;
--위의 조회값을 기준으로 교집합 내용은 삭제