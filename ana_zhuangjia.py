import tushare as ts
import sys

code = sys.argv[1]

#stock_pd = ts.get_stock_basics()
#print stock_pd
#ids = stock_pd.index
#print ids
date = '2015-07-03'
pd = ts.get_tick_data(code, date)
pd['code'] = code
rpd = pd.sort('amount', ascending=False)
rpd.to_csv('data/zj_%s_%s.csv'%(code, date), index=False, encoding='utf-8')
