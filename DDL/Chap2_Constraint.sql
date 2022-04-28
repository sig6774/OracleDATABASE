-- 테이블 생성과 제약조건 

-- TABLE COLUMN LEVEL CONSTARINT

-- PRIMARY KEY : 테이블의 고유 식별 컬러(주요키)
-- UNIQUE : 유일한 값을 가지게 하는 컬럼 (중복값 방지)
-- ONT NULL : NULL을 허용하지 않음
-- FOREIGN KEY : 참조하는 테이블의 PRIMARY KEY를 저장하는 컬럼
-- CHECK : 정의된 형식만 저장되도록 허용

-- 테이블과 제약조건 생성을 동시에 하는 방식 
CREATE TABLE dept2 (
    dept_no     NUMBER(2)
        CONSTRAINT dept2_deptno_pk PRIMARY KEY,
    dept_name   VARCHAR2(14) NOT NULL
        CONSTRAINT dept2_deptname_uk UNIQUE,
    loc         NUMBER(4)
        CONSTRAINT dept2_loca_locid_fk
            REFERENCES locations ( location_id ),
    -- 외래키로 누구를 참조하고 있는지 확인
    dept_bonus  NUMBER(10),
    dept_gender VARCHAR2(1) NOT NULL
        CONSTRAINT dept2_gender_ck CHECK ( dept_gender IN ( 'M', 'F' ) )
    --CHECK 제약조건을 통해서 dept_gender에 들어갈 수 있는 값은 M or F만 들어갈 수 있도록 작성
);

DROP TABLE dept2;

-- 테이블부터 생성하고 나중에 제약조건을 걸어주는 방식 
-- 테이블레벨 제약조건 (모든 열 선언 후 제약조건을 취하는 방식)
CREATE TABLE dept2 (
    dept_no     NUMBER(2),
    dept_name   VARCHAR2(14) NOT NULL,
    loc         NUMBER(4),
    dept_date   DATE,
    dept_bonus  NUMBER(10),
    dept_gender VARCHAR2(1),
    CONSTRAINT dept2_deptno_pk PRIMARY KEY ( dept_no ),
    CONSTRAINT dept2_deptname_uk UNIQUE ( dept_name ),
    CONSTRAINT dept2_loc_locid_fk FOREIGN KEY ( loc )
        REFERENCES locations ( location_id ),
    -- 외래키로 어떤 키를 사용하는지와 어떤 컬럼이 참조하고 있는지 표현
    CONSTRAINT dept2_deptdate_uk UNIQUE ( dept_date ),
    CONSTRAINT dept2_gender_ck CHECK ( dept_gender IN ( 'M', 'F' ) )
    -- CHECK 제약조건을 통해서 gender컬럼에 들어갈 수 있는 값을 개별 지정할 수 있음   
);

INSERT INTO dept2 VALUES (
    10,
    '처음부서',
    '3000',
    sysdate,
    '100000',
    'M'
);

INSERT INTO dept2 VALUES (
    20,
    '두번째부서',
    '4000',
    sysdate,
    '200000',
    'M'
);
--외래키로 사용하는 location_id에 해당 값이 없으므로 dept2에서 참조할 수 없으므로 에러발생 
--즉, 외래키가 부모테이블에 없다면 INSERT가 불가능
INSERT INTO dept2 VALUES (
    10,
    '처음부서',
    '3000',
    sysdate,
    '100000',
    'M'
);
--PK인 deptno와 UK인 deptname가 있으므로 중복이 있는 데이터는 삽입 X

SELECT
    *
FROM
    dept2;
--외래키가 부모테이블에 있다면 INSERT 가능 

UPDATE locations
SET
    location_id = 4000
WHERE
    location_id = 1800;
--locations테이블에 location_id가 1800인 것을 4000으로 바꿔줄려고 하는데 
--dept2 테이블에 제약조건이 걸려있어 변경하지 못함 

DROP TABLE dept2;

--제약조건 변경
CREATE TABLE dept2 (
    dept_no     NUMBER(2),
    dept_name   VARCHAR2(14) NOT NULL,
    loc         NUMBER(4),
    dept_date   DATE,
    dept_bonus  NUMBER(10),
    dept_gender VARCHAR2(1)
);

--PK추가 
ALTER TABLE dept2 ADD CONSTRAINT dept_no_pk PRIMARY KEY ( dept_no );
--FK추가
ALTER TABLE dept2
    ADD CONSTRAINT dept_loca_fk FOREIGN KEY ( loc )
        REFERENCES locations ( location_id );
--CHECK추가
ALTER TABLE dept2
    ADD CONSTRAINT dept2_gender_ck CHECK ( dept_gender IN ( 'M', 'F' ) );
--UNIQUE추가
ALTER TABLE dept2 ADD CONSTRAINT dept2_deptdate_uk UNIQUE ( dept_date );
--NOT NULL은 COLUMN 수정 형태로 변경
ALTER TABLE dept2 MODIFY
    dept_date DATE NOT NULL;

--제약조건 삭제 (제약조건 이름으로)
ALTER TABLE dept2 DROP CONSTRAINT dept_no_pk;

--문제
CREATE TABLE members (
    m_name   VARCHAR2(10),
    m_num    NUMBER(2),
    reg_date DATE,
    gender   VARCHAR2(1),
    loca     NUMBER(5),
    CONSTRAINT mem_memnum_pk PRIMARY KEY ( m_name ),
    CONSTRAINT mem_regdate_uk UNIQUE ( reg_date ),
    CONSTRAINT mem_loca_loc_locid_fk FOREIGN KEY ( loca )
        REFERENCES locations ( location_id )
);

ALTER TABLE members MODIFY
    m_name NOT NULL;

ALTER TABLE members MODIFY
    reg_date NOT NULL;

INSERT INTO members VALUES (
    'AAA',
    1,
    '2019-07-01',
    'M',
    1800
);

INSERT INTO members VALUES (
    'BBB',
    2,
    '2018-07-02',
    'F',
    1900
);

INSERT INTO members VALUES (
    'CCC',
    3,
    '2018-07-03',
    'M',
    2000
);

INSERT INTO members VALUES (
    'DDD',
    4,
    sysdate,
    'M',
    2000
);

COMMIT;

SELECT
    m.m_name,
    m.m_num,
    l.street_address,
    l.location_id
FROM
         locations l
    INNER JOIN members m ON l.location_id = m.loca
ORDER BY
    m_num ASC;