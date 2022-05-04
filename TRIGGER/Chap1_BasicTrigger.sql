
--Trigger는 테이블에 주착한 형태로써 INSERT, UPDATE, DELETE, 작업이 수행될 때 
--특정 코드가 작동되도록 하는 구문

CREATE TABLE tbl_test(
id NUMBER(10),
text VARCHAR2(20));

CREATE OR REPLACE TRIGGER trg_test
AFTER DELETE OR UPDATE -- 삭제, 수정 이후에 동작 
ON tbl_test -- 부착할 테이블 
FOR EACH ROW -- 각 행에 적용 
BEGIN dbms_output.put_line('트리거가 동작'); -- 실행되는 코드를 BEGIN ~ END에 넣음 
END;

INSERT INTO tbl_test VALUES(1,'홍길동');
UPDATE tbl_test SET text = '홍길동2' WHERE id = 1;