/*
    Topics Covered:
    * - (more details about this in the next sessions)

    1. Database and Schema Creation* 
        - CREATE DATABASE
        - CREATE SCHEMA
    
    2. Table Creation*
        - CREATE TABLE with columns, data types, and constraints
        - Primary Keys
        - Foreign Keys
    
    3. Data Insertion*
        - INSERT INTO for adding sample data to tables
    
    4. Data Retrieval
        - SELECT statement basics
        - Filtering results with WHERE
        - Using DISTINCT to remove duplicates
        - Handling NULL values with IS NULL and IS NOT NULL
        - LIKE and ILIKE for pattern matching
        - Filtering with IN and BETWEEN
    
    5. Sorting and Limiting Results
        - ORDER BY clause for sorting
        - ASC (ascending) and DESC (descending) options
        - LIMIT to restrict the number of results
    
    6. Advanced Queries
        - Using JOIN to combine data from multiple tables
        - Examples of inner joins
    
    7. Date and Time Functions
        - Filtering by date and time ranges

    Note: SQL dialects may vary slightly; adjust syntax as needed for specific SQL environments. These codes were ran in Snowflake.
*/



-- create database
CREATE DATABASE sales_db;
-- create schema
CREATE SCHEMA data_mart;


-- Create table for customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    country VARCHAR(100)
);

-- Create table for products
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTOINCREMENT,
    product_name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL
);
-- Create table for orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTOINCREMENT,
    customer_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
-- FOREIGN KEY (field name of the table you are creating)
-- REFERENCES table_name_source(primary_key from source)


-- Create table for order_items
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTOINCREMENT,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


-- Insert sample customers
INSERT INTO
    customers (
        first_name,
        last_name,
        email,
        phone,
        address,
        city,
        state,
        postal_code,
        country
    )
VALUES
    (
        'Mark',
        'Brown',
        'mark.brown@example.com',
        '555-1235',
        null,
        'Springfield',
        null,
        '62701',
        'USA'
    );

    
-- SELECT - fetch columns in the table
-- * get all columns
-- FROM - gets the table where the data is coming from
-- ; semicolon - is the end of the statement
SELECT
    -- get phone number and email address
    address,
    phone,
    email
FROM
    customers;


    
-- DISTINCT return non duplicate records
SELECT
    DISTINCT *
FROM
    customers;


    
-- WHERE - filters records using field_names and value in that field name
-- WHERE <condition>
SELECT
    *
FROM
    customers
WHERE
    first_name = 'John'; -- finds customers who has John as their first name

   
SELECT
    *
FROM
    customers
WHERE
    customer_id = 1; -- -- finds the customer with id 1



    
SELECT
    'Jayson'; -- select can be used to output or print values as well



    
-- Return the first_name, last_name and Phone number of the customer who is from postal code 62701
select
    first_name,
    last_name,
    phone
from
    customers
where
    postal_code = '62701';


    
-- AND - dapat both conditions are met
-- OR - kahit isang condition ang ma meet
-- NOT - opposite of the filter
-- return all results that do not have 62701 as postal code

-- Return the first_name, last_name and Phone number of the customer who is from postal code 62701 AND email address is jane.smith@example.com
SELECT
    first_name,
    last_name,
    phone
FROM
    customers
WHERE
    postal_code = '62701'
    AND email = 'jane.smith@example.com';



-- find all customers who do not live in postcode 62701
select
    first_name,
    last_name,
    phone
from
    customers
where
    not postal_code = '62701';


    
-- find all customers who do not live in 123 elm st
SELECT
    *
FROM
    CUSTOMERS
where
    address <> '123 Elm St';


    
-- IN - shortcut for or statement especially if one field is only used for filtering but you are looking for multiple values in that single field.
SELECT
    *
FROM
    customers
WHERE
    last_name NOT IN ('Doe', 'Smith'); -- finds all customers with either Doe or Smith as last name



    
-- Insert sample products
INSERT INTO
    products (product_name, description, price, stock_quantity)
VALUES
    (
        'Laptop',
        'A high-performance laptop with 16GB RAM and 512GB SSD.',
        999.99,
        50
    ),
    (
        'Wireless Mouse',
        'A comfortable wireless mouse with long battery life.',
        25.99,
        150
    ),
    (
        'Keyboard',
        'A mechanical keyboard with customizable RGB lighting.',
        79.99,
        75
    );


    
-- > - greater than symbol
-- < - lesser than symbol
SELECT
    *
FROM
    products
WHERE
    price < 30; -- find product prices with greater than 100 pesos




SELECT
    *
FROM
    products
WHERE
    price > 100; -- find products with stock quantity lesser than 100 and prices greater than 70



SELECT
    *
from
    PRODUCTS
where
    stock_quantity < 100
    and price > 70; -- finds all products with quantities lesser than 100 and price greater than 70


    
