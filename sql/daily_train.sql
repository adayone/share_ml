-- train
drop table if exists %{ex}_rate_delta;
create table if not exists %{ex}_rate_delta
as
select
t1.code as code, 
t1.date as label_date,
t1.rate as label_rate,
t2.date as date,  
t2.rate as rate
from
(
select code, date, rate
from
%{ex}
where 
date >= date('now', '-50 day') 
)
t1
join
%{ex} t2
on t1.code = t2.code
and t2.date < t1.date
and julianday(t1.date) - julianday(t2.date) <= 240
order by code, date desc
;

drop table if exists %{ex}_rate_train;
create table if not exists %{ex}_rate_train
as
select
code,  label_rate,
group_concat(delta, ' ') as rate_list
from
(
    select code, label_date, label_rate, date,
    printf('%d:%s', julianday(label_date) - julianday(date), rate) as delta
    from %{ex}_rate_delta
    where 
        date(label_date) = date('now', '-1 day')
        or
        date(label_date) = date('now', '-2 day')
        or
        date(label_date) = date('now', '-3 day')
        or
        date(label_date) = date('now', '-4 day')
        or
        date(label_date) = date('now', '-5 day')
        or
        date(label_date) = date('now', '-6 day')
        or
        date(label_date) = date('now', '-7 day')
)t1
group by code, label_date, label_rate
;

---- test
drop table if exists %{ex}_rate_test;
create table if not exists %{ex}_rate_test
as
select
code,  label_rate,
group_concat(delta, ' ') as rate_list
from
(
    select code, label_date, label_rate, date,
    printf('%d:%s', julianday(label_date) - julianday(date), rate) as delta
    from %{ex}_rate_delta
    where 

        date(label_date) = date('now', '-11 day')
        or
        date(label_date) = date('now', '-12 day')
        or
        date(label_date) = date('now', '-13 day')
        or
        date(label_date) = date('now', '-14 day')
        or
        date(label_date) = date('now', '-15 day')
        or
        date(label_date) = date('now', '-16 day')
        or
        date(label_date) = date('now', '-17 day')
)t1
group by code, label_date, label_rate
;


---- predict
drop table if exists %{ex}_rate_pred;
create table if not exists %{ex}_rate_pred
as
select code,  date,
printf('%d:%s', julianday('now') - julianday(date), rate) as delta
from %{ex}
where
julianday('now') - julianday(date) <= 240
order by code, date desc
;

drop table if  exists %{ex}_rate_pred_index;
create table if not exists %{ex}_rate_pred_index
as
select
code, 
group_concat(delta, ' ') as rate_list
from
%{ex}_rate_pred
group by code 
;

