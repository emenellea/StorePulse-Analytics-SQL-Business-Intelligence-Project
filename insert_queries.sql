CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    join_date DATE
);

INSERT INTO customers (customer_id, name, city, join_date) VALUES
(1, 'Ali', 'Casablanca', '2022-01-10'),
(2, 'Sara', 'Rabat', '2023-03-15'),
(3, 'Youssef', 'Marrakech', '2021-07-20'),
(4, 'Lina', 'Casablanca', '2024-02-01');

-- 
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

INSERT INTO products (product_id, product_name, category, price) VALUES
(1, 'Laptop', 'Tech', 900),
(2, 'Phone', 'Tech', 600),
(3, 'Chair', 'Furniture', 120),
(4, 'Desk', 'Furniture', 300),
(5, 'Headphones', 'Tech', 80);

--
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date) VALUES
(1, 1, 1, 1, '2024-01-01'),
(2, 2, 2, 2, '2024-01-03'),
(3, 1, 5, 3, '2024-02-10'),
(4, 3, 3, 1, '2023-12-25'),
(5, 4, 4, 1, '2024-02-15'),
(6, 2, 1, 1, '2024-02-20');

                            -- it's time for buisness questions : 
							-- Beginner level
--Q1: show products cheaper than 500 
select*
from products 
where price<500
--Q2: show customers from casablanca 
select*
from customers 
where city = 'Casablanca'
--Q3: count total products 
select 
	count(*)
from products 
--Q4: Find the most expensive product
select* 
from products 
order by price desc 
limit 1
--Q5 :total number of orders
select
	count(*) 
from orders 
--Q6: total qunatity sold 
SELECT 
	SUM(quantity)
FROM orders;  
--Q7: average product price
select
	avg(price)
from products 
--Q8: orders made in 2024
select * 
from orders 
where order_date >= '2024-01-01'
--Q9 : number of customer per city 
select
	city,
	count(*) from customers 
group by city
--Q10: show orders with customer name 
select
	c.name ,
	o.order_id 
from orders o
join customers c
on c.customer_id =o.customer_id
--Q11: show product names in each order
select 
	p.product_name ,
	o.quantity 
from products p
join orders o
on p.product_id = o.product_id 
--Q12:total money per orders
SELECT 
	o.order_id,
	p.price * o.quantity AS total_price
FROM orders o
JOIN products p
ON o.product_id = p.product_id;
--Q13: Find the top 10 products that have been ordered the most (by quantity).”
  select 
	  p.product_name ,
	  sum(o.quantity ) as total_ordered
  from orders o 
  join products p 
  on p.product_id = o.product_id
  group by p.product_name 
  order by total_ordered desc
  limit 10

                -- INTERMEDIATE LEVEL : 
-- Q1: Total revenue of the store ( revenu = price * qunatity) 
select 
	sum(p.price * o.quantity)
from orders o
join products p 
on o.product_id = p.product_id 

--Q2: Revenue per product
select distinct
		p.product_name ,
		p.price * o.quantity as revenue
from products p
join orders o
on o.product_id = p.product_id

--Q3: Revenue per customer
select
	c.name ,
	sum(p.price * o.quantity) as revenue
from orders o 
join products p on o.product_id = p.product_id
join customers c on c.customer_id = o.customer_id 
group by c.name

--Q4:Customer who spent the most
select 
	c.name ,
	sum(p.price * o.quantity) as revenue
from orders o 
join products p on o.product_id = p.product_id
join customers c on c.customer_id = o.customer_id 
group by c.name
order by revenue desc
limit 1 
--Q5: Average order value
SELECT
	AVG(order_total) 
FROM (
    SELECT 
		SUM(p.price * o.quantity) AS order_total
    FROM orders o
    JOIN products p ON o.product_id = p.product_id
    GROUP BY o.order_id
) sub;
--Q6: Customers who spent more than 1000
select 
	c.name, 
	sum(p.price*o.quantity) as spent 
from orders o 
join products p 
on o.product_id = p.product_id
join customers c 
on c.customer_id = o.customer_id 
group by c.name
having sum(p.price*o.quantity) >1000
--Q7: Products never ordered
select
	p.product_name 
from products p 
left join orders o 
on p.product_id = o.product_id
where o.product_id is null 
--Q8:  Customers who never ordered
SELECT 
	c.name 
from customers c 
left join orders o 
on c.customer_id = o.customer_id 
where o.customer_id is null
--Q10: Most recent order per customer
select
	c.name ,
	max(o.order_id) as last_order
