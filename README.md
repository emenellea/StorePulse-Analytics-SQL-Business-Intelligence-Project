# StorePulse-Analytics-SQL-Business-Intelligence-Project
 
📌 Project Overview
 
This project analyzes a structured commerce database to extract business insights related to revenue performance, customer behavior, and product trends using advanced SQL techniques.
The goal of this project is to simulate real-world data analysis tasks performed by data analysts in retail and e-commerce environments.

_ Database Schema :
The project is built using three relational tables:
1️/ Customers
•	customer_id (Primary Key)
•	name
•	city
•	join_date
2️/ Products
•	product_id (Primary Key)
•	product_name
•	category
•	price
3️/ Orders
•	order_id (Primary Key)
•	customer_id (Foreign Key)
•	product_id (Foreign Key)
•	quantity
•	order_date
The tables are linked through foreign key relationships between customers, products, and orders.

_ Business Questions Answered :
This project answers 24 business-oriented analytical questions including:
•	What is the total store revenue?
•	Who are the top spending customers?
•	What is the customer lifetime value?
•	Which product categories generate the highest revenue?
•	What is the monthly revenue trend?
•	How does revenue grow month-over-month?
•	Which customers purchased all products in a category?
•	What are the sales decline periods?

_SQL Concepts Used:
This project demonstrates the use of:
•	INNER JOIN / LEFT JOIN
•	GROUP BY and HAVING
•	Aggregate functions (SUM, AVG, COUNT)
•	Subqueries
•	Window Functions (ROW_NUMBER, RANK, LAG)
•	PARTITION BY
•	Revenue growth calculations
•	Customer segmentation logic
_Key Insights :
•	Revenue is primarily driven by the Tech category.
•	A small group of customers contributes the majority of total revenue.
•	Month-over-month revenue shows growth with occasional decline periods.
•	Certain products dominate sales performance within their categories.
________________________________________
_ Skills Demonstrated
•	Business-oriented SQL analysis
•	Data modeling understanding
•	KPI calculation
•	Analytical thinking
•	Window function implementation
•	Structured query organization
________________________________________
_ Tools Used :
•	PostgreSQL 
•	SQL
•	Git & GitHub
 
📈Project Purpose:
This project is designed as a portfolio demonstration of intermediate to advanced SQL skills, focusing on practical business analytics use cases.
 
 




