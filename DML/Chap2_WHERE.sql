SELECT
    salary
FROM
    employees
WHERE
    salary > 5000;

SELECT
    first_name,
    last_name,
    job_id
FROM
    employees
WHERE
    job_id = 'IT_PROG';

SELECT
    *
FROM
    employees
WHERE
    last_name = 'King';

SELECT
    *
FROM
    employees
WHERE
    department_id = 90;

SELECT
    *
FROM
    employees
WHERE
    salary >= 15000;

SELECT
    *
FROM
    employees
WHERE
    hire_date = '04/01/30';

--데이터 행 제한 (BETWEEN, IN, LIKE)
SELECT
    *
FROM
    employees
WHERE
    salary BETWEEN 15000 AND 20000;

SELECT
    *
FROM
    employees
WHERE
    hire_date BETWEEN '03/01/01' AND '03/12/31';

--IN연산자의 사용 (특정 값들과 비교할 때 사용)
SELECT
    *
FROM
    employees
WHERE
    manager_id IN ( 100, 101, 102 );

SELECT
    *
FROM
    employees
WHERE
    job_id IN ( 'IT_PROG', 'AD_VP' );
/*LIEK 연산자 
%는 뭐든, _는 데이터의 위치를 찾아낼 때 */

SELECT
    first_name,
    hire_date
FROM
    employees
WHERE
    hire_date LIKE '03%';
--hire_date가 03으로 시작하는 것 모든 것 조회

SELECT
    first_name,
    hire_date
FROM
    employees
WHERE
    hire_date LIKE '%15';
--hire_date가 15로 끝나는 것 모든 것 조회

SELECT
    first_name,
    hire_date
FROM
    employees
WHERE
    hire_date LIKE '%05%';
--hire_date가 앞 뒤가 05가 있는 모든 것 조회

SELECT
    first_name,
    hire_date
FROM
    employees
WHERE
    hire_date LIKE '___05%';
--4,5번째에서 05로 시작하고 이후 뒤에는 상관 X, 여기서는 5월로 시작하는 것 조회

--IS NULL (null값을 찾는 것)
SELECT
    *
FROM
    employees
WHERE
    manager_id IS NULL;
-- manager_id가 null인 것을 조회

SELECT
    *
FROM
    employees
WHERE
    commission_pct IS NULL;
-- commission_pct가 null인 것을 조회

SELECT
    *
FROM
    employees
WHERE
    commission_pct IS NOT NULL;
-- commission_pct가 null인 아닌 것을 조회

-- AND, OR 
-- AND가 OR 보다 연산순서가 우선
SELECT
    *
FROM
    employees
WHERE
    job_id = 'IT_PROG'
    OR job_id = 'FI_MGR'
    AND salary >= 6000;
-- IT_PROG 이거나 FI_MGR인 사람의 연봉이 6000이상인 사람을 조회하기 때문에 6000이상이 아닌 사람도 조회

SELECT
    *
FROM
    employees
WHERE
    ( job_id = 'IT_PROG'
      OR job_id = 'FI_MGR' )
    AND salary >= 6000;
-- 연산순서 : salary가 6000이상으로 거르고 job_id가 FI_MGR이거나 IT_PROG이거나

-- 데이터 정렬 (SELECT 구문의 가장 마지막에 배치)
-- ASC(오름차순 정렬, 기본값) DESC(내림차순 정렬)

SELECT
    *
FROM
    employees
ORDER BY
    hire_data ASC;

SELECT
    *
FROM
    employees
WHERE
    job_id = 'IT_PROG'
ORDER BY
    first_name ASC;
--직업아이디가 IT_PROG인 사람을 first_name을 A부터 차근 차근 내려가도록 정렬

SELECT
    *
FROM
    employees
WHERE
    salary >= 5000
ORDER BY
    employee_id DESC;
--연봉이 5천이 넘는 사람 중 사원번호가 큰 값부터 내려가도록 정렬

SELECT
    first_name,
    salary * 12 AS 연봉
FROM
    employees
ORDER BY
    연봉 DESC;