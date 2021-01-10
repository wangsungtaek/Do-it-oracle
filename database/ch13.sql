-- #13-1 데이터베이스를 위한 데이터를 저장한 데이터 사전
/*
데이터 사전이란 ?
	데이터 사전은 데이터베이스를 구성하고 운영하는 데 필요한 모든 정보를 저장하는 특수한
	테이블로 데이터베이스가 생성되는 시점에 자동으로 만들어집니다.
	사용자 테이블은 Normal Table, 데이터 사전은 Base Table이라고 부르기도 한다

	데이터 사전에는 데이터베이스 메모리, 성능, 사용자, 권한, 객체 등 오라클 데이터베이스 운영
	에 중요한 데이터가 보관되어 있다.
	
*/
-- SCOTT 계정에서 사용 가능한 데이터 사전 살펴보기(DICT 사용)
SELECT * FROM DICT;

-- SCOTT 계정에서 사용 가능한 데이터 사전 살펴보기(DICTIONARY 사용)
SELECT * FROM DICTIONARY;

-- SCOTT 계정이 가지고 있는 객체 정보 살펴보기(USER_접두어 사용)
SELECT TABLE_NAME FROM USER_TABLES;

-- SCOTT 계정이 사용할 수 있는 객체 정보 살펴보기(ALL_접두어 사용)
SELECT OWNER, TABLE_NAME FROM ALL_TABLES;

-- SYSTEM 계정으로 DBA_접두어 사용하기
SELECT * FROM DBA_TABLES;

-- DBA_USERS를 사용하여 사용자 정보를 알아보기(SYSTEM 계정으로 접속했을 때)
SELECT * FROM DBA_USERS WHERE USERNAME = 'SCOTT';

-- #13-2 더 빠른 검색을 위한 인덱스
/*
인덱스란?
	데이터베이스에서 데이터 검색 성능을 향상을 위해 테이블 열에 사용하는 객체를 뜻한다.
	
	Table Full Scan : 테이블 데이터를 처음부터 끝까지 검색하여 원하는 데이터를 찾는 방식
	Index Sacn : 인덱스를 통해 데이터를 찾는 방식
*/

-- SCOTT 계정이 소유한 인덱스 정보 알아보기
SELECT * FROM USER_INDEXES;
SELECT * FROM USER_IND_COLUMNS;

-- EMP 테이블의 SAL 열에 인덱스를 생성하기
CREATE INDEX IDX_EMP_SAL
	ON EMP(SAL);

-- 생성된 인덱스 살펴보기(USER_IND_COLUMNS 사용)
SELECT * FROM USER_IND_COLUMNS;

-- 인덱스 삭제
DROP INDEX IDX_EMP_SAL;

-- #13-3 테이블처럼 사용하는 뷰
/*
뷰란?
	가상 테이블로 부르는 뷰는 하나 이상의 테이블을 조회하는 SELECT문을 저장한 객체를
	뜻한다.

사용 목적
	1. 편리성 : SELECT문의 복잡도를 완화하기 위해
	2. 보안성 : 테이블의 특정 열을 노출하고 싶지 않을 경우
*/

-- 뷰를 생성하기 위해 계정 변경 접속하기(SQL*PLUS)
GRANT CREATE VIEW TO SCOTT;

-- 뷰 생성하기
CREATE VIEW VW_EMP20
	AS (SELECT EMPNO, ENAME, JOB, DEPTNO
		  FROM EMP
		 WHERE DEPTNO = 20);
		
-- 생성한 뷰 확인하기
SELECT * FROM USER_VIEWS;

-- 생성한 뷰 조회하기
SELECT * FROM VW_EMP20;

-- 뷰 삭제하기
DROP VIEW VW_EMP20;

-- ROWNUM을 추가로 조회하기
SELECT ROWNUM, E.*
  FROM EMP E;
 
-- EMP 테이블을 SAL 열 기준으로 정렬하기
SELECT ROWNUM, E.*
  FROM EMP E
ORDER BY SAL DESC;

-- 인라인 뷰(서브쿼리 사용)
SELECT ROWNUM, E.*
  FROM (SELECT *
  		  FROM EMP E
  		ORDER BY SAL DESC) E;
  	
-- 인라인 뷰(WITH절 사용)
WITH E AS(SELECT * FROM EMP ORDER BY SAL DESC)
SELECT ROWNUM, E.*
  FROM E;
 
-- 인라인 뷰로 TOP-N 추출하기(서브쿼리 사용)
SELECT ROWNUM, E.*
  FROM (SELECT *
  		  FROM EMP
  		ORDER BY SAL DESC) E
 WHERE ROWNUM <=3 ;

