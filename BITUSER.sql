/*
[1���� ����]
1. ����Ŭ ����Ʈ���� �ٿ�ε�
https://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html

2. Oracle Database 11g Release 2 Express Edition for Windows 64 (���ἳġ)

3. Oracle ��ġ(SYS, SYSTEM ������ ���� ��ȣ : 1004)

4.Sqlplus ���α׷� ����(CMD) : GUI ȯ�� �Ϲݰ����� ��� ����

5.������ Tool ��ġ ����(SqlDeveloper , https://dbeaver.io/)  ,
                 ����(��� , ������ , SqlGate) ������Ʈ�� ��ġ Ȱ�� ^^

6. SqlDeveloper ���� ���ؼ� Oracle Server ���� ....
   >> HR ���� : ��ȣ 1004 , Unlock 2���� ��밡�� .... (������� �ǽ� ���̺�)
   >> ���ο� ���� : BITUSER

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


7. ���� ���� ���� Ȯ�� : show user;   >> USER��(��) "BITUSER"�Դϴ�.


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
�ǽ��ڵ�

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
--1. ��� ���̺��� ��� �����͸� ����ϼ���
--[������]�� [��ҹ���] ����(x)
select * from emp;
SELECT * FROM EMP;

--2. Ư�� �÷� ������ ����ϱ�
select empno, ename , sal 
from emp;

select ename from emp;

--3. �÷��� ����Ī(alias)��Ī �ο��ϱ�
select empno ��� , ename �̸�
from emp;

--select empno ��    �� , ename ��    ��
--from emp;

--SQL ǥ�� (�����͸� �ٷ�� �� ���� ����Ʈ����) >> ǥ�� >> ANSI ����
-- as "��    ��"  
--Mysql  , MS-SQL �Ʒ� ���� ����
select empno as "��    ��" , ename as "��    ��"
from emp;

--Oracle ������ : [���ڿ� ������]�� �����ϰ� [��ҹ���]�� �����մϴ�
--JAVA : ���� 'A' , ���ڿ� "AAA"
--Oracle : ���ڿ� 'A'  , 'AAA'
--Oracle : A , a  >> �ٸ� ����
select empno , ename 
from emp
where ename='king'; --������

select empno , ename 
from emp
where ename='KING';
/*
select ��    3 
from ��      1
where ��     2
*/

--Oracle query(���Ǿ�) : ���
--������ (���տ����� || , ��������� + )
--java : + ����(�������)
--java : + ���ڿ�(����)
--Tip) Ms-Sql   + (���� ���)

select '����� �̸���' || ename || ' �Դϴ�' as "�������"
from emp;

--���̺��� �÷� >> Ÿ��
--java  class Emp {private int empno , private String ename}
--Oracle  create table emp (empno number)
--Ÿ��(�÷�) : ���� , ���ڿ� , ��¥ 
--create table emp (ename varchar2(10));
--10 > 10byte >> �ѱ�1�� 2byte , ������:Ư������:���� 1byte
--�ѱ�5��  , ���� 10��

desc emp;

-- ����ȯ  ���������� �ڵ� ����ȯ (���� --> ���ڿ�) ����
select empno || ename 
from emp;

select empno + ename  --���� + ���ڿ� ORA-01722: invalid number ������� �Ұ�
from emp;

--���߽�
--����� 
--�츮 ȸ�翡 ������ ��� �ֳ� ...
select job from emp;
--�ߺ� ������ ���� : Ű���� : distinct
select distinct job
from emp;

--distinct ���� : grouping
--��̷� ....
select distinct job , deptno
from emp
order by job;   --job group  �׾ȿ��� �ٽ� deptno group 1�Ǿ�(�ߺ����� �ʴ� ������)

select * from emp order by job;

select distinct deptno , job
from emp
order by deptno; 

--Oracle sql ���(������)
--java ���� ����( + , - , * , /) ������ %
--Oracle ����  [ % �����ڷ� �Ƚ�� ] >> �Լ�  Mod() 

--������̺��� ����� �޿��� 100 �޷� �λ��� ����� ����ϼ���

select empno, ename, sal, sal + 100 as "�λ�޿�"
from emp;

--dual �ӽ� ���̺� (����)
--syso
select 100 + 100 from dual; --������ �׽�Ʈ
select 100 || 100 from dual; --100100
select '100' + 100 from dual; --200  >> '100' ������ ���� (�� ��ȯ ���� ����)
select 'A100' + 100 from dual; --Error

--�� ������
--  <   >   <=
--����
--java ���� (==)  �Ҵ�(=)    javascript(== , ===) ����
--Oracle ����(=)  �����ʴ�(!=)

--�� ������
--AND ,OR ,NOT

--������(where ���ϴ� row )
select empno , ename, sal 
from emp;


select empno , ename, sal 
from emp
where sal >= 2000;

--����� 7788���� ����� ��� , �̸� , ���� , �Ի����� ����ϼ���
select empno, ename, job, hiredate    --3
from emp                              --1
where empno=7788;                     --2

--������  : select (70%) , insert , update , delete  (CRUD)
--������  : ����ϰ� ���� , ���(��Ʈ��ũ , ����) ���� , ���� (����ڱ���.. ��ȣȭ)
--Ʃ��(����Ʃ�� , �ϵ����) : ����Ʃ�� (�ӵ�) : �ð� �ܰ� 
--����(�𵨷�) : ���� (�䱸���� ���� , �м�) : DB-modeling : domain (����)

--����� �̸��� king  �� ����� ��� , �̸� , �޿� ������ ����ϼ���
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
--�޿��� 2000�޷� �̻��̸鼭 ������ manager  �� ����� ��� ������ ����ϼ���
select *
from emp
where sal >= 2000 and job='MANAGER'; --AND ��� ���ǿ� ����

--�޿��� 2000�޷� �̻��̰ų� �Ǵ� ������ manager  �� ����� ��� ������ ����ϼ���
select *
from emp
where sal >= 2000 or job='MANAGER'; 

--����Ŭ ��¥ (DB ������ ��¥)
--����Ŭ ��¥ Ű����(sysdate)

select sysdate from dual;  --21/03/02
--����Ŭ�� ��ġ�� PC�� �ð� (������ �ð�)

--��� �ý��� ��¥ �ʼ� ����
--�Խ���
--insert into board(writer, title, content, regdate)
--values('ȫ�浿','�氡','������',sysdate)
--regdate �÷��� ������ ������ �ð�
--Tip) ms-sql : select getdate()

--����Ŭ ����(ȯ�� ���� ��¥)
select * from NLS_SESSION_PARAMETERS;
--NLS_DATE_FORMAT   >>	RR/MM/DD
--NLS_DATE_LANGUAGE	>>  KOREAN
--NLS_TIME_FORMAT	  >>  HH24:MI:SSXFF

--�Ϲ������� 2021-03-02
--���� ������ ���� ����Ŭ ������ ������� �۾� ȯ�� ����
--�׷��� ������ (x)  �翬�� �������·� ���� 
--���� session���� �ݿ�
alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
--NLS_DATE_FORMAT	YYYY-MM-DD HH24:MI:SS

select sysdate from dual; --2021-03-02 14:10:09

select hiredate from emp;  --1980-12-17 00:00:00

select *
from emp
where hiredate='1980-12-17';

select *
from emp
where hiredate='1980/12/17'; --����

select *
from emp
where hiredate='1980.12.17'; --^^

select *
from emp
where hiredate='80/12/17';--�ȵǿ�  --���� format (yyyy-MM--dd) (0)

--����� �޿��� 2000�̻��̰� 4000������ ��� ����� ������ ����ϼ���
select *
from emp
where sal >= 2000 and sal <=4000;

--�ʰ�   �̸�  : where sal > 2000 and sal < 4000;

--������ : �÷��� between A and B (= ����)
select *
from emp
where sal between 2000 and 4000;

--����� �޿��� 2000�ʰ� 4000�̸� �� ��� ����� ������ ����ϼ���
select *
from emp
where sal > 2000 and sal <4000;


--�μ���ȣ�� 10�� �Ǵ� 20�� �Ǵ� 30���� ����� ��� , �̸� , �޿� , �μ���ȣ�� ����ϼ���
select *
from emp
where deptno=10 or deptno=20 or deptno=30;
--������ ( IN ������) Ǯ��� (���� or ���� or .....)
select empno, ename, sal, deptno
from emp
where deptno in (10,20,30);--where deptno=10 or deptno=20 or deptno=30; �ؼ�


--�μ���ȣ�� 10�� �Ǵ� 20���� �ƴ� ����� ��� , �̸� , �޿� , �μ���ȣ�� ����ϼ��� (����)
--and ....  !
select *
from emp
where deptno != 10 and deptno != 20;
-- IN ���� ������ (NOT IN) Ǯ���  �������� and �������� and .... 

select *
from emp
where deptno not in (10,20); --Ǯ��� deptno != 10 and deptno != 20;

--POINT : Oracle ���� ���� (������ ����) >> null
--�ʿ�� (null)

create table member(
   userid varchar2(20) not null, --null�� ������� �ʰڴ� (�ʼ� �Է�)
   name varchar2(20) not null, --�ʼ��Է�
   hobby varchar2(50) -- default null (�⺻������ null ���) �����Է�
);

select * from member;
--ȸ������ ����
insert into member(userid,hobby) values('hong','��');  --x
-- ORA-01400: cannot insert NULL into ("BITUSER"."MEMBER"."NAME")
insert into member(userid,name) values('hong','ȫ�浿');
--hobby �÷��� ������ : null ä������
select * from member;

--POINT (INSERT , UPDATE , DELETE)
--���� �ݿ��� ���ؼ��� 
--�ݵ�� commit ����� ���� (rollback)

commit;


--����(comm) �� ���� �ʴ� ��� ����� ������ ����ϼ���
-- 0 �� ������(�޴� ����)
select comm from emp;
--comm �÷��� �����Ͱ�  null  �� �͸� ����Ͻÿ�
select *
from emp 
where comm = null; --�̷� ������ ����� (���� ...�׳� �������ϴ�)

--null �񱳴� (is null , is not null) �ϱ�
select * from emp
where comm is null;

--����(comm) �� �޴� ��� ����� ������ ����ϼ���
select * from emp
where comm is not null;

--������̺��� ��� , �̸� , �޿� , ���� , �ѱ޿��� ����ϼ���
--�ѱ޿�(�޿� + ����)
select empno, ename, sal , comm, sal + comm as "�ѱ޿�"
from emp;

--POINT null �̶� �༮
--1. null ���� ��� ������ ����� : null  ex) 100+null >null  100 - null > null
--2. �� ���� �ذ� : �Լ� >> nvl() , nvl2()
--nvl(�÷���,��ü��) >> ġȯ
--Tip) MS-SQL : null > convert()
--Tip) mysql : null < IFNULL()

select empno, ename, sal , comm, sal + nvl(comm,0) as "�ѱ޿�"
from emp;

--comm �÷����� null �����͸� ������ 0���� ġȯ�ؼ� �����ض�

select 1000 + null from dual;

select 1000 + nvl(null,100) from dual;

select comm , nvl(comm,111111) from emp;

--����� �޿��� 1000 �̻��̰� ������ ���� �ʴ� ����� ��� , �̸�  , ���� , �޿�, ������ ����ϼ���
select empno, ename, job, sal, comm
from emp
where sal >= 1000 and comm is null;

