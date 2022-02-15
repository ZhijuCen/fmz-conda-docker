'''backtest
start: 2018-02-19 00:00:00
end: 2018-03-22 12:00:00
period: 15m
exchanges: [{"eid":"Bitfinex","currency":"BTC_USD","balance":10000,"stocks":0}]
'''
from fmz import *
task = VCtx(__doc__) # initialize backtest engine from __doc__
print(exchange.GetAccount())
print(exchange.GetTicker())
print(task.Join(True)) # print backtest result
task.Show() # or show backtest chart
