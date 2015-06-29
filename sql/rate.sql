drop table if exists %{ex}_rate_index;
create table if not exists %{ex}_rate_index 
(
    code string,
    rate_list string,
    num int
)
;

insert into %{ex}_rate_index 
select 
code,  
trim(group_concat(',', rate), ',') as rate_list,
count(*) as num 
from %{ex}
group by code 
order by num;

drop table if exists %{ex}_rate_index_clean;
create table if not exists %{ex}_rate_index_clean 
(
    code  string,
    rate_list string,
    num int
)
;

insert into %{ex}_rate_index_clean
select t1.code, t1.rate_list, t1.num from 
%{ex}_rate_index t1 
inner join
(select num, count(*) as fre from %{ex}_rate_index group by num order by fre DESC limit 1)t2 
on t1.num = t2.num
;
