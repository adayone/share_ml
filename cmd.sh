./cmdf sql/rate.sql $1
./cmdf sql/daily_train.sql $1
./cmdf sql/vw.sql $1
./train.sh
