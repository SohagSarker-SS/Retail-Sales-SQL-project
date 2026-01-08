Drop table if exists retail_sales;
create table retail_sales(
	transactions_id int,
	sale_date date,
	sale_time time,
	customer_id int,
	gender varchar(50),
	age int,
	category varchar(50),
	quantity int,
	price_per_unit float,
	cogs float,
	total_sale float
	);

select * from retail_sales;
	
									-- Data Cleaning
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

select
count (*) from retail_sales;

								-- Data Exploration 

select
count (*) total_sales from retail_sales;
select count (distinct customer_id) from retail_sales;								
select distinct category from retail_sales;

							--- Key questions and answers

 -- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

 select *
 from retail_sales
 where sale_date = '2022-11-05';

 ----Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

 Select *
 from retail_sales 
 where category = 'Clothing'
 and quantity >= 4
 and to_char (sale_date, 'YYYY-MM') = '2022-11'

 ------Q.3 Write a SQL query to calculate the total sales (total_sale) and total orders for each category.
Select
category,
sum(total_sale) as sale_by_category,
count(transactions_id)
from retail_sales
group by 1;

----Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select
Round (avg(age),2)as average_age
from retail_sales
where category = 'Beauty';

----Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select *
from retail_sales 
where total_sale > 1000
limit 50;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category
Select 
category,
gender,
count(transactions_id) as number_of_transactions,
sum(total_sale) as amount_sold
from retail_sales
group by category,gender
Order by gender;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

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


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales

select 
customer_id,
sum (total_sale) as sales
from retail_sales
Group by 1
Order by 2 desc 
limit 5;

--- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

Select 
category,
count(distinct customer_id) as customers
from retail_sales
group by 1

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
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
	

