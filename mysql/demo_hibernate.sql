#修改存储引擎的三种方法
#用过修改配置文件修改默认存储引擎
-default-storage-engine = engine;
#通过修改数据表命令实现
alter table user ENGINE = InnoDB;
#创建表时修改
create Table Teacher()ENGINE = InnoDB;

show VARIABLES like '%character%';
#建数据库
create database demo_hibernate;
use demo_hibernate;

																							#建表
#教师表
drop table  if EXISTS Teacher;
create Table Teacher(
Tid varchar(10) primary key,
Tname varchar(20) not null
)ENGINE=InnoDB  charset utf8;

#学生表
drop table if EXISTS Student ;
create Table Student(
Sid  varchar(10) primary key,
Sname varchar(20) not null,
Tid varchar(10) not null,
CONSTRAINT FK_Tea foreign key (Tid) references Teacher(Tid) 
)ENGINE=innoDB default charset=utf8;

#教室表
drop table if EXISTS Classroom ;
create Table Classroom(
Cid  varchar(10) primary key,
Cname varchar(20) not null,
Snum int default 0
)ENGINE=innoDB default charset=utf8;
#对应教室的学生表
drop table if EXISTS C_Students ;
create Table C_Students(
C_Sid  varchar(10) primary key,
C_Sname varchar(20) not null,
Cid varchar(10),
Constraint FK_C foreign key (Cid) references Classroom(Cid)
)ENGINE=innoDB default charset=utf8;


#供应商表
drop table if EXISTS provider;
create table provider(
Pid varchar(10) primary key,
Pname varchar(20)not null
)ENGINE=innoDB default charset=utf8;

#设置外键
#删除外键
alter table Provider drop foreign key  FK_Good;
#添加外键，级联删除 级联更新
alter table Provider add Constraint FK_Good foreign key (Gid) references Goods(Gid) ON delete cascade on update cascade;


#商品表
drop table if EXISTS Goods;
create table Goods(
Gid varchar(10) primary key,
Gname varchar(20) not null
)ENGINE=innoDB default charset=utf8;


#商品供应商链接表
drop table if EXISTS Goods_Provider;
create table Goods_Provider(
pg_id int auto_increment,
Gid varchar(10) ,
Pid varchar(10) ,
num int,
constraint PRI  primary key (pg_id),
constraint FK_G foreign key (Gid) references Goods(Gid),
constraint FK_P foreign key (Pid) references provider(Pid)
)ENGINE=innoDB default charset=utf8;

#查询语句
select * from Student;
select * from Teacher;
select * from Provider;
select * from Goods;
select * from Goods_Provider;
select * from Classroom;
select * from C_Students;

#查询表结构
DESC teacher;
DESC cartitem;

																						#更改数据库字符集
alter DATABASE demo_hibernate character set utf8;
#更改表字符集
alter table student convert to character  set utf8;
alter table Teacher convert to character  set utf8;

#插入Classroom的数据
INSERT INTO Classroom (Cid,Cname) values('C01','一班'),('C02','二班'),('C03','三班');
#插入C_Students表数据
INSERT INTO C_Students values('S01','大萨达','C01'),('S02','硕大的萨达','C01'),('S03','大的达','C02'),('S04','大硕大的','C02'),('S05','大更改达','C03');
#插入Student表数据
INSERT INTO Student values('S01','大萨达','T01'),('S02','硕大的萨达','T01'),('S03','大的达','T02'),('S04','大硕大的','T02'),('S05','大更改达','T03');
#插入Teacher表数据
INSERT INTO Teacher values('T01','数学老师'),('T02','语文老师'),('T03','英语老师');
INSERT INTO Teacher values('T04','体育老师'),('T05','物理老师');
#插入Provider表数据
INSERT INTO provider values('P01','好吃点集团'),('P02','腾讯'),('P03','阿里巴巴'),('P04','啦啦'),('P05','大米');
#插入Goods表数据
INSERT INTO Goods values('G01','红酒'),('G02','电脑'),('G03','鱼'),('G04','辣条'),('G05','大米');
#插入Goods_Provider表数据
INSERT INTO Goods_Provider (Gid,Pid,num) value('G02','P05',6);
INSERT INTO Goods_Provider (Gid,Pid,num) value('G03','P03',6);
INSERT INTO Goods_Provider (Gid,Pid,num) value('G03','P05',6);
INSERT INTO Goods_Provider (Gid,Pid,num) value('G04','P02',6);
INSERT INTO Goods_Provider (Gid,Pid,num) value('G03','P04',6);
INSERT INTO Goods_Provider (Gid,Pid,num) value('G05','P05',6);
INSERT INTO Goods_Provider (Gid,Pid,num) value('G03','P01',6);

INSERT INTO Goods_Provider (Gid,Pid,num) value('G01','P03',6);
INSERT INTO Goods_Provider (Gid,Pid,num) value('G01','P05',6);
INSERT INTO Goods_Provider (Gid,Pid,num) value('G01','P02',6);

