-- 시퀀스 
-- 순차적으로 증가하는 값을 만들어 주는 객체 

SELECT
    *
FROM
    user_sequences;

-- 시퀀스 생성 
CREATE SEQUENCE dept2_seq START WITH 1 -- 시작값 (default 증가할 때 최소값, 감소할 때 최소값)
 INCREMENT BY 1 -- 증가값 (양수면 증가, 음수면 감소, default 1)
 MAXVALUE 10 -- 최종값 (기본값 증가일 때 1027, 감소이면 -1)
 MINVALUE 1 -- 최소값 (기본값 증가일 때 1, 감소일때 -1028)
 NOCACHE -- CACHE MEMORY 사용여부 
 NOCYCLE; -- 순환 여부(default NOCYCLE) EX) 순환하게 되면 1~10까지 순환하고 다시 1~10 반복

CREATE TABLE dept3 (
    dept_no   NUMBER(2),
    dept_name VARCHAR2(14),
    loca      VARCHAR2(13),
    dept_date DATE
);

RENAME dept2_seq TO dept3_seq;

-- 시퀀스 사용하기 (NEXTVAL, CURRVAL)
INSERT INTO dept3 VALUES (
    dept3_seq.NEXTVAL,
    'test',
    'test',
    sysdate
);
--dept3_seq.NEXTVAL : dept3_seq의 다음 값을 지정해서 넣어줌
SELECT
    *
FROM
    dept3;
--dept_no의 값이 다음값으로 계속 증가하는 것을 볼 수 있음
SELECT
    dept3_seq.CURRVAL
FROM
    dual;
--CURRVAL : 현재 seq value확인 가능

--시퀀스 수정 
--START WITH은 수정이 불가능
ALTER SEQUENCE dept3_seq MAXVALUE 9999;
-- 최대값 수정 

ALTER SEQUENCE dept3_seq INCREMENT BY - 3; 
-- 증가 및 감소 값 변경

ALTER SEQUENCE dept3_seq MINVALUE - 50; 
-- 최소값 수정

DROP SEQUENCE dept3_seq;
-- 만들어 놓은 SEQUENCE 삭제

-- INDEX
-- PRIMARY KEY, UNIQUE 제약 조건에서 자동으로 생성되고, 조회를 빠르게 해주는 HINT역할
-- INDEX는 조회를 빠르게 하지만 무작위하게 많은 인덱스를 생성해서 사용하면 성능 부하를 일으킬 수 있음 
SELECT
    *
FROM
    employees
WHERE
    first_name = 'Nancy';

-- 인덱스 추가 
CREATE INDEX emp_first_name_idx ON
    employees (
        first_name
    );
/*
- 인덱스가 권장되는 경우 
1. 컬럼이 WHERE 또는 조인조건에서 자주 사용되는 경우
2. 열이 광범위한 값을 포함하는 경우
3. 테이블이 대형인 경우
4. 타겟 컬럼이 많은 수의 null값을 포함하는 경우.
5. 테이블이 자주 수정되고, 이미 하나 이상의 인덱스를 가지고 있는 경우에는
 권장하지 않음
*/

DROP INDEX emp_first_name_idx;

-- 시퀀스와 인덱스를 사용하는 HINT 방법
CREATE SEQUENCE board_seq
START WITH 1 
increment by 1 
nocache nocycle;

CREATE TABLE tbl_board (
    bno    NUMBER(10) PRIMARY KEY,
    writer VARCHAR2(20)
);

INSERT INTO tbl_board VALUES (
    board_seq.NEXTVAL,
    'test'
);

INSERT INTO tbl_board VALUES (
    board_seq.NEXTVAL,
    'admin'
);

INSERT INTO tbl_board VALUES (
    board_seq.NEXTVAL,
    'KIM'
);

SELECT
    *
FROM
    tbl_board;

ALTER INDEX sys_c007028 RENAME TO tbl_board_idx;

SELECT
    *
FROM
    (
        SELECT /*+ INDEX_DESC (tbl_board tbl_board_idx)*/ 
        --오라클의 힌트를 통해 index를 강제로 사용해서 조회하도록 하는 것
            ROWNUM AS rn,
            bno,
            writer
        FROM
            tbl_board
            /*+ INDEX(TABLE_NAME , INDEX_NAME)*/
            -- 지정된 인덱스를 강제로 쓰게끔 지정하고 INDEX DESC, ASC를 추가해서 정렬 가능
    )
WHERE
        rn > 10
    AND rn <= 20;