/*
서브쿼리 
- 사용방법 : ()안에 명시 
  서브쿼리절의 리턴행이 1줄 이하여야 함
- 서브쿼리 절에는 비교할 대상이 반드시 하나 들어가야 함
- 해석할 때는 서브쿼리절부터 먼저 해석
*/

--단일 행 서브쿼리
--Nancy의 급여보다 많은 사람 검색
SELECT
    e.first_name,
    e.salary
FROM
    employees e
WHERE
    e.salary > (
        SELECT
            salary
        FROM
            employees
        WHERE
            first_name = 'Nancy'
    );
    
--employee_id가 103번인 사람과 job_id가 동일한 사람을 검색
SELECT
    *
FROM
    employees
WHERE
    job_id = (
        SELECT
            job_id
        FROM
            employees
        WHERE
            employee_id = 103
    );
    
    
    
    
    
--다중 행 서브쿼리
SELECT * FROM employees
WHERE job_id = (SELECT job_id
FROM employees
WHERE job_id = 'IT_PROG');
--반환 행이 2개 이상임으로 오류 발생함 

/* 다중 행 연산자
IN : 목록의 어떤 값과 같은지 확인
ANY : 값을 서브쿼리에 의해 리턴된 각각의 값과 비교하며 하나라도 만족하면 됨
ALL : 값을 서브쿼리에 의해 리턴된 각각의 값과 비교해서 모두 만족해야함
*/
--IN 연산자
SELECT
    *
FROM
    employees
WHERE
    job_id IN (
        SELECT
            job_id
        FROM
            employees
        WHERE
            job_id = 'IT_PROG'
    );
--IT_PROG의 값과 같은 값이 있는지 확인하여 조회

--ANY 
--first_name이 David인 사람 중 가장 작은 값보다 급여가 큰 사람을 조회
SELECT
    *
FROM
    employees
WHERE
    salary > ANY (
        SELECT
            salary
        FROM
            employees
        WHERE
            first_name = 'David'
    );
--ANY : 서브쿼리의 결과가 앞의 부등호를 하나라도 만족하면 모두 조회 
--이러면 최소값을 찾을 수 있겠네

--ALL
SELECT
    salary
FROM
    employees
WHERE
    salary > ALL (
        SELECT
            salary
        FROM
            employees
        WHERE
            first_name = 'David'
    );

--스칼라 서브쿼리
--SELECT 구문에 서브쿼리가 오는 것이며 LEFT OUTER JOIN과 유사한 결과

SELECT
    e.first_name,
    d.department_name
FROM
    employees   e
    LEFT OUTER JOIN departments d ON e.department_id = d.department_id
ORDER BY
    first_name ASC;
    
SELECT
    e.first_name,
    (
        SELECT
            d.department_name
        FROM
            departments d
        WHERE
            d.department_id = e.department_id
    ) AS department_name
FROM
    employees e
ORDER BY
    first_name ASC;
    
--각 부서의 매니저 이름
--LEFT OUTER JOIN
SELECT
    d.*,
    e.first_name AS 매니저아이디
FROM
    departments d
    LEFT OUTER JOIN employees   e ON d.manager_id = e.employee_id
ORDER BY
    d.manager_id ASC;
    
--scalar sub query
SELECT
    d.*,
    (
        SELECT
            e.first_name
        FROM
            employees e
        WHERE
            d.manager_id = e.employee_id
    ) AS 매니저이름
FROM
    departments d
ORDER BY
    d.manager_id ASC;
/*
- 스칼라 서브쿼리가 조인보다 좋은 경우 : 함수처럼 한 레코드당 정확히 하나의 값만을 반환할 때 
- 조인이 스칼라 서브쿼리보다 좋은 경우 : 조회할 데이터가 대용량인 경우, 해당 데이터가 수정, 삭제 등이 빈번한 경우
*/

--각 부서별 사원수 뽑기
SELECT
    d.*,
    (
        SELECT
            COUNT(e.department_id)
        FROM
            employees e
        WHERE
            d.department_id = e.department_id
        GROUP BY
            e.department_id
    ) AS 사원수
FROM
    departments d;

SELECT
    d.*,
    (
        SELECT
            COUNT(e.department_id)
        FROM
            employees e
        GROUP BY
            e.department_id
        HAVING
            d.department_id = e.department_id
    ) AS 사원수
FROM
    departments d;
    
--인라인 뷰(FROM 구문에 서브쿼리가 오는것)
--순번을 정해놓은 조회 자료를 범위를 지정해서 가지고 오는 경우
SELECT employee_id, first_name, salary
FROM employees
ORDER BY salary DESC;

--ROWNUM을 이용하여 순서를 만들 수 있음
--salary로 정렬을 진행하면서 ROWNUM을 붙이면 ROWNUM이 정렬되지 않는 사태 발생
--해결방법은 정렬이 미리 진행된 자료에 ROWNUM을 붙여서 다시 조회하는 것이 좋음

SELECT
    *
FROM
    (
        SELECT
            ROWNUM AS rn,
            tbl.*
        FROM
            (
                SELECT
                    employee_id,
                    first_name,
                    salary
                FROM
                    employees
                ORDER BY
                    salary DESC
            ) tbl
    )tbl2
WHERE
        rn <= 20
    AND rn > 10;
--가장 안쪽 SELECT절에서 필요한 테이블 형식을 생성 
--바깥쪽 SELECT 절에서 ROWNUM을 붙여서 다시 조회 
--가장 바깥쪽 SELECT 절에서는 이미 붙어있는 ROWNUM의 범위를 지정해서 조회
--실행순서 : FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY

SELECT tt.name, tt.* FROM 
(SELECT TO_CHAR(TO_DATE(test, 'YY/MM/DD'), 'MMDD') as mm, name FROM
(SELECT
    '홍길동'      AS name,
    '20211126' AS test
FROM
    dual
UNION ALL
SELECT
    '김철수',
    '20210301'
FROM
    dual
UNION ALL
SELECT
    '박영희',
    '20210401'
FROM
    dual
UNION ALL
SELECT
    '김뽀삐',
    '20210501'
FROM
    dual
UNION ALL
SELECT
    '박뚜띠',
    '20210601'
FROM
    dual
UNION ALL
SELECT
    '김테스트',
    '20210701'
FROM
    dual)) tt
WHERE mm = '0401';