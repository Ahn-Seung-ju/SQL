/*
[1일차 수업]
1. 오라클 소프트웨어 다운로드
https://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html

2. Oracle Database 11g Release 2 Express Edition for Windows 64 (무료설치)

3. Oracle 설치(SYS, SYSTEM 계정의 대한 암호 : 1004)

4.Sqlplus 프로그램 제공(CMD) : GUI 환경 일반개발자 사용 불편

5.별도의 Tool 설치 무료(SqlDeveloper , https://dbeaver.io/)  ,
                 유료(토드 , 오렌지 , SqlGate) 프로젝트시 설치 활용 ^^

6. SqlDeveloper 툴을 통해서 Oracle Server 접속 ....
   >> HR 계정 : 암호 1004 , Unlock 2가지 사용가능 .... (사원관리 실습 테이블)
   >> 새로운 계정 : BITUSER

-- USER SQL
ALTER USER "HR" IDENTIFIED BY 1004 
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP"
ACCOUNT UNLOCK ;

-- QUOTAS
ALTER USER "HR" QUOTA UNLIMITED ON USERS;

-- ROLES
ALTER USER "HR" DEFAULT ROLE "RESOURCE","CONNECT";

-- SYSTEM PRIVILEGES


7. 현재 접속 계정 확인 : show user;   >> USER이(가) "BITUSER"입니다.


-- USER SQL
CREATE USER "BITUSER" IDENTIFIED BY "1004"  
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- QUOTAS

-- ROLES
GRANT "CONNECT" TO "BITUSER" WITH ADMIN OPTION;
GRANT "RESOURCE" TO "BITUSER" WITH ADMIN OPTION;
ALTER USER "BITUSER" DEFAULT ROLE "CONNECT","RESOURCE";

-- SYSTEM PRIVILEGES


*/

/*
실습코드

CREATE TABLE EMP
(EMPNO number not null,
ENAME VARCHAR2(10),
JOB VARCHAR2(9),
MGR number ,
HIREDATE date,
SAL number ,
COMM number ,
DEPTNO number );
--alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';

INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,'1980-12-17',800,null,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,'1981-02-22',1250,200,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,'1981-04-02',2975,30,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250,300,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,'1981-04-01',2850,null,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,'1981-06-01',2450,null,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,'1982-10-09',3000,null,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',null,'1981-11-17',5000,3500,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,'1981-09-08',1500,0,30);
INSERT INTO EMP VALUES
(7876,'ADAMS','CLERK',7788,'1983-01-12',1100,null,20);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,'1981-10-03',950,null,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,'1981-10-3',3000,null,20);
INSERT INTO EMP VALUES
(7934,'MILLER','CLERK',7782,'1982-01-23',1300,null,10);

COMMIT;

CREATE TABLE DEPT
(DEPTNO number,
DNAME VARCHAR2(14),
LOC VARCHAR2(13) );

INSERT INTO DEPT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES (40,'OPERATIONS','BOSTON');

COMMIT;



CREATE TABLE SALGRADE
( GRADE number,
LOSAL number,
HISAL number );

INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);
COMMIT;

*/
--1. 사원 테이블에서 모든 데이터를 출력하세요
--[쿼리문]은 [대소문자] 구별(x)
select * from emp;
SELECT * FROM EMP;

--2. 특정 컬럼 데이터 출력하기
select empno, ename , sal 
from emp;

select ename from emp;

--3. 컬럼명 가명칭(alias)별칭 부여하기
select empno 사번 , ename 이름
from emp;

--select empno 사    번 , ename 이    름
--from emp;

--SQL 표준 (데이터를 다루는 수 많은 소프트웨어) >> 표준 >> ANSI 문법
-- as "사    번"  
--Mysql  , MS-SQL 아래 쿼리 동작
select empno as "사    번" , ename as "이    름"
from emp;

--Oracle 데이터 : [문자열 데이터]는 엄격하게 [대소문자]를 구분합니다
--JAVA : 문자 'A' , 문자열 "AAA"
--Oracle : 문자열 'A'  , 'AAA'
--Oracle : A , a  >> 다른 문자
select empno , ename 
from emp
where ename='king'; --조건절

select empno , ename 
from emp
where ename='KING';
/*
select 절    3 
from 절      1
where 절     2
*/

--Oracle query(질의어) : 언어
--연산자 (결합연산자 || , 산술연산자 + )
--java : + 숫자(산술연산)
--java : + 문자열(결합)
--Tip) Ms-Sql   + (결합 산술)

select '사원의 이름은' || ename || ' 입니다' as "사원정보"
from emp;

--테이블에는 컬럼 >> 타입
--java  class Emp {private int empno , private String ename}
--Oracle  create table emp (empno number)
--타입(컬럼) : 숫자 , 문자열 , 날짜 
--create table emp (ename varchar2(10));
--10 > 10byte >> 한글1자 2byte , 영문자:특수문자:공백 1byte
--한글5자  , 영문 10자

desc emp;

-- 형변환  내부적으로 자동 형변환 (숫자 --> 문자열) 결합
select empno || ename 
from emp;

select empno + ename  --숫자 + 문자열 ORA-01722: invalid number 산술연산 불가
from emp;

--개발실
--사장님 
--우리 회사에 직종이 몇개나 있나 ...
select job from emp;
--중복 데이터 제거 : 키워드 : distinct
select distinct job
from emp;

--distinct 원리 : grouping
--재미로 ....
select distinct job , deptno
from emp
order by job;   --job group  그안에서 다시 deptno group 1건씩(중복되지 않는 데이터)

select * from emp order by job;

select distinct deptno , job
from emp
order by deptno; 

--Oracle sql 언어(연산자)
--java 거의 동일( + , - , * , /) 나머지 %
--Oracle 동일  [ % 연산자로 안써요 ] >> 함수  Mod() 

--사원테이블에서 사원의 급여를 100 달러 인상한 결과를 출력하세요

select empno, ename, sal, sal + 100 as "인상급여"
from emp;

--dual 임시 테이블 (가상)
--syso
select 100 + 100 from dual; --데이터 테스트
select 100 || 100 from dual; --100100
select '100' + 100 from dual; --200  >> '100' 숫자형 문자 (형 변환 숫자 가능)
select 'A100' + 100 from dual; --Error

--비교 연산자
--  <   >   <=
--주의
--java 같다 (==)  할당(=)    javascript(== , ===) 같다
--Oracle 같다(=)  같지않다(!=)

--논리 연사자
--AND ,OR ,NOT

--조건절(where 원하는 row )
select empno , ename, sal 
from emp;


select empno , ename, sal 
from emp
where sal >= 2000;

--사번이 7788번인 사원의 사번 , 이름 , 직종 , 입사일을 출력하세요
select empno, ename, job, hiredate    --3
from emp                              --1
where empno=7788;                     --2

--개발자  : select (70%) , insert , update , delete  (CRUD)
--관리자  : 백업하고 복구 , 장애(네트워크 , 성능) 관리 , 보안 (사용자권한.. 암호화)
--튜닝(쿼리튜닝 , 하드웨어) : 문장튜닝 (속도) : 시간 단가 
--설계(모델러) : 설계 (요구사항 정의 , 분석) : DB-modeling : domain (업무)

--사원의 이름이 king  인 사원의 사번 , 이름 , 급여 정보를 출력하세요
select empno, ename, sal
from emp
where ename ='KING';

--hint) AND , OR
/*    AND    ,   OR
0 0    0          0
0 1    0          1
1 0    0          1 
1 1    1          1
*/
--급여가 2000달러 이상이면서 직종이 manager  인 사원의 모든 정보를 출력하세요
select *
from emp
where sal >= 2000 and job='MANAGER'; --AND 모든 조건에 만족

--급여가 2000달러 이상이거나 또는 직종이 manager  인 사원의 모든 정보를 출력하세요
select *
from emp
where sal >= 2000 or job='MANAGER'; 

--오라클 날짜 (DB 서버의 날짜)
--오라클 날짜 키워드(sysdate)

select sysdate from dual;  --21/03/02
--오라클이 설치된 PC의 시간 (서버의 시간)

--모든 시스템 날짜 필수 구성
--게시판
--insert into board(writer, title, content, regdate)
--values('홍길동','방가','졸립다',sysdate)
--regdate 컬럼의 데이터 서버의 시간
--Tip) ms-sql : select getdate()

--오라클 서버(환경 설정 날짜)
select * from NLS_SESSION_PARAMETERS;
--NLS_DATE_FORMAT   >>	RR/MM/DD
--NLS_DATE_LANGUAGE	>>  KOREAN
--NLS_TIME_FORMAT	  >>  HH24:MI:SSXFF

--일반적으로 2021-03-02
--변경 정보는 현재 오라클 접속한 사용자의 작업 환경 설정
--그래서 접속을 (x)  재연결 원래상태로 복원 
--현재 session에만 반영
alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
--NLS_DATE_FORMAT	YYYY-MM-DD HH24:MI:SS

select sysdate from dual; --2021-03-02 14:10:09

select hiredate from emp;  --1980-12-17 00:00:00

select *
from emp
where hiredate='1980-12-17';

select *
from emp
where hiredate='1980/12/17'; --인정

select *
from emp
where hiredate='1980.12.17'; --^^

select *
from emp
where hiredate='80/12/17';--안되요  --현재 format (yyyy-MM--dd) (0)

--사원의 급여가 2000이상이고 4000이하인 모든 사원의 정보를 출력하세요
select *
from emp
where sal >= 2000 and sal <=4000;

--초과   미만  : where sal > 2000 and sal < 4000;

--연산자 : 컬럼명 between A and B (= 포함)
select *
from emp
where sal between 2000 and 4000;

--사원의 급여가 2000초과 4000미만 인 모든 사원의 정보를 출력하세요
select *
from emp
where sal > 2000 and sal <4000;


--부서번호가 10번 또는 20번 또는 30번인 사원의 사번 , 이름 , 급여 , 부서번호를 출력하세요
select *
from emp
where deptno=10 or deptno=20 or deptno=30;
--연산자 ( IN 연산자) 풀어쓰면 (조건 or 조건 or .....)
select empno, ename, sal, deptno
from emp
where deptno in (10,20,30);--where deptno=10 or deptno=20 or deptno=30; 해석


--부서번호가 10번 또는 20번이 아닌 사원의 사번 , 이름 , 급여 , 부서번호를 출력하세요 (부정)
--and ....  !
select *
from emp
where deptno != 10 and deptno != 20;
-- IN 부정 연산자 (NOT IN) 풀어쓰면  부정조건 and 부정조건 and .... 

select *
from emp
where deptno not in (10,20); --풀어쓰면 deptno != 10 and deptno != 20;

--POINT : Oracle 값이 없다 (데이터 없다) >> null
--필요악 (null)

create table member(
   userid varchar2(20) not null, --null을 허용하지 않겠다 (필수 입력)
   name varchar2(20) not null, --필수입력
   hobby varchar2(50) -- default null (기본적으로 null 허락) 선택입력
);

select * from member;
--회원가입 가정
insert into member(userid,hobby) values('hong','농구');  --x
-- ORA-01400: cannot insert NULL into ("BITUSER"."MEMBER"."NAME")
insert into member(userid,name) values('hong','홍길동');
--hobby 컬럼의 데이터 : null 채워진다
select * from member;

--POINT (INSERT , UPDATE , DELETE)
--실제 반영을 위해서는 
--반드시 commit 명령을 수행 (rollback)

commit;


--수당(comm) 을 받지 않는 모든 사원의 정보를 출력하세요
-- 0 도 데이터(받는 조건)
select comm from emp;
--comm 컬럼의 데이터가  null  인 것만 출력하시요
select *
from emp 
where comm = null; --이런 문법은 없어요 (질문 ...그냥 지나갑니다)

--null 비교는 (is null , is not null) 암기
select * from emp
where comm is null;

--수당(comm) 을 받는 모든 사원의 정보를 출력하세요
select * from emp
where comm is not null;

--사원테이블에서 사번 , 이름 , 급여 , 수당 , 총급여를 출력하세요
--총급여(급여 + 수당)
select empno, ename, sal , comm, sal + comm as "총급여"
from emp;

