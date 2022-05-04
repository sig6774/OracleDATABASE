SET SERVEROUTPUT ON;
--1. 모든 구구단을 출력하는 익명 블록을 만드세요(2~9단)
DECLARE
    v_num NUMBER := 3;
BEGIN
    FOR i IN 2..9 -- ..이 '~부터' 라는 뜻
     LOOP
        dbms_output.put_line(i || '단');
        FOR j IN 1..9 LOOP
            dbms_output.put_line(i
                                 || 'X'
                                 || j
                                 || '='
                                 || i * j);
        END LOOP;

    END LOOP;
END;

--2. INSERT를 300번 실행하는 익명 블록을 처리하세요 
-- BOARD라는 이름의 테이블을 만드세요 (bno wirter title 컬럼이 존재)
-- bno는 SEQUENCE로 올리고 writer와 title에 번호를 붙여서 INSERT 진행 
-- ex) 1, test1, title1 -> 2, test2, title2... 

CREATE TABLE board (
    bno    NUMBER(5),
    writer VARCHAR2(30),
    title  VARCHAR2(30)
);

DECLARE
    n NUMBER := 0;
    w VARCHAR2(30) := 'test';
    t VARCHAR2(30) := 'title';
BEGIN
    FOR i IN 1..300 LOOP
        INSERT INTO board VALUES (
            n + i,
            w || i,
            t || i
        );
--        값을 연결할 때 사용하는것은 ||

    END LOOP;
END;

SELECT
    *
FROM
    board;

CREATE TABLE board1 (
    bno    NUMBER(5) PRIMARY KEY,
    writer VARCHAR2(30),
    title  VARCHAR2(30)
);

CREATE SEQUENCE b_seq START WITH 1 INCREMENT BY 1 MAXVALUE 1000 NOCYCLE NOCACHE;

DECLARE
    v_num NUMBER := 1;
BEGIN
    WHILE v_num < 300 LOOP
        INSERT INTO board1 VALUES (
            b_seq.NEXTVAL,
            '테스투' || v_num,
            '오늘 점심은?' || v_num
        );

        v_num := v_num + 1;
    END LOOP;
END;

SELECT
    *
FROM
    board1;