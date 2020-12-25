SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)
  FROM EMP;
 
SELECT *
  FROM EMP
 WHERE UPPER(ENAME) LIKE UPPER('%scott%');
 
SELECT ENAME, LENGTH(ENAME)
  FROM EMP;
  
SELECT ENAME, LENGTH(ENAME)
  FROM EMP
 WHERE	LENGTH(ENAME) >= 5;

SELECT LENGTH('한글'), LENGTHB('한글')
  FROM DUAL;
 
SELECT JOB, SUBSTR(JOB, 1, 2), SUBSTR(JOB, 3, 2), SUBSTR(JOB, 5)
  FROM EMP;

SELECT JOB,
	   SUBSTR(JOB, -LENGTH(JOB)),
	   SUBSTR(JOB, -LENGTH(JOB),2),
	   SUBSTR(JOB, -3)
  FROM EMP;
	   
	   

 