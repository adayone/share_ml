#python history.py
./cmd.sh sz50 $1
./cmd.sh news $1
./cmd.sh zz500 $1
./cmd.sh hs300 $1

echo 'sz50 ' >> result/auc
cat model/sz50_auc >> result/auc
echo 'news ' >> result/auc
cat model/news_auc >> result/auc
echo 'zz500 ' >> result/auc
cat model/zz500_auc >> result/auc
echo 'hs300' >> result/auc
cat model/hs300_auc >> result/auc

python add_auc.py sz50 $1 
python add_auc.py zz500 $1
python add_auc.py hs300 $1
python add_auc.py news $1


cat result/sz50_pred_auc >> result/pred
cat result/news_pred_auc >> result/pred
cat result/zz500_pred_auc >> result/pred
cat result/hs300_pred_auc >> result/pred

./cmdf sql/pred_load.sql

python dump.py
