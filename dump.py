#!/usr/bin/env python
#coding=utf-8
import memcache
import sys
import sqlite3
s = memcache.Client(["127.0.0.1:11211"])
conn = sqlite3.connect('share_ml.db')
cur = conn.cursor()

cur.execute('select trim(code), round(prob,4), round(auc, 3) from daily_pred')
rs = cur.fetchall()
for item in rs:
    key = ('p_' + item[0]).encode('utf-8')
    value = str('%s auc:%s'%(item[1], item[2])).encode('utf-8')
    s.set(key, value)
conn.commit()

cur.execute('select class, round(auc, 3), round(avg(prob), 4) as avg from daily_pred group by class, auc')
dapan = cur.fetchall()
rs = '\nclass auc prob \n'
for item in dapan:
    rs += '%s %s %s \n'%(item[0], item[1], item[2])

cur.execute('select code, round(prob, 4), round(auc, 3) from daily_pred order by auc desc, prob desc limit 10')
rmd = cur.fetchall()
rs += '\ncode prob auc \n'
ss = ''
for item in rmd:
    rs += '%s %s %s\n'%(item[0], item[1], item[2])
    ss += item[0].strip() + ',' 
s.set('-2', 'all prob: '+ rs)
print ss
s.set('-1', ss.rstrip(','))



