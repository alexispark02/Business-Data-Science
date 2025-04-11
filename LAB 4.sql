
/*1) Report those payments greater than $100,000. Format your output with currency sign, commas, and two decimal places.*/

SELECT CONCAT('$', FORMAT(amount, 2))
FROM payments
WHERE amount > 100000;

/*2) How many products are in each product line?*/

SELECT productline, COUNT(*)
FROM products
GROUP BY productline;

/*3) What is the smallest payment ever paid by customer?*/

SELECT MIN(amount)
FROM payments;

/*4) How many different products does the Classic Models business sell?*/

SELECT COUNT(*)
FROM products;

/*5) Report the number of offices per country for all countries with more than one office.*/

SELECT COUNT(*), country
FROM offices
GROUP BY country
HAVING COUNT(*) > 1;

/*6) Report those payments greater than $100,000. Sort the report so the customer (by number) who made the highest payment appears first.*/

SELECT customerNumber, CONCAT('$', FORMAT(amount, 2))
FROM payments
WHERE amount > 100000
ORDER BY amount DESC;

/*7) List all products that start with a product code S700.*/

SELECT productCode
FROM products
WHERE productCode LIKE 'S700%';

/*8) Who is at the top of the organization (i.e., has no boss)?*/

SELECT CONCAT(firstname, ' ', lastname) AS Name, jobTitle
FROM employees
WHERE reportsTo IS NULL;

/*9) Using a date function Links to an external site, calculate the difference in years between the most recent and oldest order date.*/

SELECT DATEDIFF(MAX(orderDate), MIN(orderDate))/365
FROM orders;

/*10) Compute the average time between order date and ship date for each customer (by number), ordered by the largest difference first.*/

SELECT customerNumber, AVG(DATEDIFF(shippedDate, orderDate))
FROM orders
GROUP BY customerNumber
ORDER BY AVG(DATEDIFF(shippedDate, orderDate)) DESC;

/*11) Report the number of customers in each of the following countries: Japan, China, Korea, and Australia.*/

SELECT COUNT(*), country
FROM customers
WHERE COUNTRY IN ('Japan', 'China', 'Korea', 'Australia')
GROUP BY country;

/*12) How many of each product from the first half of stock (S00s – S50s) have been ordered?*/

SELECT productCode, quantityOrdered
FROM orderdetails
WHERE productCode < 'S60%'
GROUP BY productCode;