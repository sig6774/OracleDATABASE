
-- WHILE
DECLARE
    v_num   NUMBER := 3;
    v_count NUMBER := 1;
BEGIN
    WHILE v_count <= 10 LOOP
        dbms_output.put_line(v_count);
        v_count := v_count + 1;
    END LOOP;
END;

-- 탈출문
DECLARE
    v_num   NUMBER := 3;
    v_count NUMBER := 1;
BEGIN
    WHILE v_count <= 10 LOOP
        dbms_output.put_line(v_count);
        EXIT WHEN v_count = 5;
        v_count := v_count + 1;
    END LOOP;
END;

-- FOR 
DECLARE
    v_num NUMBER := 3;
BEGIN
    FOR i IN 1..9 -- ..이 '~부터' 라는 뜻
     LOOP
        dbms_output.put_line(v_num
                             || 'X'
                             || i
                             || '='
                             || v_num * i);
    END LOOP;
END;

-- CONTINUE 
DECLARE
    v_num NUMBER := 3;
BEGIN
    FOR i IN 1..9 -- ..이 '~부터' 라는 뜻
     LOOP
     CONTINUE WHEN i = 5;
        dbms_output.put_line(v_num
                             || 'X'
                             || i
                             || '='
                             || v_num * i);
    END LOOP;
END;