INSERT INTO Goods_Provider (Gid,Pid,num) value('G03','P01',6);
INSERT INTO Goods_Provider (Gid,Pid,num) value('G05','P01',4);
INSERT INTO Goods_Provider (Gid,Pid,num) value('G02','P01',3);
INSERT INTO Goods_Provider (Gid,Pid,num) value('G04','P01',3);
#删除Goods表数据
delete from Goods where Gid='G01';
#删除C_Students表数据
delete from C_Students where C_Sid= 'S01';
delete from C_Students where Cid= 'C01';

#查询老师表与学生表的(左外连接 - 左表有的数据右表没有与之对应的数据，也会显示出来)
select t.Tid as 老师ID,t.Tname as 老师名字,s.Sid as 学生ID ,s.Sname as 学生名字 from teacher t   LEFT OUTER JOIN  Student s on s.Tid = t.Tid;# where t.Tid ='T01';

#查询老师表与学生表的((右外连接 - 右表有的数据左表没有与之对应的数据，也会显示出来)
select t.Tid as 老师ID,t.Tname as 老师名字,s.Sid as 学生ID ,s.Sname as 学生名字 from teacher t   RIGHT OUTER JOIN  Student s on s.Tid = t.Tid;# where t.Tid ='T01';

#查询老师表与学生表的((内连接)
select t.Tid as 老师ID,t.Tname as 老师名字,s.Sid as 学生ID ,s.Sname as 学生名字 from teacher t   INNER JOIN  Student s on s.Tid = t.Tid;# where t.Tid ='T01';

#多对多表的查询
select gp.pid as 商家Id,p.pname as 商家名,gp.gid as 货品Id,g.gname as 货品名,gp.num as 数量 from Goods_Provider gp,Goods g,Provider p where gp.Gid = g.Gid and gp.Pid = p.Pid and gp.pid = 'P01';




#购物车例子，包括用户表，商品表，购物车表
#用户只有一个购物车，购物车可以有多个商品
drop table if exists User;
create table user(
uid varchar(20),
uname varchar(20),
constraint PK_uid primary key (uid)
)ENGINE=innoDB default charset=utf8;


drop table if exists CartItem;
create table CartItem(
c_id int auto_increment,
uid varchar(20),
com_id varchar(10),
num int,
constraint PK_cart primary key (c_id),
constraint FK_User foreign key (uid) references User(uid),
constraint FK_Com foreign key (com_id) references commodity(com_id)
)engine=InnoDB DEFAULT CHARSET=UTF8;

drop table if exists Commodity;
create table Commodity(
com_id varchar(10),
com_type varchar(10),
com_name varchar(20) ,
constraint PK_com primary key (com_id)
)ENGINE=innoDB default Charset=utf8;


#查询
select * from User;
select * from CartItem;
select * from Commodity;



#插入表数据
insert into User values
('U08','张三'),
('U07','李四'),
('U06','王五'),
('U05','贼六'),
('U01','张三'),
('U02','李四'),
('U03','王五'),
('U04','贼六');



insert into Commodity values 
('C01','酒','红酒'),
('C02','电子产品','电脑'),
('C03','海鲜','鱼'),
('C04','食物','辣条'),
('C05','食物','大米');



insert into CartItem(uid,com_id,num)values 
('U01','C01',3),               
('U01','C02',3),  
('U01','C03',3),  
('U01','C04',3);




#多表查询

select cart.uid,u.uname,cart.com_id,com.com_name,cart.num 
from   CartItem cart, Commodity  com,  User u 
where cart.com_id = com.com_id and cart.uid = u.uid and cart.uid='U01';              
																									#自定义函数（使用myusers表）


#格式化一个时间
select date_format(now(),'%Y年%m月%d日 %H点 ：%i分 ：%s秒')；
select date_format(now(),'%Y年%m月%d日');

#创建一个格式化时间函数
drop function if exists f1;
create function f1() returns varchar(30)
	return  date_format(now(),'%Y年%m月%d日');
#调用函数
select f1() as 当前时间;

#带参数的函数，计算两个数的平均值
drop function if exists f2;
create function f2(num1 smallint unsigned ,num2 smallint unsigned)
	returns Float(10,2) Unsigned
    return (num1+num2)/2;

#调用f2
select  f2(11,19) as 平均值;

#创建复杂结构的函数添加一条数据到myusers
drop function if exists f3;
DELIMITER //
create function f3(u_name varchar(10),u_age smallint unsigned ,u_sex char(2))
returns int unsigned
begin
insert   myUsers(uname,age,sex) value(u_name,u_age,u_sex);
return LAST_INSERT_ID();
end
//
select f3('李四',11,'女');

#函数作为sql语句的一部分
create function f4()
returns varchar(10)
return (select uname from myusers where uid=3);

