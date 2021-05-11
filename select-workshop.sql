/*
1)  
a. List all details of all Shippers that the company is dealing with. 
b. List all details of Shippers with the output presented in ascending order of shipper names. 
*/
---1a)
select * from Shippers
---1b)
select * from Shippers order by CompanyName /* asc or  desc*/

/*
2)  
a. List all employees - you need to display only the details of their First Name, Last Name, Title, Date of birth and their city of residence.  
b. Based on the designations (Titles) available in the employees table, can you extract the designation list? 
*/
---2a)
select firstname,lastname,title,birthdate,city from Employees
---2b)
select distinct title from Employees

/*
3) Retrieve the details of all orders made on 19 May 1997 
*/
select * from Orders
where OrderDate='1997-05-19'

/*
4) Retrieve details of all customers that are located in the cities of London or Madrid. 
*/
select * from Customers 
where city='London' or city='Madrid'/* city in ('London','Madrid') */ 

/*
5) List all customers (Customer number and names) who are located in UK.  
The list should be produced in alphabetical order of customer names.  
*/
select customerid,contactname 
from customers 
where country='UK' 
order by contactname /* asc */
 
/*
6) Provide a  list  of Orders (Order IDs and order dates) made by customer whose ID is ¡®Hanar¡¯. 
*/
select orderid,orderdate 
from orders
where customerid='Hanar'
 
/*
7) List the Fully Qualified Names of All Northwind Employees as a single column.  
Fully qualified Names should look like this:  Dr. Venkat Raman OR Ms Esther Tan, 
    where Ms is the Title of courtesy Esther is first name and Tan is last name.  
Hint:  You may need to use string concatenation. 
Is it possible that this is listed in alphabetical order of the last names?  
*/
select (titleofcourtesy+firstname+' '+lastname) 
as QualifiedName
from employees
order by lastname

/*
8) List all Orders (Order number and date) of the orders made by the Customer ¡°Maison Dewey¡± (column: company name).  
   Note: Maison Dewey is the name of the customer. 
*/
select orderid,orderdate from orders
where customerid in
    (select customerid 
	 from customers 
	 where CompanyName='Maison Dewey')
/*using join*/
select o.orderid,o.orderdate
from orders o,customers c
where o.customerid=c.customerid 
and c.companyname='Maison Dewey'

/*
9) Retrieve the details of all Products¡¯ having the word ¡°lager¡± in the product name.  
*/
select * from Products
where ProductName like '%lager%'
 
/*
10) Retrieve the Customer IDs and contact names of all customers who have yet to order any products. 
*/
select customerid,contactname from customers 
where customerid not in(select distinct customerid from orders)

/*
11) Display the average product price. 
*/
select avg(unitprice) from Products

/*
12) Prepare a list of cities where customers reside in.  
The list should not contain any duplicate cities. 
*/
select distinct city from Customers

/*
13) Retrieve the number of customers who has made orders. 
*/
select count(distinct customerid) from orders

/*
14) Retrieve the company name and phone number of customers that do not have any fax number captured.   
*/

select companyname,phone from Customers 
where fax is null

/*
15) Retrieve the total sales made. Assume sales is equal to unit price * quantity. 
*/
select sum(unitprice*quantity) 
as totalsales
from [Order Details]

/*
16) List order ids made by customer 'Alan Out' and 'Blone Coy¡¯ 
*/
select orderid from Orders
where customerid in 
    (select customerid 
	 from customers 
	 where companyname in ('Alan Out','Blone Coy'))

/*
17) Prepare a list of customer ids and the number of orders made by the customers. 
*/
select customerid,count(orderid)
from Orders
group by customerid
 
/*
18) Retrieve company name for the customer id ¡®BONAP¡¯, and also order ids made by him. 
*/
select o.orderid,c.companyname
from orders o,customers c
where o.customerid=c.customerid and c.customerid='BONAP'


/*
19)  a. Retrieve the number of orders made, IDs and company names of all customers that have made more than 10 orders.  
        The retrieved list should be display in the descending order of ¡®number of orders made¡¯. 
     b. Retrieve the number of orders made, IDs and company names for the customer with customer id ¡®BONAP¡¯. 
     c. Retrieve the number of orders made, IDs and company names of all customers that have more orders than customer with customer id ¡®BONAP¡¯.   
*/
--19a)
select count(*),o.customerid,c.companyname
from orders o,customers c
where o.customerid=c.customerid
group by o.customerid,c.companyname
having count(*)>10
order by count(*) desc
--19b)
select count(*),o.customerid,c.companyname
from orders o,customers c
where o.customerid=c.customerid and o.customerid='BONAP'
group by o.customerid,c.companyname
--19c)
select count(*),o.customerid,c.companyname
from orders o,customers c
where c.customerid=o.customerid
group by o.customerid,c.companyname
having count(*)>
    (select count(*)
     from orders o,customers c
	 where c.customerid=o.customerid and c.customerid='BONAP'
	 group by o.customerid)


