/* IMPORTANT INSTRUCTIONS FOR LEARNERS
1) DO NOT CHANGE THE ORDER OF COLUMNS.
2) YOUR QUERY SHOULD DISPLAY COLUMNS IN THE SAME ORDER AS MENTIONED IN ALL QUESTIONS.
3) YOU CAN FIND THE ORDER OF COLUMNS IN QUESTION TEMPLATE SECTION OF EACH QUESTION.
4) USE ALIASING AS MENTIONED IN QUESTION TEMPLATE FOR ALL COLUMNS
5) DO NOT CHANGE COLUMN NAMES*/
                   
-- Question 1 (Marks: 2)
-- Objective: Retrieve data using basic SELECT statements
-- List the names of all customers in the database.
-- Question Template: Display CustomerName Column

select customername from customers;

-- Question 2 (Marks: 2)
-- Objective: Apply filtering using the WHERE clause
-- Retrieve the names and prices of all products that cost less than $15.
-- Question Template: Display ProductName Column

select productname
from products
where price < 15
order by price desc;

-- Question 3 (Marks: 2)
-- Objective: Use SELECT to extract multiple fields
-- Display all employees first and last names.
-- Question Template: Display FirstName, LastName Columns

Select firstname, lastname from employees;

-- Question 4 (Marks: 2)
-- Objective: Filter data using a function on date values
-- List all orders placed in the year 1997.
-- Question Template: Display OrderID, OrderDate Columns

select Orderid, year(orderdate) as Orderdate
 from Orders
 having year(Orderdate) = 1997;

-- Question 5 (Marks: 2)
-- Objective: Apply numeric filters
-- List all products that have a price greater than $50.
-- Question Template: Display ProductName, Price Column

select productname, price
from products
where price > 50;

-- Question 6 (Marks: 3)
-- Objective: Perform multi-table JOIN operations
-- Show the names of customers and the names of the employees who handled their orders.
-- Question Template: Display CustomerName, FirstName, LastName Columns

select c.customername, e.firstname, e.lastname
from customers c
Join orders o on c.customerid = o.customerid
join employees e on e.employeeid = o.employeeid;

-- Question 7 (Marks: 3)
-- Objective: Use GROUP BY for aggregation
-- List each country along with the number of customers from that country.
-- Question Template: Display Country, CustomerCount Columns

select country, count(customername) as customercount
from customers
group by country
order by customercount desc;

-- Question 8 (Marks: 3)
-- Objective: Group data by a foreign key relationship and apply aggregation
-- Find the average price of products grouped by category.
-- Question Template: Display CategoryName, AvgPrice Columns

select c.categoryname, avg(p.price) as Avgprice
from categories c
join products p on c.categoryID = p.categoryid
group by categoryname;

-- Question 9 (Marks: 3)
-- Objective: Use aggregation to count records per group
-- Show the number of orders handled by each employee.
-- Question Template: Display EmployeeID, OrderCount Columns

select e.employeeid, count(o.orderid) as ordercount
from employees e
join orders o on e.employeeid = o.employeeid
group by employeeid;

-- Question 10 (Marks: 3)
-- Objective: Filter results using values from a joined table
-- List the names of products supplied by "Exotic Liquids".
-- Question Template: Display ProductName Column

select p.productname
 from products p
 join suppliers s on p.supplierid = s.supplierid
 where s.suppliername = 'exotic liquid';

-- Question 11 (Marks: 5)
-- Objective: Rank records using aggregation and sort
-- List the top 3 most ordered products (by quantity).
-- Question Template: Display ProductID, TotalOrdered Columns

 select p.Productid, count(od.quantity) as Totalordered
 from products p
 join orderdetails od on p.productid = od.productid
group by productid
order by totalordered desc;

-- Question 12 (Marks: 5)
-- Objective: Use GROUP BY and HAVING to filter on aggregates
-- Find customers who have placed orders worth more than $10,000 in total.
-- Question Template: Display CustomerName, TotalSpent Columns

 SELECT c.Customername, SUM(p.price * od.quantity) as TotalSpent
        FROM customers c
        join orders o ON c.customerid = o.customerid
        join orderdetails od ON o.orderid = od.orderid
        join products p on od.productid = p.productid       
        GROUP BY c.customername
        having Totalspent >= 10000;

-- Question 13 (Marks: 5)
-- Objective: Aggregate and filter at the order level
-- Display order IDs and total order value for orders that exceed $2,000 in value.
-- Question Template: Display OrderID, OrderValue Columns

select od.Orderid, sum(od.quantity * p.price) as OrderValue
 from orderdetails od
join products p ON od.productid = p.productid
 group by orderid
 having OrderValue > 2000;

-- Question 14 (Marks: 5)
-- Objective: Use subqueries in HAVING clause
-- Find the name(s) of the customer(s) who placed the largest single order (by value).
-- Question Template: Display CustomerName, OrderID, TotalValue Column

Select c.customername, o.orderid, SUM(od.quantity * p.price) AS totalvalue
from customers c	
join orders o ON c.customerid = o.customerid
join orderdetails od ON o.orderid = od.orderid
join products p ON od.productid = p.productid
GROUP BY c.customername, o.orderid
HAVING totalvalue = (
    select max(order_total) 
    FROM (		
        select SUM(od2.quantity * p2.price) AS order_total
        from orderdetails od2
        join products p2 ON od2.productid = p2.productid
        GROUP BY od2.orderid
    ) AS max_orders	
);		


-- Question 15 (Marks: 5)
-- Objective: Identify records using NOT IN with subquery
-- Get a list of products that have never been ordered.
-- Question Template: Display ProductName Columns

select * from products
 where productid not in
 (select distinct productid
 from products
 where productid is not null);

