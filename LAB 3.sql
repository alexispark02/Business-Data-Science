
/* 1) Report the total payments made to your company by date.*/

SELECT FORMAT(SUM(amount), 2), paymentDate
FROM payments
GROUP BY paymentDate
ORDER BY paymentDate;

/* 2) How many employees are there in the company? */

SELECT COUNT(*)
FROM employees;

/* 3) List the product lines that contain 'Cars'. */

SELECT productLine
FROM ProductLines
WHERE productLine LIKE '%Cars%';

/* 4) Report total payments for October 28, 2004. */

SELECT SUM(amount), paymentDate
FROM payments
WHERE DATE(paymentDate) = '2004-10-28';

/* 5) How many products are in each product line? */

SELECT productLine, COUNT(*)
FROM products
GROUP BY productLine;

/* 6) Report the name and city of customers who don't have sales representatives? */

SELECT customerName, city
FROM customers
WHERE salesRepEmployeeNumber IS NULL;

/*7) What are the names of executives with VP or Manager in their title? Use a function to combine the employee's first name and last name into a single field for reporting. */

SELECT CONCAT(firstName, ' ', lastName) AS Name
FROM employees
WHERE jobTitle LIKE '%VP%' OR jobTitle LIKE '%Manager%';

/* 8) List the customerNumber and the number of orders placed by each. Only return customers with more than ten orders.  */

SELECT customerNumber, COUNT(*)
FROM orders
GROUP BY customerNumber
HAVING COUNT(*) > 10;

/* 9) What is the average percentage markup of the MSRP on buyPrice? */

SELECT CONCAT(FORMAT(AVG(((MSRP - buyPrice) / buyPrice) * 100), 1), '%') AS avg_mrkup
FROM products;

/* 10) Which orders have a value greater than $5,000? */

SELECT orderNumber, FORMAT(SUM(quantityOrdered * priceEach), 2)
FROM orderdetails
GROUP BY orderNumber
HAVING SUM(quantityOrdered * priceEach) > 5000;