--DQL(data query language) : select 
--DDL :���Ǿ�: create , alter , drop (Table emp,dept) ��ü��� �ҷ��� 
--DML :���۾�: insert , update , delete (�ݵ�� �۾� �Ŀ���  
--�ǹݿ� : commit
--�۾� ��� : rollback ��ɾ �ݵ�� ����



--create table board (boardno number ...)
--JAVA : class board {private int boardno}

create table Board(
  boardid number not null, --���� , �ʼ� �Է�
  title varchar2(50) not null, --������(�ѱ� 25�� , ������ 50��) ,�ʼ� �Է�
  content varchar2(2000) not null, --�۳���(�ѱ� 1000��, ������ 2000��) �ʼ� �Է�
  hp varchar2(20) --default null  �ʼ� �Է��� �ƴϴ� (null ����ϰڴ�)
);

select * from USER_TAB_COLUMNS where table_name='BOARD';
desc board;
/*
--dbeaver
SELECT * 
FROM ALL_ALL_TABLES  WHERE TABLE_NAME ='BOARD';

--dbeaver  ����� �÷� ���� ����
SELECT * 
FROM ALL_TAB_COLUMNS WHERE TABLE_NAME ='BOARD';
*/

--create , alter , drop >> commit , rollback (x)
--commit , rollback (insert , update , delete) �۾��ø� �ǹݿ�, ��� ����

select * from board;

insert into board(boardid, title, content)
values(100,'����Ŭ','�Ǽ��߳�^^');

--������ �߸� �־��� ... 
rollback;

--������ �ݿ� �ؾ���
commit;
/*
TIP) MS-SQL : default : auto commit 
insert into emp(empno) values(100); �ڵ� Ŀ��

begin
    insert into emp(empno) values(100);

rollback or commit  �Ҷ� ����ض�


TIP_ : Oracle ������ commit �Ǵ� rollback �����ϱ� ������ �ǹݿ����� �ʾƿ�
*/
select * from board;
commit;

insert into board(boardid, title, content)
values(200,'�ڹ�','�׸���');


insert into board(boardid, title, content)
values(300,'�ڹ�','������ ������');

select * from board;

rollback;

/*
....
commit; �ǹݿ�
...
...
...
rollback ��� ��� (commit ���ĺ��� )
*/

select boardid, title, content, nvl(hp,'EMPTY') as "HP" 
from board;  --nvl�Լ� �߿�(POINT)

--���ڿ� �˻�
--�ּҰ˻� : �˻��� : ���� -> ���� �ܾ ���Ե� ��� �ּҰ� �� ���( LIKE ���� �˻�)
--���ڿ� ���� �˻�( LIKE ������)

--like ������(���ϵ� ī�� ���� : 1. %(����)   , 2. _(�ѹ���) ) ���� ������ ����
--�˻��� ������ >> ���� �˻� ����ǥ���� (java ����ǥ���� ����Ŭ ����)

select *
from emp
where ename like '%A%'; --ename  �÷��� �����Ͱ� A �� ����


select *
from emp
where ename like '%a%'; --��ҹ��� �����ϰ� ����


select *
from emp
where ename like 'A%'; --�̸��� ù���ڰ� A�� ��� ���


select *
from emp
where ename like '%E';

--���� �ܾ ����ִ� �ּҸ� �� �O�ƶ�
--select * from zip where dong like '%����%'

--select * from member where  name like '��%'

select *
from emp
where ename like '%LL%'; --ALLEN   MILLER


select *
from emp
where ename like '%A%A%';  --ADAMS   --AAAAA  , ABABA


select ename
from emp
where ename like '_A%'; --ù���ڴ� ����� �͵� �ǰ� �ι�° ���ڴ� A ����
--WARD
--MARTIN
--JAMES

select ename
from emp
where ename like '__A%';  
--BLAKE
--CLARK
--ADAMS

--����Ŭ ���� (regexp_like)  �󼼰˻�
select * from emp where regexp_like(ename,'[A-C]');
--����Ŭ ����� �� �ִ� ���� ǥ�� �˻� 5�� ����� (EMP)

------------------------------------------------------------------------0303


--������ �����ϱ�
--order by �÷���: ���ڵ����� , ���ڵ�����, ��¥������ ����
--��������: asc => ���� ������ => default
--��������: desc => ������
--���(cost) ���̵�� �۾�

select *
from emp
order by sal;--default asc

select * 
from emp
order by sal asc;

--�޿��� ���� �޴� ������ ����

select *
from emp
order by sal desc;

--�Ի����� ���� ���� ������ �����ؼ� ���, �̸�, �޿�, �Ի����� ���

select empno, ename, sal, hiredate
from emp
order by hiredate desc;

select *
from emp
order by ename asc; --���ڿ� ���� ����
/*
�����ϴ� ����
select ��    3
from ��      1
where ��     2
order by ��  4   (select �� ����� �����Ѵ�)
*/
--�ؼ�
select empno, ename, sal, job , hiredate
from emp
where job = 'MANAGER'
order by hiredate desc;

--order by �÷��� asc, �÷��� desc, �÷��� asc
--POINT(�亯�� �Խ���) �ʼ�

select job, deptno
from emp
order by job asc, deptno desc; 
--group ����

--������
--������(union): ���̺�� ���̺��� �����͸� ��ġ�� �� (�ߺ��� ����)
--������(union all): �ߺ��� ���

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
union --�ߺ� ������ ����
select * from uta; --ut ���� uta�� �ı��� ������ ���� ��

select * from ut
union all
select * from uta;

--union ��Ģ
--1. ������� �÷��� Ÿ���� ����
select empno, ename from emp --empno ����
union 
select job, deptno form dept;--job�� ���ڿ�

select empno, ename from emp --empno ����
union 
select deptno, dname from dept;

--2. ������� �÷��� ������ ����
--null
select empno, ename, job, sal from emp --4��
union
select deptno, dname, loc, nvl(null,0) from dept;   --3��
-----------------------------------------------------------------------------
--�ʺ� �����ڰ� �ǹ������� �ؾ��ϴ� ��(���� ���̺��� select)

------------------------------------------------------------------------------
--Tip
--����Ŭ �Լ� ......
select * from SYS.NLS_DATABASE_PARAMETERS;
--NLS_CHARACTERSET  : 	AL32UTF8  �ѱ� 3byte �ν�
--KO16KSC5601 2Byte (���� ��ȯ�ϸ� �ѱ� �ٱ���)
select * from nls_database_parameters where parameter like '%CHAR%';
------------------------------------------------------------------------------
create table test2(name varchar2(2));

insert into test2(name) values('a');
insert into test2(name) values('aa');
insert into test2(name) values('��'); --�ѱ� 1�� 3byte ����
--ORA-12899: value too large for column "BITUSER"."TEST2"."NAME" (actual: 3, maximum: 2)
-------------------------------------------------------------------------------
?--[2����]
--����Ŭ �Լ� ����
/*
1. SQL �Լ�
�����Ǵ� �Լ����� �⺻���� Query ���� ���� �����ϰ� ���ְ� ������ ���� �����ϴµ�
���ȴ�. �������� ���� �� �Լ��� �̿��Ͽ� ����,����,��¥ �Լ��� ���� ���캼 �Ӹ� ��
�϶� ���� ��ȯ�ϴ� �Լ��鿡 ���ؼ��� ���캻��. ���� ���� �� �Լ��� �̿��Ͽ� ������
�� �����Ͽ� �׷� �� �ϳ��� ����� ����ϴ� �׷� �Լ��� ���ؼ� ���캻��.
1.1 SQL �Լ��� Ư¡ �� ����
1) �����Ϳ� ����� ������ �� �ִ�.
2) �������� ������ �׸��� ������ �� �ִ�.
3) ���� �׷쿡 ���� ����� ������ �� �ִ�.
4) ����� ���� ��¥�� ���� ������ ������ �� �ִ�.
5) ���� �ڷ����� ��ȯ�� �� �ִ�.
1.2 ���� �� �Լ�(Single Row Function)
�� �Լ��� ���� �࿡ ���ؼ��� ���� �����ϰ� �ະ�� �ϳ��� ����� RETURN �Ѵ�..
Function_name (column | expression [ ,arg1,arg2, . . . . ])
function_name �Լ� ��
column ������ ���̽��� Column Name
expression � ���� ��Ʈ���̰ų� ���� ǥ����
arg1,arg2 �Լ��� ���� ���� �� �ִ� �μ�
1.2.1 ���� �� �Լ��� �̿�Ǵ� ��
1) �����Ϳ� ���� ����� ������ ���
2) ������ ������ �׸��� ������ ���
3) ����� ��¥ ������ ������ ���
4) Column Data Type �� ������ ���
1.2.2 ���� �� �Լ��� ����
1) ������ �Լ� : ���ڸ� �Է� �ް� ���ڿ� ���� �� ��θ� RETURN �� �� �ִ�.
2) ������ �Լ� : ���ڸ� �Է� �ް� ���ڸ� RETURN �Ѵ�.
3) ��¥�� �Լ� : ��¥���� ���� �����ϰ� ���ڸ� RETURN �ϴ� MONTHS_BETWEEN �Լ���
�����ϰ� ��� ��¥ ���������� ���� RETURN �Ѵ�.
4) ��ȯ�� �Լ� : � ���������� ���� �ٸ� ������������ ��ȯ�Ѵ�.
5) �Ϲ����� �Լ� : NVL, DECODE
*/

--���ڿ� �Լ�

select initcap('the super man') from dual;--The Super Man �ܾ��� �ձ��ڸ� �빮�ڷ� ����

select lower('AAA'), upper('aaa') from dual;-- lower �ܾ� �ҹ��ڷ� ����� upper �ܾ� �빮�ڷ� �����

select ename, lower(ename) as "ename" from emp;

select * from emp where lower(ename) = 'king';

select length('abcd') from dual; --���ڿ� ����
select length('ȫ�浿') from dual; -- 3��

select length('  ȫ �� �� a') from dual; --�������� 9��

--���� ������: ||  (����)
--concat()
select 'a' || 'b' || 'c' as "data"
from dual; --abc


--select concat('a','b','c') from dual;
select concat('a','b') from dual;

select ename || '           ' || job from emp;
select concat(ename,job) from emp;

--�κ� ���ڿ� ����
--java(substring)
--Oracle(substr)
select substr('ABCDE',2,3) from dual;--BCD
select substr('ABCDE',1,1) from dual;--A
select substr('ABCDE',3,1) from dual;--C

select substr('asdfiodlfdAFDOD',3) from dual; --dfiodlfdAFDOD

select substr('ABCDE',-2,1) from dual; --D
select substr('ABCDE',-2,2) from dual; --DE

--������̺��� ename �÷� �����Ϳ� ���ؼ� ù���ڴ� �ҹ��ڷ� ������ ���ڴ� �빮�ڷ� ����ϵ�
--�ϳ��� �ø����� ���� ����ϼ���
--�÷��� ��Ī��: fullname
--ù���ڿ� ������ ���� ���̿��� ���� �ϳ��� ��������
--SMITH >> s MITH ���

select lower(substr(ename,1,1)) || ' ' || substr(ename,2) as "fulllname"
from emp;

--lpad, rpad (ä���)
select lpad('ABC', 10,'*') from dual; --*******ABC
select rpad('ABC', 10,'%') from dual ;--ABC%%%%%%%

--������� ���: hong1007
--ȭ��: ho******
--���: 1004 >> 10**

select rpad(substr('hong1007',1,2),length('hong1007'),'*') as "pwd" from dual;
--ho******
select rpad(substr('1004',1,2),length('1004'),'*') as "pwd" from dual;

--emp ���̺��� ename �÷��� �����͸� ����ϵ� ù���ڸ� ����ϰ� �������� *�� ����ϼ���

select rpad(substr(ename,1,1),length(ename),'*') as "ename" from emp;

--rtrim �Լ�
--[������ ����]�� ������
select rtrim('MILLER','ER') from dual;

--ltrim �Լ�
--[���� ����]�� ������
select ltrim('MILLLLLLLLLLLER','MIL') from dual;

--�������� Ȱ��
select '>' || rtrim('MILLER          ', ' ') || '<' from dual;

--ġȯ�Լ� (replace)

select ename, replace(ename, 'A', 'Wow') from emp;
--------------------------------------------------------------------------------
--[���� �Լ�]
--round(�ݿø� �Լ�)
--trunc(�����Լ�)
--������ ���ϴ� �Լ� (mod())
-- -3 -2 -1 0(����) 1 2 3
select round(12.345, 0) as "r" from dual; -- 0 => ���� �κи� ���ܶ� ���: 12
select round(12.678, 0) as "r" from dual;-- ��� 13 round �ݿø�

select round(12.345, 1) as "r" from dual; --12.3 >> 1�� �ǹ�: �Ҽ��� 1�ڼ����� ���ܶ�
select round(12.678, 1) as "r" from dual; --12.7

select round(12.345, -1) as "r" from dual; -- 10 >> -1�� �ǹ�: 10�ڸ������� ���ܶ�
select round(15.678, -1) as "r" from dual;--  20
select round(15.678, -2) as "r" from dual;--  0

select trunc(15.1234,-1) as "t" from dual;-- ���� �Ѵ� �����: 10

--������

select 12/10 from dual; --1.2

select mod(12,10) from dual; --������ 2

--------------------------------------------------------------------------------
--[��¥�Լ�]
select sysdate from dual;

--POINT (��¥ ����)
--1. Date + Number >> Date
--2. Date - Number >> Date
--3. Date - Date   >> Number(�ϼ�)
select sysdate + 100 from dual;
select sysdate + 1000 from dual;

select hiredate from emp;
--�Լ�
select trunc(months_between('2018-02-27', '2010-02-20'),0) from dual; --96����
select months_between(sysdate,'2010-03-03') from dual;

select '2019-03-03' + 100 from dual;
--POINT
--to_date() ��ȯ�Լ�

select to_date('2019-03-03') + 100 from dual; --2019-06-11 00:00:00

--1. ��� ���̺��� ������� �Ի��Ͽ��� ���糯¥���� �ټӿ����� ���ϼ���  ( ����̸� , �Ի��� , �ټӿ��� )
--�� �ټӿ����� �����κи� ����ϼ��� (�ݿø� ���� ������)
select ename, hiredate, trunc(months_between(sysdate,hiredate),0) as "�ټ� ����"
from emp;

--2. �Ѵ��� 31 �� �̶�� ���ؿ��� �ټӿ����� ���ϼ��� (�ݿø� ���� ������) (�Լ� ���(x) >> ��¥ - ��¥ >> 150�� )��)
select ename, hiredate, trunc((sysdate - hiredate)/31,0) as "�ټ� ����"
from emp;
--------------------------------------------------------------------------------
--�Լ�(����, ����, ��¥) ����
--------------------------------------------------------------------------------
--[��ȯ �Լ�] Today Point
--Oracle ������: ���ڿ�, ���� ,��¥
--to_char(): ���� -> ���� (1000 -> $100,000) �������
--           ��¥ -> ���� ('2021-03-03' -> 2021��03��03��) �������

