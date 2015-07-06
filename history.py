from stock_tools import trade as td
from sqlalchemy import create_engine

engine = create_engine('sqlite:///share_ml.db')

sz50s = td.get_sz50s_history()
sz50s.to_sql('sz50', engine, if_exists='replace', index=False)

news = td.get_new_history()
news.to_sql('news', engine, if_exists='replace', index=False)

zz500s = td.get_zz500s_history()
zz500s.to_sql('zz500', engine, if_exists='replace', index=False)

hs300s = td.get_hs300s_history()
hs300s.to_sql('hs300', engine, if_exists='replace', index=False)

whole = td.get_all_history()
whole.to_sql('stock', engine, if_exists='replace', index=False)


