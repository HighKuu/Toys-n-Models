SELECT *
FROM productlines;
SELECT *
FROM products;
SELECT *
FROM orderdetails;

DESCRIBE productlines;
DESCRIBE products;
DESCRIBE orderdetails;

USE toys_and_models;

-- Logistique : Le stock des 5 produits les plus commandés. (champs : Quantityinstock dans la table product)(productcode)
-- productname , quantityordered
SELECT *
FROM products AS p
INNER JOIN productlines AS pl ON p.productLine = pl.productLine
ORDER BY quantityInStock;
-- Jointure de productLines et products 👆🏼

-- productCode, quantityInStock, quantityOrdered 👈 C'est les champs que j'aimerais avoir.
SELECT p.productname , o.quantityordered, p.quantityInStock
FROM orderdetails AS o
INNER JOIN products AS p ON o.productCode = p.productCode
ORDER BY quantityOrdered DESC
LIMIT 5;
-- Jointure de products et orderdetails 👆🏼

SELECT *
FROM orderdetails AS o
INNER JOIN products AS p ON o.productCode = p.productCode
INNER JOIN productlines AS pl ON p.productLine = pl.productLine;
-- Jointure des 3 tables (products et orderdetails et productLines)

-- new query
SELECT productcode , sum(quantityOrdered) sommeT
FROM orderdetails
GROUP BY productCode
ORDER BY sommeT DESC
LIMIT 10;
-- TEST
SELECT p.productcode, p.productname, quantityInStock, sum(o.quantityOrdered) sumT
FROM products p
INNER JOIN orderdetails o ON o.productcode = p.productcode
GROUP BY productcode
ORDER BY sumT DESC
LIMIT 5
;
-- CQFD
SELECT p.productcode, p.productname, quantityInStock, sum(o.quantityOrdered) sumT
FROM products p
INNER JOIN orderdetails o ON o.productcode = p.productcode
GROUP BY productcode
ORDER BY sumT DESC
LIMIT 5
;


SELECT *
FROM orderdetails;

DESCRIBE orders;
SELECT *
FROM products;
-- KPI David
SELECT
    employeeNumber,
    CONCAT(lastName, " ", firstName) AS name,
    SUM(quantityOrdered * priceEach) AS CADuMoisActuel,
    MAX(YEAR(orderDate)) AS annee,
    CASE MAX(EXTRACT(MONTH FROM orderDate))
		WHEN 1 THEN 'janvier'
		WHEN 2 THEN 'février'
		WHEN 3 THEN 'mars'
		WHEN 4 THEN 'avril'
		WHEN 5 THEN 'mai'
		WHEN 6 THEN 'juin'
		WHEN 7 THEN 'juillet'
		WHEN 8 THEN 'août'
		WHEN 9 THEN 'septembre'
		WHEN 10 THEN 'octobre'
		WHEN 11 THEN 'novembre'
		ELSE 'décembre'
	END AS mois
FROM employees AS e
INNER JOIN customers AS c ON e.employeeNumber = c.salesRepEmployeeNumber
INNER JOIN orders AS ord ON c.customerNumber = ord.customerNumber
INNER JOIN orderDetails AS ordD ON ord.orderNumber = ordD.orderNumber
WHERE EXTRACT(YEAR FROM orderDate) = (
    SELECT EXTRACT(YEAR FROM MAX(orderDate))
    FROM orders
)
AND EXTRACT(MONTH FROM orderDate) = (
    SELECT EXTRACT(MONTH FROM MAX(orderDate))
    FROM orders
)
GROUP BY employeeNumber
ORDER BY CADuMoisActuel DESC
LIMIT 2;



-- KPI supplémentaire (trouver de nouvelles corrélation
-- Recherche
SELECT *, concat(lastName," ",firstname)
FROM employees;
 
