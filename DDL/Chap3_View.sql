/*
View는 제한적인 자료만 보기 위해 사용하는 가상테이블 개념
뷰는 기본 테이블로 유도된 가상테이블이기 때문에 필요한 컬럼만 저장해두면 관리가 용이 

뷰는 가상 테이블로 실제 데이터가 물리적으로 저장된 형태는 아님 
뷰를 통해 데이터에 접근하면 원본 데이터는 안전하게 보호될 수 있음
*/

SELECT
    *
FROM
    user_sys_privs; --권한 확인 

--단순 뷰 
SELECT
    employee_id,
    first_name
    || ' '
    || last_name AS name,
    job_id,
    salary
FROM
    employees
WHERE
    department_id = 60;


-- CREATE VIEW 
CREATE VIEW view_emp AS
    ( SELECT
        employee_id,
        first_name
        || ' '
        || last_name AS name,
        job_id,
        salary
    FROM
        employees
    WHERE
        department_id = 60
    );

SELECT
    *
FROM
    view_emp;
    
-- 복합 뷰 
CREATE VIEW view_emp_dept_jobs AS
    ( SELECT
        e.employee_id,
        e.first_name
        || ' '
        || e.last_name AS name,
        d.department_name,
        j.job_title
    FROM
        employees   e
        LEFT OUTER JOIN departments d ON e.department_id = d.department_id
        LEFT OUTER JOIN jobs        j ON e.job_id = j.job_id
    )
    ORDER BY
        employee_id ASC;
--정렬은 ()를 나와서 사용해야함
SELECT
    *
FROM
    view_emp_dept_jobs;
    
-- 뷰 수정 (CREATE OR REPLACE VIEW)
-- 동일 이름으로 해당 구문을 사용하면 데이터가 변경되면서 새롭게 생성 

CREATE OR REPLACE VIEW view_emp_dept_jobs AS
    ( SELECT
        e.employee_id,
        e.first_name
        || ' '
        || e.last_name AS name,
        d.department_name,
        j.job_title,
        e.salary -- 컬럼 추가 
    FROM
        employees   e
        LEFT OUTER JOIN departments d ON e.department_id = d.department_id
        LEFT OUTER JOIN jobs        j ON e.job_id = j.job_id
    )
    ORDER BY
        employee_id ASC;

--생성된 뷰를 바탕으로 조회 
SELECT
    job_title,
    AVG(salary)
FROM
    view_emp_dept_jobs
GROUP BY
    job_title
ORDER BY
    AVG(salary) DESC;

DROP VIEW view_emp;

/*
VIEW에 INSERT가 일어나는 경우 실제 테이블에도 반영이 되기는 하지만 굳이 사용하지 않음
그래서 VIEW의 INSERT, UPDATE, DELETE는 많은 제약사항이 따름 
원본 테이블이 NOT NULL인 경우 VIEW에 INSERT가 불가능
VIEW에서 사용하는 컬럼이 가상의 열(별칭)인 경우에도 안됨
*/

INSERT INTO view_emp_dept_jobs VALUES (
    300,
    'test',
    'test',
    'test',
    10000
);
--NAME이라는 가상열(별칭)을 사용했기 때문에 INSERT X

--join된 뷰의 경우 한번에 수정할 수 없음
INSERT INTO view_emp_dept_jobs (
    employe_id,
    department_name,
    job_title,
    salary
) VALUES (
    200,
    'test',
    'test',
    10000
);

--원본 테이블의 null을 허용하지 않는 컬럼 때문에 들어갈 수 없음.
INSERT INTO view_emp (
    employee_id,
    job_id,
    salary
) VALUES (
    300,
    'test',
    10000
);

--WITH CHECK OPTION(조건 제약 컬럼)
--조건에 사용되어진 컬럼값은 뷰를 통해서 변경할 수 없게 해주는 키워드
CREATE VIEW view_emp_test AS
    ( SELECT
        employee_id,
        first_name,
        last_name AS name,
        hire_date,
        job_id,
        department_id
    FROM
        employees
    WHERE
        department_id = 60
    )
WITH CHECK OPTION CONSTRAINT view_emp_test_ck;

UPDATE view_emp_test
SET
    department_id = 100
WHERE
    employee_id = 105;
--WITH CHECK OPTION으로 인해서 UPDATE안됨

CREATE OR REPLACE VIEW view_emp_test AS
    ( SELECT
        employee_id,
        first_name,
        last_name AS name,
        hire_date,
        job_id,
        department_id
    FROM
        employees
    WHERE
        department_id = 60
    )
WITH READ ONLY;

INSERT INTO view_emp_test VALUES (
    300,
    'test',
    'test',
    sysdate,
    'IT_PROG',
    100
);
--WITH READ ONLY로 제약을 줬기 때문에 select말고는 아무것도 안됨