#!/usr/bin/env python
import pandas as pd
from sklearn.metrics import pairwise_distances
from sklearn.preprocessing import scale
import sys
from sqlalchemy import create_engine

num = int(sys.argv[1])
ex = sys.argv[2]


conn = create_engine('sqlite:///share_ml.db')
df = pd.read_sql_table('%s_rate_index_clean'%ex, con=conn) 
rate = pd.DataFrame(list(df.rate_list.str.split(',')))
pairs = pairwise_distances(rate, metric="cosine")
name = df.code
s = pd.DataFrame(pairs, index=name, columns=name)
rs = []
for i in name:
    sim_rs = s.ix[i]
    sim_rs = sim_rs.order()
    # 0 is the largest sim score
    neighour = sim_rs[:num]
    for k in neighour.keys():
        score = round(neighour.get(k), 6)
        print i, k, score
        rs += [(i,k, score)]
rpd = pd.DataFrame(rs, columns=('x', 'y', 'score'))
rpd.to_sql('%s_sim'%ex, conn, if_exists='replace', index=False)
