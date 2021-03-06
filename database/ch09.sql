-- 09-1 서브쿼리
SELECT SAL
  FROM EMP
 WHERE ENAME = 'JONES';
 
-- 급여가 2975보 높은 사원 정보 출력하기
SELECT *
  FROM EMP
 WHERE SAL > 2975;
 
-- 서브쿼리로 JONES의 급여보다 높은 급여를 받는 사원 정보 출력하기
SELECT *
  FROM EMP
 WHERE SAL > (SELECT SAL
 				FROM EMP
 			   WHERE ENAME = 'JONES');
 			   
SELECT *
  FROM EMP
 WHERE COMM > (SELECT COMM
			     FROM EMP
			    WHERE ENAME = 'ALLEN');
			    
-- 09-2 단일행 서브쿼리
-- 서브쿼리의 결과 값이 날짜형인 경우
SELECT *
  FROM EMP
 WHERE HIREDATE < (SELECT HIREDATE
 					 FROM EMP
 					WHERE ENAME = 'JAMES');
 
-- 서브쿼리 안에서 함수를 사용한 경우
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL, D.DEPTNO, D.DNAME, D.LOC
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND E.DEPTNO = 20
   AND E.SAL > (SELECT AVG(SAL)
   				  FROM EMP);
   				  
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL, D.DEPTNO, D.DNAME, D.LOC
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND E.DEPTNO = 20
   AND SAL <= (SELECT AVG(SAL)
   				 FROM EMP);
   				 
-- 09-3 다중행 서브쿼리
/*
# 다중행 연산자
1) IN : 메인쿼리의 데이터가 서브쿼리의 결과 중 하나라도 일치한 데이터가 있으면 true
2) ANY, SOME : 메인쿼리의 조건식을 만족하는 서브쿼리의 결과가 하나 이상이면 true
3) ALL : 메인쿼리의 조건식을 서브쿼리의 결과 모두가 만족하면 true
4) EXISTS : 서브쿼리의 결과가 존재하면(즉, 행이 1개 이상일 경우) true
 */
-- IN 연산자
SELECT *
  FROM EMP
 WHERE DEPTNO IN (20, 30);
 
-- 각 부서별 최고 급여와 동일한 급여를 받는 사원 정보 출력
SELECT *
  FROM EMP
 WHERE SAL IN (SELECT MAX(SAL)
			    FROM EMP
			GROUP BY DEPTNO);

-- ANY 연산자 사용하기
SELECT *
  FROM EMP
 WHERE SAL = ANY (SELECT MAX(SAL)
 					FROM EMP
 				GROUP BY DEPTNO);

-- SOME 연산자 사용하기
SELECT *
  FROM EMP
 WHERE SAL = SOME (SELECT MAX(SAL)
 					FROM EMP
 				GROUP BY DEPTNO);
 			
 -- 30번 부서 사원들의 최대 급여보다 적은 급여를 받는 사원 정보 출력하기
SELECT *
  FROM EMP
 WHERE SAL < ANY (SELECT MAX(SAL)
 					FROM EMP
				   WHERE DEPTNO = 30)
ORDER BY SAL, EMPNO;

-- 30번 부서 사원들의 최소 급여보다 많은 급여를 받는 사원 정보 출력하기
SELECT *
  FROM EMP
 WHERE SAL > ANY (SELECT MIN(SAL)
					FROM EMP
				   WHERE DEPTNO = 30);
-- ALL 연산자
-- 부서 번호가 30번인 사원들의 최소 급여보다 더 적은 급여를 받는 사원 출력하기
SELECT *
  FROM EMP
 WHERE SAL < ALL (SELECT MIN(SAL)
					FROM EMP
				   WHERE DEPTNO = 30);
	
-- 부서 번호가 30번인 사원들의 최대 급여보다 더 많은 급여를 받는 사원 출력하기
SELECT *
  FROM EMP
 WHERE SAL > ALL (SELECT MAX(SAL)
					FROM EMP
				   WHERE DEPTNO = 30);
				  
-- EXISTS
-- 서브쿼리 결과 값이 하나 이상 존재하면 조건식이 모두 true, 존재하지 않으면 false가 되는 연산자

-- 서브쿼리 값이 존재하는 경우
SELECT *
  FROM EMP
 WHERE EXISTS (SELECT DNAME
				 FROM DEPT
				WHERE DEPTNO = 10);
 
-- 서브쿼리 값이 존재하지 않는 경우
SELECT *
  FROM EMP
 WHERE EXISTS (SELECT DNAME
				 FROM DEPT
				WHERE DEPTNO = 50);
				  
-- 1분 복습
SELECT *
  FROM EMP
 WHERE HIREDATE < ALL (SELECT HIREDATE
						 FROM EMP
						WHERE DEPTNO = 10);

-- 09-4 다중열 서브쿼리
-- 다중열 서브쿼리 사용하기
SELECT *
  FROM EMP
 WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL)
 						   FROM EMP
 						 GROUP BY DEPTNO);
				  
-- 09-5 FOMR절에 사용하는 서브쿼리와 WITH절
-- 인라인 뷰 사용하기
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
  FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E10,
  	   (SELECT * FROM DEPT) D
 WHERE E10.DEPTNO = D.DEPTNO;

-- WITH절 사용하기
WITH
E10 AS (SELECT * FROM EMP WHERE DEPTNO = 10),
D	AS (SELECT * FROM DEPT)
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
  FROM E10, D
 WHERE E10.DEPTNO = D.DEPTNO;

-- 09-6 SELECT절에 사용하는 서브쿼리
SELECT EMPNO, ENAME, JOB, SAL,
	   (SELECT GRADE
	   	  FROM SALGRADE
	   	 WHERE E.SAL BETWEEN LOSAL AND HISAL) AS SALGRADE,
	   DEPTNO,
	   (SELECT DNAME
	   	  FROM DEPT
	   	 WHERE E.DEPTNO = DEPT.DEPTNO) AS DNAME
  FROM EMP E;

-- Q1
SELECT JOB, EMPNO, ENAME, SAL, E.DEPTNO, DNAME
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND JOB = (SELECT JOB
				FROM EMP
			   WHERE ENAME = 'ALLEN');
  
-- Q2
SELECT EMPNO, ENAME, DNAME, HIREDATE, LOC, SAL, GRADE
  FROM EMP E, DEPT D, SALGRADE S
 WHERE E.DEPTNO = D.DEPTNO
   AND E.SAL BETWEEN LOSAL AND HISAL
   AND SAL > (SELECT AVG(SAL)
			    FROM EMP)
ORDER BY SAL DESC, EMPNO;

-- Q3
SELECT EMPNO, ENAME, JOB, E.DEPTNO, DNAME, LOC
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND E.DEPTNO = 10
   AND JOB <> ALL (SELECT JOB
				 	 FROM EMP
					WHERE DEPTNO = 30);

-- Q4
-- 다중행 함수 사용하지 않음
SELECT EMPNO, ENAME, SAL, GRADE
  FROM EMP, SALGRADE
 WHERE SAL BETWEEN LOSAL AND HISAL
   AND SAL > (SELECT MAX(SAL)
				FROM EMP
			   WHERE JOB = 'SALESMAN')
ORDER BY EMPNO;

-- 다중행 함수 사용
SELECT EMPNO, ENAME, SAL, GRADE
  FROM EMP, SALGRADE
 WHERE SAL BETWEEN LOSAL AND HISAL
   AND SAL > ANY (SELECT MAX(SAL)
				FROM EMP
			   WHERE JOB = 'SALESMAN')
ORDER BY EMPNO;


