from stock_tools import trade as td
from sqlalchemy import create_engine
import pandas as pd
from pandas import DataFrame
import sys

def binary(row):
    rs = DataFrame(row)
    if float(row['label_rate']) < 0.01 and float(row['label_rate']) > -0.01:
        return None
    else:
        mul = int(abs(100 * row['label_rate']))
        print row['code']
        for i in range(mul - 1):
            rs = rs.append(row)
    return rs

def binary_n(pd):
    rs = pd.copy()
    for row in pd.iterrows():
        row = row[1]
        rows = binary(row) 
        if rows is None:
            continue
        rs = rs.append(rows)
        print len(rs)
        print len(pd)
    return rs



engine = create_engine('sqlite:///share_ml.db')
ex = sys.argv[1]

train = pd.read_sql_table('%s_rate_train'%ex, engine);
test = pd.read_sql_table('%s_rate_test'%ex, engine);
pred = pd.read_sql_table('%s_rate_pred'%ex, engine);


binary_n(train).to_csv('data/train.csv',  if_exists='replace', index=False)
test.to_csv('data/test.csv',  if_exists='replace', index=False)
pred.to_csv('data/pred.csv', if_exists='replace', index=False)
