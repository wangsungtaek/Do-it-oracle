-- 11-1 하나의 단위로 데이터를 처리하는 트랜잭션
/*
-- 트랜잭션이란?
	트랜잭션이란 더 이상 분할할 수 없는 최소 수행 단위를 뜻하며 계좌 이체와 같이 하나의
	작업 또는 밀접하게 연관된 작업을 수행하기 위해 한 개 이상의 데이터 조작 명령어로 이루어진다.
	즉 어떤 기능 한 가지를 수행하는 SQL문 덩어리 라고 볼 수 있다.	
*/

-- 11-2 트랜잭션을 제어하는 명령어
-- DEPT 테이블을 복사해서 DEPT_TCL 테이블 만들기
CREATE TABLE DEPT_TCL
	AS SELECT *
		 FROM DEPT;

DROP TABLE DEPT_TCL;
-- DEPT_TCL 테이블에 데이터를 입력, 수정, 삭제하기
INSERT INTO DEPT_TCL VALUES(50, 'DATABASE', 'SEOUL');

UPDATE DEPT_TCL SET LOC = 'BUSAN' WHERE DEPTNO = 40;

DELETE FROM DEPT_TCL WHERE DNAME = 'RESEARCH';

-- ROLLBACK으로 명령어 실행 취소하기
ROLLBACK;
COMMIT;
SELECT * FROM DEPT_TCL;

-- 11-3 세션과 읽기 일관성의 의미
/*
세션이란?
	일반적으로 세션은 어떤 활동을 위한 시간이나 기간을 뜻한다.
	오라클 데이터베이스에서 세션은 데이터베이스 접속을 시작으로 여러 데이터베이스에서
	관련 작업을 수행한 후 접속을 종료하기까지 전체 기간을 의미한다.
 */
DELETE FROM DEPT_TCL
 WHERE DEPTNO = 50;
COMMIT;
SELECT * FROM DEPT_TCL;

UPDATE DEPT_TCL SET LOC='SEOUL'
 WHERE DEPTNO = 30;