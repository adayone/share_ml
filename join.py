#!/usr/bin/env python
#coding=utf-8
import tushare as ts
import pandas as pd
import time

# 行业分类
inds = ts.get_industry_classified()
inds.columns = ('code', 'name', 'industry')
time.sleep(1)
# 概念分类
concepts = ts.get_concept_classified()
concepts.columns = ('code', 'name', 'concept')
time.sleep(1)
# 地域分类
areas = ts.get_area_classified()
areas.columns = ('code', 'name', 'area')

time.sleep(1)
# 中小板块
smalls = ts.get_sme_classified() 

time.sleep(1)
# 创业版
news = ts.get_gem_classified()

time.sleep(1)
# st版块
sts = ts.get_st_classified()

time.sleep(1)
# 沪深300
hss = ts.get_hs300s()

time.sleep(1)
# 上证50
szs = ts.get_sz50s()

time.sleep(1)
# 中证500
zzs = ts.get_zz500s()

time.sleep(1)
# 终止上市
tss = ts.get_terminated()

time.sleep(1)
# 暂停上市
ss = ts.get_terminated()

time.sleep(1)
# 股本
stock_basic = ts.get_stock_basics()

time.sleep(1)

news_basic = news.merge(inds, on='code', how='left').merge(concepts, on='code', how='left').merge(areas, on='code', how='left')
    




