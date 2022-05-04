-- AFTER 트리거 : INSERT, UPDATE, DELETE 작업 이후에 동작하는 트리거를 의미 
-- BEFORE 트리거 : INSERT, UPDATE, DELETE 작업 이전에 동작하는 트리거를 의미 
-- INSTEAD OF 트리거 : INSERT, UPDATE, DELETE 작업 이전에 발생하는 트리거인데 VIEW에만 부착할 수 있음

-- :OLD는 참조 전 열의 값 (INSERT: 입력 전 자료, UPDATE : 수정 전 자료, DELETE : 삭제할 값)
-- :NEW는 참조 후 열의 값 (INSERT: 입력 할 자료, UPDATE : 수정 된 자료)

CREATE TABLE tbl_user (
    id      VARCHAR2(20) PRIMARY KEY,
    name    VARCHAR2(20),
    address VARCHAR2(30)
);

CREATE TABLE tbl_user_backup (
    id          VARCHAR2(20),
    name        VARCHAR2(20),
    address     VARCHAR2(30),
    update_date DATE DEFAULT sysdate, -- 변경 시간 
    m_type      VARCHAR2(10), -- 변경 타입 
    m_user      VARCHAR2(20) -- 변경한 사용자 
);

-- AFTER 트리거 
CREATE OR REPLACE TRIGGER trg_user_backup AFTER
    UPDATE OR DELETE ON tbl_user
    FOR EACH ROW 
-- update나 delete 이후 동작 
DECLARE -- 사용할 변수를 선언 
    v_type VARCHAR2(10);
BEGIN
    IF updating THEN -- UPDATING은 시스템 자체에서 상태에 대한 내용을 지원하는 빌트인 구문 
-- UPDATE 상황이라면 
        v_type := '수정';
    ELSIF deleting THEN
        v_type := '삭제';
    END IF;

-- 실행 구문 시작. (:OLD는 테이블 DELETE, UPDATE가 적용되기 전 기존 데이터이며 변경 전 데이터를 뜻함)
-- UPDATE와 DELETE가 실행되기 전 변경 전의 데이터를 BACKUP테이블에 넣어주겠다는 뜻
    INSERT INTO tbl_user_backup VALUES (
        :OLD.id,
        :OLD.name,
        :OLD.address,
        
        sysdate,
        v_type,
        user()
    );
    -- tbl_user_backup에 데이터 변경 전의 데이터가 입력
END;
-- tbl_user가 UPDATE와 DELETE가 진행된 후 TRIGGER 진행하는데 trg_user_backup 테이블에 결과를 넣어줌

-- 트리거 동작 확인 
INSERT INTO tbl_user VALUES (
    'test01',
    'admin',
    '서울'
);

INSERT INTO tbl_user VALUES (
    'test02',
    '강아지',
    '서울'
);

INSERT INTO tbl_user VALUES (
    'test03',
    '고양이',
    '서울'
);

SELECT
    *
FROM
    tbl_user;

SELECT
    *
FROM
    tbl_user_backup;

UPDATE tbl_user
SET
    address = '인천'
WHERE
    id = 'test01';

DELETE FROM tbl_user
WHERE
    id = 'test01';
    
SELECT
    *
FROM
    tbl_user_backup;
    
-- BEFORE 트리거 
CREATE OR REPLACE TRIGGER trg_user_insert
    BEFORE INSERT
    ON tbl_user
    FOR EACH ROW
BEGIN
    :NEW.name := SUBSTR(:NEW.name, 1, 1) || '**';
END;
--    새로 입력받은 name을 넣어줌
    -- name의 첫글자만 추출하고 이후 **을 붙임 


INSERT INTO tbl_user VALUES('test05', '김메롱', '부산');
SELECT * FROM tbl_user;

/*
- 트리거의 활용
INSERT -> 주문테이블 -> 주문테이블 INSERT 트리거 실행 (물품 테이블 update)
*/

CREATE TABLE order_history(
history_no NUMBER(5) PRIMARY KEY, 
order_no NUMBER(5),
product_no NUMBER(5),
total NUMBER(10),
price NUMBER(10)
)

-- 상품 
CREATE TABLE product (
product_no NUMBER(5) PRIMARY KEY,
product_name VARCHAR2(20),
total NUMBER(5),
price NUMBER(5)
);

CREATE SEQUENCE order_history_seq NOCACHE;
CREATE SEQUENCE product_seq NOCACHE;

INSERT INTO product VALUES (
    product_seq.NEXTVAL,
    '피자',
    100,
    10000
);

INSERT INTO product VALUES (
    product_seq.NEXTVAL,
    '치킨',
    10,
    10500
);

INSERT INTO product VALUES (
    product_seq.NEXTVAL,
    '햄버거',
    100,
    5000
);

SELECT
    *
FROM
    product;

-- 주문 히스토리에 데이터가 들어오면 실행
CREATE OR REPLACE TRIGGER trg_order_history
    AFTER INSERT ON order_history FOR EACH ROW 
--    order_history에 insert가 들어간 후 trigger 발동
    DECLARE 
        v_total NUMBER;
        v_product_no NUMBER;
--        프로시저에서 사용할 변수 생성
    BEGIN 
        dbms_output.put_line('트리거 실행');
        SELECT :NEW.total
--        입력할 자료 중 total이라는 변수를 select
    INTO v_total
    FROM dual;
    
    v_product_no := :NEW.product_no;
--    값을 넣어줌
    UPDATE product 
    SET total = total - v_total
    WHERE product_no = v_product_no;
    END;
    
INSERT INTO order_history VALUES (
    order_history_seq.NEXTVAL,
    200,
    1,
    5,
    5000
);

INSERT INTO order_history VALUES (
    order_history_seq.NEXTVAL,
    200,
    1,
    1,
    15000
);

SELECT
    *
FROM
    product;
--INSERT가 진행 후 TOTAL 개수가 빠짐