--POINT null 이란 녀석
--1. null 과의 모든 연산의 결과는 : null  ex) 100+null >null  100 - null > null
--2. 위 문제 해결 : 함수 >> nvl() , nvl2()
--nvl(컬럼명,대체값) >> 치환
--Tip) MS-SQL : null > convert()
--Tip) mysql : null < IFNULL()

select empno, ename, sal , comm, sal + nvl(comm,0) as "총급여"
from emp;

--comm 컬럼에서 null 데이터를 만나면 0으로 치환해서 연산해라

select 1000 + null from dual;

select 1000 + nvl(null,100) from dual;

select comm , nvl(comm,111111) from emp;

--사원의 급여가 1000 이상이고 수당을 받지 않는 사원의 사번 , 이름  , 직종 , 급여, 수당을 출력하세요
select empno, ename, job, sal, comm
from emp
where sal >= 1000 and comm is null;

--DQL(data query language) : select 
--DDL :정의어: create , alter , drop (Table emp,dept) 객체라고 불러요 
--DML :조작어: insert , update , delete (반드시 작업 후에는  
--실반영 : commit
--작업 취속 : rollback 명령어를 반드시 실행



--create table board (boardno number ...)
--JAVA : class board {private int boardno}

create table Board(
  boardid number not null, --숫자 , 필수 입력
  title varchar2(50) not null, --글제목(한글 25자 , 영문자 50자) ,필수 입력
  content varchar2(2000) not null, --글내용(한글 1000자, 영문자 2000자) 필수 입력
  hp varchar2(20) --default null  필수 입력이 아니다 (null 사용하겠다)
);

select * from USER_TAB_COLUMNS where table_name='BOARD';
desc board;
/*
--dbeaver
SELECT * 
FROM ALL_ALL_TABLES  WHERE TABLE_NAME ='BOARD';

--dbeaver  사용자 컬럼 정보 보기
SELECT * 
FROM ALL_TAB_COLUMNS WHERE TABLE_NAME ='BOARD';
*/

--create , alter , drop >> commit , rollback (x)
--commit , rollback (insert , update , delete) 작업시만 실반영, 취소 결정

select * from board;

insert into board(boardid, title, content)
values(100,'오라클','실수했네^^');

--데이터 잘못 넣었네 ... 
rollback;

--데이터 반영 해야지
commit;
/*
TIP) MS-SQL : default : auto commit 
insert into emp(empno) values(100); 자동 커밋

begin
    insert into emp(empno) values(100);

rollback or commit  할때 대기해라


TIP_ : Oracle 개발자 commit 또는 rollback 실행하기 전에는 실반영하지 않아요
*/
select * from board;
commit;

insert into board(boardid, title, content)
values(200,'자바','그립다');


insert into board(boardid, title, content)
values(300,'자바','언젠가 보겠지');

select * from board;

rollback;

/*
....
commit; 실반영
...
...
...
rollback 모두 취소 (commit 이후부터 )
*/

select boardid, title, content, nvl(hp,'EMPTY') as "HP" 
from board;  --nvl함수 중요(POINT)

--문자열 검색
--주소검색 : 검색어 : 역삼 -> 역삼 단어가 포함된 모든 주소가 다 출력( LIKE 패턴 검색)
--문자열 패턴 검색( LIKE 연산자)

--like 연산자(와일드 카드 문자 : 1. %(모든것)   , 2. _(한문자) ) 결합 패턴을 생성
--검색이 한정적 >> 상세한 검색 정규표현식 (java 정규표현식 오라클 적용)

select *
from emp
where ename like '%A%'; --ename  컬럼의 데이터가 A 를 포함


select *
from emp
where ename like '%a%'; --대소문자 엄격하게 구분


select *
from emp
where ename like 'A%'; --이름의 첫글자가 A인 모든 사원


select *
from emp
where ename like '%E';

--역삼 단어가 들어있는 주소를 다 찿아라
--select * from zip where dong like '%역삼%'

--select * from member where  name like '김%'

select *
from emp
where ename like '%LL%'; --ALLEN   MILLER


select *
from emp
where ename like '%A%A%';  --ADAMS   --AAAAA  , ABABA


select ename
from emp
where ename like '_A%'; --첫글자는 어떤것이 와도 되고 두번째 글자는 A 시작
--WARD
--MARTIN
--JAMES

select ename
from emp
where ename like '__A%';  
--BLAKE
--CLARK
--ADAMS

--오라클 과제 (regexp_like)  상세검색
select * from emp where regexp_like(ename,'[A-C]');
--오라클 사용할 수 있는 정규 표현 검색 5개 만들기 (EMP)

------------------------------------------------------------------------0303


--데이터 정렬하기
--order by 컬럼명: 문자데이터 , 숫자데이터, 날짜데이터 정룔
--오름차순: asc => 낮은 순으로 => default
--내림차순: desc => 높은순
--비용(cost) 많이드는 작업

select *
from emp
order by sal;--default asc

select * 
from emp
order by sal asc;

--급여를 많이 받는 순으로 정렬

select *
from emp
order by sal desc;

--입사일이 가장 늦은 순으로 정렬해서 사번, 이름, 급여, 입사일을 출력

select empno, ename, sal, hiredate
from emp
order by hiredate desc;

select *
from emp
order by ename asc; --문자열 정렬 가능
/*
수행하는 순서
select 절    3
from 절      1
where 절     2
order by 절  4   (select 한 결과를 정렬한다)
*/
--해석
select empno, ename, sal, job , hiredate
from emp
where job = 'MANAGER'
order by hiredate desc;

--order by 컬럼명 asc, 컬럼명 desc, 컬럼명 asc
--POINT(답변형 게시판) 필수

select job, deptno
from emp
order by job asc, deptno desc; 
--group 원리

--연산자
--합집합(union): 테이블과 테이블의 데이터를 합치는 것 (중복값 배제)
--합집합(union all): 중복값 허용

create table uta(name varchar2(20));

insert into uta(name) values('AAA');
insert into uta(name) values('BBB');
insert into uta(name) values('CCC');
insert into uta(name) values('DDD');
commit;

select* from uta;

create table ut(name varchar2(20));

insert into ut(name) values('AAA');
insert into ut(name) values('BBB');
insert into ut(name) values('CCC');
commit;

select* from ut;

select * from ut
union --중복 데이터 배제
select * from uta; --ut 집에 uta가 식구들 데리고 가는 것

select * from ut
union all
select * from uta;

--union 규칙
--1. 대응대는 컬럼의 타입이 동일
select empno, ename from emp --empno 숫자
union 
select job, deptno form dept;--job은 문자열

select empno, ename from emp --empno 숫자
union 
select deptno, dname from dept;

--2. 대응대는 컬럼의 개수가 동일
--null
select empno, ename, job, sal from emp --4개
union
select deptno, dname, loc, nvl(null,0) from dept;   --3개
-----------------------------------------------------------------------------
--초보 개발자가 의무적으로 해야하는 것(단일 테이블에서 select)

------------------------------------------------------------------------------
--Tip
--오라클 함수 ......
select * from SYS.NLS_DATABASE_PARAMETERS;
--NLS_CHARACTERSET  : 	AL32UTF8  한글 3byte 인식
--KO16KSC5601 2Byte (현재 변환하면 한글 다깨짐)
select * from nls_database_parameters where parameter like '%CHAR%';
------------------------------------------------------------------------------
create table test2(name varchar2(2));

insert into test2(name) values('a');
insert into test2(name) values('aa');
insert into test2(name) values('가'); --한글 1자 3byte 인지
--ORA-12899: value too large for column "BITUSER"."TEST2"."NAME" (actual: 3, maximum: 2)
-------------------------------------------------------------------------------
?--[2차시]
--오라클 함수 사용법
/*
1. SQL 함수
제공되는 함수들은 기본적인 Query 문을 더욱 강력하게 해주고 데이터 값을 조작하는데
사용된다. 여러분은 단일 행 함수를 이용하여 문자,숫자,날짜 함수에 대해 살펴볼 뿐만 아
니라 형을 전환하는 함수들에 대해서도 살펴본다. 또한 복수 행 함수를 이용하여 복수의
행 조합하여 그룹 당 하나의 결과를 출력하는 그룹 함수에 대해서 살펴본다.
1.1 SQL 함수의 특징 및 이점
1) 데이터에 계산을 수행할 수 있다.
2) 개별적인 데이터 항목을 수정할 수 있다.
3) 행의 그룹에 대해 결과를 조작할 수 있다.
4) 출력을 위한 날짜와 숫자 형식을 조절할 수 있다.
5) 열의 자료형을 변환할 수 있다.
1.2 단일 행 함수(Single Row Function)
이 함수는 단일 행에 대해서만 적용 가능하고 행별로 하나의 결과를 RETURN 한다..
Function_name (column | expression [ ,arg1,arg2, . . . . ])
function_name 함수 명
column 데이터 베이스의 Column Name
expression 어떤 문자 스트링이거나 계산된 표현식
arg1,arg2 함수에 의해 사용될 수 있는 인수
1.2.1 단일 행 함수가 이용되는 곳
1) 데이터에 대해 계산을 수행할 경우
2) 각각의 데이터 항목을 변경할 경우
3) 출력할 날짜 형식을 변경할 경우
4) Column Data Type 을 변경할 경우
1.2.2 단일 행 함수의 종류
1) 문자형 함수 : 문자를 입력 받고 문자와 숫자 값 모두를 RETURN 할 수 있다.
2) 숫자형 함수 : 숫자를 입력 받고 숫자를 RETURN 한다.
3) 날짜형 함수 : 날짜형에 대해 수행하고 숫자를 RETURN 하는 MONTHS_BETWEEN 함수를
제외하고 모두 날짜 데이터형의 값을 RETURN 한다.
4) 변환형 함수 : 어떤 데이터형의 값을 다른 데이터형으로 변환한다.
5) 일반적인 함수 : NVL, DECODE
*/

--문자열 함수

select initcap('the super man') from dual;--The Super Man 단어의 앞글자를 대문자로 만듬

select lower('AAA'), upper('aaa') from dual;-- lower 단어 소문자로 만들기 upper 단어 대문자로 만들기

select ename, lower(ename) as "ename" from emp;

select * from emp where lower(ename) = 'king';

select length('abcd') from dual; --문자열 개수
select length('홍길동') from dual; -- 3개

select length('  홍 길 동 a') from dual; --공백포함 9개

--결합 연산자: ||  (유연)
--concat()
select 'a' || 'b' || 'c' as "data"
from dual; --abc


--select concat('a','b','c') from dual;
select concat('a','b') from dual;

select ename || '           ' || job from emp;
select concat(ename,job) from emp;

--부분 문자열 추출
--java(substring)
--Oracle(substr)
select substr('ABCDE',2,3) from dual;--BCD
select substr('ABCDE',1,1) from dual;--A
select substr('ABCDE',3,1) from dual;--C

select substr('asdfiodlfdAFDOD',3) from dual; --dfiodlfdAFDOD

select substr('ABCDE',-2,1) from dual; --D
select substr('ABCDE',-2,2) from dual; --DE

--사원테이블에서 ename 컬럼 데이터에 대해서 첫글자는 소문자로 나머지 글자는 대문자로 출력하되
--하나의 컬머으로 만들어서 출력하세요
--컬럼의 별칭은: fullname
--첫글자와 나머지 문자 사이에는 공백 하나를 넣으세요
--SMITH >> s MITH 출력

select lower(substr(ename,1,1)) || ' ' || substr(ename,2) as "fulllname"
from emp;

--lpad, rpad (채우기)
select lpad('ABC', 10,'*') from dual; --*******ABC
select rpad('ABC', 10,'%') from dual ;--ABC%%%%%%%

--사용자의 비번: hong1007
--화면: ho******
--비번: 1004 >> 10**

select rpad(substr('hong1007',1,2),length('hong1007'),'*') as "pwd" from dual;
--ho******
select rpad(substr('1004',1,2),length('1004'),'*') as "pwd" from dual;

--emp 테이블에서 ename 컬럼의 데이터를 출력하되 첫글자만 출력하고 나머지는 *로 출력하세요

select rpad(substr(ename,1,1),length(ename),'*') as "ename" from emp;

--rtrim 함수
--[오른쪽 문자]를 지워라
select rtrim('MILLER','ER') from dual;

--ltrim 함수
--[왼쪽 문자]를 지워라
select ltrim('MILLLLLLLLLLLER','MIL') from dual;

--공백제거 활용
select '>' || rtrim('MILLER          ', ' ') || '<' from dual;

--치환함수 (replace)

select ename, replace(ename, 'A', 'Wow') from emp;
--------------------------------------------------------------------------------
--[숫자 함수]
--round(반올림 함수)
--trunc(절삭함수)
--나머지 구하는 함수 (mod())
-- -3 -2 -1 0(정수) 1 2 3
select round(12.345, 0) as "r" from dual; -- 0 => 정수 부분만 남겨라 결과: 12
select round(12.678, 0) as "r" from dual;-- 결과 13 round 반올림

select round(12.345, 1) as "r" from dual; --12.3 >> 1의 의미: 소수점 1자수까지 남겨라
select round(12.678, 1) as "r" from dual; --12.7

select round(12.345, -1) as "r" from dual; -- 10 >> -1의 의미: 10자리수까지 남겨라
select round(15.678, -1) as "r" from dual;--  20
select round(15.678, -2) as "r" from dual;--  0

select trunc(15.1234,-1) as "t" from dual;-- 버림 한다 결과값: 10

--나머지

select 12/10 from dual; --1.2

select mod(12,10) from dual; --나머지 2

--------------------------------------------------------------------------------
--[날짜함수]
select sysdate from dual;

--POINT (날짜 연산)
--1. Date + Number >> Date
--2. Date - Number >> Date
--3. Date - Date   >> Number(일수)
select sysdate + 100 from dual;
select sysdate + 1000 from dual;

select hiredate from emp;
--함수
select trunc(months_between('2018-02-27', '2010-02-20'),0) from dual; --96개월
select months_between(sysdate,'2010-03-03') from dual;

select '2019-03-03' + 100 from dual;
--POINT
--to_date() 변환함수

select to_date('2019-03-03') + 100 from dual; --2019-06-11 00:00:00

--1. 사원 테이블에서 사원들의 입사일에서 현재날짜까지 근속월수를 구하세요  ( 사원이름 , 입사일 , 근속월수 )
--단 근속월수는 정수부분만 출력하세요 (반올림 하지 마세요)
select ename, hiredate, trunc(months_between(sysdate,hiredate),0) as "근속 월수"
from emp;

--2. 한달이 31 일 이라는 기준에서 근속월수를 구하세요 (반올림 하지 마세요) (함수 사용(x) >> 날짜 - 날짜 >> 150일 )요)
select ename, hiredate, trunc((sysdate - hiredate)/31,0) as "근속 월수"
from emp;
--------------------------------------------------------------------------------
--함수(문자, 숫자, 날짜) 까지
--------------------------------------------------------------------------------
--[변환 함수] Today Point
--Oracle 데이터: 문자열, 숫자 ,날짜
--to_char(): 숫자 -> 문자 (1000 -> $100,000) 출력형식
--           날짜 -> 문자 ('2021-03-03' -> 2021년03월03일) 출력형식

