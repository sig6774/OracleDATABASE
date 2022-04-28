-- 사용자 계정 모두 확인 
SELECT
    *
FROM
    all_users;

-- 계정 생성 명령 
CREATE USER user2 IDENTIFIED BY user2;
-- CREATE USER 아아디 IDENTIFIED BY 비밀번호;
-- sys나 system으로 접속해야 계정을 생성할 수 있음
-- hr_practice의 접속을 끊고 system으로 접속하여 계정 생성 

-- DCL
/*
CREATE USER : DB 유저 생성 권한 
CREATE SESSION : DB 접속 권한 
CREATE TABLE : 테이블 생성 권한 
CREATE VIEW : 뷰 생성 권한 
CREATE SEQUENCE : 시퀀스 생성 권한 
ALTER ANY TABLE  : 어떤 테이블도 수정할 수 있는 권한 
INSERT ANY TABLE : 어떤 테이블도 데이터를 삽입하는 권한 
SELECT ANY TABLE ...

SELECT ON [테이블 이름] TO [유저 이름] : 특정 테이블만 조회할 수 있는 권한 
INSER ON ...
UPDATE ON ...
RESOURCE, CONNECT, DBA TO [유저이름]
*/
GRANT
    CREATE SESSION
TO user2;
--USER2에게 DB접속 권한 부여
GRANT
    CREATE ANY TABLE
TO user2;

GRANT SELECT ON hr.employees TO user2;
GRANT connect, resource TO user2;
--USER2에 해당 DB에 대한 거의 대부분의 권한을 부여

CREATE TABLE t_test (
    bno NUMBER(3)
);

CREATE SEQUENCE t_test_seq;

INSERT INTO t_test VALUES ( t_test_seq.NEXTVAL );

SELECT
    *
FROM
    t_test;
    
--권한 회수 
REVOKE connect, resource FROM user2;
--USER2에 위의 권한을 회수하겠다 라는 뜻
--USER2말고 더 상위에 있는 사용자에 들어가서 REVOKE해야함

INSERT INTO t_test VALUES ( t_test_seq.NEXTVAL );
SELECT * FROM t_test;
COMMIT;


--사용자 계정 삭제 
--DROP USER [유저이름] CASCADE; 
--CASCADE가 없을시 만약 테이블, 시퀀스가 존재한다면 계정 삭제 안됨.
DROP USER user2 CASCADE;

/*
테이블 스페이스는 데이터 베이스 객체 내 실제 데이터가 저장되는 공간 
테이블 스페이스를 생성하면 지정된 경로에 실제 파일로 정의한 용량만큼 
파일이 생성되고 데이터가 물리적으로 저장 
만약 테이블 스페이스의 용량을 초과한다면 프로그램이 비정상적으로 동작
*/

SELECT * FROM dba_tablespaces;

--USERS 테이블 스페이스를 기본 사용공간으로 지정 
ALTER USER user2 DEFAULT TABLESPACE users 
QUOTA UNLIMITED ON users;