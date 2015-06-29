import tushare as ts
from pandas import DataFrame
import numpy as np
from datetime import datetime


def get_new_history():
    news = ts.get_gem_classified()
    return get_data_by_column(news)

def get_all_history():
    all = ts.get_stock_basics()
    all = all.reset_index()
    print all
    return get_data_by_column(all)


def get_sz50s_history():
    szs = ts.get_sz50s()
    return get_data_by_column(szs)

def get_zz500s_history():
    zz500s = ts.get_zz500s()
    return get_data_by_column(zz500s)

def get_hs300s_history():
    hs300s = ts.get_hs300s()
    return get_data_by_column(hs300s)

def get_data_by_column(stock_pd):
    ids = stock_pd['code']
    rs = get_data(ids[0])
    for id in ids[1:]:
        code = get_data(id)
        rs = rs.append(code)
    return rs

def get_data(id):
    if id is None:
        return None
    now = datetime.now()
    now_str = now.strftime('20%y-%m-%d')
    print now_str
    df = ts.get_h_data(id, autype='hfq', start='2013-01-01', end=now_str)
    if df is None:
        return None
    df['code'] = id
    delta = df['open'] - df['close']
    rate = delta/df['open']
    df['delta'] = np.round(delta, 3)
    df['rate'] = np.round(rate, 3)
    df = df.reset_index()
    print '~-\/-~'*10
    print id
    print df.columns
    return df