--to_date(): 문자 -> 날짜
select to_date('2021-01-01') + 100 from dual;

--to_number(): 문자 -> 숫자 >> 자동 형변환
select '100' + 100 from dual; -- '100' 숫자형 문자

select to_number('100') + 100 from dual;

--------------------------------------------------------------------------------
/*
--create table 테이블명 (컬럼명 타입, 컬럼명 타입.......)
create table member (age number); insert.... 1건 ~ 1000건
insert into member(age) values(100);
...100건 insert

[java]
class member {private int age;}
1건 -> 객체 1개
member m = new member();
m.setAge(100);

100건
List<member> mlist = new ArrayList<member>();
mlist.add(new member(100));
mlist.add(new member(200));
mlist.add(new member(300));
mlist.add(new member(400));

데이터 타입
문자열 타입
char(10)     >>  10Byte >> 한글 5자, 영문자:특수문자:공백 10자 >> 고정길이 문자열
varchar2(10) >>  10Byte >> 한글 5자, 영문자:특수문자:공백 10자 >> 가변길이 문자열

char(10)     >> 'abc' >> 3byte >> [a][b][c][][][][][][][] >> 공간의 변화가 없다 >> 10byte 
varchar2(10) >> 'abc' >> 3byte >> [a][b][c] >> 데이터 크기 만큼만 공간 확보 >> 3byte

-한글 1자 3byte (남,여)
create table member(gender char(3));
create table member(gender varchar2(3));
--성능(char)

create table member(gender char(30)); >> 사람의 이름
create table member(gender varchar2(30)); >> (O)

약속: 고정길이 데이터(남,여 || 대,중,소 || 주민번호 ...) char()
      가변길이 데이터(사람이름, 주소 , 취미) varchar2()

char() varchar2()단점: 한글, 영문자:특수문자:공백
varchar2(10)

unicode (2byte): 한글, 영문자, 특수문자, 공백 >> 2byte로 보자

nchar(20)     >> 20글자 >> 2*20byte >> 40byte
nvarchar2(20) >> 20글자 >> 2*20byte >> 40byte

한글문화권 n^^
*/
create table test3(name nchar(2), ename nvarchar2(2));

insert into test3(name) values('a');
insert into test3(name) values('가');

insert into test3(name) values('ab');
insert into test3(name) values('가나');

insert into test3(name) values('abc');
insert into test3(ename) values('가나다');

commit;

--1. to_number() -> 숫자로 (자동 형변환)
select '1' + 1 from dual;
--원칙
select to_number('1') + 1 from dual;

--2. to_char() 숫자 -> 형식문자, 날짜 -> 형식 문자
/*
select sysdate, to_char(sysdate,'YYYY') || '년' as 'YYYY",
                to_char(sysdate,'YEAR'),
                to_char(sysdate,'DD'),
                to_char(sysdate, 'DAY'),
                to_char(sysdate, 'DY')
from dual;
 */
 
 --입사일이 12월인 사번의 사번, 이름, 입사일, 입사년도, 입사월을 출력
 select empno, ename, hiredate, to_char(hiredate,'YYYY') as "YYYY", to_char(hiredate, 'MM') as "MM"
 from emp
 where to_char(hiredate, 'MM') = '12';
 
 select to_char(hiredate, 'YYYY MM DD') from emp;
 
 select to_char(hiredate,'YYYY"년" MM"월" DD"일"') from emp;
 
 --to_char(): 숫자 -> 형식문자
 --pdf 오라클 71page 49page
 --10000000 -> $100,000,000 -> 문자
 
 select '>' || to_char(12345,'99999999999') || '<' from dual;
 select '>' || to_char(12345,'09999999999') || '<' from dual; --> 00000012345<
 
 
 select '>' || to_char(12345,'$99,999,999,999') || '<' from dual;
 select sal, to_char(sal,'$999,999') from emp;
 
 --HR 계정으로 
 
select * from employees;
select sysdate from dual;
alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
 
 /*
사원테이블(employees)에서 사원의 이름은 last_name , first_name 합쳐서 fullname 별칭 부여해서 출력하고
입사일은  YYYY-MM-DD 형식으로 출력하고 연봉(급여 *12)을 구하고 연봉의 10%(연봉 * 1.1)인상한 값을
출력하고 그 결과는 1000단위 콤마 처리해서 출력하세요
단 2005년 이후 입사자들만 출력하세요 그리고 연봉이 높은 순으로  출력하세요
*/
select last_name || first_name as "fullname",
       to_char(hire_date, 'YYYY-MM-DD') as "YYYY-MM-DD",
       salary * 12 as "연봉",
       to_char((salary * 12) + ((salary* 12)/10),'$999,999,999') as "연봉 인상한 값",
       hire_date
