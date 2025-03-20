use inventory_db;
select * from  final_cleaned_sale_data;

# Total Revenue
SELECT InventoryID, SUM(SalesDollars) AS Total_Revenue
FROM final_cleaned_sale_data
GROUP BY InventoryID;

# Total Units Sold
SELECT InventoryID, SUM(SalesQuantity) AS Total_Units_Sold
FROM Final_Cleaned_Sale_data
GROUP BY InventoryID;

# Gross_Profit_After_Tax 
SELECT 
    InventoryId,
    SUM(SalesPrice * SalesQuantity) AS Total_Revenue,
    SUM(ExciseTax) AS Total_Tax,
    (SUM(SalesPrice * SalesQuantity) - SUM(ExciseTax)) AS Gross_Profit_After_Tax
FROM Final_Cleaned_Sale_data
GROUP BY InventoryId
ORDER BY Gross_Profit_After_Tax DESC;

#Top 5 Brand By Sales 
SELECT 
    Brand,
    SUM(SalesDollars) AS Total_Revenue
FROM Final_Cleaned_Sale_data
GROUP BY Brand
ORDER BY Total_Revenue DESC
LIMIT 5;
#Average Price Per Unit
SELECT 
    InventoryID,
    SUM(SalesDollars) / NULLIF(SUM(SalesQuantity), 0) AS Avg_Price_Per_Unit
FROM Final_Cleaned_Sale_data
GROUP BY InventoryID;

#Revenue_Per_Day (January 2016)
SELECT SalesDate,InventoryID,
SUM(SalesDollars) AS Revenue_Per_Day
FROM Final_Cleaned_Sale_data
GROUP BY SalesDate, InventoryID
ORDER BY SalesDate, InventoryID;

#Top 10 Product by sale revenue
SELECT 
    Description, 
    SUM(SalesDollars) AS Total_Revenue
FROM Final_Cleaned_Sale_data
GROUP BY Description
ORDER BY Total_Revenue DESC
LIMIT 10;

# Sales by Classification
SELECT 
    Classification, 
    SUM(SalesDollars) AS Total_Revenue,
    ROUND(
        (SUM(SalesDollars) / (SELECT SUM(SalesDollars) FROM Final_Cleaned_Sale_data)) * 100, 2
    ) AS Revenue_Percentage
FROM Final_Cleaned_Sale_data
GROUP BY Classification
ORDER BY Revenue_Percentage DESC;

#Top 10 Vendors by Sales Contribution
SELECT 
    VendorName, 
    SUM(SalesDollars) AS Total_Revenue,
    ROUND(
        (SUM(SalesDollars) / (SELECT SUM(SalesDollars) FROM Final_Cleaned_Sale_data)) * 100, 2
    ) AS Revenue_Percentage
FROM Final_Cleaned_Sale_data
GROUP BY VendorName
ORDER BY Total_Revenue DESC
LIMIT 10;