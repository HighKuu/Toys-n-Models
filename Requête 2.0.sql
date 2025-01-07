-- KPI logistique
SELECT p.productcode, p.productname, quantityInStock, sum(o.quantityOrdered) sumT
FROM products p
INNER JOIN orderdetails o ON o.productcode = p.productcode
GROUP BY productcode
ORDER BY sumT DESC
LIMIT 5
;

-- KPI logistique avec le stock plus petit que 50
SELECT p.productcode, p.productname, quantityInStock, sum(o.quantityOrdered) sumT
FROM products p
INNER JOIN orderdetails o ON o.productcode = p.productcode
GROUP BY productcode
HAVING quantityInStock < 200
ORDER BY quantityInStock DESC
;

-- Ranking des stocks

SELECT quantityInStock,productname, somme,
		RANK() OVER(ORDER BY quantityInStock) AS Rank_quantity,
        RANK() OVER(ORDER BY somme) AS Rank_nb_command
FROM 
(SELECT quantityInStock, productname, sum(quantityOrdered) AS somme
FROM products p
INNER JOIN orderdetails o ON o.productcode = p.productcode
GROUP BY productname, quantityInStock) as A
ORDER BY Rank_nb_command ASC;

DESCRIBE orders;
DESCRIBE customers;

-- KPI logistique avec les pays
SELECT p.productcode, p.productname, p.quantityInStock, sum(o.quantityOrdered) sumT
FROM products p
INNER JOIN orderdetails o ON o.productcode = p.productcode
INNER JOIN orders os ON os.orderNumber = o.ordernumber
INNER JOIN customers c ON c.customerNumber = os.customerNumber
GROUP BY productcode
ORDER BY sumT DESC
;

-- Nombre de client

SELECT COUNT(customerNumber)
FROM customers;

-- Nombre d'employées
SELECT  COUNT(firstname) AS nb_total_employ
FROM employees;

-- Nombre de produit proposé
SELECT COUNT(productcode)
FROM products;

-- Amount total
SELECT SUM(amount) AS CA_total
FROM payments;

-- Nombre de pays
SELECT *
FROM products;