from employees
where to_char(hire_date, 'YYYY') >= '2005'
order by "연봉" desc;
--order by 절에 select 가지고 있는 별칭을 사용할 수 있다(실행 순서)
--------------------------------------------------------------------------------
--문자함수
--날짜함수
--숫자함수
--변환함수(to_char(),to_number(), to_date()
--------------------------------------------------------------------------------
--일반함수(프로그램 성격이 가장 강한 함수)
--nvl(), nvl2() >> null 처리하는 함수
--dicode() >> java if 처럼 사용할 수 있다
--case()   >> java switch 처럼 사용할 수 있다

--오라클 SQL (변수, 제어문 개념이 없다) (X)
--오라클 PL-SQL (변수, 제어문 사용가능) 고급...SPRING할 때 수업
--계정 bituser 
select comm, nvl(comm,0) from emp;

create table t_emp(
    id number(6), --정수 6자리
    job nvarchar2(20)  
);

insert into t_emp(id, job) values(100,'IT');
insert into t_emp(id, job) values(200,'SALES');
insert into t_emp(id, job) values(300,'MGR');
insert into t_emp(id, job) values(400);
insert into t_emp(id, job) values(100,'MRG');
commit;

select *
from t_emp;

select id, decode(id, 100, '아이티', 
                      200, '영업부', 
                      300, '관리팀', 
                      '기타부서') as "부서이름"
from t_emp;

select empno, ename, deptno, decode(deptno, 10, '인사부',
                                            20, '관리부',
                                            30, '회계부',
                                            40, '부서',
                                            'ETC') as "부서이름"
from emp;

--Quiz
CREATE TABLE t_emp2(
id NUMBER(2),
jumin CHAR(7)
);
INSERT INTO t_emp2(id, jumin) VALUES(1,'1234567');
INSERT INTO t_emp2(id, jumin) VALUES(2,'2234567');
INSERT INTO t_emp2(id, jumin) VALUES(3,'3234567');
INSERT INTO t_emp2(id, jumin) VALUES(4,'4234567');
INSERT INTO t_emp2(id, jumin) VALUES(5,'5234567');
COMMIT;
SELECT * FROM t_emp2;
/*
t_emp2 테이블에서 id, jumin 데이터를 출력하되 jumin 컬럼의 앞자리가 1이면
'남성' 출력 2이면 '여성' 3이면 '중성' 그외는  '기타' 라고 출력하세요
컬럼명은 '성별'
*/

select decode(substr(jumin,1,1), 1, '남성',
                                 2, '여성',
                                 3, '중성',
                                 '기타') as "성별", id
from t_emp2;

select deptno, decode(deptno, 20, decode(ename , 'SMITH' , 'HELLO', 'WORLD')
                      ,'ETC')
from emp;

--decode >> 다양한 통계...

--CASE 문
--java switch
/*
CASE 조건식 when 결과 1 THEN 출력 1
           when 결과 2 then 출력 2
           when 결과 3 then 출력 3
           else 출력 4
END "컬렴명"
*/
create table t_zip(
    zipcode number(10)  
);

insert into t_zip(zipcode) values(2);
insert into t_zip(zipcode) values(31);
insert into t_zip(zipcode) values(32);
insert into t_zip(zipcode) values(33);
insert into t_zip(zipcode) values(41);
commit;

select *
from t_zip;

select '0' || to_char(zipcode) , case zipcode when 2 then '서울'
                                              when 31 then '경기'
                                              when 32 then '강원'
                                              when 41 then '제주'
                                              else '기타지역'
                        end "지역이름"
from t_zip;

select case  when sal <= 1000 then '4급'
             when sal between 1001 and 2000 then '3급'
             when sal between 2001 and 3000 then '2급'
             when sal between 3001 and 4000 then '1급'
             else  '특급'
end "급수"
from emp;
--------------------------------------------------------------------------------
--문자함수 끝
--숫자함수 끝
--날짜함수 끝
--변환함수 끝 (to_char(), to_date(), to_number())
--일반함수 nvl(), decode(), case 구문
--기본함수 END--
--------------------------------------------------------------------------------
--집계(그룹)함수
--오라클.pdf (75page)

--1. count(*) >> row수, count(컬러명) >> 데이터 건수 (null은 포함하지 않는다)
--2. sum()
--3. avg()
--4. max()
--5. min()
--기타 등등
--1. 집계함수는 group by 절과 같이 사용
--2. 모든 집계함수는 null 값을 무시한다.
--3. select 절에 집계함수 이외에 다른 컬럼이 오면 반드시 그 컬럼은 group by 절에 명시해야 된다.

select count(*) from emp; --14건 (줄수 row)
select count(empno) from emp;
select count(comm) from emp;-- 6건 null값은 무시한다
select comm from emp;
select count(nvl(comm,0)) from emp;

--급여의 합을 더해라
select sum(sal) as "급여의 합" from emp;

select round(avg(sal),0) as "급여의 평균" from emp;

--사장님 우리회사 총 수당이 얼마나 지급되었나
select sum(comm) from emp;

--수당의 평균
select trunc(avg(comm),0) from emp; --721 (null 값을 무시)
--회사의 규정(받은 사원 기준)
select trunc((sum(comm)/14),0) from emp;--309
--회사의 규정(전체 사원 기준)
select comm from emp;

select trunc(avg(nvl(comm,0))) from emp;

select max(sal) from emp;

select min(sal) from emp;

select empno, count(empno) from emp; --ORA-00937: not a single-group group function
--14 --1

select sum(sal) , avg(sal) , max(sal), min(sal), count(sal) from emp;
--------------------------------------------------------------------------------
--부서별 평균 급여를 구하세요
select deptno, avg(sal)
from emp
group by deptno;

--직종별 평균 급여를 구하시오
select job, avg(sal)
from emp
group by job;

--직종별 평균급여, 급여 , 최대 급여 , 최소급여, 건수 출력

select job, avg(sal), max(sal), min(sal), count(sal)
from emp
group by job;

/*
grouping

distinct 컬럼명1, 컬럼명2

order by 컬럼명, 컬럼명2

group by 컬럼명1, 컬럼명2
*/

--부서별, 직종별 급여의 합

select deptno, sum(sal)
from emp
group by deptno;

select deptno, job, sum(sal), count(sal)
from emp
group by deptno, job;

/*
select      5
from        1
where       2
group by    3
having      4
order by    6
*/

--직종별 평균급여가 3000달러 이상인 사원의 직종과 평균급여를 출력

select job , avg(sal) as "avgsal"
from emp
group by job
having avg(sal) >= 3000;
--having 절에서 select 가명칭을 사용하지 못한다
/*
1.form 조건절 where
2. group by 절의 조건절 having
*/

select * from emp;
/* 사원테이블에서 직종별 급여합을 출력하되 수당은 지급 받고 급여의 합이 5000 이상인 사원들의 목록을 출력하세요
--급여의 합이 낮은 순으로 출력하세요 */
select job , sum(sal + nvl(comm, 0)) as "급여합"
from emp
where comm is not null
group by job
having sum(sal) >= 5000 
order by "급여합" asc;

/* 사원테이블에서 부서 인원이 4명보다 많은 부서의 부서번호 ,인원수 , 급여의 합을 출력하세요 */
select deptno, count(*), sum(sal)
from emp
group by deptno
having count(*) > 4;

select count(ename)
from emp
group by deptno;
/* 사원테이블에서 직종별 급여의 합이 5000를 초과하는 직종과 급여의 합을 출력하세요
단 판매직종(salesman) 은 제외하고 급여합으로 내림차순 정렬하세요 */
select job, sum(sal)
from emp
where job != 'SALESMAN'
group by job
having sum(sal) > 5000
order by sum(sal) desc;

--------------------------------------------------------------------------------
--여기까지가 단일테이블에서 데이터를 가져오는 것 END
--6장 오라클 85page
--다중테이블에서 데이터 가져오기
--RDBMS(한개 이상의 테이블들이 서로 관계를 가지고 있는 구조)
--데이터를 가져오는 방법: 조인(join)
--관계
-- 1 : 1  [일] 대 [일]
-- 1 : N  [일] 대 [다]
-- M : N  [다] 대 [다]



--조인 실습 테이블 구성하기--
create table M (M1 char(6) , M2 char(10));
create table S (S1 char(6) , S2 char(10));
create table X (X1 char(6) , X2 char(10));

insert into M values('A','1');
insert into M values('B','1');
insert into M values('C','3');
insert into M values(null,'3');
commit;

insert into S values('A','X');
insert into S values('B','Y');
insert into S values(null,'Z');
commit;

insert into X values('A','DATA');
commit;

select * from m;
select * from s;
select * from x;

--종류
--1. 등가조인(equl join) 70%
--원테이블과 대응대는 테이블에 있는 컬럼의 데이터를 1:1 매핑


--문법
--1. SQL JOIN 문법(오라클 문법) >> 간단하게
--2. ANSI 문법(표준) 권장: 무조건 쓰라 이마리야 >> [inner(생략가능)] join on 조건절
select*
from m ,s
where m.m1 = s.s1;

select m.m1, m.m2, s.s2
from m ,s
where m.m1 = s.s1;

--ANSI
select *
from m inner join s
on m.m1 = s.s1;

select m.m1, m.m2, s.s2
from m join s --inner 일반적으로 생략
on m.m1 = s.s1;

select m.m1, m.m2, x.x2
from m join x
on m.m1 = x.x1;

--emp, dept
--사원번호, 사원의 이름 ,부서번호, 부서이름

select emp.empno, emp.ename, emp.deptno, dept.dname
from emp join dept
on emp.deptno = dept.deptno;

--현업: 테이블 명이 길어지면 
--join 테이블의 별칭을 붙여 줄여 쓴다

select e.empno, e.ename, e.deptno, d.dname
from emp e join dept d
on e.deptno = d.deptno;

--join
--테이블 1개 이상으로 join 할수 있다
--SQL join
select *
from m, s, x
where m.m1 = s.s1 and s.s1 = x.x1;

--ANSI JOIN
select m.m1 , m.m2, s.s2, x.x2
from m join s on m.m1 = s.s1
       join x on s.s1 = x.x1;

--a(a1), b(b1), c(c1), d(d1)
/*
from a join b on a.a1 = b.b1
       join c on c.c1 = b.b1
       join d on d.1 =c.c1
*/

--HR계정
select * from employees;
select * from departments;
select * from locations;

--1. 사번, 이름(last), 부서번호, 부서이름

select e.employee_id, e.last_name, e.department_id, d.department_name
from employees e join departments d on e.department_id = d.department_id;
--문제점
--사원수: 107명
--데이터 106건 (누군가 누락)
--select * from employees where employee_id =178;
--등가조인 (null 처리 불가) >> null 하지 않는다       

--1. 사번, 이름(last), 부서번호, 부서이름 ,지역코드, 도시명
select e.employee_id, 
        e.last_name, 
        e.department_id, 
        d.department_name,
        d.department_id,
        l.city
from employees e join departments d on e.department_id = d.department_id
                join locations l on l.location_id = d.location_id;


--------------------------------------------------------------------------------
--bituser 계정

select * from emp;

--2. 비등가 조인( non-equi join) => 1 : 1 로 비교할 컬럼이 없다
--의미만 존재 >> 등가join 문법 사용
--join: 컬럼과 컬럼이 1:1 매핑 emp.deptno = dept.deptno

select * from emp;
select * from salgrade;

--비등가 조인
select e.empno, e.ename, e.sal, s.grade
from emp e join salgrade s
on e.sal between s.losal and s.hisal
order by s.grade;

--3. outer join (equi join + null(나머지)
--outer join >> 1.equi join 선행하고 >> 2. 그 다음 의사결정(남은 데이터를 어떻게 가져오느냐)
--outer join: join되는 테이블의 주종 관계를 파악하는게 중요@@@!@$#@#
--주인이 되는 테이블의 남은 데이터를 가져 올 수 있다.
--문법
--1. left [outer](생략가능) join (왼쪽 테이블이 주인)
--2. right [outer] join (오른쪽 테이블이 주인)
--3. full [outer] join (left와 right join >> union)

select *
from m left join s
on m.m1 = s.s1;

select *
from m right join s
on m.m1 = s.s1;

select *
from m full outer join s
on m.m1 = s.s1;
--------------------------------------------------------------------------------
--HR 계정
--1. 사번, 이름(last), 부서번호, 부서이름 (106명이 아닌 107명)
--사원수: 107명

select e.employee_id, e.last_name, e.department_id, d.department_name
from employees e left join departments d on e.department_id = d.department_id;

select * from employees where department_id is null; --178 Kimberely

--bituser 계정
--4. self join (자기참조) --> 문법(x) 의미만 존재 >> 문법 (등가 조인)
--하나의 테이블이 컬럼이 자신의 테이블에 다른 컬럼을 참조하는 경우
--Emp 관리자

--join 기본 테이블 2개
--emp 테이블 1개
--가명칭

select e.empno, e.ename, m.empno, m.ename
from emp e join emp m
on e.mgr = m.empno;
--13명

select * from emp where ename = 'KING';

select e.empno, e.ename, m.empno, m.ename
from emp e left join emp m
on e.mgr = m.empno;

--------------------------------------------------------------------------------

-- 1. 사원들의 이름, 부서번호, 부서이름을 출력하라.
select e.ename, e.deptno, d.dname
from emp e join dept d on e.deptno = d.deptno;

select *
from emp e join dept d on e.deptno = d.deptno;

-- 2. DALLAS에서 근무하는 사원의 이름, 직위, 부서번호, 부서이름을
-- 출력하라.

select e.ename, e.job, d.deptno, d.dname
from emp e join dept d on e.deptno = d.deptno
where d.loc = 'DALLAS';

-- 3. 이름에 'A'가 들어가는 사원들의 이름과 부서이름을 출력하라.

select e.ename, d.dname
from emp e join dept d on e.deptno = d.deptno
where ename like '%A%';

select *
from emp
where ename like '%A%';

-- 4. 사원이름과 그 사원이 속한 부서의 부서명, 그리고 월급을
--출력하는데 월급이 3000이상인 사원을 출력하라.

select d.dname, e.sal
from emp e join dept d on e.deptno = d.deptno
where sal >= 3000;

select *
from emp
where sal >= 3000;

-- 5. 직위(직종)가 'SALESMAN'인 사원들의 직위와 그 사원이름, 그리고

-- 그 사원이 속한 부서 이름을 출력하라.

select e.ename, d.dname
from emp e join dept d on e.deptno = d.deptno
where e.job = 'SALESMAN';

-- 6. 커미션이 책정된 사원들의 사원번호, 이름, 연봉, 연봉+커미션,

-- 급여등급을 출력하되, 각각의 컬럼명을 '사원번호', '사원이름',

-- '연봉','실급여', '급여등급'으로 하여 출력하라.

--(비등가 ) 1 : 1 매핑 대는 컬럼이 없다

select e.empno as 사원번호, e.ename as 사원이름, sal *12 as 연봉, (sal*12 + comm) as 실급여, s.grade
from emp e join salgrade s on e.sal between s.losal and s.hisal
where comm is not null;


select *
from salgrade;





/*
select case  when sal <= 1000 then '4급'
             when sal between 1001 and 2000 then '3급'
             when sal between 2001 and 3000 then '2급'
             when sal between 3001 and 4000 then '1급'
             else  '특급'
end "급수"
*/








-- 7. 부서번호가 10번인 사원들의 부서번호, 부서이름, 사원이름,

-- 월급, 급여등급을 출력하라.

select e.deptno, d.dname, e.ename, e.sal, s.grade
from emp e  join dept d on e.deptno = d.deptno
            join salgrade s on e.sal between s.losal and hisal
where e.deptno = 10;

-- 8. 부서번호가 10번, 20번인 사원들의 부서번호, 부서이름,

-- 사원이름, 월급, 급여등급을 출력하라. 그리고 그 출력된

-- 결과물을 부서번호가 낮은 순으로, 월급이 높은 순으로

-- 정렬하라.

select e.deptno, d.dname, e.ename, e.sal, s.grade
from emp e  join dept d on e.deptno = d.deptno
            join salgrade s on e.sal between s.losal and s.hisal
where e.deptno in (10,20)
order by e.deptno, e.sal desc;

-- 9. 사원번호와 사원이름, 그리고 그 사원을 관리하는 관리자의

-- 사원번호와 사원이름을 출력하되 각각의 컬럼명을 '사원번호',

-- '사원이름', '관리자번호', '관리자이름'으로 하여 출력하라.

--SELF JOIN (자기 자신테이블의 컬럼을 참조 하는 경우)

select *
from emp;

select e.empno as 사원번호, e.ename as 사원이름, s.empno as 관리자번호, s.ename 관리자이름
from emp e left outer join emp s on e.mgr = s.empno;

SELECT E.EMPNO, E.ENAME , M.EMPNO, M.ENAME
FROM EMP E  left outer join EMP M
on e.MGR = m.EMPNO;
--------------------------------------------------------------------------------
--해결(초급개발자....해결------------------------------------

--Subquery
--오라클.pdf 7장(100page)
--sql 꽃 , 만능이라고 한다
--1. 함수 >> 다중 >> JOIN > 해결이 안되면 subquery

--사원테이블에서 사원들의 평균 월급보다 더 많은 급여를 받는 사원의 사번,이름 급여 출력

select empno, ename, sal
from emp
where sal > 2073;

--하나의 문제 해결 쿼리 2개 -> 1개로 가능

select empno, ename, sal
from emp
where sal > (select avg(sal) from emp);

--subquery
--1. single row subquery    :subquery의 실행결과가 단일 row 단일 colum (단일값)
--  기존 연산자 (= > < ..)

--2. multi  row subquery     :subqurey의 실행결과가 1개 이상의 row (여러개 값)
--in, not, any, all 연산자
--all: sal > 100 and sal > 4000 and .....
--any: sal > 1000 or sal < 4000 or ...
--why: 사용되는 연산자의 종류가 다르다

--subquery 문법
--1. 괄호안에 있어야 한다 >> (select max(sal) from emp)
--2. 단일 컬럼으로 구성 되어야 한다>> select emopno, sal from emp(서브쿼리(X))
--3. 단독으로 실행 가능해야 한다

--실행순서
--1. subquery
--2. subqurey 결과를 가지고 main qurey가 실행

--Tip)
--select (subqurey) -> 한개의 행만 반환할 경우 (scala subquery)
--from (subqurey)   -> Inline view (가상테이블) 중요~~~~~
--where (subqurey)  -> 조건

--사원테이블에서 jones의 급여보다 더 많은 급여를 사원으 사번, 이름, 급여 출력
select sal
from emp where ename = 'JONES';

select empno, ename, sal
from emp
where sal > (select sal from emp where ename = 'JONES');

select *
from emp
where sal in (select sal from emp where deptno = 30);
--ORA-01427: single-row subquery returns more than one row
--결과: multi row

select *
from emp
where sal in (select sal from emp where deptno = 30);
--sal = 1600 or sal = 1250 or sal = 2850...

select *
from emp
where sal not in (select sal from emp where deptno = 30);
-- sal != 1600 and sal != 1250 and sal != 2850...

--부하직원이 있는 사원의 사번과 이름을 출력하세요
--(내 사번이 mgr 컬럼에 있다)

select mgr
from emp
where mgr is not null;

select *
from emp
where empno in (select mgr from emp);

select *
from emp
where empno in (select mgr from emp where mgr is not null);

select *
from emp
where empno in (select mgr from emp);
--emp == 7902 or empno .... or empno = null ( or 연산에 null영향(X))
--부하직원이 없는 사원의 사번과 이름을 출력

select *
from emp
where empno not in (select mgr from emp);
--(and 연산에 null 영향(O)) >> 그결과는 null
--emp != 7902 and empno .... and empno != null

select empno, ename
from emp
where empno in (select nvl(mgr,0) from emp);

--king 에게 보고하는 즉 직속상관이 king인 사원의 사번, 이름, 직종, 관리자 사번(mgr) 을 출력하세요
select empno from emp where ename = 'KING';

select empno, ename, job , mgr
from emp
where mgr = (select empno from emp where ename = 'KING');

--20번 부서의 사원중에서 가장 많은 급여를 받는 사원보다 더많은 급여를 받는 사원의 사번, 이름, 급여 ,부서번호

select max(sal)
from emp
where deptno = 20;

select empno, ename, sal, deptno
from emp
where sal > (select max(sal) from emp where deptno = 20);

--자기 부서의 평균 월급보다 더 많은 월급을 받는 사원의 사본, 이름, 부서번호, 부서별 평균 월급을 출력

select job , avg(sal) as "avgsal"
from emp
group by job
having avg(sal) >= 3000;

select job , avg(sal) as "평균"
from emp
group by deptno
having sal > avg(sal);

select avg(sal)
from emp
group by deptno;

select e.empno, e.ename, e.deptno, e.sal, a."dd"
from emp e join (select avg(sal) as "dd" from emp group by deptno) a on e.sal > a."dd";

select e.empno, e.ename, e.deptno, e.sal, s.avgsal
from emp e join (select deptno, round(avg(sal),0) as avgsal from emp group by deptno) s on e.deptno = s.deptno
where e.sal > s.avgsal;

--------------------------------------------------------------------------------
--1. 'SMITH'보다 월급을 많이 받는 사원들의 이름과 월급을 출력하라.

select sal
from emp
where ename = 'SMITH';

select ename, sal
from emp
where sal > (select sal from emp where ename = 'SMITH');


--2. 10번 부서의 사원들과 같은 월급을 받는 사원들의 이름, 월급,

-- 부서번호를 출력하라.

select * from emp where deptno = 10;
select ename, sal, deptno
from emp
where sal in (select sal from emp where deptno = 10);


--3. 'BLAKE'와 같은 부서에 있는 사원들의 이름과 고용일을 뽑는데

-- 'BLAKE'는 빼고 출력하라.

select deptno from emp where ename = 'BLAKE';

select ename, hiredate
from emp
where deptno = (select deptno from emp where ename = 'BLAKE')
                and ename != 'BLAKE';


--4. 평균급여보다 많은 급여를 받는 사원들의 사원번호, 이름, 월급을

-- 출력하되, 월급이 높은 사람 순으로 출력하라.

select round(avg(sal),0) from emp;

select empno, ename, sal
from emp
where sal > (select round(avg(sal),0) from emp)
order by sal desc;

--5. 이름에 'T'를 포함하고 있는 사원들과 같은 부서에서 근무하고

-- 있는 사원의 사원번호와 이름을 출력하라.

select deptno from emp where ename like '%T%';

select empno, ename
from emp
where deptno in (select deptno from emp where ename like '%T%');

--6. 30번 부서에 있는 사원들 중에서 가장 많은 월급을 받는 사원보다

-- 많은 월급을 받는 사원들의 이름, 부서번호, 월급을 출력하라.

--(단, ALL(and) 또는 ANY(or) 연산자를 사용할 것)

select max(sal) from emp where deptno = 30;

select ename, deptno, sal
from emp
where sal > (select max(sal) from emp where deptno = 30);

--7. 'DALLAS'에서 근무하고 있는 사원과 같은 부서에서 일하는 사원의

-- 이름, 부서번호, 직업을 출력하라.

select deptno from dept where loc = 'DALLAS';

select ename, deptno, job
from emp
where deptno = (select deptno from dept where loc = 'DALLAS');


select e.ename, e.deptno, e.job
from emp e join dept d on e.deptno = d.deptno
where d.loc = 'DALLAS';



--8. SALES 부서에서 일하는 사원들의 부서번호, 이름, 직업을 출력하라.

select deptno from dept where dname = 'SALES';

select deptno , ename, job
from emp
where deptno in (select deptno from dept where dname = 'SALES');

--9. 'KING'에게 보고하는 모든 사원의 이름과 급여를 출력하라

--king 이 사수인 사람 (mgr 데이터가 king 사번)

select ename, sal 
from emp 
where mgr = (select empno from emp where ename = 'KING');

--10. 자신의 급여가 평균 급여보다 많고, 이름에 'S'가 들어가는

-- 사원과 동일한 부서에서 근무하는 모든 사원의 사원번호, 이름,

-- 급여를 출력하라.
-- sal > (select avg(sal) from emp) and 
select avg(sal) from emp;

select deptno from emp where ename like '%S%';

select empno, ename, sal
from emp
where sal > (select avg(sal) from emp) and  deptno in (select deptno from emp where ename like '%S%');

--11. 커미션을 받는 사원과 부서번호, 월급이 같은 사원의

-- 이름, 월급, 부서번호를 출력하라.

select deptno from emp where comm is not null;
select sal from emp where comm is not null;

select ename, sal, deptno from emp where deptno in (select deptno from emp where comm is not null) and sal in (select sal from emp where comm is not null);

?--12. 30번 부서 사원들과 월급과 커미션이 같지 않은

-- 사원들의 이름, 월급, 커미션을 출력하라.

select comm from emp where comm is not null and deptno = 30;

select sal from emp where deptno =30;

select ename, sal, comm
from emp
where sal not in (select sal from emp where deptno = 30) 
      and comm not in (select comm from emp where comm is not null and deptno = 30);


--------------------------------------------------------------------------------
--데이터 조작(DML)
--오라클.pdf 168page
--반드시 암기
--insert, update, delete

?/*
오라클 기준
DDL(데이터 정의어): [create, alter, drop, truncate] , rename, modify
DML(데이터 조작어): insert, update, delete
DQL(데이터 질의어): select
DCL(데이터 제어어): 관리자: grant, revoke
TCL(트랜잭션)     : commit, rollback, savepoint

DML 작업 (insert, update, delete)
--A라는 계좌에서 B라는 계좌로 이체 (100)
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--A 계좌(1000) 출금: update 계좌 set 금액
-->900
--B 계좌(1000) 입금: update 계좌 set 금액 +
-->1100
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--A계좌에서 출금 B계좌 입금 [하나의 논리적인 단위로 묶자]
--둘다 성공 둘다 실패
--트랜잭션: 하나의 논리적인 단위
--처리하는 방법: commit, rollback
?*/

--desc emp(기본정보)

--상세한 정보 (현재 접속 계정이 가지고 있는 테이블 목록)
select * from tab;
?
--create table 이름 .... 기존에 있으면 생성 불가 >> 확인용도
select * from tab where tname = 'BOARD2';-- 테이블 존재(X) 생성 불가

select * from tab where tname = 'BOARD'; --테이블 존재 생성 불가

select * from col where tname = 'EMP';

--------------------------------------------------------------------------------
--1. insert

create table temp(
    id number primary key ,--제약(null(X), 중복 데이터를 허용하지 않겠다)
    name nvarchar2(20)
);

--1. 가장 일반적인 INSERT
insert into temp(id, name)
values(100,'홍길동');

select * from temp;

commit; -- 실반영

--2. 컬럼 목록 생략 가능.... 개발에서 쓰지 말것
insert into temp
values(200,'김유신');

select * from temp;

rollback;

--3. 문제 (id 컬럼에 PK)
insert into temp(id, name)
values(100,'아무개');
--ORA-00001: unique constraint (BITUSER.SYS_C007013) violated

insert into temp(name)
values('아무개');
--ORA-01400: cannot insert NULL into ("BITUSER"."TEMP"."ID")
----------------------------------------------------------------------------0305
--Tip)
--일반적인 SQL프로그램적인 요소(X)
--PL-SQL (변수, 제어문)
--개발시에 샘플 데이터 넣고 TEST

create table temp2 (id varchar2(50));
/*
begin
    for i in 1..100 loop
        insert into temp2(id) values('A' || to_char(i));
    end loop;
end;
*/
--항상 주석 처리
select * from temp2;
--------------------------------------------------------------------------------

create table temp3(
    memberid number(3) not null, --정수 3자리 null 허용(x)
    name varchar2(10),           --입력을 안주면 null 허용(O)
    regdate date default sysdate --초기값을 지정(기본값) (insert 자동 시스템 날짜)
    
);

select sysdate from dual;
alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';

insert into temp3(memberid, name, regdate)
values(100,'홍길동','2021-03-04');

select * from temp3;
commit;

insert into temp3(memberid, name)
values(200,'김유신');

select * from temp3;
commit;

insert into temp3(memberid)
values(300);

select * from temp3;
commit;

insert into temp3(name)
values('누구');
--ORA-01400: cannot insert NULL into ("BITUSER"."TEMP3"."MEMBERID")
--------------------------------------------------------------------------------
--Tip)
--1. 대량 데이터 insert 하기
create table temp4(id number);
create table temp5(num number);

