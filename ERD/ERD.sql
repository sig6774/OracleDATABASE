
/* Drop Triggers */

DROP TRIGGER TRI_BOARD_bno;



/* Drop Tables */

DROP TABLE Reply CASCADE CONSTRAINTS;
DROP TABLE BOARD CASCADE CONSTRAINTS;
DROP TABLE USERS CASCADE CONSTRAINTS;
DROP TABLE ADMIN1 CASCADE CONSTRAINTS;



/* Drop Sequences */

DROP SEQUENCE SEQ_BOARD_bno;




/* Create Sequences */

CREATE SEQUENCE SEQ_BOARD_bno INCREMENT BY 1 START WITH 1;



/* Create Tables */

CREATE TABLE ADMIN1
(
	ID varchar2(30) NOT NULL,
	updatedate date DEFAULT SYSDATE,
	PRIMARY KEY (ID)
);


CREATE TABLE BOARD
(
	Title varchar2(30) NOT NULL,
	Content varchar2(1500),
	Writer varchar2(30) NOT NULL,
	bno number(10) NOT NULL,
	PRIMARY KEY (bno)
);


CREATE TABLE Reply
(
	RNO number(10) NOT NULL,
	Content varchar2(500) NOT NULL,
	Writer varchar2(30) NOT NULL,
	bno number(10) NOT NULL,
	PRIMARY KEY (RNO)
);


CREATE TABLE USERS
(
	ID varchar2(30),
	NAME varchar2(30) NOT NULL,
	REGDATE date NOT NULL,
	PRIMARY KEY (ID)
);



/* Create Foreign Keys */

ALTER TABLE USERS
	ADD FOREIGN KEY (ID)
	REFERENCES ADMIN1 (ID)
;


ALTER TABLE Reply
	ADD FOREIGN KEY (bno)
	REFERENCES BOARD (bno)
;


ALTER TABLE BOARD
	ADD FOREIGN KEY (Writer)
	REFERENCES USERS (ID)
;


ALTER TABLE Reply
	ADD FOREIGN KEY (Writer)
	REFERENCES USERS (ID)
;



/* Create Triggers */

CREATE OR REPLACE TRIGGER TRI_BOARD_bno BEFORE INSERT ON BOARD
FOR EACH ROW
BEGIN
	SELECT SEQ_BOARD_bno.nextval
	INTO :new.bno
	FROM dual;
END;

/




