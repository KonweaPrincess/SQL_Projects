--working with dates
--Date_Trunc rounds down to the first day of the month
SELECT DATE_TRUNC('MONTH', DATE '2023-06-12')  
--Using extract to select the month of the year
SELECT EXTRACT (MONTH '2023-06-12') 

---SELECT EXTRACT (YEAR FROM order_date)

---RECENT DATE
SELECT NOW()
SELECT EXTRACT (YEAR FROM now())
--INTERVALS
SELECT *
FROM order_table
WHERE order_date <= now() - interval '30 days'

SELECT *
FROM order_table
WHERE order_date <= '2012-04-11' - interval '30 days'

---DISTINCT: to remove duplicates
SELECT EXTRACT(YEAR FROM AGE(DATE '2023-06-12', DATE '1993-06-12'));
---dates and casts
SELECT to_char(DATE '2023-06-12', 'month');
select now()::date

--GROUPING SET AND UNION (RETURNS ONLY UNIQUE VALUE) AND UNION ALL (DOES NOT REMOVES DUPLICATES)

SELECT NULL as shipping_status, p.product_name ----o.deliver_date, p.product_name
FROM order_table o
join products p
on p.product_id = o.product_id
---WHERE deliver_date IS NULL
UNION
SELECT o.deliver_date as shipping_status, p.product_name
FROM order_table o
join products p
on p.product_id = o.product_id
---WHERE deliver_date IS NOT NULL


SELECT o.deliver_date, p.product_name
FROM order_table o
join products p
on p.product_id = o.product_id
WHERE deliver_date IS NULL
UNION
SELECT o.deliver_date, p.product_name
FROM order_table o
join products p
on p.product_id = o.product_id
WHERE deliver_date IS NOT NULL
select * from order_table

select * from products

SELECT p.category, sum(p.price * o.quantity) 
OVER(PARTITION BY p.category)
FROM orders o
JOIN products p
ON o.product_id = p.product_id;


select p.product_name, sum(p.unit_price * o.quantity) as revenue, count(o.order_id) as no_of_orders
FROM order_table o
join products p
on p.product_id = o.product_id
GROUP BY p.product_name

	GROUPING SET(
		(),
		(o.deliver_date)
	);
	
select o.deliver_date, sum(p.unit_price * o.quantity), p.product_name
FROM order_table o
join products p
on p.product_id = o.product_id
GROUP BY
	GROUPING SETS (
		(),
		(o.deliver_date),
		(p.product_name)
	)
	
--show all orders that have been placed in Categories 
select * from order_table
select * from products

EXTRACT (YEAR FROM order_date 
		 
--select * from stock_level		 

WITH product AS (
  SELECT *
  FROM stock_level s
),
orders AS (
  SELECT *
  FROM orders o
)
SELECT --product_name,
		 category,
		 SUM(p.price * o.quantity) as revenue
		 FROM products p
		 JOIN orders o
		 ON p.product_id = o.product_id
		 JOIN stock_level s
		 ON p.product_id = s.stock_id 
GROUP BY GROUPING SETS ((product_name, category))
ORDER BY revenue 
		 

select * from products
select * from orders
select * from stock_level 
		 