insert into temp4(id) values(1);
insert into temp4(id) values(2);
insert into temp4(id) values(3);
insert into temp4(id) values(4);
insert into temp4(id) values(5);
insert into temp4(id) values(6);
insert into temp4(id) values(7);
insert into temp4(id) values(8);
insert into temp4(id) values(9);
insert into temp4(id) values(10);

commit;

select * from temp4;

select * from temp5;

--요구사항
--temp4에 있는 모든 데이터를 temp5에 넣고 싶다
--insert into 테이블명 (컬럼리스트) values(values 리스트)
--insert into 테이블명 (컬럼리스트) select 절

insert into temp5(num)
select id from temp4;

select * from temp5;
commit;

--2. 대량 insert
--테이블이 없는 상황에서 >> [테이블 복제(구조: 스키마) + 데이터 삽입]
--단, 제약 정보는 복사가 안되요(PK..FK)
--순수한 데이터 구조 + 데이터 복사
--create table copyemp(id nuber ....)


create table copyemp
as
     select * from emp;

select * from copyemp;
commit;

create table copyemp2
as
    select empno, ename, sal
    from emp
    where deptno =30;

select * from copyemp2;
commit;

--질문
--틀(스키마) 구조만 복제하고 데이터는 복사하고 싶지 않다면

