use sales;
select * from transactions;
SET SQL_SAFE_UPDATES = 0;
Alter table transactions 
add column order_date_valid date;
select Str_to_date(order_date,"%d-%m-%Y") as order_date_valid from transactions;

update transactions
set order_date_valid = str_to_date(order_date,"%d-%m-%Y");
select * from transactions;

/*Revenue Trend (yearwise)*/
select year(order_date_valid), sum(sales_qty*unit_price) as total_revenue from transactions
group by year(order_date_valid)
order by year(order_date_valid) desc;

/*Sales volume by regions*/
select year(order_date_valid) as year, markets.zone, sum(sales_qty) as sales_volume 
from transactions join markets on transactions.market_ID=markets.market_ID
group by markets.zone, year(order_date_valid)
order by year(order_date_valid) desc;

/*Revenue by Markets*/
select markets.markets_name, sum(sales_qty*unit_price) as total_revenue 
from transactions join markets on transactions.market_ID=markets.market_ID
group by markets_name;

/*Sales volume by markets*/
select markets.markets_name, sum(sales_qty) as Sales_volume 
from transactions join markets on transactions.market_ID=markets.market_ID
group by markets_name;

/*Top 5 customers by Revenue*/
select customer_data.custmer_name, customer_data.customer_ID, sales_qty*unit_price as revenue from transactions join customer_data
on transactions.customer_ID=customer_data.customer_ID
group by customer_data.custmer_name
order by revenue desc
limit 5;

/*Bottom 5 customers by Revenue*/
select customer_data.custmer_name, customer_data.customer_ID, sales_qty*unit_price as revenue from transactions join customer_data
on transactions.customer_ID=customer_data.customer_ID
group by customer_data.custmer_name
order by revenue asc
limit 5;

/*Top 5 products by Revenue*/
select product_ID, sales_qty*unit_price as revenue from transactions
group by product_ID
order by revenue desc
limit 5;

/*Bottom 5 products by Revenue*/
select product_ID, sales_qty*unit_price as revenue from transactions
group by product_ID
order by revenue asc
limit 5;