--1. 모든 구구단을 출력하는 익명 블록을 만드세요(2~9단)
DECLARE
    v_num NUMBER := 3;
BEGIN
    FOR i IN 2..9 -- ..이 '~부터' 라는 뜻
    LOOP
    dbms_output.put_line(i || '단');
        FOR j IN 1..9
             LOOP
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