create table copyemp3
as
    select * from emp where 1=2; -- where 1=1 거짓조건

select * from copyemp3;
----------------------------[INSERT END]----------------------------------------
--[UPDATE]
/*
update table_name
set colum1 = vlaue1,[colum2 = value2..]
[where condition]

update table_naem
set column1 = [subquery]
where column2 = [subquery]
*/
select * from copyemp;

update copyemp
set sal = 0;

rollback;

update copyemp
set sal = 1111
where deptno = 20;

select * from copyemp where deptno = 20;

update copyemp
set sal = (select sum(sal) from emp);

select * from copyemp;
rollback;

--여러개의 컬럼 update

update copyemp
set ename = 'AAA', job = 'BBB', hiredate = sysdate, sal = (select sum(sal) from emp)
where empno = 7369;

select * from copyemp where empno = 7369;
rollback;
---------------------------------[UPDATE END]-----------------------------------
--[DELETE]
delete from copyemp;

select * from copyemp;
rollback;

select * from copyemp;

delete from copyemp where deptno = 10;

select * from copyemp where deptno = 10;
commit;
--------------------------[DELETE END]------------------------------------------
--개발자 (SQL) >> CRUD (Create(insert), Read(select), Update, Delete)
--APP(JAVA) -     JDBC API    - Oracle
--insert
--update
--delete
--select (70%)

--CRUD
--전체조회(함수), 조건 조회(함수), 삽입(함수), 수정(함수), 삭제(함수) => 개발자 => JAVA코드
--JAVA코드 
--전체 조회 public List<Emp> getEmpAllList() { select * from emp }
--조건 조회 public Emp getEmpListByEmpno(int empno) { select * from emp where empno = 7788}
--삽입     public int insertEmp(Emp enp) {insert into emp(..) values(....)}

--------------------------------------------------------------------------------
--DDL (create, alter, drop (rename): 테이블 만들고, 수정, 삭제
--오라클.pdf 9장 130page

select * from board;

drop table board;

select * from board;
--ORA-00942: table or view does not exist

create table board(
    boardid number,
    title nvarchar2(50),
    content nvarchar2(2000),
    regdate date default sysdate
);

desc board; --약식으로 정보 보기

--Tip (정보조회)
select * from user_tables where lower(table_name) = 'board';
select * from user_constraints where(table_name) = 'board'; --제약정보 보는것
----------

--Oracle 11g >> 가상 컬럼 (조합컬럼)
--학생 성적 테이블: 국어, 영어, 수학, 총점
--국어, 영어, 수학 데이터만 insert를 하면 자동으로 총점 데이터가 만들고 싶다

create table vtable(
    no1 number,
    no2 number,
    no3 number generated always as (no1 + no2) virtual
);

insert into vtable (no1, no2) values(100,100);

select * from vtable;

insert into vtable(no1, no2) values(90,90);

select * from vtable;

insert into vtable(no1,no2,no3) values(80,90,88);
--SQL 오류: ORA-54013: INSERT operation disallowed on virtual columns

select * from user_tab_columns where table_name = 'VTABLE';



--실무에서  활용하는 코드
--제품정보 (입고일) 분기별 데이터 (4분기)
--입고일 : 2019-03-01 >> 1분기

create table vtable2
(
  no number , --순번
  p_code char(4), --제품코드 (A001 , B002)
  p_date char(8), --입고일(20190303)
  p_qty number, --수량
  p_bungi number(1) GENERATED ALWAYS as (
                                         CASE WHEN substr(p_date,5,2) IN ('01','02','03') THEN 1
                                              WHEN substr(p_date,5,2) IN ('04','05','06') THEN 2
                                              WHEN substr(p_date,5,2) IN ('07','08','09') THEN 3
                                              ELSE 4
                                          END        
                                         ) VIRTUAL
  );

select COLUMN_NAME , DATA_TYPE , DATA_DEFAULT 
from user_tab_columns where table_name='VTABLE2';

insert into vtable2(p_date) values('20180101');
insert into vtable2(p_date) values('20180126');
insert into vtable2(p_date) values('20190301');
insert into vtable2(p_date) values('20191225');
insert into vtable2(p_date) values('20190525');
insert into vtable2(p_date) values('20201111');
select * from vtable2;
select * from vtable2 where p_bungi=4;

commit;
--------------------------------------------------------------------------------
--DDL 테이블 만들고 수정 삭제

--1. 테이블 생성하기
create table temp6(id number);

--2. 테이블 이미 생성 했는데 컬럼을 추가
--기존 테이블 추가

alter table temp6
add ename varchar2(20);

select * from temp6;

--3. 기존 테이블에 있는 컬럼의 이름 잘못 표시(ename -> username)
--기존 테이블에 있는 기존 컬럼의 이름 바꾸기(rename)
alter table temp6
rename column ename to username;

select * from temp6;

--4. 기존 테이블에 있는 기존 컬럼의 타입 정보 수정 (modify)
alter table temp6
modify(username varchar2(2000));

desc temp6;

--5. 기존 테이블에 있는 기존 컬럼 삭제
alter table temp6
drop column username;

select * from temp6;

--6. 테이블 전체가 필요 없어졌다
--6.1 delete: 데이터 삭제
--테이블 처음 만들면 처음 크기 >> 데이터 넣으면 >> 데이터 크기 만큼 테이블 크기 증가
--Ex) 처음 1M >> 데이터 10만건 >> 100M >> delet 10만건 삭제 >> 데이터 삭제 >> 집의 크기 그대로

--테이블 데이터 삭제 [공간의 크기도 줄일 수 없을까]
--truncate (단점 where 절 사용 못함)
--truncate table emp;

--7. 테이블 삭제
drop table temp6;

--------------------------------------------------------------------------------
--데이터 무결성 제약 조건 오라클.pdf 136.page
--데이터 무결성 확보
--insert, update (제약)
/*
제 약 조 건 설 명
PRIMARY KEY(PK)     : 유일하게 테이블의 각행을 식별(NOT NULL 과 UNIQUE 조건을 만족)
                    : where empno = 7799 >> 데이터 1건 보장 >> 성능 >> 조회 >> (내부적으로 index)
                    : 만화방 >> 100권 >> 단골 >> 책 대출 요청 >> 빠르게 찾아줌
                    : 만화 >> 1000권으로 늘림 >> 단골 >> 용비불패 >> 주인 안옴 >> 찾는데 오래걸림
                    : 주인 컨설팅 >> 컨설터 >>
                    : 빨리 찾는 순( 장르별 등등): 책의 위치 정보
                    : 문제) 반대로 새로운 책이 오거나 파손된 책을 버리는 행위에 불필요한 작업이 필요하다 (DML) 불합리하다
                    : 시집(page) >> index >> 출판사 >> 검색 >> 5page >> index(X)
                    : 테이블 당 1개 (여러개의 묶어서 1개): 복합키

FOREIGN KEY(FK)     : 열과 참조된 열 사이의 외래키 관계를 적용하고 설정합니다.
                    : 테이블과 테이블과의 관계를 정의 (참조제약)
                    
UNIQUE key(UK)      : 테이블의 모든 행을 유일하게 하는 값을 가진 열(NULL 을 허용)
                    : 유일값을 사용하지만 null은 허용 >> not null unigue 둘다 
                    : 컬럼의 개수 만큼 만들수 있다
                    
NOT NULL(NN)        : 열은 NULL 값을 포함할 수 없습니다. (필수 입력)

CHECK(CK)           : 참이어야 하는 조건을 지정함(대부분 업무 규칙을 설정)
                    : 설정 범위 내의 값만 입력받겠다 ( gender: 컬럼에 남 또는 여 데이터만 입력)
                    : where gender in ('남', '여')
                    : gender in ('남','여') 제약으로
*/

--제약을 만드는 시점( create table ... 안에서 생성)
--테이블 생성 이후에 추가 (alter table ... add constraint ...) 많이 사용 @@ >> 모델링 툴

--Tip)
--제약 정보 확인
select * from user_constraints where table_name = 'EMP';

create table temp7(
    --id number primary key --안된다(권장하지 않는다) --제약의 이름이 자동 생성( 삭제 수정) 어렵다
    id number constraint pk_temp7_id primary key, --관용적 표현 이름설정: pk_temp7_id
    name varchar2(20) not null,
    addr varchar2(50)
);

select * from user_constraints where table_name = 'TEMP7';
--DBEAVER
--select * from ALL_CONSTRAINTS where table_name = 'TEMP7';

insert into temp7(name, addr) values('홍길동','서울시 강남구');
--ORA-01400: cannot insert NULL into ("BITUSER"."TEMP7"."ID")

insert into temp7(id, name, addr) values(10,'홍길동','서울시 강남구');

select * from temp7;
commit;

insert into temp7(id, name, addr) values(10,'아무개','서울시 개포동');
--ORA-00001: unique constraint (BITUSER.PK_TEMP7_ID) violated

--1. primary key 테이블에 몇개까지 걸 수 있을까 > 1개
--여러개 묶어서 1개
--create table member (ename, age) >> ename, age 묶어서 하나의 복합키
--where ename = and age = and num = (한건의 데이터 보장)

create table temp8(
    id number constraint pk_temp8_id primary key,
    name nvarchar2(30) not null,
    jumin nchar(6) constraint uk_temp8_jumin unique,
    addr nvarchar2(1000)
);

select * from user_constraints where table_name = 'TEMP8';

insert into temp8(id,name,jumin,addr)
values(10,'홍길동','123456','경기도');
commit;

insert into temp8(id,name,jumin,addr)
values(20,'김유신','123456','서울');
--ORA-00001: unique constraint (BITUSER.UK_TEMP8_JUMIN) violated

insert into temp8(id,name, addr)
values(20,'김유신','서울');

select * from temp8; --unique 제약 null 허용
--jumin nchar(6) not null constraint uk_temp8_jumin unique, --null(X)

insert into temp8(id,name, addr)
values(30,'아무개','강원도');
--null 중복 체크를 하지 않는다

select * from temp8;
commit;
--------------------------------------------------------------------------------
--테이블 생성 후 제약 걸기
create table temp9 (id number);

--기존 테이블에 제약 추가하기
--조건 (제약이 추가될때 테이블에 데이터 검사) >> 중복 데이터 > 중복데이터 삭제 >> 제약 추가

alter table temp9
add constraint pk_temp9_id primary key(id);
--add constraint pk_temp9_id primary key(id ,num); --복합 프라이머리 키

select * from user_constraints where table_name = 'TEMP9';