-- >= greater than  or equal to
-- <= lesser than or equal to
SELECT
    *
FROM
    products
WHERE
    price >= 25
    AND price <= 80;


-- BETWEEN - this can be used in WHERE clause to filter through a range (inclusive of start and end values)
SELECT
    *
FROM
    products
WHERE
    price BETWEEN 25.99
    AND 79.99;




SELECT
    *
FROM
    products
WHERE
    STOCK_QUANTITY BETWEEN 50
    AND 100; -- find products with 50 to 100 quantity

    
-- Insert sample orders
INSERT INTO
    orders (customer_id, order_date, status)
VALUES
    (1, '2024-09-01 10:30:00', 'Shipped'),
    (2, '2024-09-02 14:45:00', 'Pending');





-- find all orders that were placed between Sept 1, 12AM to Sept 1 11PM

SELECT
    *
FROM
    orders
WHERE
    order_date BETWEEN '2024-09-01 00:00:00.000'
    AND '2024-09-01 11:00:00.000'; 


    
-- find all orders that were placed between Sept 1, 11PM to Sept 2 11PM
SELECT
    *
FROM
    orders
WHERE
    order_date BETWEEN '2024-09-01 23:00:00.000'
    AND '2024-09-02 23:00:00.000';


    
-- LIKE -- wildcard search
-- J% -- finding any records STARTING with J
-- %n -- finding any records ENDING with n
-- %o% -- finding any records with o in the middle.


SELECT
    *
FROM
    customers
WHERE
    first_name LIKE '%n'; -- finds all first names ending with n
    

SELECT
    *
FROM
    customers
WHERE
    first_name LIKE 'J%'; -- finds all first names starting with J


-- What if I only know the middle letter of their first name?
SELECT
    *
FROM
    customers
WHERE
    first_name LIKE '%o%'; 



    
-- LIKE case sensitive
-- ILIKE case insensitive

SELECT
    *
FROM
    customers
WHERE
    first_name ILIKE '%N'; -- finds all first names ending with n
    

SELECT
    *
FROM
    customers
WHERE
    first_name ILIKE 'j%'; -- finds all first names starting with j


-- What if I only know the middle letter of their first name?
SELECT
    *
FROM
    customers
WHERE
    first_name ILIKE '%o%'; 



-- How to find missing values?
-- IS NULL - use it to find missing values in a field
-- IS NOT NULL - use it for finding existing records

SELECT
    *
FROM
    customers
WHERE
    address IS NOT NULL;
    
-- what if we want to find missing values in address
SELECT
    *
FROM
    customers
WHERE
    address IS NULL;


    
-- what if I want to find customers who do not have a state registered or their first name starts with J?
SELECT
    *
from
    CUSTOMERS
where
    state is NULL
    or first_name LIKE 'J%';

    
-- ORDER BY -- sorts data ASC / DESC
-- ASC - ascending ( low to high )
-- DESC - descending ( high to low)

SELECT
    *
FROM
    customers
ORDER BY
    customer_id DESC; -- sorts records from high to low according to customer_id
    
SELECT
    *
FROM
    customers
ORDER BY
    postal_code,
    email ASC; -- sorts records from low to high according to (and by priority) postal_code then email


    
-- try to sort the products by quantity from lowest to highest
SELECT
    *
FROM
    products
ORDER BY
    stock_quantity ASC;

    
-- do the opposite
Select
    *
from
    PRODUCTS
order by
    stock_quantity DESC;

    
-- LIMIT - limits result of the query
Select
    *
from
    PRODUCTS
order by
    stock_quantity DESC
LIMIT
    2; -- limits the result to 2 records only

    
-- I only need 1 record from products
Select
    *
from
    PRODUCTS
order by
    stock_quantity DESC
LIMIT
    1;

    
-- Get the top 3 highest
-- Get the top 3 lowest stock (how to get it?)
SELECT
    *
FROM
    products
ORDER BY
    5 ASC -- we can use a number in ORDER BY as a substitute to the actual field name on the 5th position 
LIMIT
    3;

    
-- TOP - works like LIMIT but is appended on the SELECT statement
SELECT
    top 3 *
FROM
    products
ORDER BY
    5 ASC;


-- Sample JOIN that shows the purpose of the primary key and foreign keys.
SELECT
    *
FROM
    customers
JOIN orders ON customers.customer_id = orders.customer_id;


-- Insert sample order items
INSERT INTO
    order_items (order_id, product_id, quantity, price)
VALUES
    (1, 1, 1, 999.99),
    -- Order 1 includes 1 Laptop
    (1, 2, 2, 25.99),
    -- Order 1 includes 2 Wireless Mice
    (2, 3, 1, 79.99);
-- Order 2 includes 1 Keyboard

