--Check Auto Commit 
SHOW AUTOCOMMIT;

-- Auto Commit On 
SET AUTOCOMMIT ON;
--연산을 수행할 때 마다 자동으로 commit되도록 하는 명령어
SET AUTOCOMMIT OFF;

SELECT
    *
FROM
    emps;

INSERT INTO emps (
    employee_id,
    last_name,
    email,
    hire_date,
    job_id
) VALUES (
    300,
    'moon',
    'abs23@nfek.com',
    sysdate,
    1800
);

--보류중인 모든 데이터 변경사항을 취소, 직전 커밋 단계로 회귀 및 트랜잭션 종료 
ROLLBACK;

--SAVEPOINT
--ROLLBACK할 포인트를 직접 이름을 붙여서 지정 하지만 권장하지는 않음 
SAVEPOINT insert_moon;

INSERT INTO emps (
    employee_id,
    last_name,
    email,
    hire_date,
    job_id
) VALUES (
    300,
    'ahn',
    'wers23@nfek.com',
    sysdate,
    1500
);

SELECT
    *
FROM
    emps;
-- emps 테이블에 moon과 ahn이 모두 들어가있는 상태 

ROLLBACK TO SAVEPOINT insert_moon;
--moon을 insert하고 난 후의 상태로 ROLLBACK
SELECT
    *
FROM
    emps;

--COMMIT 
--보류중인 모든 데이터 변경사항을 영구적으로 적용하면서 트랜잭션을 종료
--커밋한 이후 어떤 방법을 사용하더라도 ROOLBACK안됨 
commit