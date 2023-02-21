USE sql_store;
SELECT customer_id, first_name FROM customers;
SELECT * FROM customers WHERE customer_id= 1;
SELECT * FROM customers ORDER BY first_name;

# SELECT 

SELECT first_name, last_name, points FROM customers;

SELECT
	first_name,
    last_name AS 'last name',
    points,
    (points + 10) * 10 AS 'discount factor'
FROM customers;

SELECT state FROM customers;

SELECT DISTINCT state FROM customers;

# Return all the products name, unit price and new price (+ 10%)

SELECT name, unit_price, unit_price * 1.1 AS new_price
FROM products;

# WHERE

SELECT * FROM customers WHERE points > 3000;
SELECT * FROM customers WHERE points <= 3000;

SELECT * FROM customers WHERE state != 'VA';
SELECT * FROM customers WHERE state = 'VA';
SELECT * FROM customers WHERE birth_date > '1990-01-01';

# Get the orders placed this year

SELECT *
FROM orders
WHERE order_date >= '2019-01-01';

# AND, OR and NOT 

SELECT *
FROM customers
WHERE birth_date >= '1990-01-01' AND points > 1000;

SELECT *
FROM customers
WHERE birth_date >= '1990-01-01' OR points > 1000 AND state = 'VA';

SELECT *
FROM customers
WHERE birth_date >= '1990-01-01' OR
	(points > 1000 AND state = 'VA');

SELECT *
FROM customers
WHERE NOT (birth_date >= '1990-01-01' OR points > 1000);

SELECT *
FROM customers
WHERE birth_date <= '1990-01-01' AND points <= 1000;

# From the order_items table get the items for order #6 
# where the total price is > 30

SELECT *
FROM order_items
WHERE order_id = 6 AND unit_price * quantity > 30;

# IN

SELECT *
FROM customers
WHERE state = 'VA' OR state = 'GA' OR state = 'FL';

SELECT *
FROM customers
WHERE state IN ('VA', 'GA','FL');

SELECT *
FROM customers
WHERE state NOT IN ('VA', 'GA','FL');

SELECT *
FROM customers
WHERE state NOT IN ('VA', 'GA','FL');

# Return products with quantity in stock equal to 49, 38, 72

SELECT *
FROM products
WHERE quantity_in_stock IN (49, 38, 72);

# BETWEEN

SELECT *
FROM customers
WHERE points >= 1000 AND  points <= 3000;

SELECT *
FROM customers
WHERE points BETWEEN 1000 AND 3000;

# Return cutomers born between 1/1/1990 and 1/1/2000

SELECT *
FROM customers
WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';

# LIKE

SELECT *
FROM customers
WHERE last_name LIKE 'b%';

SELECT *
FROM customers
WHERE last_name LIKE '%b%';

SELECT *
FROM customers
WHERE last_name LIKE '_____y';

SELECT *
FROM customers
WHERE last_name LIKE 'B____y';

# Get the customers whose adresses contain TRAIL or AVENUE
# and phone numbers end with 9

SELECT *
FROM customers
WHERE address LIKE '%trail%' OR
	  address LIKE '%avenue%';

SELECT *
FROM customers
WHERE phone LIKE '%9';

# REGEXP

SELECT *
FROM customers
WHERE last_name LIKE '%field%';

SELECT *
FROM customers
WHERE last_name REGEXP 'field';

SELECT *
FROM customers
WHERE last_name REGEXP '^br';

SELECT *
FROM customers
WHERE last_name REGEXP 'field$';

SELECT *
FROM customers
WHERE last_name REGEXP '^field|mac|rose';

SELECT *
FROM customers
WHERE last_name REGEXP 'field$|mac|rose';

SELECT *
FROM customers
WHERE last_name REGEXP '[gim]e';

SELECT *
FROM customers
WHERE last_name REGEXP '[a-h]e';

# ^ beginning
# $ end
# | or
# [abcd]
# [a-d]

# Get the customers whose:
# first name are Elka or Ambur

SELECT *
FROM customers
WHERE first_name REGEXP 'Elka|Ambur';

# last name end with EY or ON

SELECT *
FROM customers
WHERE last_name REGEXP 'ey$|on$';

# last names start with MY or contains Se 

SELECT *
FROM customers
WHERE last_name REGEXP '^my|se';

# last names contain B followed by R or U

SELECT *
FROM customers
WHERE last_name REGEXP 'b[r|u]';

# IS NULL

SELECT *
FROM customers
WHERE phone IS NULL;

SELECT *
FROM customers
WHERE phone IS NOT NULL;

# Get the orders that are not shipped

SELECT *
FROM orders
WHERE shipped_date IS NULL;

# ORDER BY

SELECT *
FROM customers
ORDER BY first_name DESC;

SELECT *
FROM customers
ORDER BY state DESC, first_name DESC;

SELECT last_name
FROM customers
ORDER BY state DESC, first_name DESC;

SELECT first_name, last_name, 10 AS points
FROM customers
ORDER BY points, first_name;

