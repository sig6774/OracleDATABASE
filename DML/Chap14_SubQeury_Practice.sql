SELECT
    *
FROM
    employees e
WHERE
    e.salary > (
        SELECT
            AVG(e2.salary)
        FROM
            employees e2
    );

SELECT
    COUNT(*)
FROM
    employees e
WHERE
    e.salary > (
        SELECT
            AVG(e2.salary)
        FROM
            employees e2
    );

SELECT
    *
FROM
    employees e
WHERE
    e.salary > (
        SELECT
            AVG(e2.salary)
        FROM
            employees e2
        WHERE
            e2.job_id = 'IT_PROG'
    );

SELECT
    *
FROM
    employees e
WHERE
    e.department_id = (
        SELECT
            d.department_id
        FROM
            departments d
        WHERE
            manager_id = 100
    );

SELECT
    *
FROM
    employees
WHERE
    manager_id > (
        SELECT
            e.manager_id
        FROM
            employees e
        WHERE
            e.first_name = 'Pat'
    );

SELECT
    *
FROM
    employees
WHERE
    manager_id IN (
        SELECT
            e.manager_id
        FROM
            employees e
        WHERE
            e.first_name = 'James'
    );

SELECT
    *
FROM
    (
        SELECT
            ROWNUM AS num,
            tr.first_name
        FROM
            (
                SELECT
                    *
                FROM
                    employees e
                ORDER BY
                    e.first_name DESC
            ) tr
    )
WHERE
        num >= 41
    AND num <= 50;

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
                    e.employee_id,
                    e.first_name,
                    e.phone_number,
                    e.hire_date
                FROM
                    employees e
                ORDER BY
                    e.hire_date ASC
            ) tbl
    )
WHERE
        rn > 30
    AND rn <= 40;

/*
문제 6 
직원 테이블 부서 테이블을 left 조인하세요 
- 직원 아이디, 이름(성, 이름), 부서아이디, 부서명만 출력 
- 직원 아이디 기준 오름차순 정렬
*/

SELECT
    e.employee_id,
    e.first_name || e.last_name,
    d.department_id,
    d.department_name
FROM
    employees   e
    LEFT OUTER JOIN departments d ON e.department_id = d.department_id
ORDER BY
    e.employee_id DESC;

/*
문제 7
문제 6의 결과를 스칼라 쿼리로 동일하게 조회 
*/
SELECT
    e.employee_id,
    e.first_name || e.last_name,
    e.department_id,
    (
        SELECT
            d.department_name
        FROM
            departments d
        WHERE
            e.department_id = d.department_id
    ) AS 부서이름
FROM
    employees e
ORDER BY
    e.employee_id DESC;

/*
문제 8
departments 테이블 locations 테이블을 left 조인하세요
- 부서아아디, 부서이름, 매니저아아디, 로케이션 아이디, 스트릿 어드레스 ,포스트 코드, 시티만 출력
- 부서아이디 기준 오름차순 정렬
*/
SELECT
    d.department_id,
    d.department_name,
    d.manager_id,
    d.location_id,
    l.street_address,
    l.postal_code,
    l.city
FROM
    departments d
    LEFT OUTER JOIN locations   l ON d.location_id = l.location_id
ORDER BY
    d.department_id ASC;

/*
문제 9
문제 8의 결과를 스칼라 쿼리로 동일하게 조회 
*/
SELECT
    d.department_id,
    d.department_name,
    d.manager_id,
    d.location_id,
    (
        SELECT
            l.street_address
        FROM
            locations l
        WHERE
            d.location_id = l.location_id
    ) AS 지역주소,
    (
        SELECT
            l.postal_code
        FROM
            locations l
        WHERE
            d.location_id = l.location_id
    ) AS postal_code,
    (
        SELECT
            l.city
        FROM
            locations l
        WHERE
            d.location_id = l.location_id
    ) AS 도시
FROM
    departments d
ORDER BY
    d.department_id ASC;
--조인이 훨씬 좋음

/*
문제 10 
locations 테이블 countries 테이블을 left 조인하세요
- 로케이션 아이디, 주소, 시티, 나라 아이디, 나라 이름만 출력 
- 나라 이름 기준 오름차순 정렬 
*/
SELECT
    l.location_id,
    l.street_address,
    l.postal_code,
    l.city,
    c.country_id,
    c.country_name
FROM
    countries c
    LEFT OUTER JOIN locations l ON l.country_id = c.country_id
ORDER BY
    c.country_name;


/*
문제 11
문제 10의 결과를 스칼라 쿼리로 동일하게 조회
*/
SELECT
    l.location_id,
    l.street_address,
    l.postal_code,
    l.city,
    (
        SELECT
            c.country_id
        FROM
            countries c
        WHERE
            l.country_id = c.country_id
    ) AS 나라아이디,
    (
        SELECT
            c.country_name
        FROM
            countries c
        WHERE
            l.country_id = c.country_id
    ) AS 나라이름
FROM
    locations l
ORDER BY
    나라이름;  

--문제 12
SELECT
    *
FROM
    (
        SELECT
            ROWNUM AS num,
            tt.*
        FROM
            (
                SELECT
                    e.employee_id,
                    e.first_name,
                    e.phone_number,
                    e.hire_date,
                    d.department_id,
                    d.department_name
                FROM
                    employees   e
                    LEFT OUTER JOIN departments d ON d.department_id = e.department_id
                ORDER BY
                    e.hire_date ASC
            ) tt
    )
WHERE
        num > 0
    AND num <= 10;   

--문제 13 
SELECT
    e.last_name,
    e.job_id,
    e.department_id,
    d.department_name
FROM
    employees   e
    LEFT OUTER JOIN departments d ON e.department_id = d.department_id
WHERE
    e.job_id = 'SA_MAN';
    
SELECT
    d.department_name,
    tbl.*
FROM
         (
        SELECT
            last_name,
            job_id,
            department_id
        FROM
            employees
        WHERE
            job_id = 'SA_MAN'
    ) tbl
    JOIN departments d ON tbl.department_id = d.department_id;
    
--문제 14
SELECT
    *
FROM
         departments d
    JOIN (
        SELECT
            department_id,
            COUNT(*) AS total
        FROM
            employees
        GROUP BY
            department_id
    ) groupa ON groupa.department_id = d.department_id
ORDER BY
    groupa.total DESC;
--GROUPBY한 것을 먼저 작성하고 이후 조인을 통해 원하는 쿼리 적으면 groupby 열 말고도 다른 열도 조회가능

--문제 15
SELECT
    d.*,
    loc.street_address,
    loc.postal_code,
    nvl(groupemp.result, 0)
FROM
         departments d
    INNER JOIN locations loc ON d.location_id = loc.location_id
    LEFT JOIN (
        SELECT
            department_id,
            trunc(AVG(salary)) AS result
        FROM
            employees
        GROUP BY
            department_id
    )         groupemp ON d.department_id = groupemp.department_id;
--우선 안에 들어가는 서브쿼리부터 먼저 작성(여기서 그룹화)하고 조인하여 나머지 정보 출력
