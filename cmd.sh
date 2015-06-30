./cmdf sql/rate.sql $1
./cmdf sql/daily_train.sql $1
./cmdf sql/vw.sql $1
cat train.sh | sed 's/%{ex}/'$1'/g' > ./real_train.sh
./real_train.sh

#cat reg_train.sh | sed 's/%{ex}/'$1'/g' > ./real_reg_train.sh
#./real_reg_train.sh
