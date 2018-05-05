																				#sql优化技巧
#查看是否开启慢查询日志
show variables like 'slow_query_log';
#查询日志开启情况
show variables like '%log%';

#打开记录未使用索引的查询日志
set global log_queries_not_using_indexes = on;
#打开查询时间日志
show variables like 'long_query_time';
set global slow_query_log = on;

use sakila;

select * from store limit 10;

show variables like 'slow%';

#man查询日志管理工具mysqldumpslow


--索引的优化