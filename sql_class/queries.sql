	CREATE TABLE customers_table(
		customer_id INTEGER NOT NULL PRIMARY KEY,
		customer_name VARCHAR(50),
		customer_gender VARCHAR(1),
		customer_location VARCHAR(3),
		customer_email VARCHAR(50)
	);

	CREATE TABLE products_table(
		product_id VARCHAR(2) NOT NULL PRIMARY KEY,
		product_name VARCHAR(30),
		price INTEGER
	);
	
	CREATE TABLE members_table(
		member_id VARCHAR(3) NOT NULL PRIMARY KEY,
		customer_id INTEGER,
		FOREIGN KEY (customer_id) REFERENCES customers_table(customer_id),
		join_date DATE
	);
	
	CREATE TABLE orders_table(
		order_id VARCHAR(5) NOT NULL PRIMARY KEY,
		customer_id INTEGER REFERENCES customers_table(customer_id),
		order_date DATE,
		product_id VARCHAR(2) REFERENCES products_table(product_id),
		delivery_status VARCHAR(20)
	);
	
	INSERT INTO members_table
	VALUES('M01', 1, '2022-01-07'),
		  ('M02', 2, '2022-01-09'),
		  ('M03', 5, '2022-01-13'),
		  ('M04', 7, '2022-01-15'),
		  ('M05', 4, '2022-01-21');
		  
INSERT INTO products_table
VALUES('P1', 'HP Laptop 15', 180000),
	  ('P2', 'HP ProBook 11', 135000),
	  ('P3', 'Lenovo IdeaPad', 159000),
	  ('P4', 'HP Stream 11', 99000),
	  ('P5', 'Dell Latitude E7270', 234900),
	  ('P6', 'Lenovo V14 G1', 192500);
	  
SELECT *
FROM products_table;
	
SELECT *
FROM members_table;

SELECT *
FROM customers_table;

SELECT *
FROM products_table;

SELECT *
FROM orders_table;

SELECT o.*, p.product_name
FROM orders_table AS o
INNER JOIN products_table AS p ON o.product_id = p.product_id;

-- Q1 Which product was ordered the most and their names?
SELECT products_table.product_name,
		COUNT(products_table.product_name) AS num_of_orders
FROM orders_table
INNER JOIN products_table ON orders_table.product_id = products_table.product_id
GROUP BY products_table.product_name
ORDER BY num_of_orders DESC;

-- Q2 Which customers have ordered the most?
SELECT customers_table.customer_name,
		COUNT(orders_table.order_id) AS num_of_orders
FROM orders_table
JOIN customers_table ON orders_table.customer_id = customers_table.customer_id
GROUP BY customers_table.customer_name
ORDER BY num_of_orders DESC;

-- Q3 Which days did we have the least number of orders?
SELECT order_date,
		COUNT(*) AS num_of_orders
FROM orders_table
GROUP BY order_date
ORDER BY num_of_orders
LIMIT 8;

-- Q4 Which 2 customerss have patronized us the least number of times?
SELECT customers_table.customer_name,
		COUNT(orders_table.order_id) AS num_of_orders
FROM orders_table
JOIN customers_table ON orders_table.customer_id = customers_table.customer_id
GROUP BY customers_table.customer_name
ORDER BY num_of_orders
LIMIT 2;






SELECT customers_table.customer_name,
	  SUM(products_table.price) AS total_price
FROM customers_table 
JOIN orders_table ON customers_table.customer_id = orders_table.customer_id
JOIN products_table ON orders_table.product_id = products_table.product_id
GROUP BY customers_table.customer_name
ORDER BY total_price DESC
LIMIT 1;




SELECT customers_table.customer_gender,
	   AVG(products_table.price) AS average_price
FROM customers_table 
JOIN orders_table  ON customers_table.customer_id = orders_table.customer_id
JOIN products_table  ON orders_table.product_id = products_table.product_id
WHERE customers_table.customer_location = 'USA'
GROUP BY customers_table.customer_gender;



SELECT o.customer_id, 
	SUM(p.price) AS total_amount
FROM orders_table o
JOIN products_table p ON o.product_id = p.product_id
GROUP BY o.customer_id
HAVING SUM(p.price) < 500000



HAVING SUM(p.price) > 500000;



