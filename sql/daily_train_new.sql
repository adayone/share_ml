-- target 
-- label day close - label yesterday close as label
drop table if exists %{ex}_target;
create table if not exists %{ex}_target 
as
    select 
    t1.code as code,
    t1.date as date,
    (t1.close - t2.close)/t2.close as target 
    from 
    %{ex} t1
join
%{ex} t2
on 
julianday(t1.date) - julianday(t2.date) = 2
and
t1.date >= date('now', '-50 day') 
and
t1.code = t2.code
order by code, date desc
;

-- train
-- join target day and feature day as make features
drop table if exists %{ex}_train;
create table if not exists %{ex}_train
as
select
    t2.date, 
    t2.open, 
    t2.high, 
    t2.close, 
    t2.low, 
    t2.volume, 
    t2.amount, 
    t2.code, 
    t2.delta, 
    t2.rate,
    (julianday(t1.date) - julianday(t2.date)) as day_delta,
    t1.date as label_date,
    t1.target
    from
    %{ex}_target t1
    join
    %{ex} t2
    on
julianday(t1.date) - julianday(t2.date) <= 240
;

-- feature 
drop table if exists %{ex}_feature;
create table if not exists %{ex}_feature
as
select
code, target, label_date,
group_concat(feature, ' ') as feature
from
(
    select code, label_date, target, date,
    printf('open_%d:%s high_%d:%s low_%d:%s close_%d:%s volume_%d:%s amount_%d:%s rate_%d:%s delta_%d:%s',  day_delta, open, day_delta, high, day_delta, low, day_delta, close, day_delta, volume,
    day_delta, amount,
    day_delta, rate,
    day_delta, delta
) as feature,
target
from %{ex}_train
)t1
group by code, label_date, target
;

-- trainset 
-- build trainset from 
drop table if exists %{ex}_train;
create table if not exists %{ex}_train
as
select 
*
from
%{ex}_feature
where
date(label_date) = date('now', '-1 day')
or
date(label_date) = date('now', '-9 day')
or
date(label_date) = date('now', '-3 day')
or
date(label_date) = date('now', '-11 day')
or
date(label_date) = date('now', '-5 day')
or
date(label_date) = date('now', '-13 day')
or
date(label_date) = date('now', '-7 day')
;

-- testset
drop table if exists %{ex}_test;
create table if not exists %{ex}_test
as
select 
*
from
%{ex}_feature
where
date(label_date) = date('now', '-2 day')
or
date(label_date) = date('now', '-8 day')
or
date(label_date) = date('now', '-4 day')
or
date(label_date) = date('now', '-10 day')
or
date(label_date) = date('now', '-6 day')
or
date(label_date) = date('now', '-12 day')
or
date(label_date) = date('now', '-14 day')
;


---- predict
drop table if exists %{ex}_pred_feature;
create table if not exists %{ex}_rate_pred
as
select *
from %{ex}_features
where
julianday('now') = julianday(date) 
order by code, date desc
;


