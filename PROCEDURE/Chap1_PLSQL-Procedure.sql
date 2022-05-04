-- PROCEDURE 

-- void 메소드랑 유사하며 특정 로직을 처리하고 결과값을 반환하지 않는 코드 덩어리 
-- PL/SQL에도 값을 전달받아서 코드를 실행 후 리턴하는 함수가 존재 
-- 하지만 프로시저를 통해서도 값을 리턴하는 방법이 존재 
-- 매개값(인수)이 없는 프로시저 

-- CREATE PROCEDURE ~ IS ~ BEGIN ~ END;
CREATE PROCEDURE p_test IS -- 선언부 
    v_msg VARCHAR2(30) := 'HI Procedure';
BEGIN -- 실행부 
    dbms_output.put_line(v_msg);
-- 출력문을 넣었는데 출력이 안됨 
END; -- 종료부 

-- 프로시저의 이름을 지정하면 밑의 방법으로 프로시저를 호출해서 출력 확인 가능 
EXEC p_test; -- 프로시저 호출문

-- IN 입력값을 받는 파라미터 
CREATE PROCEDURE my_new_job_proc (
    p_job_id    IN jobs.job_id%TYPE,
    p_job_title IN jobs.job_title%TYPE,
    p_min_sal   IN jobs.min_salary%TYPE,
    p_max_sal   IN jobs.max_salary%TYPE
) -- 매개값 작성 (IN 키워드 사용)
 IS
BEGIN
    INSERT INTO jobs VALUES (
        p_job_id,
        p_job_title,
        p_min_sal,
        p_max_sal
    );

    COMMIT;
-- IN키워드를 사용해서 매개값으로 받은 것을 넣어줌 
END;

EXEC my_new_job_proc('job1', 'test', 1000, 5000);
-- 진짜 함수처럼 프로시저 이름과 매개값들을 넣어주네 (이렇게 함수를 하나 만들어서 인수만 넣어주면 쉽겠다)

SELECT
    *
    
FROM
    jobs;
    
-- 프로시저가 없으면 만들어주고 이미 존재하면 수정해줌 
CREATE OR REPLACE PROCEDURE my_new_job_proc (
    p_job_id    IN jobs.job_id%TYPE,
    p_job_title IN jobs.job_title%TYPE,
    p_min_sal   IN jobs.min_salary%TYPE,
    p_max_sal   IN jobs.max_salary%TYPE
) -- 매개값 작성 (IN 키워드 사용)
 IS
    v_cnt NUMBER := 0;
BEGIN
    -- 동일한 job_id가 있는지부터 체크
    -- 이미 존재한다면 1, 존재하지 않는다면 0을 주고 그것을 v_cnt에 대입할 예정
    SELECT
        COUNT(*)
    INTO v_cnt
    FROM
        jobs
    WHERE
        job_id = p_job_id;
    -- 중복이 존재하면 1이 나옴 

    IF v_cnt = 0 THEN -- 없다면 INSERT 
        INSERT INTO jobs VALUES (
            p_job_id,
            p_job_title,
            p_min_sal,
            p_max_sal
        );

    ELSE -- 있다면 UPDATE 
        UPDATE jobs
        SET
            job_title = p_job_title,
            min_salary = p_min_sal,
            max_salary = p_max_sal
        WHERE
            job_id = p_job_id;

    END IF;

    COMMIT;
-- IN키워드를 사용해서 매개값으로 받은 것을 넣어줌 
END;


EXEC my_new_job_proc('job2', 'test job2', 5000, 10000);
EXEC my_new_job_proc('job1', 'test job3', 5000, 10);
-- 값을 새로 만들어서 넣을 수 있고 이미 있다면 값을 갱신할 수도 있음

SELECT
    *
FROM
    jobs;
    
-- 매개변수(인수)의 디폴트 값(기본값) 설정  매개변수로 값을 입력 받지 않아도 min,max_sal은 기본값으로 대입 
CREATE OR REPLACE PROCEDURE my_new_job_proc (
    p_job_id    IN jobs.job_id%TYPE,
    p_job_title IN jobs.job_title%TYPE,
    p_min_sal   IN jobs.min_salary%TYPE := 0,
    p_max_sal   IN jobs.max_salary%TYPE := 1000
) -- 매개값 작성 (IN 키워드 사용)
 IS
    v_cnt NUMBER := 0;
