cat reg_train.sh | sed 's/%{ex}/'$1'/g' > ./real_reg_train.sh
./real_reg_train.sh
