# Retail Sales Analysis using SQL

## Project Overview
This project focuses on analyzing retail sales data using SQL to extract meaningful business insights.
The goal is to demonstrate strong SQL querying skills, data cleaning, and analytical thinking by answering real-world business questions commonly faced by retail companies.
The analysis covers sales performance, customer behavior, product trends, and time-based insights using structured queries.
## Project Objective
To analyze retail sales data and answer key business questions related to:
1. **Revenue performance**
2. **Product and category demand**
3. **Customer purchasing behavior**
4. **Time-based sales trends**
## Dataset Overview
The dataset contains transaction-level retail sales data, including:
- Transaction ID
- Date & Time of Sale
- Product Category
- Quantity Sold
- Unit Price
- Total Sales Value
- Customer Identifier

Data is imported from CSV and analyzed using structured SQL queries.
## Data Exploration & Cleaning
- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.
```sql
select
count (*) from retail_sales;

select * from retail_sales
limit 5;
Alter Table retail_sales
rename column quantiy to quantity;

Select * from retail_sales
where 
	transactions_id is null
	or sale_date is null
	or sale_time is null
	or customer_id is null 
	or gender is null
	or age is null
	or category is null 
	or quantity is null 
	or price_per_unit is null 
	or cogs is null 
	or total_sale is null;

Delete from retail_sales
where 
	transactions_id is null
	or sale_date is null
	or sale_time is null
	or customer_id is null 
	or gender is null 
	or category is null 
	or age is null
	or quantity is null 
	or price_per_unit is null 
	or cogs is null 
	or total_sale is null;
```
## Key Business Questions Answered
**Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05**
```sql
select *
 from retail_sales
 where sale_date = '2022-11-05';
```
**Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than or equals to 4 in the month of Nov-2022**
```sql
Select *
 from retail_sales 
 where category = 'Clothing'
 and quantity >= 4
 and to_char (sale_date, 'YYYY-MM') = '2022-11'
```
**Q.3 Write a SQL query to calculate the total sales (total_sale) and total orders for each category**
```sql
Select
category,
sum(total_sale) as sale_by_category,
count(transactions_id)
from retail_sales
group by 1;
```
**Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category**
```sql
select
Round (avg(age),2)as average_age
from retail_sales
where category = 'Beauty';
```
**Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000**
```sql
select *
from retail_sales 
where total_sale > 1000
limit 50;
```
**Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category**
```sql
Select 
category,
gender,
count(transactions_id) as number_of_transactions,
sum(total_sale) as amount_sold
from retail_sales
group by category,gender
Order by gender;
```
**Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**
```sql
Select
year,
month,
average_sales
From
(
	Select
	extract (year from sale_date) as year,
	extract (month from sale_date) as month,
	avg (total_sale) as average_sales,
	rank() over(partition by extract (year from sale_date) order by avg (total_sale) desc) as rank
	from retail_sales
	group by 1,2
) as year_rank
where rank = 1;
```
**Q.8 Write a SQL query to find the top 5 customers based on the highest total sales**
```sql
select 
customer_id,
sum (total_sale) as sales
from retail_sales
Group by 1
Order by 2 desc 
limit 5;
```
**Q.9 Write a SQL query to find the number of unique customers who purchased items from each category**
```sql
Select 
category,
count(distinct customer_id) as customers
from retail_sales
group by 1
```
**Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)**
```sql
Select
	case
	when extract (hour from sale_time) < 12 then 'morning'
	when extract (hour from sale_time) between 12 and 17 then 'Afternoon'
	ELSE 'evening'
	end as shifts,
count(transactions_id) as orders
From retail_sales
group by shifts
Order by Orders desc;
```
## Findings
- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.
## Conclusion
This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.
## Author
**Sohag Sarker**<br>
MSc in Economics & Business Administration – Management Accounting
University of Southern Denmark
