/* 문제 1
사원 테이블에서 JOB_ID 별 사원 수를 구하세요 
사원 테이블에서 JOB_ID 별 월급의 평균을 구하세요. 월급의 평균 순으로 내림차순 정렬 */

SELECT
    job_id,
    COUNT(job_id),
    AVG(salary)
FROM
    employees
GROUP BY
    job_id
ORDER BY
    AVG(salary);

/* 문제 2
사원 테이블에서 입사 년도 별 사원 수를 구하세요 */

SELECT
    to_char(hire_date, 'YY'),
    COUNT(hire_date)
FROM
    employees
GROUP BY
    to_char(hire_date, 'YY');

/* 문제 3 
급여가 8000이상인 사원들의 부서별 평균 급여를 출력하세요. 단 부서 평균 급여가 2000이상인 부서만 출력 */

SELECT
    department_id,
    trunc(AVG(salary))
FROM
    employees
WHERE
    salary >= 8000
GROUP BY
    department_id
HAVING
    AVG(salary) >= 2000;

/* 문제4
사원 테이블에서 commission_pct 컬럼이 null이 아닌 사람들의 부서별, 월급 평균 합계, count를 구함 
조건1 월급의 평균은 커미션을 적용시킨 월급 
조건2 평균은 소수 2째 자리에서 절삭 */

SELECT
    department_id,
    TRUNC((AVG(salary +(salary * commission_pct))), 2) AS 평균,
    SUM(salary +(salary * commission_pct)) AS 합,
    COUNT(*) AS 수
FROM
    employees
WHERE
    commission_pct IS NOT NULL
GROUP BY
    department_id;