select * from myusers where uname = f4();

																									#存储过程（使用myusers表）

#简单存储过程  spl_1
create procedure spl_1() 
select version();
#调用spl_1的两种方法(不带参数、带参数)
Call spl_1();

Call spl_1;


#UNSIGNED无符号整型

DROP TABLE IF EXISTS myUsers;
CREATE TABLE myUsers(
uid int Auto_increment ,
uname varchar(10),
age int unsigned,
sex char(2),
PRIMARY KEY (uid),
constraint u_sex check(sex in('男','女'))
)ENGINE=INNODB DEFAULT CHARSET=utf8;

select  * from myUsers;

SELECT ROW_COUNT();
insert into myUsers(uname,age,sex) values
('张三',11,'女'),
('张三',11,'男'),
('张三',21,'女'),
('张三',21,'男'),
('张三',30,'女');
SELECT ROW_COUNT();

#在数据中加入一段字符
update myusers set uname=concat(uname,'#addme') where uid<=5;
#查看插入的数据总数

#解决运行在safe-updates模式下，该模式会导致非主键条件下无法执行update或者delete命令      
SET SQL_SAFE_UPDATES = 0;
#创建带参数in(调用时要带入的参数)的存储过程      
drop procedure if exists removeUserById;			
DELIMITER //
create PROCEDURE removeUserById(IN id varchar(10) )
Begin
delete from myUsers where uid = id;
end
//



DELIMITER //
call removeUserById(1);
//




##创建带参数in(调用时要带入的参数)、out(返回的参数)的存储过程
#nums是局部变量，通过 @nums用户变量 保存输出的 nums局部变量 方便查询输出结果
#局部变量只在begin和end之间有效
drop procedure if exists removeUserByIdAndReturnNums;
DELIMITER //
create procedure removeUserByIdAndReturnNums(IN id varchar(10) ,OUT nums INT unsigned)
begin
	Delete from myUsers where uid = id;
    select count(id) from myUsers INTO nums;
END
//

#调用存储过程
call removeUserByIdAndReturnNums(2,@num);
#查询用户变量
select @num;

#定义用户变量,只对当前用户的客户端有效
set @i = 7;
select @i;


#定义多个out参数,根据age删除数据，并获取剩余数据量还有删除的数据量
drop procedure if exists deletefromAgeReturnusers;
DELIMITER //
create procedure deletefromAgeReturnusers(IN u_age SMALLINT unsigned ,OUT deleteUsers smallint UNSIGNED ,OUT usercount smallint unsigned)
begin
	delete from myUsers where age =u_age;
    select ROW_COUNT() INTO deleteUsers;
    select count(uid) from myUsers  INTO usercount;
end
//

DELIMITER //
call deletefromAgeReturnusers(21,@deleteusers,@usercount);
//

select @deleteusers,@usercount;

																							#触发器                                                                                            


#查看触发器
show triggers;


#创建触发器来使班级表中的班内学生数随着学生的添加自动更新
drop  trigger  if exists tri_StuInsert;
DELIMITER //
create trigger tri_StuInsert after insert
on c_students for each row
begin
declare c int ;
set c = (select Snum from Classroom where Cid = new.Cid);
update Classroom set Snum = c + 1 where Cid= new.Cid; 
end  		
//



#创建触发器来使班级表中的班内学生数随着学生的删除自动更新
#使用 DECLARE 来定义一局部变量，该变量只能在 BEGIN … END 复合语句中使用，并且应该定义在复合语句的开头
drop  trigger  if exists tri_StuDelete;
DELIMITER //
create trigger tri_StuDelete after delete
on c_students for each row
begin
declare c int ;
set c = (select Snum from classroom where cid = old.cid);
update classroom set snum = c-1 where cid = old.cid;
end   
//

																							#游标获取数据
#用游标修改c_students中同个教室学生的名字
drop procedure if exists cursor_1;

delimiter //
create procedure cursor_1(IN C_id varchar(10))
modifies sql data
begin
declare S_id varchar(10);
declare S_name varchar(10) charset utf8;
declare state varchar(10);
declare stu_cursor cursor for select c_sid,c_sname from c_students where cid = C_id; #初始化游标
declare continue handler for not found												#游标循环结束的标志
	begin	
	set state = true;																#设置循环退出的条件
    end;
open stu_cursor;
read_loop:loop																		#循环开始 read_loop为循环的别名
fetch stu_cursor into S_id,S_name;													#抓取游标中的一条数据赋值给局部变量
if state then
	LEAVE read_loop;																#判断游标是否还有数据
end if;    
set S_name = '张三';									
update C_students set C_Sname=S_name where Cid = C_id;								#修改数据
end loop;																			#结束循环
close stu_cursor;																	#关闭游标
end
//

delimiter //
call cursor_1('C01');
//
select * from c_students;

