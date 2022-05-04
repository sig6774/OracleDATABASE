/*
프로시저명 guguProc
구구단 단수를 전달받아 해당 단수를 출력하는 procedure을 생성하세요. 
*/

CREATE OR REPLACE PROCEDURE guguproc (
    p_num IN NUMBER
) IS
BEGIN
    FOR i IN 1..9 LOOP
        dbms_output.put_line(p_num
                             || '*'
                             || i
                             || '='
                             || p_num * i);
    END LOOP;
END;

DECLARE BEGIN
    guguproc(3);
END;

/*
부서번호, 부서명, 작업 flag(I: insert, U:update, D:delete)을 매개변수로 받아 
depts 테이블에 
각각 INSERT, UPDATE, DELETE 하는 depts_proc 란 이름의 프로시저를 만들어보자.
그리고 정상종료라면 commit, 예외라면 롤백 처리하도록 처리하세요.
*/
DROP TABLE depts;
CREATE TABLE depts AS SELECT department_id, department_name FROM departments;
ALTER TABLE depts ADD CONSTRAINTS depts_pk PRIMARY KEY(department_id);
SELECT * FROM depts;

CREATE OR REPLACE PROCEDURE depts_proc (
    d_num  IN depts.department_id%TYPE,
    d_name IN depts.department_name%TYPE,
    flag   IN VARCHAR2
) IS
BEGIN
    IF flag = 'I' THEN
        INSERT INTO depts VALUES (
            d_num,
            d_name
        );

    ELSIF flag = 'U' THEN
        UPDATE depts
        SET
            department_name = d_name
        WHERE
            department_id = d_num;

    ELSIF flag = 'D' THEN
        DELETE FROM depts
        WHERE
            department_id = d_num;

    ELSE
        dbms_output.put_line('친구야 다른 flag를 넣었어');
    END IF;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('예외가 발생했어!');
        dbms_output.put_line('예외 메세지 : ' || sqlerrm);
        ROLLBACK;
END;

EXEC depts_proc(0, 'OK~', 'I');
EXEC depts_proc(10, '아아아아아아', 'U');

SELECT
    *
FROM
    depts;
    
/*
employee_id를 입력받아 employees에 존재하면,
근속년수를 out하는 프로시저를 작성하세요. (익명블록에서 프로시저를 실행)
없다면 exception처리하세요
*/

CREATE OR REPLACE PROCEDURE emp_hire_proc (
    e_id   IN employees.employee_id%TYPE,
    e_year OUT NUMBER
) IS
    v_cnt       NUMBER := 0;
    v_hire_date employees.hire_date%TYPE;
BEGIN
    SELECT
        hire_date
    INTO v_hire_date
    FROM
        employees
    WHERE
        employee_id = e_id;

    e_year := trunc((sysdate - v_hire_date) / 365);
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(e_id || '(은) 는 없는 데이터 입니다.');
        COMMIT;
END;

DECLARE
    e_year NUMBER;
BEGIN
    emp_hire_proc(136, e_year);
    dbms_output.put_line(e_year || '년');
END;

/*
프로시저명 - new_emp_proc
employees 테이블의 복사 테이블 emps를 생성합니다.
employee_id, last_name, email, hire_date, job_id를 입력받아
존재하면 이름, 이메일, 입사일, 직업을 update, 
없다면 insert하는 merge문을 작성하세요
*/

CREATE OR REPLACE PROCEDURE new_emp_proc(
p_employee_id IN emps.employee_id%TYPE,
p_last_name IN emps.last_name%TYPE,
p_email IN emps.email%TYPE ,
p_hire_date IN emps.hire_date%TYPE,
p_job_id IN emps.job_id%TYPE
)
IS 

BEGIN 
    MERGE INTO emps a 
    USING (SELECT p_employee_id AS employee_id FROM dual) b 
    ON (a.employee_id = b.employee_id)
    WHEN MATCHED THEN --조건을 만족하면 
        UPDATE SET 
        a.last_name = p_last_name, 
        a.email = p_email,
        a.hire_date = p_hire_date,
        a.job_id = p_job_id
    WHEN NOT MATCHED THEN 
    INSERT (a.employee_id, a.last_name, a.email, a.hire_date, a.job_id)
    VALUES (p_employee_id, p_last_name, p_email, p_hire_date, p_job_id);
END;

EXEC new_emp_proc(100, 'MOON', 'ABC', sysdate, 'test');
EXEC new_emp_proc(100, 'MOO', 'AB', sysdate, 'test234');
SELECT * FROM EMPS;
