echo $1
cat data/train.csv | python binary.py  $1 > data/vw_train
cat data/test.csv | python binary.py  $1 > data/vw_test

#cat data/vw_train| python format_svm.py > data/svm_train
#cat data/vw_test| python format_svm.py > data/svm_test


rm -rf data/*.cache
rm model/news_model.txt
rm model/news_mode.vw

/usr/local/bin/vw -d data/vw_train \
-c \
-f model/news_model.vw \
--ngram 5 \
--passes 1000 \
--holdout_off \
--readable_model model/news_model.txt 


cat data/vw_test | awk -F'|' '{print $1}'  > data/gold
/usr/local/bin/vw -d data/vw_test -t -i model/news_model.vw -p data/pred_test
cat data/test.csv |  awk -F',' '{print $1}' > data/id
paste data/id data/gold data/pred_test > data/pred_test_cv
/usr/local/bin/perf -roc -files data/gold data/pred_test > model/news_auc 
cat model/news_auc


cat data/predict.csv | tr -d '"' | sed 's/,/ | /g' > data/vw_pred	
cat data/vw_pred |  awk -F'|' '{print $1}' > data/id
/usr/local/bin/vw -d data/vw_pred -t -i model/news_model.vw -p data/pred_day
paste data/id data/pred_day > result/news_pred


