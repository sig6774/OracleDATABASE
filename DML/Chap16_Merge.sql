/*
한 테이블에 해당하는 데이터가 있다면 UPDATE를 없으면 INSERT로 처리

한 테이블에 해당하는 데이터가 있다면 UPDATE를 없으면 INSERT를처리하라 
만약 MERGER가 없으면 해당 데이터의 존재 유무를 일일히 확인하고 IF문을 사용해서 데이터가 있다면 UPDATE
없다면 else문을 사용하여 INSERT를 하라고 하나씩 이야기해야하는데 MERGE를 통해 쉽게 처리가능 
*/
CREATE TABLE emps_it
    AS
        ( SELECT
            *
        FROM
            employees
        WHERE
            1 = 2
        );

SELECT
    *
FROM
    emps_it;
--테이블의 구조만 가져옴

INSERT INTO emps_it (
    employee_id,
    first_name,
    last_name,
    email,
    hire_date,
    job_id
) VALUES (
    105,
    '데이비드',
    '베컴',
    'DAVID@nekr.com',
    '22-APRIL-27',
    'IT_PROG'
);

SELECT
    *
FROM
    employees
WHERE
    job_id = 'IT_PROG';

MERGE INTO emps_it a -- (머지를 할 타겟 테이블)
USING -- 병합시킬 데이터
 (
          SELECT
              *
          FROM
              employees
          WHERE
              job_id = 'IT_PROG'
      )
b -- 조인 구문
 ON -- 병합시킬 데이터의 연결 조건
 ( a.employee_id = b.employee_id ) -- 조인 조건
         --B에는 사원번호가 103~107까지 조회되고 A의 사원번호가 105번이므로 충돌이 발생할 수 있음
WHEN MATCHED THEN -- 조건에 일치할 경우 타겟 테이블에 이렇게 실행해라.
 --수정이 목적일 때 사용
 UPDATE
SET a.phone_number = b.phone_number,
    a.hire_date = b.hire_date,
    a.salary = b.salary,
    a.commission_pct = b.commission_pct,
    a.manager_id = b.manager_id,
    a.department_id = b.department_id
    
    /*
    DELETE만 단독으로 사용될 수 없음 
    UPDATE 이후 DELETE 작성이 가능 
    UPDATE 된 대상을 DELETE 하도록 설계되어 있기 때문에 삭제할 대상 컬럼들을 동일한 값으로 UPDATE하고 
    DELETE의 WHERE 절에 아까 지정한 동일한 값을 지정하여 삭제 
    */
    DELETE 
        WHERE a.employee_id = b.employee_id
        -- employee_id가 같으면 모두 지워라 라는 뜻
        -- update를 먼저 작성하고 DELETE 가능하며 데이비드 베컴이 삭제됨

WHEN NOT MATCHED THEN  -- 조건에 일치하지 않는 경우 타겟 테이블에 실행.
INSERT /*속성(컬럼)*/
VALUES
    ( b.employee_id,
      b.first_name,
      b.last_name,
      b.email,
      b.phone_number,
      b.hire_date,
      b.job_id,
      b.salary,
      b.commission_pct,
      b.manager_id,
      b.department_id );
--------------------------------------------------------------------------------

INSERT INTO emps_it (
    employee_id,
    first_name,
    last_name,
    email,
    hire_date,
    job_id
) VALUES (
    102,
    '렉스',
    '박',
    'LEXPARK',
    '21-APRIL-23',
    'AD_VP'
);

INSERT INTO emps_it (
    employee_id,
    first_name,
    last_name,
    email,
    hire_date,
    job_id
) VALUES (
    101,
    '니나',
    '최',
    'NINA',
    '20-MAY-22',
    'AD_VP'
);

INSERT INTO emps_it (
    employee_id,
    first_name,
    last_name,
    email,
    hire_date,
    job_id
) VALUES (
    103,
    '흥민',
    '손',
    'HMSON',
    '22-APRIL-27',
    'AD_VP'
);

--employees 테이블을 매번 수정되는 테이블이라고 가정 
--기존 데이터는 email, phone, salary, comm_pct, man_id, dept_id는 업데이트 하도록 처리
--새로 유입된 데이터는 그대로 추가 

MERGE INTO emps_it a 
USING 
(select * FROM employees) b 
ON 
(a.employee_id = b.employee_id)
--데이터가 충돌이 일어나면

WHEN MATCHED THEN 
UPDATE SET 
a.first_name = b.first_name,
a.email = b.email,
a.phone_number = b.phone_number,
a.salary = b.salary,
a.commission_pct = b.commission_pct,
a.manager_id = b.manager_id,
a.department_id = b.department_id
-- 데이터의 충돌이 일어나면 a의 데이터에 b의 데이터 값을 update

WHEN NOT MATCHED THEN 
INSERT VALUES 
    ( b.employee_id,
      b.first_name,
      b.last_name,
      b.email,
      b.phone_number,
      b.hire_date,
      b.job_id,
      b.salary,
      b.commission_pct,
      b.manager_id,
      b.department_id );
-- 데이터의 충돌이 일어나지 않으면 해당 값을 insert

SELECT
    *
FROM
    emps_it
ORDER BY
    employee_id ASC;
    
ROLLBACK;