--to_date(): ���� -> ��¥
select to_date('2021-01-01') + 100 from dual;

--to_number(): ���� -> ���� >> �ڵ� ����ȯ
select '100' + 100 from dual; -- '100' ������ ����

select to_number('100') + 100 from dual;

--------------------------------------------------------------------------------
/*
--create table ���̺�� (�÷��� Ÿ��, �÷��� Ÿ��.......)
create table member (age number); insert.... 1�� ~ 1000��
insert into member(age) values(100);
...100�� insert

[java]
class member {private int age;}
1�� -> ��ü 1��
member m = new member();
m.setAge(100);

100��
List<member> mlist = new ArrayList<member>();
mlist.add(new member(100));
mlist.add(new member(200));
mlist.add(new member(300));
mlist.add(new member(400));

������ Ÿ��
���ڿ� Ÿ��
char(10)     >>  10Byte >> �ѱ� 5��, ������:Ư������:���� 10�� >> �������� ���ڿ�
varchar2(10) >>  10Byte >> �ѱ� 5��, ������:Ư������:���� 10�� >> �������� ���ڿ�

char(10)     >> 'abc' >> 3byte >> [a][b][c][][][][][][][] >> ������ ��ȭ�� ���� >> 10byte 
varchar2(10) >> 'abc' >> 3byte >> [a][b][c] >> ������ ũ�� ��ŭ�� ���� Ȯ�� >> 3byte

-�ѱ� 1�� 3byte (��,��)
create table member(gender char(3));
create table member(gender varchar2(3));
--����(char)

create table member(gender char(30)); >> ����� �̸�
create table member(gender varchar2(30)); >> (O)

���: �������� ������(��,�� || ��,��,�� || �ֹι�ȣ ...) char()
      �������� ������(����̸�, �ּ� , ���) varchar2()

char() varchar2()����: �ѱ�, ������:Ư������:����
varchar2(10)

unicode (2byte): �ѱ�, ������, Ư������, ���� >> 2byte�� ����

nchar(20)     >> 20���� >> 2*20byte >> 40byte
nvarchar2(20) >> 20���� >> 2*20byte >> 40byte

�ѱ۹�ȭ�� n^^
*/
create table test3(name nchar(2), ename nvarchar2(2));

insert into test3(name) values('a');
insert into test3(name) values('��');

insert into test3(name) values('ab');
insert into test3(name) values('����');

insert into test3(name) values('abc');
insert into test3(ename) values('������');

commit;

--1. to_number() -> ���ڷ� (�ڵ� ����ȯ)
select '1' + 1 from dual;
--��Ģ
select to_number('1') + 1 from dual;

--2. to_char() ���� -> ���Ĺ���, ��¥ -> ���� ����
/*
select sysdate, to_char(sysdate,'YYYY') || '��' as 'YYYY",
                to_char(sysdate,'YEAR'),
                to_char(sysdate,'DD'),
                to_char(sysdate, 'DAY'),
                to_char(sysdate, 'DY')
from dual;
 */
 
 --�Ի����� 12���� ����� ���, �̸�, �Ի���, �Ի�⵵, �Ի���� ���
 select empno, ename, hiredate, to_char(hiredate,'YYYY') as "YYYY", to_char(hiredate, 'MM') as "MM"
 from emp
 where to_char(hiredate, 'MM') = '12';
 
 select to_char(hiredate, 'YYYY MM DD') from emp;
 
 select to_char(hiredate,'YYYY"��" MM"��" DD"��"') from emp;
 
 --to_char(): ���� -> ���Ĺ���
 --pdf ����Ŭ 71page 49page
 --10000000 -> $100,000,000 -> ����
 
 select '>' || to_char(12345,'99999999999') || '<' from dual;
 select '>' || to_char(12345,'09999999999') || '<' from dual; --> 00000012345<
 
 
 select '>' || to_char(12345,'$99,999,999,999') || '<' from dual;
 select sal, to_char(sal,'$999,999') from emp;
 
 --HR �������� 
 
select * from employees;
select sysdate from dual;
alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
 
 /*
������̺�(employees)���� ����� �̸��� last_name , first_name ���ļ� fullname ��Ī �ο��ؼ� ����ϰ�
�Ի�����  YYYY-MM-DD �������� ����ϰ� ����(�޿� *12)�� ���ϰ� ������ 10%(���� * 1.1)�λ��� ����
����ϰ� �� ����� 1000���� �޸� ó���ؼ� ����ϼ���
�� 2005�� ���� �Ի��ڵ鸸 ����ϼ��� �׸��� ������ ���� ������  ����ϼ���
*/
select last_name || first_name as "fullname",
       to_char(hire_date, 'YYYY-MM-DD') as "YYYY-MM-DD",
       salary * 12 as "����",
       to_char((salary * 12) + ((salary* 12)/10),'$999,999,999') as "���� �λ��� ��",
       hire_date
