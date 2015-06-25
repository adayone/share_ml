import tushare as ts

def get_new_stock():
    news = ts.get_gem_classified()
    id = news['code']
    return id.apply(lambda x: get_data(x))


def get_data(id):
    df = ts.get_hist_data(x, start='2013-01-01', end='2015-06-20')
    df['code'] = id
    return df
