echo $1
./cmdf sql/rate.sql $1
./cmdf sql/daily_train_new.sql $1
./cmdf sql/vw.sql $1
cat train.sh | sed 's/%{ex}/'$1'/g' > ./real_train.sh
echo $2
./real_train.sh $2

#cat reg_train.sh | sed 's/%{ex}/'$1'/g' > ./real_reg_train.sh
#./real_reg_train.sh