/*
20)  a. Prepare a Product list belonging to Beverages and Condiments categories (you may use in your SQL statement Categories Codes 1 and 2).  
        The list should be sorted on Product code and Product Name. 
     b. How would the above query change if you are not provided category codes but only the names "Beverages", "Condiments" for retrieval.   
	    Would this require a join or subquery? 
*/
--20a)
select productid,productname
from products
where categoryid in
    (select categoryid 
	 from categories 
	 where categoryid in (1,2))
--20b)
select productid,productname
from products
where categoryid in
    (select categoryid 
	 from categories 
	 where categoryname in ('Beverages','Condiments'))
/* using inner join */
select ProductName 
from Products P
INNER JOIN Categories C ON P.CategoryID=C.CategoryID
where CategoryName in('Beverages','Condiments')


/*
21)  a. How many employees do we have in our organization? 
     b. How many employees do we have in USA? 
*/
--21a)
select count(distinct employeeid) 
as NumOfEmployee
from employees
--21b)
select count(distinct employeeid)
as NumOfEmployee
from employees
where country='USA'

/*
22) Retrieve all details of Orders administered by persons who hold the designation Sales Representative and shipped by United Package. 
*/
select * from orders o,shippers s,employees e
where o.employeeid=e.employeeid
and o.shipvia=s.shipperid
and e.title='Sales Representative'
and s.CompanyName='United Package'

/*
23) Retrieve the names of all employee.  For each employee list the name of his/her manager in adjacent columns.
*/
select (e.firstname+' '+e.lastname) as StaffName,
       (em.firstname+' '+em.lastname) as ManagerName
from employees e,employees em
where e.reportsto=em.employeeid
/* using outer join, all employee will be listed */
select staff.LastName + ' ' + staff.FirstName as Employee,  
       manager.LastName + ' ' + manager.FirstName as Manager
from Employees staff left outer join Employees manager
on staff.ReportsTo = manager.EmployeeID

/*
24) Retrieve the five highest ranking discounted product. "Discounted Product" indicates products with the total largest discount (in dollars) given to customers. 
*/
select top 5 p.productname,
           sum(od.unitprice * od.quantity * od.discount)
from products p,[Order Details] od
where p.productid=od.productid
group by p.productid,p.productname
order by sum(od.unitprice * od.quantity * od.discount) desc


/*
25) Retrieve a list of Northwind¡¯s Customers (names) who are located in cities where there are no suppliers. 
*/
select contactname 
from customers
where city not in (select distinct city from suppliers)

/*
26) List all those cities that have both Northwind¡¯s Supplier and Customers.  
*/
select city from customers
where city in (select distinct city from suppliers)
/* using join */
Select C.City
from Customers C, Suppliers S
where C.City= S.City;

/*
27)  a. Northwind proposes to create a mailing list of its business associates.  
        The mailing list would consist of all Suppliers and Customers collectively called Business Associates here.  
		The details that need to be captured are the Business Associates' Names, Address and Phone. 
     b. Is it possible for you to add on to the same list Northwind's Shippers also.  
	    Since we do not have address of shippers, it is sufficient only phone is included leaving the address column blank. 
*/
--27a)
select companyname,address,phone from customers
union
select companyname,address,phone from suppliers
--27b)
select companyname,address,phone from customers
union
select companyname,address,phone from suppliers
union
select companyname,null,phone from shippers
/* alter 
select c.contactname as BusinessAssociateName,
       c.address,c.phone
from customers c
union
select s.companyname,s.address,s.phone
from suppliers s

select c.contactname as BusinessAssociateName,
       c.address,c.phone
from customers c
union
select s.companyname,s.address,s.phone
from suppliers s
union 
select sh.companyname,null,sh.phone
from shippers sh */

/*
28) Retrieve the manager¡¯s name of the employee who has handled the order 10248. 
*/
select o.orderid,
       e.firstname+' '+e.lastname as StaffName,
       em.firstname+' '+em.lastname as ManagerName