SELECT first_name, last_name, 10 AS points
FROM customers
ORDER BY 1, 2; # column numbers

SELECT *, quantity * unit_price AS total_price
FROM order_items
WHERE order_id = 2
ORDER BY total_price DESC;

# LIMIT

SELECT *
FROM customers
LIMIT 3;

SELECT *
FROM customers
LIMIT 6, 3; # 6 offset

# Get the top 3 loyal customers

SELECT *
FROM customers
ORDER BY points DESC
LIMIT 3;

# INNER JOINS

SELECT *
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id;

SELECT order_id, first_name, last_name
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id;

SELECT order_id, orders.customer_id, first_name, last_name
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id;

SELECT order_id, o.customer_id, first_name, last_name
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

SELECT order_id, oi.product_id, quantity, oi.unit_price
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;

# JOINING ACROSS DB

SELECT *
FROM order_items oi
JOIN sql_inventory.products p
	ON oi.product_id = p.product_id;
    
USE sql_inventory;

SELECT *
FROM sql_store.order_items oi
JOIN sql_inventory.products p
	ON oi.product_id = p.product_id;


# SELF JOINS

USE sql_hr;

SELECT *
FROM employees e
JOIN employees m
	ON e.reports_to = m.employee_id;

SELECT
	e.employee_id,
	e.first_name AS employee,
    m.first_name AS manager
FROM employees e
JOIN employees m
	ON e.reports_to = m.employee_id;
    
# JOINING MULTIPLE TABLES

USE sql_store;

SELECT *
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
JOIN order_statuses os
	ON o.status = os.order_status_id;
    
SELECT
	o.order_id,
    o.order_date,
    c.last_name,
    os.name AS status
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
JOIN order_statuses os
	ON o.status = os.order_status_id;

USE sql_invoicing;

SELECT
	p.date,
    p.invoice_id,
    p.amount,
    c.name,
    pm.name AS payment_method
FROM payments p
JOIN clients c
	ON p.client_id = c.client_id
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id;

# COMPOUND JOIN CONDITIONS

USE sql_store;

SELECT *
FROM order_items oi
JOIN order_item_notes oin
	ON oi.order_id = oin.order_id AND oi.product_id = oin.product_id;
    
# IMPLICIT JOIN SYNTAX

SELECT *
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id;

SELECT *
FROM orders o, customers c
WHERE o.customer_id = c.customer_id;

# OUTER JOINS

SELECT
	c.customer_id,
    c.first_name,
    o.order_id
FROM customers c
JOIN orders o
	ON c.customer_id = o.customer_id
ORDER BY c.customer_id; # inner
    
SELECT
	c.customer_id,
    c.first_name,
    o.order_id
FROM customers c
LEFT JOIN orders o
	ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

SELECT
	c.customer_id,
    c.first_name,
    o.order_id
FROM customers c
RIGHT JOIN orders o
	ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

SELECT
	c.customer_id,
    c.first_name,
    o.order_id
FROM orders o
RIGHT JOIN customers c
	ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

SELECT
	p.product_id,
	p.name,
    oi.quantity
FROM products p
LEFT JOIN order_items oi
	ON p.Product_id = oi.product_id;
    
# OUTER JOINS BETWEEN MULTIPLE TABLES

SELECT
	c.customer_id,
    c.first_name,
    o.order_id,
    sh.name AS shipper
FROM customers c
LEFT JOIN orders o
	ON c.customer_id = o.customer_id
LEFT JOIN shippers sh
	ON o.shipper_id = sh.shipper_id
ORDER BY c.customer_id;

SELECT
	o.order_id,
    o.order_date,
    c.first_name AS customer,
    sh.name AS shipper,
    os.name AS status
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
LEFT JOIN shippers sh
	ON o.shipper_id = sh.shipper_id
JOIN order_statuses os
	ON o.status = os.order_status_id;

# SELF OUTER JOINS

USE sql_hr;

SELECT
	e.employee_id,
	e.first_name,
	m.first_name AS manager
FROM employees e
LEFT JOIN employees m
	ON e.reports_to = m.employee_id;

# USING

USE SQL_store;

SELECT
	o.order_id,
    c.first_name
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id;

SELECT
	o.order_id,
    c.first_name,
    sh.name AS shipper
FROM orders o
JOIN customers c
	USING (customer_id)
LEFT JOIN shippers sh
	USING (shipper_id);
    
SELECT *
FROM order_items oi
JOIN order_item_notes oin
	ON oi.order_id = oin.order_id AND
		oi.product_id = oin.product_id;
	
SELECT *
FROM order_items oi
JOIN order_item_notes oin
	USING (order_id, product_id);
    
USE SQL_invoicing;

SELECT
	p.date,
    c.name AS client,
    p.amount,
    pm.name AS payment_method
FROM payments p
JOIN clients c USING (client_id)
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id;
    
# NATURAL JOINS

USE sql_store;

SELECT
	o.order_id,
    c.first_name
FROM orders o
NATURAL JOIN customers c;

