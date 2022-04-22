--그룹함수 AVG, MAX, MIN, SUM, COUNT 

SELECT
    COUNT(*)
FROM
    employees
WHERE
    job_id = 'IT_PROG';

SELECT
    job_id,
    round(AVG(salary), 0) AS 평균급여,
    round(MAX(salary), 0),
    round(MIN(salary), 0),
    round(SUM(salary), 0),
    COUNT(salary)
FROM
    employees
WHERE
    salary >= 5000
GROUP BY
    job_id
ORDER BY
    평균급여 DESC;
    
SELECT
    COUNT(*)
FROM
    employees;

SELECT
    COUNT(first_name)
FROM
    employees;

SELECT
    COUNT(commission_pct)
FROM
    employees;
/* commission_pct는 null값이 있는 컬럼이므로 
'null은 값이 비어있다'라는 뜻이므로 count하지 않음 */



SELECT
    COUNT(commission_pct)
FROM
    employees
WHERE
    commission_pct IS NOT NULL;

SELECT
    department_id,
    trunc(AVG(salary)) AS 평균급여
FROM
    employees
GROUP BY
    department_id
ORDER BY
    평균급여 DESC;
/*select에 그룹함수를 사용한 컬럼이 아닌 일반 컬럼이 있으면 GROUP BY 해야 조회 가능
즉, 그룹함수는 일반 컬럼과 동시에 그냥 출력할 수 없음 */

SELECT
    job_id,
    department_id,
    trunc(AVG(salary))
FROM
    employees
GROUP BY
    department_id,
    job_id;
--그룹함수를 사용할 때 같이 일반 컬럼을 1개 이상 쓰면 일반 컬럼은 GROUP BY에 전부 써야함 

--HAVING
SELECT department_id, SUM(salary)
FROM employees
GROUP BY department_id
HAVING SUM(salary) > 100000;
/* WHERE절에 group함수를 쓰면 GROUPBY보다 먼저 연산을 수행하기 때문에 에러가 남
그렇기 때문에 HAVING을 써서 그룹화 이후 조건을 걸어줌 */

SELECT
    job_id,
    COUNT(job_id),
    count(*)
FROM
    employees
GROUP BY
    job_id
HAVING
    COUNT(job_id) >= 20;
--job별 근무하는 직원 수가 20명 이상 일때 조회

--부서 아이디가 50이상인 것들을 그룹화 시키고, 그룹 월급 평균 중 5000이상만 조회 
SELECT
    department_id,
    AVG(salary)
FROM
    employees
GROUP BY
    department_id
HAVING department_id >= 50
       AND AVG(salary) >= 5000
ORDER BY
    department_id ASC;
    
SELECT
    department_id,
    AVG(salary)
FROM
    employees
WHERE
    department_id >= 50
GROUP BY
    department_id
HAVING
    AVG(salary) >= 5000
ORDER BY
    department_id ASC;