alter table temp9
add ename varchar2(50);

--not null 추가
alter table temp9
modify(ename not null);

select * from user_constraints where table_name = 'TEMP9';
--------------------------------[unique 제약 끝]---------------------------------
--[check 제약]
--where 조건과 동일한 형태의 제약 >> where gender in ('남', '여')
--POINT
create table temp10(
    id number constraint pk_temp10_id primary key,
    name varchar2(20) not null,
    jumin char(6) constraint uk_temp10_jumin unique,
    addr varchar2(20),
    age number constraint ck_temp10_age check(age >= 19)
    --where (age >= 19) => 요부분을 check() 괄호 안에 써준다
);

select * from user_constraints where table_name = 'TEMP10';

insert into temp10(id, name, jumin, addr, age)
values(100,'홍길동','123456','서울시',25);

select * from Temp10;
commit;

insert into temp10(id, name, jumin, addr, age)
values(200,'김유신','123456','서울시',18);--19살 이하라 걸림
--ORA-02290: check constraint (BITUSER.CK_TEMP10_AGE) violated
--------------------------------[check 제약]-------------------------------------
--참조 제약
--exrd -> db모델링 프로그램

--사원테이블에 부서번호는 부서테이블의 부서번호를 참조한다
--> forign key
--부서테이블의 부서번호는 사원테이블의 부서번호를 참조 당한다
--> primary key(forign key) 보다 선행되어야 한다
--참조제약: 테이블과 테이블과의 제약

create table c_emp
as
    select empno, ename, deptno from emp where 1=2;

select * from c_emp;

create table c_detp
as
    select deptno, dname from dept where 1= 2;

select * from c_detp;

--참조(A테이블에 있는 어떠한 컬럼의 데이터는 B테이블에 컬럼의 데이터만 받겠다)
--c_emp 테이블에 있는 deptno 컬럼의 데이터는 c_detp 테이블에 있는 deptno 컬럼의 데이터만 쓰겠다
--참조하겠다(fk)

--alter table c_emp
--add constraint fk_c_emp_deptno foreign key(deptno) references c_detp(deptno);
--ORA-02270: no matching unique or primary key for this column-list
--실행하기전에 

alter table c_detp
add constraint pk_c_detp_deptno primary key(deptno);
-->신용 확보

alter table c_emp
add constraint fk_c_emp_deptno foreign key(deptno) references c_detp(deptno);

--제약
insert into c_detp(deptno, dname) values(100,'인사팀');
insert into c_detp(deptno, dname) values(200,'관리팀');
insert into c_detp(deptno, dname) values(300,'회계팀');

commit;
select * from c_detp;

--신입사원 입사
insert into c_emp(empno,ename) values(100,'홍길동'); --deptno 입력 
--deptno fk 있어도 not null 하지 않으면 null 값 허용

select * from c_emp;
--설계: 신입사원은 부서를 가지지 않을 수 있다

--설계: 신입사원은 반드시 부서를 가져야 한다
--create table c_emp(deptno not null .... constraint .. )

insert into c_emp(empno,ename, deptno) values(200,'홍길동', 50);
--ORA-02291: integrity constraint (BITUSER.FK_C_EMP_DEPTNO) violated - parent key not found
--참조 당하는 테이블의 데이터만 쓸수 있다

insert into c_emp(empno,ename, deptno) values(200,'홍길동', 100);

select * from c_emp;
commit;
-------------------------[제약 끝]-----------------------------------------------
--개발자 입장
--테이블(부모, 자식)
--c_emp, c_detp [deptno] 컬럼을 기준으로....
--부모 (master): deptno에 관계 PK를 가진 테이블이 부모
--자식 (detail): deptno에 관계 FK를 가진 테이블이 자식

--c_detp에서 100 데이터 삭제 가능하지 않다

delete from c_detp where deptno = 100; --100데이터 자식테이블 사용..
--ORA-02292: integrity constraint (BITUSER.FK_C_EMP_DEPTNO) violated - child record found
--지우고 싶으면
--먼저 자식 100 삭제 >> 부모 100 삭제

delete from c_detp where deptno = 200;--자식테이블 데이터를 쓰고 있지 않아서

commit;

/*
(column datatype [CONSTRAINT constraint_name]       
REFERENCES table_ name (column1[,column2,..] [ON DELETE CASCADE]) 

column datatype, . . . . . . . , 
[CONSTRAINT constraint_name] FOREIGN KEY (column1[,column2,..])        
REFERENCES table_name  (column1[,column2,..] [ON DELETE CASCADE]) 
*/
-- [ON DELETE CASCADE]  부모테이블과 생명을 같이 하겠다
-- 300 삭제 할 있나요?  네 
-- delete from c_dept where detpno=300;
-- 참조하는 자식 데이터 같이 삭제
-- delete from c_emp where deptno=300; 같이 실행

alter table c_emp
add constraint fk_emp_deptno foreign key(deptno) references c_dept(deptno) ON DELETE CASCADE;

--MS-SQL
--on delete cascade:
--on update cascade;
--------------------------------------------------------------------------------
--영문테이블, 영문 컬럼

--학생 성적 테이블
--학번의 데이터는 중복되거나 NULL 값을 허용하면 안된다
--이름 NULL 값을 허용하지 않는다
--국어
--영어
--수학 점수 컬럼은 숫자 타입이고 NULL 값을 허용
--값을 입력하지 않으면 default로 0값을 갖는다
--총점 ,평균 컬럼은 가상컬럼으로(조합컬럼) 생성한다
--학과코드는 학과 테이블에 학과코드를 참조한다
--학번 , 이름 , 국어 , 영어 , 수학 , 총점 , 평균 , 학과코드

--테이블 grade 학번: dno 이름 dname 국어 kor 영어 eng 수학 math 총점 sum 평균 avg 학과 코드 depno

--no3 number generated always as (no1 + no2) virtual
--constraint fk_c_emp_deptno foreign key(deptno) references c_detp(deptno);
--constraint uk_temp10_jumin unique,

--alter table c_emp
--add constraint fk_c_emp_deptno foreign key(deptno) references c_detp(deptno);

--학과 테이블
--학과코드 데이터는 중복되거나 NULL 값을 허용하면 안된다,
--학과명 은 null값을 허락하지 않는다
--학과코드 , 학과명


--샘플 데이터 insert ..
--그리고 select 결과는
--학번 , 이름 총점, 평균 , 학과코드 , 학과명 을 출력하세요
--학과테이블 dep 학과명 dname  학과코드 depno 

-- id number constraint pk_temp7_id primary key

create table grade(
    dno number(6) not null constraint uk_grade_dno unique,
    dname nvarchar2(9) not null,
    kor number(3) default 0,
    eng number(3) default 0,
    math number(3) default 0,
    sumg number generated always as (kor + eng + math) virtual,
    avgg number generated always as (round(((kor + eng + math)/3),0)) virtual,
    depno number
    
);

alter table grade
add constraint pk_grade_dno primary key (dno);

insert into grade (dno, dname, kor, eng, math, depno) values ( 123, '안승주', 100, 100, 100, 40);
insert into grade (dno, dname, kor, eng, math, depno) values ( 124, '이동근', 100, 100, 99, 20);
insert into grade (dno, dname, depno) values ( 125, '이보희', 40);
insert into grade (dno, dname, kor, eng, math, depno) values ( 126, '한석희', 88 , 99, 98, 30);
insert into grade (dno, dname, kor, eng, math, depno) values ( 127, '김진아', 55, 65, 77, 10);
insert into grade (dno, dname, kor, eng, math, depno) values ( 128, '김대업', 66, 55, 100, 40);
insert into grade (dno, dname, kor, eng, math, depno) values ( 129, '서태희', 10, 10, 10, 50);
insert into grade (dno, dname, kor, eng, math, depno) values ( 130, '문형철', 100, 100, 100, 40);
commit;

drop table grade;

alter table grade
add constraint fk_grade_depno foreign key(depno) references dep(depno);

select * from grade;

create table dep(
    depno number constraint pk_dep_depno primary key,
    dname nvarchar2(10) not null
);
insert into dep (depno,dname) values(10,'수학과');
insert into dep (depno,dname) values(20,'의과');
insert into dep (depno,dname) values(30,'국어과');
insert into dep (depno,dname) values(40,'건축과');
insert into dep (depno,dname) values(50,'경영과');
insert into dep (depno,dname) values(10,'수학과');--오류
select * from dep;
select * from grade;

--학번 , 이름 총점, 평균 , 학과코드 , 학과명 을 출력하세요


select g.dno, g.dname, g.sumg, g.avgg, g.depno, d.dname
from grade g join dep d on g.depno = d.depno;

--------------------------------------------------------------------------------
select * from emp;
select * from dept;
select * from salgrade;

--날짜 바꾸기 
--오라클 192page 12장 view