# CROSS JOINS 

SELECT
	c.first_name AS customer,
    p.name AS product
FROM customers c
CROSS JOIN products p
ORDER BY c.first_name;

SELECT
	c.first_name AS customer,
    p.name AS product
FROM customers c, products p
ORDER BY c.first_name;

# Do a cross join between shippers and products
#	using the implicit syntax

SELECT
	p.name AS product,
    sh.name AS shipper
FROM products p, shippers sh
ORDER BY sh.name;

#	ant using the explicit syntax

SELECT
	p.name AS product,
    sh.name AS shipper
FROM products p
CROSS JOIN shippers sh
ORDER BY sh.name;

# UNIONS
use sql_store;

SELECT 
	order_id,
    order_date,
    'Active' AS status
FROM orders
WHERE order_date >= '2019-01-01'
UNION
SELECT 
	order_id,
    order_date,
    'Archived' AS status
FROM orders
WHERE order_date < '2019-01-01';

SELECT first_name
FROM customers
UNION
SELECT name
FROM shippers;

SELECT
	customer_id,
    first_name, points,
    'Bronze' AS type
FROM customers
WHERE points < 2000
UNION
SELECT
	customer_id,
    first_name, points,
    'Silver' AS type
FROM customers
WHERE points BETWEEN 2000 AND 3000
UNION
SELECT
	customer_id,
    first_name, points,
    'Gold' AS type
FROM customers
WHERE points > 3000
ORDER BY first_name;

# COLUMN ATTRIBUTES

# SINGLE ROW

INSERT INTO customers
VALUES (DEFAULT, 'John', 'Smith', '1990-01-01', NULL, 'address', 'city', 'CA', DEFAULT);

INSERT INTO customers (first_name, last_name, birth_date, address, city, state)
VALUES ('John', 'Smith', '1990-01-01', 'address', 'city', 'CA');

SELECT *
FROM customers;

# MULTIPLE ROWS

INSERT INTO shippers (name)
VALUES ('shipper1'),
	('shipper2'),
    ('shipper3'),
    ('shipper4');

SELECT *
FROM shippers;

# insert 3 rows in the products table

INSERT INTO products (name, quantity_in_stock, unit_price)
VALUES ('milk', 10, 1),
	('bread', 5, 0.2),
    ('beer', 100, 1.5);
    
SELECT *
FROM products;

# HIERARCHICAL ROWS

INSERT INTO orders (customer_id, order_date, status)
VALUES (1, '2019-01-2', 1);

INSERT INTO order_items
VALUES (LAST_INSERT_ID(), 1, 1, 2.96),
	(LAST_INSERT_ID(), 2, 1, 3.96);

# CREATING A COPY OF A TABLE

CREATE TABLE orders_archived AS
SELECT * FROM orders;

INSERT INTO orders_archived
SELECT *
FROM orders
WHERE order_date < '2019-01-01';

USE sql_invoicing;

CREATE TABLE invoices_Archive AS
SELECT
	i.invoice_id,
    i.number,
    c.name AS client,
    i.invoice_total,
    i.payment_total,
    i.invoice_date,
    i.payment_date,
    i.due_date
FROM invoices i
JOIN clients c
	USING (client_id)
WHERE payment_date IS NOT NULL;

# UPDATING A SINGLE ROW

UPDATE invoices
SET payment_total = 10, payment_date = '2019-03-01'
WHERE invoice_id = 1;

UPDATE invoices
SET payment_total = DEFAULT, payment_date = NULL
WHERE invoice_id = 1;

UPDATE invoices
SET payment_total = invoice_total * 0.5, payment_date = due_date
WHERE invoice_id = 3;

# UPDATING MULTIPLE ROW

UPDATE invoices
SET payment_total = invoice_total * 0.5,
	payment_date = due_date
WHERE client_id = 3;

UPDATE invoices
SET payment_total = invoice_total * 0.5,
	payment_date = due_date
WHERE client_id IN (3, 4);

# WRITE q SQL statement to give + 50 points if birth_date < 1990

USE sql_store;

UPDATE customers
SET points = points + 50
WHERE birth_date < '1990-01-01';

# USING SUBQUERIES IN UPDATE
USE sql_invoicing;

UPDATE invoices
SET payment_total = invoice_total * 0.5,
	payment_date = due_date
WHERE client_id =
	(SELECT client_id
	FROM clients
	WHERE name = 'Myworks');

UPDATE invoices
SET payment_total = invoice_total * 0.5,
	payment_date = due_date
WHERE client_id IN
	(SELECT client_id
	FROM clients
	WHERE state IN ('CA', 'NY'));
    
USE sql_store;

UPDATE orders
SET comments = 'Gold customer'
WHERE customer_id IN
	(SELECT customer_id
	FROM customers
	WHERE points > 3000);
    
# DELETING ROWS

USE sql_invoicing;

DELETE FROM invoices
WHERE client_id = (
	SELECT *
	FROM clients
	WHERE name = 'Myworks');
    
# RESTORING THE DATABASES
