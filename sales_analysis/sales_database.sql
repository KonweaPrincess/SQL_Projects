select * from orders
select * from products
select * from aisles
select * from departments

Alter Table orders
Add column order_date date, 
Add column order_status text

Alter Table products
Add column unit_price numeric, 
Add column unit_cost numeric (4,1)

--Ques1 How have the orders changed over time(monthly)?
SELECT TO_CHAR(DATE_TRUNC('MONTH', o.order_date), 'YYYY-MM') AS formatted_date, COUNT(*) AS count_per_month
FROM orders o
GROUP BY formatted_date
ORDER BY formatted_date;

--another way to solve Question1
SELECT extract(month from order_date) AS month,
	   extract(year from order_date) AS year,
       count(*) AS weekly_fluntuation
FROM orders o
where order_date between '2015-01-01' and '2023-04-30'
GROUP BY month,year
ORDER BY month,year;

--Ques2 Are there any weekly fluntuations in the size of orders?
SELECT extract(week from order_date) AS week,
	   extract(year from order_date) AS year,
       count(*) AS weekly_fluntuation
FROM orders o
where order_date between '2015-01-01' and '2015-01-31'
GROUP BY week,year
ORDER BY week,year;

--Ques3 What is the average number of orders placed by day of the week
SELECT DATE_PART('dow', order_date) AS day_of_week,Round(AVG(num_orders), 2) AS avg_orders_per_day
FROM (
    SELECT DATE_TRUNC('day', order_date) AS order_date, COUNT(*) AS num_orders
    FROM orders
    GROUP BY order_date
) AS orders_by_day
GROUP BY day_of_week
ORDER BY day_of_week;

--Ques4 What is the hour of the day with the highest number of orders?
select order_hour_of_day hour_of_day, count(*) total
from orders
group by hour_of_day
order by total desc
limit 1

--Ques5 Which department has the highest average spend per customers? 
Select distinct(o.user_id),d.department, round(avg(dept_count),2) avg_spend
from (select o.user_id, sum(p.unit_price) as dept_count from products p
	 join orders o on p.product_id = o.product_id
	 group by user_id) as unit,
departments d
join products p on d.department_id = p.department_id
join orders o on p.product_id = o.product_id 
group by d.department,o.user_id
order by avg_spend desc

--Ques6 Which product generated more profit?
select p.product_name, sum(p.unit_price - p.unit_cost) profit
from products p
join orders o on p.product_id = o.product_id
group by p.product_name
order by profit desc
limit 1

--Ques7 What are the 3 aisles with most orders and which departments do those orders belong to?
select a.aisle,d.department,count(*) most_orders
from orders o
join products p on o.product_id = p.product_id 
join aisles a on p.aisle_id = a.aisle_id
join departments d on p.department_id = d.department_id
group by a.aisle,d.department
order by most_orders desc
limit 3

--Ques8 Which 3 users generated the highest revenue and how many aisles did they ordered from?
select o.user_id,count(a.aisle) num_aisles ,sum(p.unit_price - p.unit_cost) most_revenue_generated
from orders o
join products p on o.product_id = p.product_id 
join aisles a on p.aisle_id = a.aisle_id
group by o.user_id
order by most_revenue_generated desc
limit 3
