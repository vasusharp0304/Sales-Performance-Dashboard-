import pandas as pd
import numpy as np
from pathlib import Path

# Paths
raw_path = Path("train.csv")
clean_path = Path("data/cleaned/cleaned_sales.csv")

# Create directories
clean_path.parent.mkdir(parents=True, exist_ok=True)

# Load data
df = pd.read_csv(raw_path)

print(f"Original shape: {df.shape}")
print(df.head())

# Data Cleaning
df['Order Date'] = pd.to_datetime(df['Order Date'], format='%d/%m/%Y', errors='coerce')
df['Ship Date'] = pd.to_datetime(df['Ship Date'], format='%d/%m/%Y', errors='coerce')

# Drop rows with critical missing dates
df = df.dropna(subset=['Order Date', 'Customer ID'])

# Remove duplicates
df = df.drop_duplicates(subset=['Order ID', 'Row ID'])

# Create new features
df['Year'] = df['Order Date'].dt.year
df['Month'] = df['Order Date'].dt.month
df['Month_Name'] = df['Order Date'].dt.strftime('%b')
df['YearMonth'] = df['Order Date'].dt.strftime('%Y-%m')
df['Shipping_Duration_Days'] = (df['Ship Date'] - df['Order Date']).dt.days
df['Profit_Margin_%'] = (df['Profit'] / df['Sales']) * 100

# Save cleaned data
df.to_csv(clean_path, index=False)
print(f"Cleaned data saved: {clean_path}")
print(f"Final shape: {df.shape}")