from customers c 
left join orders o 
on o.customer_id = c.customer_id 
group by c.name
--Q11: Revenue by category
select 
	p.category,
sum(p.price * o.quantity) as revenue 
from orders o 
join products p 
on o.product_id = p.product_id 
group by p.category

         -- ADVANCED LEVEL 
--Q12: Rank customers by spending
select 
	c.name , 
	sum(p.price * o.quantity) as Spent,
	rank() over( order by sum(p.price * o.quantity) desc ) as ranking
from orders o 
join products p on  o.product_id = p.product_id
join customers c on c.customer_id = o.customer_id
group  by c.name 
--Q13: Running total revenue by date
select 
	o.order_date,
	sum(p.price * o.quantity) as revenue
from orders o 
join products p on o.product_id = p.product_id
group by o.order_date
order by sum(p.price * o.quantity) desc
--Q14: Top product per category
select *
from (select
	p.product_name , 
	p.category,
	sum(o.quantity) as quantity ,
	rank()over (partition by p.category order by sum(o.quantity) desc ) as ranking
from orders o 
join products p on p.product_id = o.product_id 
group by p.product_name , 
	p.category 
	)sub
where ranking =1

--Q15: Monthly Revenue
SELECT
		DATE_TRUNC('month', o.order_date) AS month,
		sum(p.price*o.quantity) AS revenue
from orders o 
join products p 
on p.product_id = o.product_id
group by DATE_TRUNC('month', o.order_date)
order by month
--Q16: Customers with more than 2 orders
SELECT 
    c.name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name
HAVING COUNT(o.order_id) > 2;
--Q17 : Average quantity sold per product
SELECT 
	p.product_name ,
	avg(o.quantity) as avg 
from orders o 
join products p
on o.product_id = p.product_id 
group by p.product_name 
--Q18: Orders above average order value
 select* 
 from
		 (select 
		 		o.order_id, 
		 		sum(o.quantity * p.price ) as total_orders
		 from orders o
		 join products p 
		 on p.product_id = o.product_id
		 group by o.order_id ) sub
 where total_orders > 
			 (select
			 		avg(total_orders)
			 from
				 (select
				 		o.order_id, 
						 sum(o.quantity * p.price ) as total_orders
				 from orders o
				 join products p 
				 on p.product_id = o.product_id
				 group by o.order_id ) avg_sub
				 );

--Q19 : First product purchased by each customer
select*
from (
		select
				p.product_name ,
                c.name ,
				o.order_date,
				row_number () over (PARTITION BY c.customer_id ORDER BY o.order_date) AS rn
		from orders o 
		join customers c on o.customer_id= c.customer_id
		join products p on o.product_id = p.product_id 
		)sub 
where rn=1
--Q20:Customers who bought Tech but not Furniture
select distinct
	c.name
from customers c
join orders o on c.customer_id= o.customer_id
join products p on o.product_id = p.product_id
where p.category ='Tech'
AND o.customer_id not in (
		select 
			o.customer_id 
		from customers c
		join orders o on c.customer_id= o.customer_id
		join products p on o.product_id = p.product_id
		where p.category= 'Furniture'
)
--Q21: Revenue growth month over month
select
	month,
	revenue,
	revenue - lag(revenue) over(order by month ) as growth -- LAG compares with the previous row 
from (Select date_trunc ( 'month' , o.order_date) as month,
		sum(o.quantity * p.price ) as revenue 
from orders o 
join products p on p.product_id = o.product_id
group by date_trunc ( 'month' , o.order_date) 
) sub ;

--Q22:Most active city (by number of orders)
select 
	c.city ,
	count(o.order_id ) as count
from customers c 
join orders o 
on o.customer_id = c.customer_id 
group by c.city 
order by count(o.order_id ) desc
limit 1

--Q23: Product contributing most to each customer
 select* from 
 (SELECT 
 	c.name , 
	p.product_name ,
	sum( p.price * o.quantity ) as revenue , 
	rank() over ( partition by c.customer_id order by  sum( p.price * o.quantity ) desc) as rank
from orders o 
join customers c  on c.customer_id= o.customer_id
join products p  on o.product_id = p.product_id
group by c.name , p.product_name , c.customer_id ) sub
where rank =1 ;
--Q24: Best selling category per month
select*
from (select
		p.category ,
		date_trunc( 'month' , o.order_date ) as month,
		sum(o.quantity) as total_sold , 
		rank() over ( partition by date_trunc( 'month' , o.order_date ) order by sum(quantity) desc) as rank
from orders o 
join products p on o.product_id = p.product_id
group by p.category , month ) sub
where rank=1