BEGIN
    -- 동일한 job_id가 있는지부터 체크
    -- 이미 존재한다면 1, 존재하지 않는다면 0을 주고 그것을 v_cnt에 대입할 예정
    SELECT
        COUNT(*)
    INTO v_cnt
    FROM
        jobs
    WHERE
        job_id = p_job_id;
    -- 중복이 존재하면 1이 나옴 

    IF v_cnt = 0 THEN -- 없다면 INSERT 
        INSERT INTO jobs VALUES (
            p_job_id,
            p_job_title,
            p_min_sal,
            p_max_sal
        );

    ELSE -- 있다면 UPDATE 
        UPDATE jobs
        SET
            job_title = p_job_title,
            min_salary = p_min_sal,
            max_salary = p_max_sal
        WHERE
            job_id = p_job_id;

    END IF;

    COMMIT;
-- IN키워드를 사용해서 매개값으로 받은 것을 넣어줌 
END;

EXEC my_new_job_proc('job2', 'test_job2');
-- 기본값을 지정한 것이 있기 때문에 기본값으로 지정하고 싶으면 매개변수를 넣지 않아도 됨

SELECT
    *
FROM
    jobs;
    
    
    
-- OUT, IN OUT 매개변수(인수) 사용 
-- OUT 변수를 사용하면 프로시저 바깥쪽으로 값을 보냄 
-- OUT을 통해서 보낸 값은 바깥 익명블록에서 실행해야함
CREATE OR REPLACE PROCEDURE my_new_job_proc (
    p_job_id    IN jobs.job_id%TYPE,
    p_job_title IN jobs.job_title%TYPE,
    p_min_sal   IN jobs.min_salary%TYPE := 0,
    p_max_sal   IN jobs.max_salary%TYPE := 1000,
    p_result OUT VARCHAR 
    -- 블록 바깥쪽에서 출력을 하기 위한 변수 
) -- 매개값 작성 (IN, OUT 키워드 사용)
IS
    v_cnt NUMBER := 0;
    v_result VARCHAR2(100) := '값이 존재하지 않아서 INSERT로 처리 되었습니다.';
BEGIN
    -- 동일한 job_id가 있는지부터 체크
    -- 이미 존재한다면 1, 존재하지 않는다면 0을 주고 그것을 v_cnt에 대입할 예정
    SELECT
        COUNT(*)
    INTO v_cnt
    FROM
        jobs
    WHERE
        job_id = p_job_id;
    -- 중복이 존재하면 1이 나옴 

    IF v_cnt = 0 THEN -- 없다면 INSERT 
        INSERT INTO jobs VALUES (
            p_job_id,
            p_job_title,
            p_min_sal,
            p_max_sal
        );

    ELSE -- 있다면 결과를 추출
        SELECT 
            p_job_id || '의 최대 연봉 : ' || max_salary || ', 최소 연봉: ' || min_salary
            INTO v_result
            -- 매개변수로 입력받은 id가 기존에 같은 값이 있으면 그사람의 최소,최대 연봉의 내용을 v_result에 저장
            -- v_result는 조회 결과가 있으면 블록을 나갈 수 있고 조회 결과가 없으면 블록을 나갈 수 없음
        FROM jobs
        WHERE job_id = p_job_id;

    END IF;

    -- OUT 매개변수에 결과를 할당 
    p_result := v_result;

    COMMIT;
-- IN키워드를 사용해서 매개값으로 받은 것을 넣어줌 
END;

-- 프로시저에 out이 있으면 새로운 PLSQL을 작성해서 출력할 수 있음
DECLARE
    str VARCHAR2(100);
BEGIN
    my_new_job_proc('job1', 'test_job1', 2000, 7000, str);
    -- out변수가 존재하는 프로시저를 부를 때 out되는 값을 받을 변수를 하나 더 전달해야함
    dbms_output.put_line(str);
    -- 동일한 id가 있으므로 salary정보를 출력 

    my_new_job_proc('CEO', 'test_CEO', 10000, 70000, str);
    dbms_output.put_line(str);
    -- 동일한 id가 없으므로 insert 
END;

