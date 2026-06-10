import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv(r"C:\Users\91726\OneDrive\Desktop\ecommerce_cleaned.csv", encoding="latin1")
df["sales"] = pd.to_numeric(df["sales"], errors="coerce")
df.dropna(subset=["sales"], inplace=True)

print("Shape:", df.shape)
print("Nulls:\n", df.isnull().sum())




total_sales  = round(df["sales"].sum(), 2)
total_profit = round(df["profit"].sum(), 2)
margin       = round(total_profit / total_sales * 100, 2)
loss_orders  = (df["profit"] < 0).sum()

print("Total Sales   :", total_sales)
print("Total Profit  :", total_profit)
print("Profit Margin :", margin, "%")
print("Loss Orders   :", loss_orders)



print("\nSales by Category:")
print(df.groupby("category")["sales"].sum()
        .sort_values(ascending=False).round(2))

print("\nProfit by Segment:")
print(df.groupby("segment")["profit"].sum()
        .sort_values(ascending=False).round(2))

print("\nSales by Year:")
print(df.groupby("year")["sales"].sum().round(2))




# Chart 1 - Sales by Category
df.groupby("category")["sales"].sum()\
  .sort_values().plot(kind="barh",
    color="steelblue",
    title="Total Sales by Category")
plt.xlabel("Total Sales ($)")
plt.tight_layout()
plt.savefig(r"C:\Users\91726\OneDrive\Desktop\sales_by_category.png")
plt.show()

# Chart 2 - Yearly Sales Trend
df.groupby("year")["sales"].sum()\
  .plot(kind="line", marker="o",
    color="green",
    title="Yearly Sales Trend (2011-2014)")
plt.ylabel("Total Sales ($)")
plt.tight_layout()
plt.savefig(r"C:\Users\91726\OneDrive\Desktop\yearly_trend.png")
plt.show()