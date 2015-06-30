cat data/train.csv | python reg.py > data/vw_train
cat data/test.csv | python reg.py > data/vw_test
#cat data/vw_train| python format_svm.py > data/svm_train
#cat data/vw_test| python format_svm.py > data/svm_test


rm -rf data/*.cache
rm model/hs300_model_reg.txt
rm model/mode.vw

/usr/local/bin/vw -d data/vw_train \
-c \
-f model/hs300_model_reg.vw \
--ngram 5 \
--passes 1000 \
--holdout_off \
--readable_model model/hs300_model_reg.txt 


cat data/vw_test | awk -F'|' '{print $1}'  > data/gold
/usr/local/bin/vw -d data/vw_test -t -i model/hs300_model_reg.vw -p data/pred_test
cat data/test.csv |  awk -F',' '{print $1}' > data/id
paste data/id data/gold data/pred_test > data/pred_test_cv
/usr/local/bin/perf -roc -files data/gold data/pred_test > model/hs300_auc 
cat model/hs300_auc


cat data/predict.csv | tr -d '"' | sed 's/,/ | /g' > data/vw_pred	
cat data/vw_pred |  awk -F'|' '{print $1}' > data/id
/usr/local/bin/vw -d data/vw_pred -t -i model/hs300_model_reg.vw -p data/pred_day
paste data/id data/pred_day > result/hs300_pred_reg


