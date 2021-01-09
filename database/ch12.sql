-- # 12-1 객체를 생성, 변경, 삭제하는 데이터 정의어
/*
데이터 정의어(DDL : Data Definition Language)는 데이터베이스 데이터를 보관하고 관리하기
위해 제공되는 여러 객체의 생성, 변경, 삭제 관련 기능을 수행하는 언어이다.

주의사항
사용자 정의어 실행은 COMMIT 효과를 낸다
*/

-- # 12-2 테이블을 생성하는 CREATE
-- 모든 열의 각 자료형을 정의해서 테이블 생성하기
CREATE TABLE EMP_DDL(
	EMPNO 		NUMBER(4),
	ENAME		VARCHAR2(10),
	JOB			VARCHAR2(9),
	MGR			NUMBER(4),
	HIREDATE	DATE,
	SAL			NUMBER(7, 2),
	COMM		NUMBER(7, 2),
	DEPTNO		NUMBER(2)
);

DESC EMP_DDL;

-- 다른 테이블을 복사하여 테이블 생성하기
CREATE TABLE DEPT_DDL
	AS SELECT * FROM DEPT;
	
SELECT * FROM DEPT_DDL;

-- 다른 테이블의 일부를 복사하여 테이블 생성하기
CREATE TABLE EMP_DDL_30
	AS SELECT *
		 FROM EMP
		WHERE DEPTNO = 30;

SELECT * FROM EMP_DDL_30;

-- 다른 테이블을 복사하여 테이블 생성하기
CREATE TABLE EMPDEPT_DDL
	AS SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE,
			  E.SAL, E.COMM, E.DEPTNO, D.DNAME, D.LOC
		 FROM EMP E, DEPT D
		WHERE 1<>1;
		
SELECT * FROM EMPDEPT_DDL;

-- # 12-3 테이블을 변경하는 ALTER
-- EMP 테이블 복사하여 EMP_ALTER 테이블 생성하기
CREATE TABLE EMP_ALTER
	AS SELECT * FROM EMP;

-- ALTER 명령어로 HP 열 추가하기
ALTER TABLE EMP_ALTER
  ADD HP VARCHAR2(20);
  
-- ALTER 명령어로 HP 열 이름을 TEL로 변경하기
ALTER TABLE EMP_ALTER
  RENAME COLUMN HP TO TEL;

-- ALTER 명령어로 EMPNO 열 길이 변경하기
ALTER TABLE EMP_ALTER
MODIFY EMPNO NUMBER(5);

-- ALTER 명령어로 TEL열 삭제하기
ALTER TABLE EMP_ALTER
DROP COLUMN TEL;

SELECT * FROM EMP_ALTER; 

-- # 12-4 테이블 이름을 변경하는 RENAME
-- 테이블 이름 변경하기
RENAME EMP_ALTER TO EMP_RENAME;
SELECT * FROM EMP_RENAME;

-- # 12-5 테이블의 데이터를 삭제하는 TRUNCATE
-- EMP_RENAME 테이블의 전체 데이터 삭제하기
TRUNCATE TABLE EMP_RENAME;
/*
TRUNCATE는 구조만 남겨 놓고 데이터를 전부 삭제하는 것은,
DML(Data Manipulation language)의 DELECT 명령어에서 where절을 삭제한 결과가 같다
하지만 TRUNCATE는 데이터 정의어에 포함되므로 자동 커밋이 되는 반면
DELECT는 데이터 조작어에 해당하므로 커밋이나 롤백이 가능하다.
 */
SELECT * FROM EMP_RENAME;

-- # 12-6 테이블을 삭제하는 DROP
DROP TABLE EMP_RENAME;

-- Q1
CREATE TABLE EMP_HW (
	EMPNO		NUMBER(4),
	ENAME		VARCHAR2(10),
	JOB			VARCHAR2(9),
	MGR			NUMBER(4),
	HIREDATE	DATE,
	SAL			NUMBER(7,2),
	COMM		NUMBER(7,2),
	DEPTNO		NUMBER(2)
);

-- Q2
ALTER TABLE EMP_HW
  ADD BIGO VARCHAR2(20);

-- Q3
ALTER TABLE EMP_HW
MODIFY BIGO VARCHAR2(30);

-- Q4
ALTER TABLE EMP_HW
RENAME COLUMN BIGO TO REMARK;

-- Q5
INSERT INTO EMP_HW
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO, NULL
  FROM EMP;

-- Q6
DROP TABLE EMP_HW;
  
SELECT * FROM EMP_HW;

SELECT sysdate FROM DUAL;