from employees
where to_char(hire_date, 'YYYY') >= '2005'
order by "����" desc;
--order by ���� select ������ �ִ� ��Ī�� ����� �� �ִ�(���� ����)
--------------------------------------------------------------------------------
--�����Լ�
--��¥�Լ�
--�����Լ�
--��ȯ�Լ�(to_char(),to_number(), to_date()
--------------------------------------------------------------------------------
--�Ϲ��Լ�(���α׷� ������ ���� ���� �Լ�)
--nvl(), nvl2() >> null ó���ϴ� �Լ�
--dicode() >> java if ó�� ����� �� �ִ�
--case()   >> java switch ó�� ����� �� �ִ�

--����Ŭ SQL (����, ��� ������ ����) (X)
--����Ŭ PL-SQL (����, ��� ��밡��) ���...SPRING�� �� ����
--���� bituser 
select comm, nvl(comm,0) from emp;

create table t_emp(
    id number(6), --���� 6�ڸ�
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

select id, decode(id, 100, '����Ƽ', 
                      200, '������', 
                      300, '������', 
                      '��Ÿ�μ�') as "�μ��̸�"
from t_emp;

select empno, ename, deptno, decode(deptno, 10, '�λ��',
                                            20, '������',
                                            30, 'ȸ���',
                                            40, '�μ�',
                                            'ETC') as "�μ��̸�"
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
t_emp2 ���̺��� id, jumin �����͸� ����ϵ� jumin �÷��� ���ڸ��� 1�̸�
'����' ��� 2�̸� '����' 3�̸� '�߼�' �׿ܴ�  '��Ÿ' ��� ����ϼ���
�÷����� '����'
*/

select decode(substr(jumin,1,1), 1, '����',
                                 2, '����',
                                 3, '�߼�',
                                 '��Ÿ') as "����", id
from t_emp2;

select deptno, decode(deptno, 20, decode(ename , 'SMITH' , 'HELLO', 'WORLD')
                      ,'ETC')
from emp;

--decode >> �پ��� ���...

--CASE ��
--java switch
/*
CASE ���ǽ� when ��� 1 THEN ��� 1
           when ��� 2 then ��� 2
           when ��� 3 then ��� 3
           else ��� 4
END "�÷Ÿ�"
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

select '0' || to_char(zipcode) , case zipcode when 2 then '����'
                                              when 31 then '���'
                                              when 32 then '����'
                                              when 41 then '����'
                                              else '��Ÿ����'
                        end "�����̸�"
from t_zip;

select case  when sal <= 1000 then '4��'
             when sal between 1001 and 2000 then '3��'
             when sal between 2001 and 3000 then '2��'
             when sal between 3001 and 4000 then '1��'
             else  'Ư��'
end "�޼�"
from emp;
--------------------------------------------------------------------------------
--�����Լ� ��
--�����Լ� ��
--��¥�Լ� ��
--��ȯ�Լ� �� (to_char(), to_date(), to_number())
--�Ϲ��Լ� nvl(), decode(), case ����
--�⺻�Լ� END--
--------------------------------------------------------------------------------
--����(�׷�)�Լ�
--����Ŭ.pdf (75page)

--1. count(*) >> row��, count(�÷���) >> ������ �Ǽ� (null�� �������� �ʴ´�)
--2. sum()
--3. avg()
--4. max()
--5. min()
--��Ÿ ���
--1. �����Լ��� group by ���� ���� ���
--2. ��� �����Լ��� null ���� �����Ѵ�.
--3. select ���� �����Լ� �̿ܿ� �ٸ� �÷��� ���� �ݵ�� �� �÷��� group by ���� ����ؾ� �ȴ�.

select count(*) from emp; --14�� (�ټ� row)
select count(empno) from emp;
select count(comm) from emp;-- 6�� null���� �����Ѵ�
select comm from emp;
select count(nvl(comm,0)) from emp;

--�޿��� ���� ���ض�
select sum(sal) as "�޿��� ��" from emp;

select round(avg(sal),0) as "�޿��� ���" from emp;

--����� �츮ȸ�� �� ������ �󸶳� ���޵Ǿ���
select sum(comm) from emp;

--������ ���
select trunc(avg(comm),0) from emp; --721 (null ���� ����)
--ȸ���� ����(���� ��� ����)
select trunc((sum(comm)/14),0) from emp;--309
--ȸ���� ����(��ü ��� ����)
select comm from emp;

select trunc(avg(nvl(comm,0))) from emp;

select max(sal) from emp;

select min(sal) from emp;

select empno, count(empno) from emp; --ORA-00937: not a single-group group function
--14 --1

select sum(sal) , avg(sal) , max(sal), min(sal), count(sal) from emp;
--------------------------------------------------------------------------------
--�μ��� ��� �޿��� ���ϼ���
select deptno, avg(sal)
from emp
group by deptno;

--������ ��� �޿��� ���Ͻÿ�
select job, avg(sal)
from emp
group by job;

--������ ��ձ޿�, �޿� , �ִ� �޿� , �ּұ޿�, �Ǽ� ���

select job, avg(sal), max(sal), min(sal), count(sal)
from emp
group by job;

/*
grouping

distinct �÷���1, �÷���2

order by �÷���, �÷���2

group by �÷���1, �÷���2
*/

--�μ���, ������ �޿��� ��

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

--������ ��ձ޿��� 3000�޷� �̻��� ����� ������ ��ձ޿��� ���

select job , avg(sal) as "avgsal"
from emp
group by job
having avg(sal) >= 3000;
--having ������ select ����Ī�� ������� ���Ѵ�
/*
1.form ������ where
2. group by ���� ������ having
*/

select * from emp;
/* ������̺��� ������ �޿����� ����ϵ� ������ ���� �ް� �޿��� ���� 5000 �̻��� ������� ����� ����ϼ���
--�޿��� ���� ���� ������ ����ϼ��� */
select job , sum(sal + nvl(comm, 0)) as "�޿���"
from emp
where comm is not null
group by job
having sum(sal) >= 5000 
order by "�޿���" asc;

/* ������̺��� �μ� �ο��� 4���� ���� �μ��� �μ���ȣ ,�ο��� , �޿��� ���� ����ϼ��� */
select deptno, count(*), sum(sal)
from emp
group by deptno
having count(*) > 4;

select count(ename)
from emp
group by deptno;
/* ������̺��� ������ �޿��� ���� 5000�� �ʰ��ϴ� ������ �޿��� ���� ����ϼ���
�� �Ǹ�����(salesman) �� �����ϰ� �޿������� �������� �����ϼ��� */
select job, sum(sal)
from emp
where job != 'SALESMAN'
group by job
having sum(sal) > 5000
order by sum(sal) desc;

--------------------------------------------------------------------------------
--��������� �������̺��� �����͸� �������� �� END
--6�� ����Ŭ 85page
--�������̺��� ������ ��������
--RDBMS(�Ѱ� �̻��� ���̺���� ���� ���踦 ������ �ִ� ����)
--�����͸� �������� ���: ����(join)
--����
-- 1 : 1  [��] �� [��]
-- 1 : N  [��] �� [��]
-- M : N  [��] �� [��]



--���� �ǽ� ���̺� �����ϱ�--
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

--����
--1. �����(equl join) 70%
--�����̺�� ������� ���̺� �ִ� �÷��� �����͸� 1:1 ����


--����
--1. SQL JOIN ����(����Ŭ ����) >> �����ϰ�
--2. ANSI ����(ǥ��) ����: ������ ���� �̸����� >> [inner(��������)] join on ������
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
from m join s --inner �Ϲ������� ����
on m.m1 = s.s1;

select m.m1, m.m2, x.x2
from m join x
on m.m1 = x.x1;

--emp, dept
--�����ȣ, ����� �̸� ,�μ���ȣ, �μ��̸�

select emp.empno, emp.ename, emp.deptno, dept.dname
from emp join dept
on emp.deptno = dept.deptno;

--����: ���̺� ���� ������� 
--join ���̺��� ��Ī�� �ٿ� �ٿ� ����

select e.empno, e.ename, e.deptno, d.dname
from emp e join dept d
on e.deptno = d.deptno;

--join
--���̺� 1�� �̻����� join �Ҽ� �ִ�
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

--HR����
select * from employees;
select * from departments;
select * from locations;

--1. ���, �̸�(last), �μ���ȣ, �μ��̸�

select e.employee_id, e.last_name, e.department_id, d.department_name
from employees e join departments d on e.department_id = d.department_id;
--������
--�����: 107��
--������ 106�� (������ ����)
--select * from employees where employee_id =178;
--����� (null ó�� �Ұ�) >> null ���� �ʴ´�       

--1. ���, �̸�(last), �μ���ȣ, �μ��̸� ,�����ڵ�, ���ø�
select e.employee_id, 
        e.last_name, 
        e.department_id, 
        d.department_name,
        d.department_id,
        l.city
from employees e join departments d on e.department_id = d.department_id
                join locations l on l.location_id = d.location_id;


--------------------------------------------------------------------------------
--bituser ����

select * from emp;

--2. �� ����( non-equi join) => 1 : 1 �� ���� �÷��� ����
--�ǹ̸� ���� >> �join ���� ���
--join: �÷��� �÷��� 1:1 ���� emp.deptno = dept.deptno

select * from emp;
select * from salgrade;

--�� ����
select e.empno, e.ename, e.sal, s.grade
from emp e join salgrade s
on e.sal between s.losal and s.hisal
order by s.grade;

--3. outer join (equi join + null(������)
--outer join >> 1.equi join �����ϰ� >> 2. �� ���� �ǻ����(���� �����͸� ��� ����������)
--outer join: join�Ǵ� ���̺��� ���� ���踦 �ľ��ϴ°� �߿�@@@!@$#@#
--������ �Ǵ� ���̺��� ���� �����͸� ���� �� �� �ִ�.
--����
--1. left [outer](��������) join (���� ���̺��� ����)
--2. right [outer] join (������ ���̺��� ����)
--3. full [outer] join (left�� right join >> union)

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
--HR ����
--1. ���, �̸�(last), �μ���ȣ, �μ��̸� (106���� �ƴ� 107��)
--�����: 107��

select e.employee_id, e.last_name, e.department_id, d.department_name
from employees e left join departments d on e.department_id = d.department_id;

select * from employees where department_id is null; --178 Kimberely

--bituser ����
--4. self join (�ڱ�����) --> ����(x) �ǹ̸� ���� >> ���� (� ����)
--�ϳ��� ���̺��� �÷��� �ڽ��� ���̺� �ٸ� �÷��� �����ϴ� ���
--Emp ������

--join �⺻ ���̺� 2��
--emp ���̺� 1��
--����Ī

select e.empno, e.ename, m.empno, m.ename
from emp e join emp m
on e.mgr = m.empno;
--13��

select * from emp where ename = 'KING';

select e.empno, e.ename, m.empno, m.ename
from emp e left join emp m
on e.mgr = m.empno;

--------------------------------------------------------------------------------

-- 1. ������� �̸�, �μ���ȣ, �μ��̸��� ����϶�.
select e.ename, e.deptno, d.dname
from emp e join dept d on e.deptno = d.deptno;

select *
from emp e join dept d on e.deptno = d.deptno;

-- 2. DALLAS���� �ٹ��ϴ� ����� �̸�, ����, �μ���ȣ, �μ��̸���
-- ����϶�.

select e.ename, e.job, d.deptno, d.dname
from emp e join dept d on e.deptno = d.deptno
where d.loc = 'DALLAS';

-- 3. �̸��� 'A'�� ���� ������� �̸��� �μ��̸��� ����϶�.

select e.ename, d.dname
from emp e join dept d on e.deptno = d.deptno
where ename like '%A%';

select *
from emp
where ename like '%A%';

-- 4. ����̸��� �� ����� ���� �μ��� �μ���, �׸��� ������
--����ϴµ� ������ 3000�̻��� ����� ����϶�.

select d.dname, e.sal
from emp e join dept d on e.deptno = d.deptno
where sal >= 3000;

select *
from emp
where sal >= 3000;

-- 5. ����(����)�� 'SALESMAN'�� ������� ������ �� ����̸�, �׸���

-- �� ����� ���� �μ� �̸��� ����϶�.

select e.ename, d.dname
from emp e join dept d on e.deptno = d.deptno
where e.job = 'SALESMAN';

-- 6. Ŀ�̼��� å���� ������� �����ȣ, �̸�, ����, ����+Ŀ�̼�,

-- �޿������ ����ϵ�, ������ �÷����� '�����ȣ', '����̸�',

-- '����','�Ǳ޿�', '�޿����'���� �Ͽ� ����϶�.

--(�� ) 1 : 1 ���� ��� �÷��� ����

select e.empno as �����ȣ, e.ename as ����̸�, sal *12 as ����, (sal*12 + comm) as �Ǳ޿�, s.grade
from emp e join salgrade s on e.sal between s.losal and s.hisal
where comm is not null;


select *
from salgrade;





/*
select case  when sal <= 1000 then '4��'
             when sal between 1001 and 2000 then '3��'
             when sal between 2001 and 3000 then '2��'
             when sal between 3001 and 4000 then '1��'
             else  'Ư��'
end "�޼�"
*/








-- 7. �μ���ȣ�� 10���� ������� �μ���ȣ, �μ��̸�, ����̸�,

-- ����, �޿������ ����϶�.

select e.deptno, d.dname, e.ename, e.sal, s.grade
from emp e  join dept d on e.deptno = d.deptno
            join salgrade s on e.sal between s.losal and hisal
where e.deptno = 10;

-- 8. �μ���ȣ�� 10��, 20���� ������� �μ���ȣ, �μ��̸�,

-- ����̸�, ����, �޿������ ����϶�. �׸��� �� ��µ�

-- ������� �μ���ȣ�� ���� ������, ������ ���� ������

-- �����϶�.

select e.deptno, d.dname, e.ename, e.sal, s.grade
from emp e  join dept d on e.deptno = d.deptno
            join salgrade s on e.sal between s.losal and s.hisal
where e.deptno in (10,20)
order by e.deptno, e.sal desc;

-- 9. �����ȣ�� ����̸�, �׸��� �� ����� �����ϴ� ��������

-- �����ȣ�� ����̸��� ����ϵ� ������ �÷����� '�����ȣ',

-- '����̸�', '�����ڹ�ȣ', '�������̸�'���� �Ͽ� ����϶�.

--SELF JOIN (�ڱ� �ڽ����̺��� �÷��� ���� �ϴ� ���)

select *
from emp;

select e.empno as �����ȣ, e.ename as ����̸�, s.empno as �����ڹ�ȣ, s.ename �������̸�
from emp e left outer join emp s on e.mgr = s.empno;

SELECT E.EMPNO, E.ENAME , M.EMPNO, M.ENAME
FROM EMP E  left outer join EMP M
on e.MGR = m.EMPNO;
--------------------------------------------------------------------------------
--�ذ�(�ʱް�����....�ذ�------------------------------------

--Subquery
--����Ŭ.pdf 7��(100page)
--sql �� , �����̶�� �Ѵ�
--1. �Լ� >> ���� >> JOIN > �ذ��� �ȵǸ� subquery

--������̺��� ������� ��� ���޺��� �� ���� �޿��� �޴� ����� ���,�̸� �޿� ���

select empno, ename, sal
from emp
where sal > 2073;

--�ϳ��� ���� �ذ� ���� 2�� -> 1���� ����

select empno, ename, sal
from emp
where sal > (select avg(sal) from emp);

--subquery
--1. single row subquery    :subquery�� �������� ���� row ���� colum (���ϰ�)
--  ���� ������ (= > < ..)

--2. multi  row subquery     :subqurey�� �������� 1�� �̻��� row (������ ��)
--in, not, any, all ������
--all: sal > 100 and sal > 4000 and .....
--any: sal > 1000 or sal < 4000 or ...
--why: ���Ǵ� �������� ������ �ٸ���

--subquery ����
--1. ��ȣ�ȿ� �־�� �Ѵ� >> (select max(sal) from emp)
--2. ���� �÷����� ���� �Ǿ�� �Ѵ�>> select emopno, sal from emp(��������(X))
--3. �ܵ����� ���� �����ؾ� �Ѵ�

--�������
--1. subquery
--2. subqurey ����� ������ main qurey�� ����

--Tip)
--select (subqurey) -> �Ѱ��� �ุ ��ȯ�� ��� (scala subquery)
--from (subqurey)   -> Inline view (�������̺�) �߿�~~~~~
--where (subqurey)  -> ����

--������̺��� jones�� �޿����� �� ���� �޿��� ����� ���, �̸�, �޿� ���
select sal
from emp where ename = 'JONES';

select empno, ename, sal
from emp
where sal > (select sal from emp where ename = 'JONES');

select *
from emp
where sal in (select sal from emp where deptno = 30);
--ORA-01427: single-row subquery returns more than one row
--���: multi row

select *
from emp
where sal in (select sal from emp where deptno = 30);
--sal = 1600 or sal = 1250 or sal = 2850...

select *
from emp
where sal not in (select sal from emp where deptno = 30);
-- sal != 1600 and sal != 1250 and sal != 2850...

--���������� �ִ� ����� ����� �̸��� ����ϼ���
--(�� ����� mgr �÷��� �ִ�)

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
--emp == 7902 or empno .... or empno = null ( or ���꿡 null����(X))
--���������� ���� ����� ����� �̸��� ���

select *
from emp
where empno not in (select mgr from emp);
--(and ���꿡 null ����(O)) >> �װ���� null
--emp != 7902 and empno .... and empno != null

select empno, ename
from emp
where empno in (select nvl(mgr,0) from emp);

--king ���� �����ϴ� �� ���ӻ���� king�� ����� ���, �̸�, ����, ������ ���(mgr) �� ����ϼ���
select empno from emp where ename = 'KING';

select empno, ename, job , mgr
from emp
where mgr = (select empno from emp where ename = 'KING');

--20�� �μ��� ����߿��� ���� ���� �޿��� �޴� ������� ������ �޿��� �޴� ����� ���, �̸�, �޿� ,�μ���ȣ

select max(sal)
from emp
where deptno = 20;

select empno, ename, sal, deptno
from emp
where sal > (select max(sal) from emp where deptno = 20);

--�ڱ� �μ��� ��� ���޺��� �� ���� ������ �޴� ����� �纻, �̸�, �μ���ȣ, �μ��� ��� ������ ���

select job , avg(sal) as "avgsal"
from emp
group by job
having avg(sal) >= 3000;

select job , avg(sal) as "���"
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
--1. 'SMITH'���� ������ ���� �޴� ������� �̸��� ������ ����϶�.

select sal
from emp
where ename = 'SMITH';

select ename, sal
from emp
where sal > (select sal from emp where ename = 'SMITH');


--2. 10�� �μ��� ������ ���� ������ �޴� ������� �̸�, ����,

-- �μ���ȣ�� ����϶�.

select * from emp where deptno = 10;
select ename, sal, deptno
from emp
where sal in (select sal from emp where deptno = 10);


--3. 'BLAKE'�� ���� �μ��� �ִ� ������� �̸��� ������� �̴µ�

-- 'BLAKE'�� ���� ����϶�.

select deptno from emp where ename = 'BLAKE';

select ename, hiredate
from emp
where deptno = (select deptno from emp where ename = 'BLAKE')
                and ename != 'BLAKE';


--4. ��ձ޿����� ���� �޿��� �޴� ������� �����ȣ, �̸�, ������

-- ����ϵ�, ������ ���� ��� ������ ����϶�.

select round(avg(sal),0) from emp;

select empno, ename, sal
from emp
where sal > (select round(avg(sal),0) from emp)
order by sal desc;

--5. �̸��� 'T'�� �����ϰ� �ִ� ������ ���� �μ����� �ٹ��ϰ�

-- �ִ� ����� �����ȣ�� �̸��� ����϶�.

select deptno from emp where ename like '%T%';

select empno, ename
from emp
where deptno in (select deptno from emp where ename like '%T%');

--6. 30�� �μ��� �ִ� ����� �߿��� ���� ���� ������ �޴� �������

-- ���� ������ �޴� ������� �̸�, �μ���ȣ, ������ ����϶�.

--(��, ALL(and) �Ǵ� ANY(or) �����ڸ� ����� ��)

select max(sal) from emp where deptno = 30;

select ename, deptno, sal
from emp
where sal > (select max(sal) from emp where deptno = 30);

--7. 'DALLAS'���� �ٹ��ϰ� �ִ� ����� ���� �μ����� ���ϴ� �����

-- �̸�, �μ���ȣ, ������ ����϶�.

select deptno from dept where loc = 'DALLAS';

select ename, deptno, job
from emp
where deptno = (select deptno from dept where loc = 'DALLAS');


select e.ename, e.deptno, e.job
from emp e join dept d on e.deptno = d.deptno
where d.loc = 'DALLAS';



--8. SALES �μ����� ���ϴ� ������� �μ���ȣ, �̸�, ������ ����϶�.

select deptno from dept where dname = 'SALES';

select deptno , ename, job
from emp
where deptno in (select deptno from dept where dname = 'SALES');

--9. 'KING'���� �����ϴ� ��� ����� �̸��� �޿��� ����϶�

--king �� ����� ��� (mgr �����Ͱ� king ���)

select ename, sal 
from emp 
where mgr = (select empno from emp where ename = 'KING');

--10. �ڽ��� �޿��� ��� �޿����� ����, �̸��� 'S'�� ����

-- ����� ������ �μ����� �ٹ��ϴ� ��� ����� �����ȣ, �̸�,

-- �޿��� ����϶�.
-- sal > (select avg(sal) from emp) and 
select avg(sal) from emp;

select deptno from emp where ename like '%S%';

select empno, ename, sal
from emp
where sal > (select avg(sal) from emp) and  deptno in (select deptno from emp where ename like '%S%');

--11. Ŀ�̼��� �޴� ����� �μ���ȣ, ������ ���� �����

-- �̸�, ����, �μ���ȣ�� ����϶�.

select deptno from emp where comm is not null;
select sal from emp where comm is not null;

select ename, sal, deptno from emp where deptno in (select deptno from emp where comm is not null) and sal in (select sal from emp where comm is not null);

?--12. 30�� �μ� ������ ���ް� Ŀ�̼��� ���� ����

-- ������� �̸�, ����, Ŀ�̼��� ����϶�.

select comm from emp where comm is not null and deptno = 30;

select sal from emp where deptno =30;

select ename, sal, comm
from emp
where sal not in (select sal from emp where deptno = 30) 
      and comm not in (select comm from emp where comm is not null and deptno = 30);


--------------------------------------------------------------------------------
--������ ����(DML)
--����Ŭ.pdf 168page
--�ݵ�� �ϱ�
--insert, update, delete

?/*
����Ŭ ����
DDL(������ ���Ǿ�): [create, alter, drop, truncate] , rename, modify
DML(������ ���۾�): insert, update, delete
DQL(������ ���Ǿ�): select
DCL(������ �����): ������: grant, revoke
TCL(Ʈ�����)     : commit, rollback, savepoint

DML �۾� (insert, update, delete)
--A��� ���¿��� B��� ���·� ��ü (100)
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--A ����(1000) ���: update ���� set �ݾ�
-->900
--B ����(1000) �Ա�: update ���� set �ݾ� +
-->1100
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--A���¿��� ��� B���� �Ա� [�ϳ��� ������ ������ ����]
--�Ѵ� ���� �Ѵ� ����
--Ʈ�����: �ϳ��� ������ ����
--ó���ϴ� ���: commit, rollback
?*/

--desc emp(�⺻����)

--���� ���� (���� ���� ������ ������ �ִ� ���̺� ���)
select * from tab;
?
--create table �̸� .... ������ ������ ���� �Ұ� >> Ȯ�ο뵵
select * from tab where tname = 'BOARD2';-- ���̺� ����(X) ���� �Ұ�

select * from tab where tname = 'BOARD'; --���̺� ���� ���� �Ұ�

select * from col where tname = 'EMP';

--------------------------------------------------------------------------------
--1. insert

create table temp(
    id number primary key ,--����(null(X), �ߺ� �����͸� ������� �ʰڴ�)
    name nvarchar2(20)
);

--1. ���� �Ϲ����� INSERT
insert into temp(id, name)
values(100,'ȫ�浿');

select * from temp;

commit; -- �ǹݿ�

--2. �÷� ��� ���� ����.... ���߿��� ���� ����
insert into temp
values(200,'������');

select * from temp;

rollback;

--3. ���� (id �÷��� PK)
insert into temp(id, name)
values(100,'�ƹ���');
--ORA-00001: unique constraint (BITUSER.SYS_C007013) violated

insert into temp(name)
values('�ƹ���');
--ORA-01400: cannot insert NULL into ("BITUSER"."TEMP"."ID")
----------------------------------------------------------------------------0305
--Tip)
--�Ϲ����� SQL���α׷����� ���(X)
--PL-SQL (����, ���)
--���߽ÿ� ���� ������ �ְ� TEST

create table temp2 (id varchar2(50));
/*
begin
    for i in 1..100 loop
        insert into temp2(id) values('A' || to_char(i));
    end loop;
end;
*/
--�׻� �ּ� ó��
select * from temp2;
--------------------------------------------------------------------------------

create table temp3(
    memberid number(3) not null, --���� 3�ڸ� null ���(x)
    name varchar2(10),           --�Է��� ���ָ� null ���(O)
    regdate date default sysdate --�ʱⰪ�� ����(�⺻��) (insert �ڵ� �ý��� ��¥)
    
);

select sysdate from dual;
alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';

insert into temp3(memberid, name, regdate)
values(100,'ȫ�浿','2021-03-04');

select * from temp3;
commit;

insert into temp3(memberid, name)
values(200,'������');

select * from temp3;
commit;

insert into temp3(memberid)
values(300);

select * from temp3;
commit;

insert into temp3(name)
values('����');
--ORA-01400: cannot insert NULL into ("BITUSER"."TEMP3"."MEMBERID")
--------------------------------------------------------------------------------
--Tip)
--1. �뷮 ������ insert �ϱ�
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

--�䱸����
--temp4�� �ִ� ��� �����͸� temp5�� �ְ� �ʹ�
--insert into ���̺�� (�÷�����Ʈ) values(values ����Ʈ)
--insert into ���̺�� (�÷�����Ʈ) select ��

insert into temp5(num)
select id from temp4;

select * from temp5;
commit;

--2. �뷮 insert
--���̺��� ���� ��Ȳ���� >> [���̺� ����(����: ��Ű��) + ������ ����]
--��, ���� ������ ���簡 �ȵǿ�(PK..FK)
--������ ������ ���� + ������ ����
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

--����
--Ʋ(��Ű��) ������ �����ϰ� �����ʹ� �����ϰ� ���� �ʴٸ�

create table copyemp3
as
    select * from emp where 1=2; -- where 1=1 ��������

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

--�������� �÷� update

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
--������ (SQL) >> CRUD (Create(insert), Read(select), Update, Delete)
--APP(JAVA) -     JDBC API    - Oracle
--insert
--update
--delete
--select (70%)

--CRUD
--��ü��ȸ(�Լ�), ���� ��ȸ(�Լ�), ����(�Լ�), ����(�Լ�), ����(�Լ�) => ������ => JAVA�ڵ�
--JAVA�ڵ� 
--��ü ��ȸ public List<Emp> getEmpAllList() { select * from emp }
--���� ��ȸ public Emp getEmpListByEmpno(int empno) { select * from emp where empno = 7788}
--����     public int insertEmp(Emp enp) {insert into emp(..) values(....)}

--------------------------------------------------------------------------------
--DDL (create, alter, drop (rename): ���̺� �����, ����, ����
--����Ŭ.pdf 9�� 130page

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

desc board; --������� ���� ����

--Tip (������ȸ)
select * from user_tables where lower(table_name) = 'board';
select * from user_constraints where(table_name) = 'board'; --�������� ���°�
----------

--Oracle 11g >> ���� �÷� (�����÷�)
--�л� ���� ���̺�: ����, ����, ����, ����
--����, ����, ���� �����͸� insert�� �ϸ� �ڵ����� ���� �����Ͱ� ����� �ʹ�

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
--SQL ����: ORA-54013: INSERT operation disallowed on virtual columns

select * from user_tab_columns where table_name = 'VTABLE';



--�ǹ�����  Ȱ���ϴ� �ڵ�
--��ǰ���� (�԰���) �б⺰ ������ (4�б�)
--�԰��� : 2019-03-01 >> 1�б�

create table vtable2
(
  no number , --����
  p_code char(4), --��ǰ�ڵ� (A001 , B002)
  p_date char(8), --�԰���(20190303)
  p_qty number, --����
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
--DDL ���̺� ����� ���� ����

--1. ���̺� �����ϱ�
create table temp6(id number);

--2. ���̺� �̹� ���� �ߴµ� �÷��� �߰�
--���� ���̺� �߰�

alter table temp6
add ename varchar2(20);

select * from temp6;

--3. ���� ���̺� �ִ� �÷��� �̸� �߸� ǥ��(ename -> username)
--���� ���̺� �ִ� ���� �÷��� �̸� �ٲٱ�(rename)
alter table temp6
rename column ename to username;

select * from temp6;

--4. ���� ���̺� �ִ� ���� �÷��� Ÿ�� ���� ���� (modify)
alter table temp6
modify(username varchar2(2000));

desc temp6;

--5. ���� ���̺� �ִ� ���� �÷� ����
alter table temp6
drop column username;

select * from temp6;

--6. ���̺� ��ü�� �ʿ� ��������
--6.1 delete: ������ ����
--���̺� ó�� ����� ó�� ũ�� >> ������ ������ >> ������ ũ�� ��ŭ ���̺� ũ�� ����
--Ex) ó�� 1M >> ������ 10���� >> 100M >> delet 10���� ���� >> ������ ���� >> ���� ũ�� �״��

--���̺� ������ ���� [������ ũ�⵵ ���� �� ������]
--truncate (���� where �� ��� ����)
--truncate table emp;

--7. ���̺� ����
drop table temp6;

--------------------------------------------------------------------------------
--������ ���Ἲ ���� ���� ����Ŭ.pdf 136.page
--������ ���Ἲ Ȯ��
--insert, update (����)
/*
�� �� �� �� �� ��
PRIMARY KEY(PK)     : �����ϰ� ���̺��� ������ �ĺ�(NOT NULL �� UNIQUE ������ ����)
                    : where empno = 7799 >> ������ 1�� ���� >> ���� >> ��ȸ >> (���������� index)
                    : ��ȭ�� >> 100�� >> �ܰ� >> å ���� ��û >> ������ ã����
                    : ��ȭ >> 1000������ �ø� >> �ܰ� >> ������ >> ���� �ȿ� >> ã�µ� �����ɸ�
                    : ���� ������ >> ������ >>
                    : ���� ã�� ��( �帣�� ���): å�� ��ġ ����
                    : ����) �ݴ�� ���ο� å�� ���ų� �ļյ� å�� ������ ������ ���ʿ��� �۾��� �ʿ��ϴ� (DML) ���ո��ϴ�
                    : ����(page) >> index >> ���ǻ� >> �˻� >> 5page >> index(X)
                    : ���̺� �� 1�� (�������� ��� 1��): ����Ű

FOREIGN KEY(FK)     : ���� ������ �� ������ �ܷ�Ű ���踦 �����ϰ� �����մϴ�.
                    : ���̺�� ���̺���� ���踦 ���� (��������)
                    
UNIQUE key(UK)      : ���̺��� ��� ���� �����ϰ� �ϴ� ���� ���� ��(NULL �� ���)
                    : ���ϰ��� ��������� null�� ��� >> not null unigue �Ѵ� 
                    : �÷��� ���� ��ŭ ����� �ִ�
                    
NOT NULL(NN)        : ���� NULL ���� ������ �� �����ϴ�. (�ʼ� �Է�)

CHECK(CK)           : ���̾�� �ϴ� ������ ������(��κ� ���� ��Ģ�� ����)
                    : ���� ���� ���� ���� �Է¹ްڴ� ( gender: �÷��� �� �Ǵ� �� �����͸� �Է�)
                    : where gender in ('��', '��')
                    : gender in ('��','��') ��������
*/

--������ ����� ����( create table ... �ȿ��� ����)
--���̺� ���� ���Ŀ� �߰� (alter table ... add constraint ...) ���� ��� @@ >> �𵨸� ��

--Tip)
--���� ���� Ȯ��
select * from user_constraints where table_name = 'EMP';

create table temp7(
    --id number primary key --�ȵȴ�(�������� �ʴ´�) --������ �̸��� �ڵ� ����( ���� ����) ��ƴ�
    id number constraint pk_temp7_id primary key, --������ ǥ�� �̸�����: pk_temp7_id
    name varchar2(20) not null,
    addr varchar2(50)
);

select * from user_constraints where table_name = 'TEMP7';
--DBEAVER
--select * from ALL_CONSTRAINTS where table_name = 'TEMP7';

insert into temp7(name, addr) values('ȫ�浿','����� ������');
--ORA-01400: cannot insert NULL into ("BITUSER"."TEMP7"."ID")

insert into temp7(id, name, addr) values(10,'ȫ�浿','����� ������');

select * from temp7;
commit;

insert into temp7(id, name, addr) values(10,'�ƹ���','����� ������');
--ORA-00001: unique constraint (BITUSER.PK_TEMP7_ID) violated

--1. primary key ���̺� ����� �� �� ������ > 1��
--������ ��� 1��
--create table member (ename, age) >> ename, age ��� �ϳ��� ����Ű
--where ename = and age = and num = (�Ѱ��� ������ ����)

create table temp8(
    id number constraint pk_temp8_id primary key,
    name nvarchar2(30) not null,
    jumin nchar(6) constraint uk_temp8_jumin unique,
    addr nvarchar2(1000)
);

select * from user_constraints where table_name = 'TEMP8';

insert into temp8(id,name,jumin,addr)
values(10,'ȫ�浿','123456','��⵵');
commit;

insert into temp8(id,name,jumin,addr)
values(20,'������','123456','����');
--ORA-00001: unique constraint (BITUSER.UK_TEMP8_JUMIN) violated

insert into temp8(id,name, addr)
values(20,'������','����');

select * from temp8; --unique ���� null ���
--jumin nchar(6) not null constraint uk_temp8_jumin unique, --null(X)

insert into temp8(id,name, addr)
values(30,'�ƹ���','������');
--null �ߺ� üũ�� ���� �ʴ´�

select * from temp8;
commit;
--------------------------------------------------------------------------------
--���̺� ���� �� ���� �ɱ�
create table temp9 (id number);

--���� ���̺� ���� �߰��ϱ�
--���� (������ �߰��ɶ� ���̺� ������ �˻�) >> �ߺ� ������ > �ߺ������� ���� >> ���� �߰�

alter table temp9
add constraint pk_temp9_id primary key(id);
--add constraint pk_temp9_id primary key(id ,num); --���� �����̸Ӹ� Ű

select * from user_constraints where table_name = 'TEMP9';


alter table temp9
add ename varchar2(50);

--not null �߰�
alter table temp9
modify(ename not null);

select * from user_constraints where table_name = 'TEMP9';
--------------------------------[unique ���� ��]---------------------------------
--[check ����]
--where ���ǰ� ������ ������ ���� >> where gender in ('��', '��')
--POINT
create table temp10(
    id number constraint pk_temp10_id primary key,
    name varchar2(20) not null,
    jumin char(6) constraint uk_temp10_jumin unique,
    addr varchar2(20),
    age number constraint ck_temp10_age check(age >= 19)
    --where (age >= 19) => ��κ��� check() ��ȣ �ȿ� ���ش�
);

select * from user_constraints where table_name = 'TEMP10';

insert into temp10(id, name, jumin, addr, age)
values(100,'ȫ�浿','123456','�����',25);

select * from Temp10;
commit;

insert into temp10(id, name, jumin, addr, age)
values(200,'������','123456','�����',18);--19�� ���϶� �ɸ�
--ORA-02290: check constraint (BITUSER.CK_TEMP10_AGE) violated
--------------------------------[check ����]-------------------------------------
--���� ����
--exrd -> db�𵨸� ���α׷�

--������̺� �μ���ȣ�� �μ����̺��� �μ���ȣ�� �����Ѵ�
--> forign key
--�μ����̺��� �μ���ȣ�� ������̺��� �μ���ȣ�� ���� ���Ѵ�
--> primary key(forign key) ���� ����Ǿ�� �Ѵ�
--��������: ���̺�� ���̺���� ����

create table c_emp
as
    select empno, ename, deptno from emp where 1=2;

select * from c_emp;

create table c_detp
as
    select deptno, dname from dept where 1= 2;

select * from c_detp;

--����(A���̺� �ִ� ��� �÷��� �����ʹ� B���̺� �÷��� �����͸� �ްڴ�)
--c_emp ���̺� �ִ� deptno �÷��� �����ʹ� c_detp ���̺� �ִ� deptno �÷��� �����͸� ���ڴ�
--�����ϰڴ�(fk)

--alter table c_emp
--add constraint fk_c_emp_deptno foreign key(deptno) references c_detp(deptno);
--ORA-02270: no matching unique or primary key for this column-list
--�����ϱ����� 

alter table c_detp
add constraint pk_c_detp_deptno primary key(deptno);
-->�ſ� Ȯ��

alter table c_emp
add constraint fk_c_emp_deptno foreign key(deptno) references c_detp(deptno);

--����
insert into c_detp(deptno, dname) values(100,'�λ���');
insert into c_detp(deptno, dname) values(200,'������');
insert into c_detp(deptno, dname) values(300,'ȸ����');

commit;
select * from c_detp;

--���Ի�� �Ի�
insert into c_emp(empno,ename) values(100,'ȫ�浿'); --deptno �Է� 
--deptno fk �־ not null ���� ������ null �� ���

select * from c_emp;
--����: ���Ի���� �μ��� ������ ���� �� �ִ�

--����: ���Ի���� �ݵ�� �μ��� ������ �Ѵ�
--create table c_emp(deptno not null .... constraint .. )

insert into c_emp(empno,ename, deptno) values(200,'ȫ�浿', 50);
--ORA-02291: integrity constraint (BITUSER.FK_C_EMP_DEPTNO) violated - parent key not found
--���� ���ϴ� ���̺��� �����͸� ���� �ִ�

insert into c_emp(empno,ename, deptno) values(200,'ȫ�浿', 100);

select * from c_emp;
commit;
-------------------------[���� ��]-----------------------------------------------
--������ ����
--���̺�(�θ�, �ڽ�)
--c_emp, c_detp [deptno] �÷��� ��������....
--�θ� (master): deptno�� ���� PK�� ���� ���̺��� �θ�
--�ڽ� (detail): deptno�� ���� FK�� ���� ���̺��� �ڽ�

--c_detp���� 100 ������ ���� �������� �ʴ�

delete from c_detp where deptno = 100; --100������ �ڽ����̺� ���..
--ORA-02292: integrity constraint (BITUSER.FK_C_EMP_DEPTNO) violated - child record found
--����� ������
--���� �ڽ� 100 ���� >> �θ� 100 ����

delete from c_detp where deptno = 200;--�ڽ����̺� �����͸� ���� ���� �ʾƼ�

commit;

/*
(column datatype [CONSTRAINT constraint_name]       
REFERENCES table_ name (column1[,column2,..] [ON DELETE CASCADE]) 

column datatype, . . . . . . . , 
[CONSTRAINT constraint_name] FOREIGN KEY (column1[,column2,..])        
REFERENCES table_name  (column1[,column2,..] [ON DELETE CASCADE]) 
*/
-- [ON DELETE CASCADE]  �θ����̺�� ������ ���� �ϰڴ�
-- 300 ���� �� �ֳ���?  �� 
-- delete from c_dept where detpno=300;
-- �����ϴ� �ڽ� ������ ���� ����
-- delete from c_emp where deptno=300; ���� ����

alter table c_emp
add constraint fk_emp_deptno foreign key(deptno) references c_dept(deptno) ON DELETE CASCADE;

--MS-SQL
--on delete cascade:
--on update cascade;
--------------------------------------------------------------------------------
--�������̺�, ���� �÷�

--�л� ���� ���̺�
--�й��� �����ʹ� �ߺ��ǰų� NULL ���� ����ϸ� �ȵȴ�
--�̸� NULL ���� ������� �ʴ´�
--����
--����
--���� ���� �÷��� ���� Ÿ���̰� NULL ���� ���
--���� �Է����� ������ default�� 0���� ���´�
--���� ,��� �÷��� �����÷�����(�����÷�) �����Ѵ�
--�а��ڵ�� �а� ���̺� �а��ڵ带 �����Ѵ�
--�й� , �̸� , ���� , ���� , ���� , ���� , ��� , �а��ڵ�

--���̺� grade �й�: dno �̸� dname ���� kor ���� eng ���� math ���� sum ��� avg �а� �ڵ� depno

--no3 number generated always as (no1 + no2) virtual
--constraint fk_c_emp_deptno foreign key(deptno) references c_detp(deptno);
--constraint uk_temp10_jumin unique,

--alter table c_emp
--add constraint fk_c_emp_deptno foreign key(deptno) references c_detp(deptno);

--�а� ���̺�
--�а��ڵ� �����ʹ� �ߺ��ǰų� NULL ���� ����ϸ� �ȵȴ�,
--�а��� �� null���� ������� �ʴ´�
--�а��ڵ� , �а���


--���� ������ insert ..
--�׸��� select �����
--�й� , �̸� ����, ��� , �а��ڵ� , �а��� �� ����ϼ���
--�а����̺� dep �а��� dname  �а��ڵ� depno 

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

insert into grade (dno, dname, kor, eng, math, depno) values ( 123, '�Ƚ���', 100, 100, 100, 40);
insert into grade (dno, dname, kor, eng, math, depno) values ( 124, '�̵���', 100, 100, 99, 20);
insert into grade (dno, dname, depno) values ( 125, '�̺���', 40);
insert into grade (dno, dname, kor, eng, math, depno) values ( 126, '�Ѽ���', 88 , 99, 98, 30);
insert into grade (dno, dname, kor, eng, math, depno) values ( 127, '������', 55, 65, 77, 10);
insert into grade (dno, dname, kor, eng, math, depno) values ( 128, '����', 66, 55, 100, 40);
insert into grade (dno, dname, kor, eng, math, depno) values ( 129, '������', 10, 10, 10, 50);
insert into grade (dno, dname, kor, eng, math, depno) values ( 130, '����ö', 100, 100, 100, 40);
commit;

drop table grade;

alter table grade
add constraint fk_grade_depno foreign key(depno) references dep(depno);

select * from grade;

create table dep(
    depno number constraint pk_dep_depno primary key,
    dname nvarchar2(10) not null
);
insert into dep (depno,dname) values(10,'���а�');
insert into dep (depno,dname) values(20,'�ǰ�');
insert into dep (depno,dname) values(30,'�����');
insert into dep (depno,dname) values(40,'�����');
insert into dep (depno,dname) values(50,'�濵��');
insert into dep (depno,dname) values(10,'���а�');--����
select * from dep;
select * from grade;

--�й� , �̸� ����, ��� , �а��ڵ� , �а��� �� ����ϼ���


select g.dno, g.dname, g.sumg, g.avgg, g.depno, d.dname
from grade g join dep d on g.depno = d.depno;

--------------------------------------------------------------------------------
select * from emp;
select * from dept;
select * from salgrade;

--��¥ �ٲٱ� 
--����Ŭ 192page 12�� view

--View ��ü .. (���� ���̺�)
--view ��ü(create ...)
--create view ���̸� as [select ����}
--view�� ���̺�ó�� ��밡���� [�������̺�]: ������ �����͸� ������ ���� �ʴ�
--view �޸𸮻󿡸� �����ϴ� �������̺�
--(subquery -> in line view -> from (select dept avg(sal) from ...)

--view ���� ���̺�
--����: �Ϲ����̺�� ������ ����(select , where ....)
--��, view �� �� �ִ� ������ ���ؼ�
--DML(insert, update, delete) -> view�� ���ؼ� �������̺� ���� -> DML ����

--bituser ���� ���� (SYSTEM ������ ���ؼ�)
--SYSTEM >> GRANT CREATE ANY VIEW TO "BITUSER" WHITH ADMIN OPTION; ����

create view v_001
as
    select empno, ename from emp;
--ORA-01031: insufficient privileges -> ������ ���� -> ������ �ο��ؾ��Ѵ� ANY VIEW

select * from v_001;--view ������ �ִ�SQL ������ ����

--VIEW ������
--1. ������ ����: JOIN, SUBQUERY >> VIEW ��� >> ���� ���� ������ >> �����ڰ� ���ϰ�
--2. ������ �ܼ�ȭ (����): ������ ������ �̸� ����� �ΰ� ���
--3. ������ ���ȼ� >> Ư�� �÷��� ����

--������ >> ���Ի�� >> emp ����

create view v_emp
as 
    select empno, ename, job, hiredate from emp;

--���Ի��: view ���� �ִ� ����: v_emp�� ����Ͻÿ�
--view ���ؼ�.....
select * from v_emp;
select * from v_emp where job = 'CLERK';
select empno from v_emp;

--����
create view v_002
as
    select e.ename, e.empno, e.deptno, d.dname
    from emp e join dept d
    on e.deptno = d.deptno;

select * from v_002;

select * from v_002 where deptno = 20;

--view �������̺�(������) ���� ���̺��ε� (�÷����� ����)

create view v_003
as                                 --�÷��� ��Ī ���� �ƴϸ� "" �Ⱥ��̴°� ���ϴ� 
    select deptno, avg(sal) as avgsal --ORA-00998: must name this expression with a column alias
    from emp
    group by deptno;

select deptno, avgsal from v_003;

/*

CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW view_name [(alias[,alias,...])]
AS Subquery 
[WITH CHECK OPTION [CONSTRAINT constraint ]]
[WITH READ ONLY]

OR REPLACE                  �̹� �����Ѵٸ� �ٽ� �����Ѵ�.
FORCE Base Table            ������ ������� VIEW �� �����.
NOFORCE                     �⺻ ���̺��� ������ ��쿡�� VIEW �� �����Ѵ�.
view_name VIEW �� �̸�
Alias Subquery �� ����       ���õ� ���� ���� Column ���� �ȴ�.
Subquery SELECT             ������ ����Ѵ�.
WITH CHECK OPTION VIEW      �� ���� �׼��� �� �� �ִ� �ุ�� �Է�,���ŵ� �� �ִ�. 
Constraint CHECK OPTON      ���� ���ǿ� ���� ������ �̸��̴�.
WITH READ ONLY �� VIEW ���� DML �� ����� �� ���� �Ѵ�.

*/

create or replace view v_004 --������ ���� ����� ������ overwiriting
as
    select avg(sal) as avgsal from emp;

select * from v_004;

create or replace view v_004
as
    select round(avg(sal),0) as avgsal from emp;

select * from v_004;

--view ���� ���̺� DML �۾� ����(insert update delete)
--�� view ���ؼ� ���� �ִ� �����͸� DML ... �׸��� ���� ���̺� ����
--�ܼ� view(���̺� 1��) >> (DML) ������ �ѵ� >> ��������
--���� view(���̺� 1�� �̻�) >> join, subquery >> DML �Ұ���

select * from v_emp;

update v_emp set sal = 0; --v_emp sal �÷��� �����͸� ���� ����

update v_emp set job = 'IT'; --view ������ �������̺��� ������ ����

select * from emp;
rollback;

--30�� �μ� ������� ����, �̸�, ������ ��� view�� ����µ�,
--������ �÷����� ����, ����̸�, �������� ALIAS�� �ְ� ������
--300���� ���� ����鸸 �����ϵ��� �϶�.

create view vQ1
as
    select job as "����", ename as "����̸�", sal as "����"
    from emp
    where sal > 300 and deptno = 30;



select *
from vQ1;

select * from vq1;


--�μ��� ��տ����� ��� view�� �����, ��տ����� 2000�̻���
--�μ��� �߷��ϵ��� �϶�
--from ���� => where
--group by ���� => having

create view vq2
as
    select round(avg(sal),0) as "��տ���", deptno
    from emp
    group by deptno
    having avg(sal) >= 2000;

--����
select v.deptno, v.��տ���, d.dname
from vq2 v join dept d on v.deptno = d.deptno;
--------------------------------------------------------------------------------
--������ �������� SQL
--����Ŭ.pdf 11�� SEQUENCE 185page
--���� �����ϱ� (ä���ϱ�)
--�ڵ����� ��ȣ�� �����ϴ� ��ü

/*
CREATE SEQUENCE sequence_name
[INCREMENT BY n]
[START WITH n]
[{MAXVALUE n | NOMAXVALUE}]
[{MINVALUE n | NOMINVALUE}]
[{CYCLE | NOCYCLE}]
[{CACHE | NOCACHE}];
sequence_name SEQUENCE �� �̸��Դϴ�.
INCREMENT BY n ���� ���� n ���� SEQUENCE ��ȣ ������ ������ ����.
�� ���� �����Ǹ� SEQUENCE �� 1 �� ����.
START WITH n    �����ϱ� ���� ù��° SEQUENCE �� ����.
                �� ���� �����Ǹ� SEQUENCE �� 1 �� ����.
MAXVALUE n SEQUENCE �� ������ �� �ִ� �ִ� ���� ����.
NOMAXVALUE      ���������� 10^27 �ִ밪�� ����������-1 �� �ּҰ��� ����.
MINVALUE n      �ּ� SEQUENCE ���� ����.
NOMINVALUE      ���������� 1 �� ����������-(10^26)�� �ּҰ��� ����.
CYCLE | NOCYCLE �ִ� �Ǵ� �ּҰ��� ������ �Ŀ� ��� ���� ������ ���� ���θ�
                ����. NOCYCLE �� ����Ʈ.
CACHE | NOCACHE �󸶳� ���� ���� �޸𸮿� ����Ŭ ������ �̸� �Ҵ��ϰ� ����
�ϴ°��� ����. ����Ʈ�� ����Ŭ ������ 20 �� CACHE.
*/

--why: web site: �Խ��� >> key (�ĺ���) >> ���� (1,2,3 ....)

drop table board;

create table board(
    boardid number constraint pk_borad_boardid primary key,
    title nvarchar2(50)
);



select * from board;
--boardid(pk: not null , unique, ���������� index �ڵ� ����)
--�Խ��ǿ� ���� ����
--insert into board (boardid, title) values();
--boardid �÷��� �����ʹ� ó�� ���� ���� 1 �̶�� ���� insert �� ���� �ۺ��ʹ�
--2, 3, 4 �������� �����Ͱ� insert �Ǵ� ��Ģ�� ����ÿ�

select count(boardid) + 1 from board;

insert into board(boardid, title) values((select count(boardid) + 1 from board)  ,'ó�� ��');
insert into board(boardid, title) values((select nvl(max(boardid),0) + 1 from board) ,'ó�� ��');--1

select *
from board;

commit;

--������: CRUD ���� (insert, update, delete)

delete from board where boardid = 1;
commit;

insert into board(boardid, title) values ((select count(boardid) + 1 from board), 't��������');
--ORA-00001: unique constraint (BITUSER.PK_BORAD_BOARDID) violated
--DML �����߻�

--�ٸ� ���
insert into board(boardid, title) values ((select count(boardid) + 1 from board), 't��������');

delete from board;

insert into board(boardid, title) values ((select nvl((max(boardid),0) + 1 from board), '1������');
insert into board(boardid, title) values ((select nvl(max(boardid),0) + 1 from board), '2������');
insert into board(boardid, title) values ((select nvl(max(boardid),0) + 1 from board), '3������');

insert into board(boardid, title) values((select nvl((max(boardid),0) + 1 from board), '1');

insert into board(boardid, title) values((select nvl(max(boardid),0) + 1 from board) ,'ó�� ��');
--> max()�� �̿��Ͽ� null���� 0���� ��ü�ϰ� �����ض� >> ����: null���� ���� ����� �׻� null�̴�
select * from board;

commit;

--------------------------------------------------------------------------------
--sequence ��ȣ�� ����: �ߺ����� ���� �������� ��( ���� ��ü)
--------------------------------------------------------------------------------
--sequence ��ȣ�� ����: �ߺ����� ���� �������� ��( ���� ��ü)
create sequence board_num;

select * from USER_SEQUENCES;

--����Ŭ 187page 
/*
NEXTVAL �� CURRVAL �ǻ翭 
��) Ư¡ 
1) NEXTVAL �� ���� ��� ������ SEQUENCE ���� ��ȯ �Ѵ�.��188��
2) SEQUENCE �� ������ �� ����, �ٸ� ����ڿ��� ������ ������ ���� ��ȯ�Ѵ�.
3) CURRVAL �� ���� SEQUENCE ���� ��´�.
4) CURRVAL �� �����Ǳ� ���� NEXTVAL �� ���Ǿ�� �Ѵ�.
*/

--��ȣ ����
select board_num.NEXTVAL from dual;
select board_num.NEXTVAL from dual;
select board_num.NEXTVAL from dual;

--������� ä���� ��ȣ Ȯ��(������ ��ȣ ����)
select board_num.CURRVAL from dual;

--------------------------------------------------------------------------------
--�Խ���
--�Խ��ǻ��Ǵ� ä����
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
--1. sequence ��ü�� ���̺� ���ӵ��� �ʴ´� (�ϳ��� �������� �������� ���̺��� ��밡��)
--sequence ���� >> A ���̺�, B ���̺��� ����

--�� ����Ʈ(�Խ��� 10��)
--��ǰ�Խ���, ������ �Խ���, ȸ�� �Խ��� ...
--�䱸����
--sequence 10�� ���� ���� ����� ��� ����
--sequence 1�� ���� �Խ��ǿ��� ��� ����

--Tip)
--MS-SQL: create table board(boardnum int indentity(1,1), title varchar(20));
--insert into board(title) values('hi') >> boardnum �ڵ� 1.....2....3...
--���̺��� ����.....
--MS-SQL: 2012 ���� (sequence)

--mysql: create table board(boardnum int auto_increment, titlbe varchar(20));
--insert into board(title) values('hi') >> boardnum �ڵ� 1.....2....3...

--mysql ���� ������� ���ļ� open source ���� >> mariadb(���� ����)
--https://mariadb.com/kb/en/create-sequence/

--------------------------------------------------------------------------------
--�ɼ�
create sequence seq_num
start with 10       --���� 10
increment by 2;     --����ġ 2

select seq_num.nextval from dual;

--�Խ��� �� 100��
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
--�Ϲ������� �Խ��� �ֽű�(���� ���߿� �� ����) ȭ�鿡 ���� ���

select * from kboard order by num desc; --�ϹݰԽ��� ù ����
--------------------------------------------------------------------------------
--������
--rownum �ǻ��÷�: ���� ���������� �����ϴ� �÷��� �ƴϰ� ������ ����
--rownum: ������ ���̺� �÷��� �������� ������ ���������� �� ��ȣ�� �ο��� �� �ִ� �÷�

select * from emp;
select rownum as ����, empno , ename from emp;
--select �� ����� ������ �ο�

--Top -n (���ĵ� �������� ������ � ����)
--���̺��� ���ǿ� �´� ����(TOP) ���ڵ� (row) n�� ����
--TIP
--MS-SQL (top Ű����)
--select top 10, * from emp order by sal desc;

--Oracle top n(X)
--rownum : ������ �ο� Ư�� ������ ����ؼ� top ���� ����

--1. ������ ������ ����(����)
--2. ���ĵ� �����͸� �������� rownum�� �����ϰ� ������ �ɾ �����͸� ����

--1�ܰ� 
select *
from(
        select * 
        from emp
        order by sal desc
    ) e;

--2�ܰ�

select rownum as num, e.*
from(
        select * 
        from emp
        order by sal desc
    ) e;

--3�ܰ� (�޿��� ���� �޴� ��� 5��) top n

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
--top n (�Խ��� ����¡ ó��)
--1000 ��
--�� ȭ�� 100�� ������ �ѹ��� ������� �ʴ´�
--10�Ǿ� �� ȭ�鿡 

--pagesize = 10 (�� ȭ�鿡 (������) ������ �� �ִ� row�Ǽ�)
--page ���� >> 10��

--1page, 2page ... 10page   ( 1page Ŭ�� select 1 ~ 10 java ����)
--                          ( 1page Ŭ�� select 11 ~ 20 java ����)

--<a href = 'pagejsp?'>10</a> 10page(91 ~ 100)
--------------------------------------------------------------------------------
--HR���� �̵�
--����� ���� ������ ����(����)
select * from employees; --107��

--1�ܰ� (���� ������ �����)
select * from employees order by employee_id asc;

--2�ܰ� (���ص����Ϳ� ���� �ο��ϱ�)
select rownum as num, e.*
from(
        select * from employees order by employee_id asc
    ) e 
where rownum <= 50; --���������� ������ rownum�� ���

--3�ܰ�
select *
from (
        select rownum as num, e.*
        from(
                select * from employees order by employee_id asc
            ) e 
        where rownum <= 50
    ) n where num >= 41;

--107��
--pagesize = 10
--[1][2][3][4][5][6][7][8][9][10][11]
--[1] >> 1 ~ 10
--[2] >> 11 ~ 20
--....
--[5] >> 41 ~ 50 �����͸� �����ִ� ����

select *
from (
        select rownum as num, e.*
        from(
                select * from employees order by employee_id asc
            ) e 
        where rownum <= 10
    ) n where num >= 1;

-- between A and B >> where rownum 1 and 10
-- servlet & jsp ���� �ٽ�
        select rownum as num, e.*
        from(
                select * from employees order by employee_id asc
            ) e 
        where rownum <= 10 and rownum >=1;

select rownum as num, e.*
from(
        select * from employees order by salary desc
    )e where rownum between 1 and 10;

--��� �� ������ �޴� ������� ���� ������ ���� �޴� ����� �����ϰ� ��ȣ�� �ο��ϰ� ����� �Ű� �̸� ��� ���� �μ���ȣ �μ��̸��� ����ض�
select rownum as ��ȣ, a.*
from(
        select e.empno, e.sal, s.grade, e.deptno, d.dname
        from emp e  join salgrade s on e.sal between s.losal and s.hisal
                    join dept d on e.deptno = d.deptno
        where comm is not null
        order by sal desc
    ) a where rownum between 1 and 6;
    
--------------------------------------------------------------------------------
--SQL END-----------------------------------------------------------------------

