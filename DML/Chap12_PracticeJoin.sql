/*
문제 1 
employee와 departments 테이블을 INNER, LEFT OUTER, RIGHT OUTER, FULL OUTER 조인하세요
*/
SELECT
    *
FROM
         employees e
    INNER JOIN departments d ON e.department_id = d.department_id;
-- 106개의 행이 존재 

SELECT
    *
FROM
    employees   e
    LEFT OUTER JOIN departments d ON e.department_id = d.department_id;
-- 107개의 행이 존재

SELECT
    *
FROM
    employees   e
    RIGHT OUTER JOIN departments d ON e.department_id = d.department_id;
-- 122개의 행이 존재

SELECT
    *
FROM
    employees   e
    FULL OUTER JOIN departments d ON e.department_id = d.department_id;
--123개의 행이 존재

/*
문제2 
employee, department 테이블을 inner join하세요
조건1 employee_id가 200인 사람의 이름, department_id출력 
조건2 이름 컬럼은 first_name과 last_name을 합쳐서 출력 
*/
SELECT
    e.first_name || e.last_name,
    d.department_id
FROM
         employees e
    INNER JOIN departments d ON e.department_id = d.department_id
WHERE
    e.employee_id = 200;

/*
문제3 
employee, job 테이블을 inner join하세요 
모든 사원의 이름과 직무아이디, 직무 타이틀을 출력하고 이름 기준으로 오름차순 정렬 
*/
SELECT
    e.first_name,
    e.job_id,
    j.job_title
FROM
         employees e
    INNER JOIN jobs j ON e.job_id = j.job_id
ORDER BY
    e.first_name ASC;

/*
문제4 
job, job_history 테이블을 left outer join하세요
*/
SELECT
    *
FROM
    jobs        j
    LEFT OUTER JOIN job_history jh ON j.job_id = jh.job_id;

/*
문제5
Steven King의 부서명을 출력하세요
*/
SELECT
    e.first_name || e.last_name,
    d.department_name
FROM
         employees e
    INNER JOIN departments d ON e.department_id = d.department_id
WHERE
        e.first_name = 'Steven'
    AND e.last_name = 'King';

SELECT
    e.first_name || e.last_name,
    d.department_name
FROM
    employees   e
    LEFT OUTER JOIN departments d ON e.department_id = d.department_id
WHERE
        e.first_name = 'Steven'
    AND e.last_name = 'King';

/*
문제6 
employee, departments 테이블을 cartesian product(CROSS JOIN)처리하세요
*/
SELECT
    *
FROM
         employees e
    CROSS JOIN departments d;

/*
문제 7 
사원과 부서 테이블의 부서번호를 조인하고 SA_MAN 사원만의 사원번호, 이름, 급여, 부서명, 그눔지를 출력하세요
*/
SELECT
    e.employee_id AS 사원번호,
    e.first_name AS 이름,
    e.salary AS 급여,
    d.department_name AS 부서이름,
    d.location_id AS 지역번호,
    L.state_province AS 지역이름
FROM
    employees   e
    LEFT OUTER JOIN departments d ON e.department_id = d.department_id
    LEFT OUTER JOIN locations L ON d.location_id = l.location_id
WHERE
    e.job_id = 'SA_MAN';
    
/*
문제8 
employees, job 테이블을 조인 지정하고 job_title이 'Stock Manager', 'Stock Clerk'인 직원 정보만 출력하세요
*/
SELECT e.first_name, e.last_name, e.salary, j.job_title
FROM employees e LEFT OUTER JOIN jobs j ON e.job_id = j.job_id
WHERE j.job_title = 'Stock Manager' or j.job_title = 'Stock Clerk';

/*
문제9
부서 테이블에서 직원이 없는 부서를 찾아 출력하세요.
*/
--manager_id가 없으면 직원이 없으므로 manager_id로 조회
SELECT count(*)
FROM departments d LEFT OUTER JOIN employees e ON d.department_id = e.department_id
WHERE d.manager_id IS NULL;


/*
문제10
join을 이용해서 사원의 이름과 그 사원의 매니저 이름을 출력하세요
*/
SELECT e1.first_name, e2.first_name
FROM employees e1 INNER JOIN employees e2 ON e1.manager_id = e2.employee_id;

/*
문제11
직원 테이블에서 left join하여 매니저 이름, 매니저 급여까지 출력하세요. 
*/
SELECT DISTINCT e2.first_name, e2.salary
FROM employees e1 LEFT OUTER JOIN employees e2 ON e1.manager_id = e2.employee_id
WHERE e1.manager_id IS NOT NULL
ORDER BY e2.salary DESC;

