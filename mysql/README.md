# MySQL

## build docker image
```
cd mysql-5.6
docker build -t my-mysql:5.6 .
```

## run mysql5.6
```
docker run -d -p 3306:3306 \
  -v /Users/helechen/IdeaProjects/my-docker/mysql/mysql-5.6/my.cnf:/etc/mysql/my.cnf \
  --name mysql56 \
  my-mysql:5.6
```

## go into container
```
docker exec -it 7ff43ec10bcc /bin/bash
```

### start/stop container
可以保留数据现场
```
docker stop 7ff43ec10bcc
docker start 7ff43ec10bcc
```

## commands
```
/etc/init.d/mysql start
/etc/init.d/mysql stop
tail -f /var/log/mysql/error.log

mysql -h127.0.0.1 -P3306 -uroot -pmysql
mysql -h127.0.0.1 -P3306 -umysql -pmysql
mysql -h127.0.0.1 -P3306 -urepl -prepl
```

### sample table data

```
CREATE TABLE emp
(empno smallint(4) not null primary key,
 ename varchar(10),
 job varchar(9),
 mgr smallint(4),
 hiredate date,
 sal float(7, 2),
 comm float(7, 2),
 deptno tinyint(2)
) engine=innodb charset=utf8;

INSERT INTO emp VALUES (7369, '员工SMITH',  'CLERK',     7902, '1980-12-17',  800, NULL, 20);
INSERT INTO emp VALUES (7499, '员工ALLEN',  'SALESMAN',  7698, '1981-02-20', 1600,  300, 30);
INSERT INTO emp VALUES (7521, '员工WARD',   'SALESMAN',  7698, '1981-02-22', 1250,  500, 30);
INSERT INTO emp VALUES (7566, '员工JONES',  'MANAGER',   7839, '1981-04-02',  2975, NULL, 20);
INSERT INTO emp VALUES (7654, '员工MARTIN', 'SALESMAN',  7698, '1981-09-28', 1250, 1400, 30);
INSERT INTO emp VALUES (7698, '员工BLAKE',  'MANAGER',   7839, '1981-05-01',  2850, NULL, 30);
INSERT INTO emp VALUES (7782, '员工CLARK',  'MANAGER',   7839, '1981-06-09',  2450, NULL, 10);
INSERT INTO emp VALUES (7788, '员工SCOTT',  'ANALYST',   7566, '1982-10-09', 3000, NULL, 20);
INSERT INTO emp VALUES (7839, '员工KING',   'PRESIDENT', NULL, '1981-11-17', 5000, NULL, 10);
INSERT INTO emp VALUES (7844, '员工TURNER', 'SALESMAN',  7698, '1981-09-08',  1500,    0, 30);
INSERT INTO emp VALUES (7876, '员工ADAMS',  'CLERK',     7788, '1983-01-12', 1100, NULL, 20);
INSERT INTO emp VALUES (7900, '员工JAMES',  'CLERK',     7698, '1981-12-03',   950, NULL, 30);
INSERT INTO emp VALUES (7902, '员工FORD',   'ANALYST',   7566, '1981-12-03',  3000, NULL, 20);
INSERT INTO emp VALUES (7934, '员工MILLER', 'CLERK',     7782, '1982-01-23', 1300, NULL, 10);
```