from employees em,employees e,orders o
where o.orderid=10248
and o.employeeid=e.employeeid
and e.reportsto=em.employeeid

/*
29) List the product name and product id with unit price greater than average unit product price. 
*/
select productid,productname
from products
where unitprice>(select avg(unitprice) from products)
 
/*
30) List all the orders (order number and amount ) that exceed $10000 value per order.  
    Amount means Quantity*Price. 
	For the above data: 101 (9362.50) and 104 ( $4950) do not qualify. 
*/
select orderid,sum(unitprice * quantity)
from [Order Details]
group by orderid
having sum(unitprice * quantity)>10000

/*
31) List all the orders that exceed $10000 value per order. 
    Your list should include order number and customer id.  
	For the above data: 101 and 104 do not qualify. 
	Since CustomerID is not part of the table, you should extract CustomerID by Joining the Order and OrderDetails table. 
*/
select od.orderid,sum(od.unitprice * od.quantity),
       c.customerid
from [Order Details] od,orders o,customers c
group by od.orderid,o.orderid,c.customerid,o.customerid
having sum(od.unitprice * od.quantity)>10000
and od.orderid=o.orderid
and o.customerid=c.customerid

/*
32) List all the orders that exceed $10000 value per order. 
    Your list should include order number and customer id and customer name.  
	For the above data: 101 and 104 do not qualify. 
	Since CustomerID is not part of the table, you should extract CustomerID by Joining the Order and OrderDetails table. 
	Since Customer name is not part of either of these tables, this is obtained by further joining Customer Table also. 
*/
select od.orderid,sum(od.unitprice * od.quantity),
       c.customerid,c.companyname
from [Order Details] od,orders o,customers c
group by od.orderid,o.orderid,c.customerid,o.customerid,c.companyname
having sum(od.unitprice * od.quantity)>10000
and od.orderid=o.orderid
and o.customerid=c.customerid

/*
33) List the total orders made by each customer.  
    Your list should have customer id and Amount (Quantity * Price) for each customer. 
	Since CustomerID is not part of the table, you should extract CustomerID by Joining the Order and OrderDetails table.  
	For the above data: CustomerID Amount C001 73055 C003 21760 C004 4950 
*/
select o.customerid,sum(od.unitprice * od.quantity) as Amount
from [Order Details] od,orders o
where od.orderid=o.orderid
group by o.customerid

/*
34) Retrieve the Average Amount of business that a northwind customer provides.  
    The Average Business is total amount for each customer divided by the number of customer. 
	For the above data, the Average Amount  is:   (73055 +  23460 + 4950) / 3 = 33821.67 
*/
select sum(od.unitprice * od.quantity) / count(distinct o.customerid)
from [Order Details] od,orders o
where od.orderid=o.orderid

/*
35) List all customers (Customer id, Customer name) who have placed orders more than the average business that a northwind customer provides.  
    For the above data only customer C001 stands above the average of 33828.67. 
*/
select o.customerid,c.companyname,
       sum(od.quantity*od.unitprice) as amount
from customers c,[Order Details] od,orders o
group by o.customerid,c.companyname,o.customerid,
         c.customerid,od.orderid,o.orderid
having o.customerid=c.customerid and o.orderid=od.orderid 
and sum(od.quantity*unitprice)> (select (select sum(quantity*unitprice)from [Order Details])/count(*) from customers)
/* ´íÎóµÄÀý×Ó 
select c.customerid,c.companyname
from customers c,[Order Details] od,orders o
group by c.customerid,c.companyname,o.orderid,od.orderid,o.customerid
having od.orderid=o.orderid
and o.customerid=c.customerid
and    sum(od.unitprice * od.quantity) >
       (select sum(od.unitprice * od.quantity)
	    / count(distinct o.customerid)
	   from [Order Details] od,orders o
	   where od.orderid=o.orderid) */

/*
36) List the total orders made by each customer.  
    Your list should have customer id and Amount (Quantity * Price) for each customer in the year 1997. 
	(Use year(orderdate) to retrieve the year of the column orderdate) 
	Since Order Number 106 was in Jan 98, it is not included 
	CustomerID Amount C001 62455 C003 23460 C004 4950 
*/
select o.customerid,
       sum(od.unitprice * od.quantity) as Amount
from orders o,[Order Details] od
where o.orderid=od.orderid
and year(o.orderdate)='1997'
group by o.customerid


