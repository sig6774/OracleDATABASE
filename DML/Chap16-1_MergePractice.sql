CREATE TABLE depts
    AS
        ( SELECT
            *
        FROM
            departments
        );
-- 1번 
INSERT INTO depts VALUES (
    280,
    '개발',
    NULL,
    1800
);

INSERT INTO depts VALUES (
    290,
    '회계부',
    NULL,
    1800
);

INSERT INTO depts VALUES (
    300,
    '재정',
    301,
    1800
);

INSERT INTO depts VALUES (
    310,
    '인사',
    302,
    1800
);

INSERT INTO depts VALUES (
    320,
    '영업',
    303,
    1700
);


--2번 
SELECT
    *
FROM
    depts;

UPDATE depts
SET
    department_name = 'IT_bank'
WHERE
    department_name = 'IT Support';

UPDATE depts
SET
    manager_id = 301
WHERE
    department_id = 290;

UPDATE depts
SET
    department_name = 'IT_Help',
    manager_id = 303,
    location_id = 1800
WHERE
    department_name = 'IT Helpdesk';
--1개 이상의 값 변경 

UPDATE depts
SET
    manager_id = 301
WHERE
    department_id IN ( 290, 300, 310, 320 );

SELECT
    *
FROM
    depts;

-- 3번 
DELETE FROM depts
WHERE
    department_id = (
        SELECT
            department_id
        FROM
            depts
        WHERE
            department_name = '영업'
    );

DELETE FROM depts
WHERE
    department_id = (
        SELECT
            department_id
        FROM
            depts
        WHERE
            department_name = 'NOC'
    );

-- 4번 
SELECT
    *
FROM
    depts;

DELETE FROM depts
WHERE
    department_id > 200;

UPDATE depts
SET
    manager_id = 100
WHERE
    manager_id IS NOT NULL;

MERGE INTO depts a
USING (
          SELECT
              *
          FROM
              departments
      )
b ON ( a.department_id = b.department_id )
WHEN MATCHED THEN --조건이 맞는다면 
 UPDATE
SET a.department_name = b.department_name,
    a.manager_id = b.manager_id,
    a.location_id = b.location_id
WHEN NOT MATCHED THEN -- 조건이 맞지 않는다면 
INSERT
VALUES
    ( b.department_id,
      b.department_name,
      b.manager_id,
      b.location_id );
    
SELECT * FROM depts;

--5번
CREATE TABLE job_it
    AS
        ( SELECT
            *
        FROM
            jobs
        WHERE
            min_salary >= 6000
        );
        
SELECT * FROM job_it;

INSERT INTO job_it VALUES('IT_DEV', '아이티개발팀', 6000, 20000);
INSERT INTO job_it VALUES('NET_DEV', '네트워크개발팀', 5000, 20000);
INSERT INTO job_it VALUES('SEC_DEV', '보안개발팀', 6000, 19000);

MERGE INTO job_it a 
USING (SELECT * FROM jobs WHERE min_salary >= 0) b ON 