--View 객체 .. (가상 테이블)
--view 객체(create ...)
--create view 뷰이름 as [select 구문}
--view는 테이블처럼 사용가능한 [가상테이블]: 실제로 데이터를 가지고 있지 않다
--view 메모리상에만 존재하는 가상테이블
--(subquery -> in line view -> from (select dept avg(sal) from ...)

--view 가상 테이블
--사용법: 일반테이블과 사용법이 동일(select , where ....)
--단, view 볼 수 있는 데이터 한해서
--DML(insert, update, delete) -> view를 통해서 원본테이블에 대한 -> DML 가능

--bituser 권한 문제 (SYSTEM 계정을 통해서)
--SYSTEM >> GRANT CREATE ANY VIEW TO "BITUSER" WHITH ADMIN OPTION; 실행

create view v_001
as
    select empno, ename from emp;
--ORA-01031: insufficient privileges -> 권한이 없다 -> 권한을 부여해야한다 ANY VIEW

select * from v_001;--view 가지고 있는SQL 문장이 실행

--VIEW 사용목적
--1. 개발자 편리성: JOIN, SUBQUERY >> VIEW 사용 >> 성는 문제 떨어짐 >> 개발자가 편하게
--2. 쿼리의 단순화 (편리성): 복잡한 쿼리를 미리 만들어 두고 사용
--3. 관리자 보안성 >> 특정 컬러만 노출

--관리자 >> 신입사원 >> emp 업무

create view v_emp
as 
    select empno, ename, job, hiredate from emp;

--신입사원: view 볼수 있는 권한: v_emp을 사용하시오
--view 통해서.....
select * from v_emp;
select * from v_emp where job = 'CLERK';
select empno from v_emp;

--편리성
create view v_002
as
    select e.ename, e.empno, e.deptno, d.dname
    from emp e join dept d
    on e.deptno = d.deptno;

select * from v_002;

select * from v_002 where deptno = 20;

--view 가상테이블(자존심) 나도 테이블인디 (컬럼명이 존재)

create view v_003
as                                 --컬럼명 별칭 띄어쓰기 아니면 "" 안붙이는게 편하다 
    select deptno, avg(sal) as avgsal --ORA-00998: must name this expression with a column alias
    from emp
    group by deptno;

select deptno, avgsal from v_003;

/*

CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW view_name [(alias[,alias,...])]
AS Subquery 
[WITH CHECK OPTION [CONSTRAINT constraint ]]
[WITH READ ONLY]

OR REPLACE                  이미 존재한다면 다시 생성한다.
FORCE Base Table            유무에 관계없이 VIEW 을 만든다.
NOFORCE                     기본 테이블이 존재할 경우에만 VIEW 를 생성한다.
view_name VIEW 의 이름
Alias Subquery 를 통해       선택된 값에 대한 Column 명이 된다.
Subquery SELECT             문장을 기술한다.
WITH CHECK OPTION VIEW      에 의해 액세스 될 수 있는 행만이 입력,갱신될 수 있다. 
Constraint CHECK OPTON      제약 조건에 대해 지정된 이름이다.
WITH READ ONLY 이 VIEW 에서 DML 이 수행될 수 없게 한다.

*/

create or replace view v_004 --없으면 새로 만들고 있으면 overwiriting
as
    select avg(sal) as avgsal from emp;

select * from v_004;

create or replace view v_004
as
    select round(avg(sal),0) as avgsal from emp;

select * from v_004;

--view 가상 테이블 DML 작업 가능(insert update delete)
--단 view 통해서 볼수 있는 데이터만 DML ... 그리고 단일 테이블만 가능
--단순 view(테이블 1개) >> (DML) 가능은 한데 >> 하지말자
--복합 view(테이블 1개 이상) >> join, subquery >> DML 불가능

select * from v_emp;

update v_emp set sal = 0; --v_emp sal 컬럼의 데이터를 볼수 없다

update v_emp set job = 'IT'; --view 가지는 원본테이블의 데이터 변경

select * from emp;
rollback;

--30번 부서 사원들의 직위, 이름, 월급을 담는 view를 만드는데,
--각각의 컬럼명을 직위, 사원이름, 월급으로 ALIAS를 주고 월급이
--300보다 많은 사원들만 추줄하도록 하라.

create view vQ1
as
    select job as "직위", ename as "사원이름", sal as "월급"
    from emp
    where sal > 300 and deptno = 30;



select *
from vQ1;

select * from vq1;


--부서별 평균월급을 담는 view를 만들되, 평균월급이 2000이상인
--부서만 추력하도록 하라
--from 조건 => where
--group by 조건 => having

create view vq2
as
    select round(avg(sal),0) as "평균월급", deptno
    from emp
    group by deptno
    having avg(sal) >= 2000;

--퀴즈
select v.deptno, v.평균월급, d.dname
from vq2 v join dept d on v.deptno = d.deptno;
--------------------------------------------------------------------------------
--개발자 관점에서 SQL
--오라클.pdf 11장 SEQUENCE 185page
--수번 추출하기 (채번하기)
--자동으로 번호를 생성하는 객체

/*
CREATE SEQUENCE sequence_name
[INCREMENT BY n]
[START WITH n]
[{MAXVALUE n | NOMAXVALUE}]
[{MINVALUE n | NOMINVALUE}]
[{CYCLE | NOCYCLE}]
[{CACHE | NOCACHE}];
sequence_name SEQUENCE 의 이름입니다.
INCREMENT BY n 정수 값인 n 으로 SEQUENCE 번호 사이의 간격을 지정.
이 절이 생략되면 SEQUENCE 는 1 씩 증가.
START WITH n    생성하기 위해 첫번째 SEQUENCE 를 지정.
                이 절이 생략되면 SEQUENCE 는 1 로 시작.
MAXVALUE n SEQUENCE 를 생성할 수 있는 최대 값을 지정.
NOMAXVALUE      오름차순용 10^27 최대값과 내림차순용-1 의 최소값을 지정.
MINVALUE n      최소 SEQUENCE 값을 지정.
NOMINVALUE      오름차순용 1 과 내림차순용-(10^26)의 최소값을 지정.
CYCLE | NOCYCLE 최대 또는 최소값에 도달한 후에 계속 값을 생성할 지의 여부를
                지정. NOCYCLE 이 디폴트.
CACHE | NOCACHE 얼마나 많은 값이 메모리에 오라클 서버가 미리 할당하고 유지
하는가를 지정. 디폴트로 오라클 서버는 20 을 CACHE.
*/

--why: web site: 게시판 >> key (식별값) >> 순번 (1,2,3 ....)

drop table board;

create table board(
    boardid number constraint pk_borad_boardid primary key,
    title nvarchar2(50)
);



select * from board;
--boardid(pk: not null , unique, 내부적으로 index 자동 생성)
--게시판에 글을 쓰면
--insert into board (boardid, title) values();
--boardid 컬럼의 데이터는 처음 글을 쓰면 1 이라는 값이 insert 그 다음 글부터는
--2, 3, 4 순차적인 데이터가 insert 되는 규칙을 만드시오

select count(boardid) + 1 from board;

insert into board(boardid, title) values((select count(boardid) + 1 from board)  ,'처음 글');
insert into board(boardid, title) values((select nvl(max(boardid),0) + 1 from board) ,'처음 글');--1

select *
from board;

commit;

--문제점: CRUD 관점 (insert, update, delete)

delete from board where boardid = 1;
commit;

insert into board(boardid, title) values ((select count(boardid) + 1 from board), 't새번쨰글');
--ORA-00001: unique constraint (BITUSER.PK_BORAD_BOARDID) violated
--DML 문제발생

--다른 방법
insert into board(boardid, title) values ((select count(boardid) + 1 from board), 't새번쨰글');

delete from board;

insert into board(boardid, title) values ((select nvl((max(boardid),0) + 1 from board), '1번쨰글');
insert into board(boardid, title) values ((select nvl(max(boardid),0) + 1 from board), '2번쨰글');
insert into board(boardid, title) values ((select nvl(max(boardid),0) + 1 from board), '3번쨰글');

insert into board(boardid, title) values((select nvl((max(boardid),0) + 1 from board), '1');

insert into board(boardid, title) values((select nvl(max(boardid),0) + 1 from board) ,'처음 글');
--> max()를 이용하여 null값을 0으로 대체하고 연산해라 >> 이유: null값의 연산 결과는 항상 null이다
select * from board;

commit;

--------------------------------------------------------------------------------
--sequence 번호를 추출: 중복값이 없고 순차적인 값( 공유 객체)
--------------------------------------------------------------------------------
--sequence 번호를 추출: 중복값이 없고 순차적인 값( 공유 객체)
create sequence board_num;

select * from USER_SEQUENCES;

--오라클 187page 
/*
NEXTVAL 과 CURRVAL 의사열 
가) 특징 
1) NEXTVAL 는 다음 사용 가능한 SEQUENCE 값을 반환 한다.－188－
2) SEQUENCE 가 참조될 때 마다, 다른 사용자에게 조차도 유일한 값을 반환한다.
3) CURRVAL 은 현재 SEQUENCE 값을 얻는다.
4) CURRVAL 이 참조되기 전에 NEXTVAL 이 사용되어야 한다.
*/

--번호 추출
select board_num.NEXTVAL from dual;
select board_num.NEXTVAL from dual;
select board_num.NEXTVAL from dual;

--현재까지 채번한 번호 확인(마지막 번호 질문)
select board_num.CURRVAL from dual;

--------------------------------------------------------------------------------
--게시판
--게시판사용되는 채번기
create table kboard(
    num number constraint pk_kboard_num primary key,
    title nvarchar2(20)
);

create sequence kboard_num;

insert into kboard values(kboard_num.NEXTVAL , 'frist');
insert into kboard values(kboard_num.NEXTVAL , 'second');
insert into kboard values(kboard_num.NEXTVAL , 'third');

select * from kboard;
commit;

delete from kboard where num = 1;
select * from kboard;

commit;

select kboard_num.currval from dual;

insert into kboard values(kboard_num.nextval, 'fourth');

select * from kboard;
commit;

delete from kboard where num = 4;
commit;

insert into kboard values(kboard_num.nextval, 'fiveth');
select * from kboard;
commit;

--------------------------------------------------------------------------------
--1. sequence 객체는 테이블에 종속되지 않는다 (하나의 시퀀스를 여러개의 테이블에서 사용가능)
--sequence 생성 >> A 테이블, B 테이블에서 가능

--웹 사이트(게시판 10개)
--상품게시판, 관리자 게시판, 회원 게시판 ...
--요구사항
--sequence 10개 만들어서 각각 만들어 사용 가능
--sequence 1개 만들어서 게시판에서 사용 가능

--Tip)
--MS-SQL: create table board(boardnum int indentity(1,1), title varchar(20));
--insert into board(title) values('hi') >> boardnum 자동 1.....2....3...
--테이블의 종속.....
--MS-SQL: 2012 버전 (sequence)

--mysql: create table board(boardnum int auto_increment, titlbe varchar(20));
--insert into board(title) values('hi') >> boardnum 자동 1.....2....3...

--mysql 만든 사람들이 뭉쳐서 open source 개념 >> mariadb(같은 엔진)
--https://mariadb.com/kb/en/create-sequence/

--------------------------------------------------------------------------------
--옵션
create sequence seq_num
start with 10       --시작 10
increment by 2;     --증가치 2

select seq_num.nextval from dual;

--게시판 글 100개
/*
num,        title,          content
1
2
3
.
.
.
100
*/
--일반적으로 게시판 최신글(가장 나중에 쓴 글이) 화면에 가장 상단

select * from kboard order by num desc; --일반게시판 첫 쿼리
--------------------------------------------------------------------------------
--개발자
--rownum 의사컬럼: 실제 물리적으로 존재하는 컬럼이 아니고 논리적인 존재
--rownum: 실제로 테이블에 컬럼에 존재하지 않지만 내부적으로 행 번호를 부여할 수 있는 컬럼

select * from emp;
select rownum as 순번, empno , ename from emp;
--select 한 결과에 순번을 부여

--Top -n (정렬된 기준으로 위에서 몇개 추출)
--테이블에서 조건에 맞는 상위(TOP) 레코드 (row) n개 추출
--TIP
--MS-SQL (top 키워드)
--select top 10, * from emp order by sal desc;

--Oracle top n(X)
--rownum : 순번을 부여 특정 조건을 사용해서 top 쿼리 실행

--1. 정렬의 기준을 정의(선행)
--2. 정렬된 데이터를 기준으로 rownum을 설정하고 조건을 걸어서 데이터를 추출

--1단계 
select *
from(
        select * 
        from emp
        order by sal desc
    ) e;

--2단계

select rownum as num, e.*
from(
        select * 
        from emp
        order by sal desc
    ) e;

--3단계 (급여를 많이 받는 사원 5명) top n

select *
from(
        select rownum as num, e.*
        from(
                select * 
                from emp
                order by sal desc
            ) e
    ) n where num <= 5;
--------------------------------------------------------------------------------
--top n (게시판 페이징 처리)
--1000 건
--웹 화면 100건 데이터 한번에 출력하지 않는다
--10건씩 한 화면에 

--pagesize = 10 (한 화면에 (페이지) 보여줄 수 있는 row건수)
--page 개수 >> 10개

--1page, 2page ... 10page   ( 1page 클릭 select 1 ~ 10 java 전달)
--                          ( 1page 클릭 select 11 ~ 20 java 전달)

--<a href = 'pagejsp?'>10</a> 10page(91 ~ 100)
--------------------------------------------------------------------------------
--HR계정 이동
--사번이 낮은 순으로 정렬(기준)
select * from employees; --107건

--1단계 (기준 데이터 만들기)
select * from employees order by employee_id asc;

--2단계 (기준데이터에 순번 부여하기)
select rownum as num, e.*
from(
        select * from employees order by employee_id asc
    ) e 
where rownum <= 50; --내부적으로 생성된 rownum을 사용

--3단계
select *
from (
        select rownum as num, e.*
        from(
                select * from employees order by employee_id asc
            ) e 
        where rownum <= 50
    ) n where num >= 41;

--107건
--pagesize = 10
--[1][2][3][4][5][6][7][8][9][10][11]
--[1] >> 1 ~ 10
--[2] >> 11 ~ 20
--....
--[5] >> 41 ~ 50 데이터를 보여주는 쿼리

select *
from (
        select rownum as num, e.*
        from(
                select * from employees order by employee_id asc
            ) e 
        where rownum <= 10
    ) n where num >= 1;

-- between A and B >> where rownum 1 and 10
-- servlet & jsp 수업 다시
        select rownum as num, e.*
        from(
                select * from employees order by employee_id asc
            ) e 
        where rownum <= 10 and rownum >=1;

select rownum as num, e.*
from(
        select * from employees order by salary desc
    )e where rownum between 1 and 10;

--사원 중 수당을 받는 사람들중 가장 월급을 많이 받는 사람을 정렬하고 번호을 부여하고 등급을 매겨 이름 사번 월급 부서번호 부서이름을 출력해라
select rownum as 번호, a.*
from(
        select e.empno, e.sal, s.grade, e.deptno, d.dname
        from emp e  join salgrade s on e.sal between s.losal and s.hisal
                    join dept d on e.deptno = d.deptno
        where comm is not null
        order by sal desc
    ) a where rownum between 1 and 6;
    
--------------------------------------------------------------------------------
--SQL END-----------------------------------------------------------------------

