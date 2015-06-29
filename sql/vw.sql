.mode csv
.output data/train.csv
select * from %{ex}_rate_train;

.mode csv
.output data/test.csv
select * from %{ex}_rate_test;

.mode csv
.output data/predict.csv
select * from %{ex}_rate_pred_index;
