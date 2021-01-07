-- 04-4 중복데이터를 삭제하는 DISTINCT
SELECT * FROM EMP;
SELECT EMPNO, ENAME, DEPTNO
	FROM EMP;
SELECT EMPNO, DEPTNO
	FROM EMP;
SELECT DISTINCT DEPTNO -- 특정열 중복제거
	FROM EMP;
SELECT DISTINCT JOB, DEPTNO --여러열 중복제거
	FROM EMP;
SELECT ALL JOB, DEPTNO -- ALL은 default이다.
	FROM  EMP;

-- 04-5 별칭
SELECT ENAME, SAL, SAL*12+COMM, COMM
	FROM EMP;
SELECT ENAME, SAL, SAL+SAL+SAL+SAL+SAL+SAL+SAL+SAL+SAL+SAL+SAL+SAL+COMM, COMM
	FROM EMP;
SELECT ENAME, SAL, SAL*12+COMM AS ANNSAL, COMM
	FROM EMP;

-- 04-6 ORDER BY
SELECT *
	FROM EMP
ORDER BY SAL; -- 오름차순 ASC

SELECT *
	FROM EMP
ORDER BY EMPNO;

SELECT *
	FROM EMP
ORDER BY SAL DESC; -- 내림차순 DESC

SELECT *
	FROM EMP
ORDER BY DEPTNO ASC, SAL DESC;

-- 4장 Q2
SELECT DISTINCT JOB
	FROM EMP;

-- 4장 Q3
SELECT	EMPNO AS EMPLOYEE_NO,
		ENAME AS EMPLOYEE_NAME,
		JOB,
		MGR AS MANAGER,
		HIREDATE,
		SAL AS SALARY,
		COMM AS COMMISSION,
		DEPTNO AS DEPARTMENT_NO
	FROM EMP
ORDER BY DEPTNO DESC, ENAME;