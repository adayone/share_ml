drop table if exists daily_pred;
create table if not exists
daily_pred
(
    code varchar(6),
    prob float,
    auc float,
    class varchar(6),
    threshold float
);

.mode csv
.separator \t
.import result/pred daily_pred
