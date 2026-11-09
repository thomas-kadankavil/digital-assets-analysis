import os
import numpy as np
import pandas as pd
import yfinance as yf
from fredapi import Fred
import matplotlib.pyplot as plt
from scipy.stats import linregress

# Set up the data folder
data_folder = r"C:\Users\thoma\Documents\UMSL\04_Fall2026\BusinessAnalytics6572\BA\data"
if not os.path.exists(data_folder):
    os.makedirs(data_folder)

# 1. Download market data
tickers = ["SPY", "QQQ", "VTI", "BTC-USD", "ETH-USD"]
print("Getting Yahoo data...")
market_data = yf.download(tickers, start="2014-01-01", end="2026-11-01")["Close"]
market_data.to_csv(data_folder + "\\yfinance_market_data.csv")

# 2. Download FRED data
print("Getting FRED data...")
# Paste your real API key here
fred = Fred(api_key="11ce6e135cbe18336ee9ca337bcd5398") 

sofr = fred.get_series("SOFR")
treasury = fred.get_series("DGS1")
fred_data = pd.DataFrame({"SOFR": sofr, "Treasury_1Y": treasury})
fred_data.to_csv(data_folder + "\\fred_macro_data.csv")

# 3. Clean and merge the data
print("Cleaning data...")
# Use SPY dates to line everything up
dates = market_data["SPY"].dropna().index
clean_market = market_data.reindex(dates)
returns = clean_market.pct_change().dropna(how="all")

clean_fred = fred_data.reindex(dates).ffill()
rf_daily = (clean_fred["Treasury_1Y"] / 100) / 252

# Put it all in one table
final_data = pd.concat([clean_market, clean_fred], axis=1)
returns_data = returns.join(rf_daily.rename("rf_daily"))

# 4. Save clean data
final_data.to_csv(data_folder + "\\clean_prices.csv")
returns_data.to_csv(data_folder + "\\clean_returns.csv")
print("Saved files to", data_folder)

# 5. Make Charts
print("Making charts...")

# Chart A: Prices
fig, axes = plt.subplots(3, 2, figsize=(12, 10))
axes = axes.flatten()

for i in range(len(tickers)):
    ticker = tickers[i]
    axes[i].plot(clean_market.index, clean_market[ticker])
    axes[i].set_title(ticker)
    axes[i].set_ylabel("Price")

axes[5].set_visible(False) # Hide the 6th empty plot
plt.tight_layout()
plt.savefig(data_folder + "\\prices.png")
plt.show()

# Chart B: Growth multiples
first_prices = clean_market.bfill().iloc[0]
growth = clean_market / first_prices

plt.figure(figsize=(10, 6))
for ticker in tickers:
    plt.plot(growth.index, growth[ticker], label=ticker)

plt.yscale("log")
plt.title("Price Growth Since 2014")
plt.ylabel("Multiple (Log Scale)")
plt.legend()
plt.savefig(data_folder + "\\growth_multiple.png")
plt.show()

# 6. Data Checks
print("\n--- Data Checks ---")
print("\nMissing values:")
print(clean_market.isna().sum())

print("\nSummary stats:")
print(returns.describe())

print("\nFinding outliers (>3 std dev):")
for ticker in tickers:
    tick_returns = returns[ticker].dropna()
    mean = tick_returns.mean()
    std = tick_returns.std()
    z_scores = (tick_returns - mean) / std
    outliers = (abs(z_scores) > 3).sum()
    print(f"{ticker} has {outliers} outlier days")

# 7. Stats & Regression
print("\n--- Stats ---")
print("\nCorrelations:")
print(returns[tickers].corr().round(2))

# SPY Histogram
plt.figure(figsize=(8, 5))
plt.hist(returns["SPY"].dropna(), bins=50)
plt.title("SPY Returns")
plt.savefig(data_folder + "\\spy_hist.png")
plt.show()