-- 인라인 뷰로 TON-N 추출하기(WITH절 사용)
WITH E AS(SELECT * FROM EMP ORDER BY SAL DESC)
SELECT ROWNUM, E.*
  FROM E
 WHERE ROWNUM <=3 ;

-- 13-4 규칙에 따라 순번을 생성하는 시퀀스
/*
시퀀스란?
	특정 규칙에 맞는 연속 숫자를 생성하는 객체이다.
 */
-- DEPT 테이블을 사용하여 DEPT_SEQUENCE 테이블 생성하기
CREATE TABLE DEPT_SEQUENCE
	AS SELECT *
	 	 FROM DEPT
	 	WHERE 1<>1;
	 
SELECT * FROM DEPT_SEQUENCE;

-- 시퀀스 생성하기
CREATE SEQUENCE SEQ_DEPT_SEQUENCE
  INCREMENT BY 10 -- 시퀀스에서 생성할 번호의 증가 값
  START WITH 10 -- 시퀀스에서 생성할 번호의 시작 값
  MAXVALUE 90 -- 시퀀스에서 생성할 번호의 최댓값 지정 
  MINVALUE 0 -- 시퀀스에서 생성할 번호의 최솟값 지정
  NOCYCLE -- 시퀀스에서 생성한 번호가 최댓값에 도달 시 시작 값에서 다시 시작할지
  CACHE 2; -- 시퀀스가 생성할 번호를 메모리에 미리 할당해 놓은 수를 지정.
 
-- 시퀀스 확인하기
SELECT * FROM USER_SEQUENCES;

-- 시퀀스에서 생성한 순번을 사용한 INSERT문 실행하기
INSERT INTO DEPT_SEQUENCE(DEPTNO, DNAME, LOC)
VALUES (SEQ_DEPT_SEQUENCE.NEXTVAL, 'DATABASE', 'SEOUL');

SELECT * FROM DEPT_SEQUENCE ORDER BY DEPTNO;

-- 가장 마지막으로 생성된 시퀀스 확인하기
SELECT SEQ_DEPT_SEQUENCE.CURRVAL
  FROM DUAL;
  
-- 시퀀스 옵션 수정하기
ALTER SEQUENCE SEQ_DEPT_SEQUENCE
  INCREMENT BY	3
  MAXVALUE	99
  CYCLE;

-- 옵션을 수정한 시퀀스 조회하기
SELECT * FROM USER_SEQUENCES;

-- 시퀀스 삭제
DROP SEQUENCE SEQ_DEPT_SEQUENCE;

-- #13-5 공식 별칭을 지정하는 동의어
/*
동의어란?
	테이블, 뷰, 시퀀스 등 객체 이름 대신 사용할 수 있는 다른 이름을 부여하는 객체
*/
-- 권한 부여하기
GRANT CREATE SYNONYM TO SCOTT;

-- EMP 테이블의 동의어 생성하기
CREATE SYNONYM E
   FOR EMP;
   
SELECT * FROM E;

-- 동의어의 삭제
DROP SYNONYM E;

-- Q1
--1
CREATE TABLE EMPIDX AS SELECT * FROM EMP WHERE 1<>1;
--2
CREATE INDEX IDX_EMPIDX_EMPNO
	ON EMPIDX(EMPNO);
--3
SELECT * FROM USER_INDEXES WHERE INDEX_NAME = 'IDX_EMPIDX_EMPNO';

-- Q2
CREATE OR REPLACE VIEW EMPIDX_OVER15K
	AS (SELECT EMPNO, ENAME, JOB, DEPTNO, SAL, NVL2(COMM, 'O', 'X') AS COMM
		  FROM EMPIDX
		 WHERE SAL > 1500);
SELECT *
  FROM EMPIDX_OVER15K;
 
SELECT EMPIDX; 

-- Q3
--1
CREATE TABLE DEPTSEQ AS SELECT * FROM DEPT;
--2
CREATE SEQUENCE SEQ_DEPT
  INCREMENT BY 1
  START WITH 1
  MAXVALUE 99
  MINVALUE 1
  NOCYCLE NOCACHE;
 
--3
INSERT INTO DEPTSEQ(DEPTNO, DNAME, LOC) VALUES(SEQ_DEPT.NEXTVAL, 'DATABASE', 'SEOUL');
INSERT INTO DEPTSEQ(DEPTNO, DNAME, LOC) VALUES(SEQ_DEPT.NEXTVAL, 'WEB', 'BUSAN');
INSERT INTO DEPTSEQ(DEPTNO, DNAME, LOC) VALUES(SEQ_DEPT.NEXTVAL, 'MOBILE', 'ILSAN');

SELECT * FROM USER_SEQUENCES;
SELECT * FROM DEPTSEQ;