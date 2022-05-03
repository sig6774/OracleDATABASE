/*
PLSQL
- 오라클에서 제공하는 SQL 프로그래밍 기능 
- 일반적인 프로그래밍과는 차이가 있지만 오라클 내부에서 적절한 처리를 위해서 
  적용해 줄 수 있는 절차지향적 코드 작성 방식
- 쿼리문의 집합으로 어떠한 동작을 일괄처리하기 위한 용도로 사용 
*/

SET SERVEROUTPUT ON; -- 출력문 활성화

--프로시저는 드래그해서 F5로 실행
-- PLSQL은 DECLARE와 BEGIN, END로 구간을 나눔 
DECLARE -- 변수 선언 (선언부)
    emp_num NUMBER; -- 변수 선언
BEGIN -- 코드 실행 (실행부)
    emp_num := 10; -- := PLSQL의 대입연산자 
    dbms_output.put_line(emp_num);
    dbms_output.put_line('THIS IS PL/SQL.');
    -- print와 같은 기능
END; -- PL/SQL이 끝나는 구간 (종료부)

-- 연산자 
-- 일반 SQL문의 모든 연산자의 사용이 가능

DECLARE
    a NUMBER := 2 * * 2 * 3 * * 2;
BEGIN
    dbms_output.put_line('a = ' || to_char(a));
END;

/*
DDL은 사용이 불가능하고 DML은 사용가능하며 일반적인 SQL문의 SELECT 등을 사용하는데 
특이한 점은 SELECT 아래에 INTO 절을 사용해 변수에 할당할 수 있음
*/

DECLARE
    v_emp_name VARCHAR2(50); --문자열 변수는 길이 제약 적어야함 
    v_dep_name VARCHAR2(50);
BEGIN
    SELECT
        e.first_name,
        d.department_name
    INTO
        v_emp_name,
        v_dep_name
-- 변수에 대입을 의미
-- SELECT문의 조회 결과를 INTO에 적은 변수에 대입하겠다는 의미
    FROM
        employees   e
        LEFT OUTER JOIN departments d ON e.department_id = d.department_id
    WHERE
        employee_id = 100;

    dbms_output.put_line(v_emp_name
                         || '-'
                         || v_dep_name);
END;

--해당 테이블과 같은 타입의 컬럼 변수를 선언하려면 테이블명, 컬럼명 %type을 사용함으로써 타인을 일일히 확인하는 번거로움을 방지할 수 있음
DECLARE
    v_emp_name employees.first_name%TYPE; -- 대입하고자 하는 변수에 자료형을 모를 때 사용 
    v_dep_name departments.department_name%TYPE(50);
BEGIN
    SELECT
        e.first_name,
        d.department_name
    INTO
        v_emp_name,
        v_dep_name
-- 변수에 대입을 의미
-- SELECT문의 조회 결과를 INTO에 적은 변수에 대입하겠다는 의미
    FROM
        employees   e
        LEFT OUTER JOIN departments d ON e.department_id = d.department_id
    WHERE
        employee_id = 100;

    dbms_output.put_line(v_emp_name
                         || '-'
                         || v_dep_name);
END;