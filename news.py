from stock_tool import trade as td

pd = td.get_new_stock()
pd.to_csv('./data')
