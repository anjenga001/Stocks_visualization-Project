import yfinance as yf
import pandas as pd


tickers = ['MSFT', 'NET', 'ORCL', 'SNPS', 'NTAP']

df = yf.download(tickers, start='2021-01-01', end='2026-01-01')

df = df.stack(level=1).reset_index()
df.rename(columns={'level_1': 'Ticker'}, inplace=True)

df.to_csv('stock_data.csv', index=False)
print('data saved')