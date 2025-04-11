/*Two-table JOINs*/

/*Report the account representative for each customer.*/

SELECT *
FROM customers JOIN orders
	ON customers.customerNumber = orders.customerNumber;

/*Report the total amount of all payments made by 'Atelier graphique.'*/

SELECT customerName, SUM(amount)
FROM customers JOIN payments
	ON customers.customerNumber = payments.customerNumber
WHERE customerName = 'Atelier graphique';

/*What customer has made the most orders?*/

SELECT customerName, COUNT(*) AS orderCount
FROM customers JOIN orders
	ON customers.customerNumber = orders.customerNumber
GROUP BY customerName
ORDER BY orderCount DESC
LIMIT 1;

/*How many orders have been placed by Herkku Gifts?*/

SELECT COUNT(*)
FROM customers JOIN orders
	ON customers.customerNumber = orders.customerNumber
WHERE customerName = 'Herkku Gifts';

/*Who are the employees in Boston?*/

SELECT CONCAT(firstName, ' ', lastName)
FROM employees JOIN offices
	ON employees.officeCode = offices.officeCode
WHERE offices.city = 'Boston';

/*Report those payments greater than $100,000. Sort the report so 
the customer who made the highest payment appears first.*/

SELECT customerName, CONCAT('$', amount)
FROM payments JOIN customers
	ON payments.customerNumber = customers.customerNumber
WHERE payments.amount > 100000
ORDER BY payments.amount DESC;

/*List the dollar value of all 'On Hold' orders.*/

SELECT orders.orderNumber, CONCAT('$', orderdetails.priceEach * orderdetails.quantityOrdered)
FROM orders JOIN orderdetails
	ON orders.orderNumber = orderdetails.orderNumber
WHERE orders.status = 'On Hold';

/*Report the number of orders 'On Hold' for each customer*/

SELECT orders.customerNumber, COUNT(*)
FROM orders JOIN orderdetails
	ON orders.orderNumber = orderdetails.orderNumber
WHERE orders.status = 'On Hold'
GROUP BY orders.customerNumber;

/*Multi-table JOINs*/

/*List products sold by order date.*/

SELECT products.productName, orders.orderDate
FROM products JOIN orderdetails
	ON products.productCode = orderdetails.productCode
    JOIN orders ON orders.orderNumber = orderdetails.orderNumber
ORDER BY orders.orderDate;

/*List the order dates in descending order for orders for the 1940 Ford Pickup Truck.*/

SELECT products.productName, orders.orderDate
FROM products JOIN orderdetails
	ON products.productCode = orderdetails.productCode
    JOIN orders ON orders.orderNumber = orderdetails.orderNumber
WHERE products.productName = '1940 Ford Pickup Truck'
ORDER BY orders.orderDate DESC;

/*List the names of customers and their corresponding order number where a 
particular order from that customer has a value greater than $25,000.*/

SELECT customers.customerName, orders.orderNumber, FORMAT(SUM(orderdetails.quantityOrdered * orderdetails.priceEach), 2)
FROM customers JOIN orders
	ON customers.customerNumber = orders.customerNumber
    JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber
HAVING SUM(orderdetails.quantityOrdered * orderdetails.priceEach) > 25000;

/*Are there any products that don't appear on any orders?*/

SELECT productName
FROM products 
WHERE productCode NOT IN (SELECT productCode 
FROM orderdetails);

/*List the names of products sold at less than 80% of the MSRP.*/

SELECT productName, MSRP, priceEach
FROM products JOIN orderdetails
	ON products.productcode = orderdetails.productcode
WHERE orderdetails.priceEach < products.MSRP * 0.8;

/*Reports those products that have been sold with a markup of 100% or more 
(i.e.,  the priceEach is at least twice the buyPrice)*/

SELECT productName, priceEach, buyPrice
FROM products JOIN orderdetails
	ON products.productcode = orderdetails.productcode
WHERE priceEach >= 2 * buyPrice;

/*List the products ordered on a Monday.*/

SELECT productName, DAYNAME(orderDate)
FROM orders JOIN orderdetails
	USING(orderNumber)
    JOIN products
    USING(productCode)
WHERE DAYNAME(orderDate) = 'Monday';


/*What is the quantity on hand for products listed on 'On Hold' orders?*/

SELECT productName, quantityInStock
FROM orders JOIN orderdetails
	ON orders.orderNumber = orderdetails.orderNumber
    JOIN products ON products.productcode = orderdetails.productcode
WHERE status = 'On Hold';
