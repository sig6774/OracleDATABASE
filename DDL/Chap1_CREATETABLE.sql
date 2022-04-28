CREATE TABLE dept1 (
    dept_no    NUMBER(2),
    dept_name  VARCHAR2(23),
    loca       VARCHAR2(15),
    dept_date  DATE,
    dept_bonus NUMBER(6)
);
--number(2) : 정수를 2자리까지 저장할 수 있음
--number(5,2) : 정수부, 실수부를 합친 총 자리수 5자리, 소수점 2자리 ex)123.45
--number : 괄호를 생략하면 (38,0) 자동 지정
--varchar2(byte) : 괄호 안에 들어올 문자열 최대 길이 
SELECT
    *
FROM
    dept1;
    
DESC dept1;
    
    
INSERT INTO dept1
VALUES (10, '영어부', '서울', sysdate, 20000);
--만약 테이블에서 정한 범위를 초과하면 ERROR발생 할 수 있음 
INSERT INTO dept1
VALUES (10, '영업부인것 같으면서도 총무도 하는 부서', '서울', sysdate, 20000);
--사전에 정한 테이블의 정의를 바꾸고 싶음!


--ALTER
--컬럼 추가 
ALTER TABLE dept1
ADD (dept_count NUMBER(3));

SELECT * FROM dept1;

--컬럼명 변경 
ALTER TABLE dept1
RENAME COLUMN dept_count TO emp_count;

--컬럼 속성 변경 
ALTER TABLE dept1
MODIFY (emp_count NUMBER(5));

DESC dept2;

--컬럼 삭제 
ALTER TABLE dept1
DROP COLUMN emp_count;

--테이블 이름 변경 
ALTER TABLE dept1
RENAME TO dept3;

SELECT * FROM dept3;

--TRUNCATE
-- 테이블의 구조만 남겨놓고 데이터만 모두 삭제 
TRUNCATE TABLE dept3;

SELECT * FROM dept3;
--모두 삭제된 것을 확인 

--DROP 
DROP TABLE dept3;
DROP TABLE dept2;


