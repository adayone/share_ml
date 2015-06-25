import pandas as pd
import tushare as ts
import os

ids = open('./pure_id', 'r').read().split('\n')
filename = 'data'
count = 0
for id in ids:
    if len(id) < 0:
        continue
    count += 1
    print count
    id = id.split('|')[0]
    df = ts.get_hist_data(id, '2015-06-18')
    if df is None or df.empty:
        continue
    df['code'] = pd.Series(id, index = df.index)
    if os.path.exists(filename):
        df.to_csv(filename, mode='a', header=None)
    else:
        df.to_csv(filename)