-- IN OUT 동시 처리 
CREATE OR REPLACE PROCEDURE my_parameter_test_proc (
    p_var1 IN VARCHAR2,
    -- IN : 반환 불가이며 한번 값이 할당되면 바뀌지 않음
    p_var2 OUT VARCHAR2,
    -- OUT변수는 프로시저가 끝나기 전까지 값의 할당이 안됨 
    -- 프로시저가 끝나야 OUT 가능 
    p_var3 IN OUT VARCHAR2
    -- IN과 OUT이 둘 다 가능
) IS
BEGIN
    dbms_output.put_line('p_var1:' || p_var1); -- 출력가능 
    dbms_output.put_line('p_var2:' || p_var2); -- 값이 전달이 안됨 (공백)
    dbms_output.put_line('p_var3:' || p_var3); -- 출력가능 (IN의 성질을 가지고 있음)
    
--    p_var1 := '결과1';
    -- IN으로 작성된 변수는 값을 할당할 수 없음
    p_var2 := '결과2';
    p_var3 := '결과3';
    -- IN OUT은 IN의 성질과 OUT의 기능을 모두 사용가능 
    dbms_output.put_line('-----------------------------------');
END;

DECLARE
    v_var1 VARCHAR2(10) := 'value1';
    v_var2 VARCHAR2(10) := 'value2';
    v_var3 VARCHAR2(10) := 'value3';
BEGIN
    my_parameter_test_proc(v_var1, v_var2, v_var3);
    dbms_output.put_line('v_var1 : ' || v_var1);
    dbms_output.put_line('v_var2 : ' || v_var2);
    dbms_output.put_line('v_var3 : ' || v_var3);
END;

-- RETURN
-- RETURN은 메소드를 강제 종료시키는 경향이 있음
CREATE OR REPLACE PROCEDURE my_new_job_proc (
    p_job_id IN jobs.job_id%TYPE,
    p_result OUT VARCHAR 
    -- 블록 바깥쪽에서 출력을 하기 위한 변수 
) -- 매개값 작성 (IN, OUT 키워드 사용)
 IS
    v_cnt    NUMBER := 0;
    v_result VARCHAR2(100) := '값이 존재하지 않아서 INSERT로 처리 되었습니다.';
BEGIN
    SELECT
        COUNT(*)
    INTO v_cnt
    FROM
        jobs
    WHERE
        job_id = p_job_id;
    -- 중복이 존재하면 1이 나옴 

    IF v_cnt = 0 THEN -- 없다면 RETURN
        dbms_output.put_line(p_job_id || '는 테이블에 존재하지 않습니다.');
        RETURN;
        -- 프로시저 강제 종료
    END IF;    
--    job_id와 같은게 존재하지 않으면 위의 코드를 작성하며 프로시저를 강제 종료
--    job_id와 같은게 있으면 밑의 코드를 작성

    SELECT
        p_job_id
        || '의 최대 연봉 : '
        || max_salary
        || ', 최소 연봉: '
        || min_salary
    INTO v_result
        -- 매개변수로 입력받은 id가 기존에 같은 값이 있으면 그사람의 최소,최대 연봉의 내용을 v_result에 저장
        -- v_result는 조회 결과가 있으면 블록을 나갈 수 있고 조회 결과가 없으면 블록을 나갈 수 없음
    FROM
        jobs
    WHERE
        job_id = p_job_id;

    -- OUT 매개변수에 결과를 할당 
    p_result := v_result;
    COMMIT;
-- IN키워드를 사용해서 매개값으로 받은 것을 넣어줌 
END;

DECLARE
    str VARCHAR2(100);
BEGIN
    my_new_job_proc('CEO', str);
    dbms_output.put_line(str);
    my_new_job_proc('student', str);
    dbms_output.put_line(str);
-- 데이터가 존재하지 않으면 거기서 RETURN을 통해 프로세스를 종료
END;

-- 예외처리 
DECLARE
    v_num NUMBER := 0;
BEGIN
    v_num := 10 / 0;
EXCEPTION
    WHEN OTHERS THEN -- 예외처리
        dbms_output.put_line('0으로 나눌 수 없습니다.');
        dbms_output.put_line('SQL ERROR CODE : ' || sqlcode);
        dbms_output.put_line('ERROR MSG : ' || sqlerrm);
END;