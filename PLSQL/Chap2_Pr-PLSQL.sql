-- 1. 구구단 중 3단을 출력하는 익명 블록을 만들어 보자 (출력문 9개를 복사해서 쓰세요.)
DECLARE
    num NUMBER;
BEGIN
    num := 3;
    dbms_output.put_line(num * 1);
    dbms_output.put_line(num * 2);
    dbms_output.put_line(num * 3);
    dbms_output.put_line(num * 4);
    dbms_output.put_line(num * 5);
    dbms_output.put_line(num * 6);
    dbms_output.put_line(num * 7);
    dbms_output.put_line(num * 8);
    dbms_output.put_line(num * 9);
END;

-- 2. 사원 테이블에서 201번 사원의 이름과 이메일주소를 출력하는 익명 블록을 만들어 보자
-- 변수에 담아서 출력하세요.

DECLARE
    a_name  VARCHAR2(30);
    a_email VARCHAR2(30);
BEGIN
    SELECT
        e.first_name,
        e.email
    INTO
        a_name,
        a_email
    FROM
        employees e
    WHERE
        e.employee_id = 201;

    dbms_output.put_line('이름 : '
                         || ' '
                         || a_name
                         || '    '
                         || 'email : '
                         || ' '
                         || a_email);

END;

-- 3. 사원 테이블에서 사원번호가 제일 큰 사원을 찾아낸 뒤 (MAX 함수 사용),
-- 이 번호 + 1번으로 아래의 사원을 emps에
-- employee_id, last_name, email, hire_date, job_id를 신규 입력하는 익명 블록을 만드세요.
-- SELECT절 이후에 INSERT문 사용이 가능합니다.
/*
<사원명>: steven
<이메일>: stevenjobs
<입사일자>: 오늘날짜
<JOB_ID>: CEO
*/
DROP TABLE emps;

CREATE TABLE emps
    AS
        ( SELECT
            *
        FROM
            employees
        WHERE
            1 = 2
        );

DECLARE
    max_id employees.employee_id%TYPE;
BEGIN
    SELECT
        MAX(employee_id)
    INTO max_id
    FROM
        employees;

    INSERT INTO emps (
        employee_id,
        last_name,
        email,
        hire_date,
        job_id
    ) VALUES (
        max_id + 1,
        'steven',
        'stevenjobs',
        sysdate,
        'CEO'
    );
    COMMIT;
END;
SELECT * FROM emps;