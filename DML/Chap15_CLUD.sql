CREATE TABLE managers
    AS
        ( SELECT
            employee_id,
            first_name,
            job_id,
            hire_date
        FROM
            employees
        WHERE
            1 = 2
        );
--테이블 생성
-- where 1= 2 논리값으로 FALSE이므로 테이블의 구조만 가져오고 데이터는 가져오지 않음

SELECT
    *
FROM
    managers;
--테이블의 구조만 가져온 것을 확인할 수 있음
DROP TABLE managers;
--생성한 테이블 삭제 

INSERT INTO managers
    ( SELECT
        employee_id,
        first_name,
        job_id,
        hire_date
    FROM
        employees
    );
--서브쿼리를 통해서 데이터를 삽입할 수 있음 

--UPDATE 
CREATE TABLE emps
    AS
        ( SELECT
            *
        FROM
            employees
        );

SELECT
    *
FROM
    emps;
--CREATE TABLE AS 를 사용하면 제약 조건은 not null말고는 복사되지 않음
--제약조건 : 업무규칙을 지키는 데이터만 저장하고 그렇지 않은 것들이 DB에 저장되는 것을 방지하는 목적 

--UPDATE를 진행할 때는 누구를 수정할 지 잘 지목해야함 
--그렇지 않으면 수정 대상이 테이블 전체로 지목됨
UPDATE emps
SET
    salary = 30000;
--이렇게 되면 salary가 모두 30000으로 변경됨
SELECT
    *
FROM
    emps;

ROLLBACK;
--했던 행동을 다시 복구 

UPDATE emps
SET
    salary = 30000
WHERE
    employee_id = 100;
--특정값만 update된 것을 확인

UPDATE emps
SET
    salary = salary + salary * 0.1
WHERE
    employee_id = 100;
--사원번호가 100인 사람의 급여를 주겠다는 뜻 

UPDATE emps
SET
    phone_number = '515.123.4566',
    manager_id = 102
WHERE
    employee_id = 100;
--여러개의 컬럼에 있는 값을 업데이트 가능 

--UPDATE(서브쿼리)
UPDATE emps
SET
    ( job_id,
      salary,
      manager_id ) = (
        SELECT
            job_id,
            salary,
            manager_id
        FROM
            emps
        WHERE
            employee_id = 100
    )
WHERE
    employee_id = 101;
--사원번호가 101인 사람의 job_id와 salary,manager_id를 사원번호가 100번인 사람의 값으로 변경하는 것 

ROLLBACK;

--DELECTE
DELETE FROM emps
WHERE
    employee_id = 103;
-- 사원번호 103번이 삭제된 것을 확인할 수 있음 

--사본테이블 생성 
CREATE TABLE depts
    AS
        ( SELECT
            *
        FROM
            departments
        );
        

--DELETE(서브쿼리)
DELETE FROM emps
WHERE
    department_id = (
        SELECT
            department_id
        FROM
            depts
        WHERE
            department_id = 100
    );
    
SELECT
    *
FROM
    emps;
--사라진 것을 확인할 수 있음 

DELETE FROM emps
WHERE
    department_id = (
        SELECT
            department_id
        FROM
            depts
        WHERE
            department_name = 'IT'
    );
--IT부서의 사람들이 모두 삭제된 것을 확인 