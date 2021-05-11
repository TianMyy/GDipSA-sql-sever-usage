/*UserView Exercise*/
/*
 Exercise Userview1 
 Create a View Customer1998 containing Customer IDs and names, Product IDs and names 
 for customers who have made orders on the year 1998. 
 */
create view Customer1998
as select c.customerid,c.companyname,p.productid,p.productname
from customers c,products p,orders o,[Order Details] od
where c.customerid=o.customerid
and o.orderid=od.orderid
and od.productid=p.productid
and year(o.orderdate)='1998'
group by c.customerid,c.companyname,p.productid,p.productname,o.orderdate
-- use group by to eliminate customer who made the same order before 1998
select * from customer1998

/*
Exercise Userview2 
Using the View Customer1998, retrieve the Customer name, Product name and supplier names 
for the Customers who have made orders on the year 1998 according to Customer Name. 
*/
select c.companyname as customername,p.productname,s.companyname as suppliername
from customer1998 c,suppliers s,products p
where p.supplierid=s.supplierid
and c.productid=p.productid
group by  c.companyname,p.productname,s.companyname


/*
Exercise Userview3 
Retrieve the Customer name and the number of products ordered by them in the year 1998.
*/
/* Mistake
select c.companyname,count(od.quantity) as NumOfProducts
from customers c,[Order Details] od,orders o
where c.customerid=o.customerid
and o.orderid=od.orderid
group by c.companyname*/
select companyname,count(distinct productid)as NumOfProducts
from customer1998
group by companyname


/*
Exercise Userview4 
--a) Create an Userview to represent total business made by each customer.  
The userview includes two columns: 
¨C The sum of product¡¯s unit price multiplied by quantity ordered by the customer 
¨C Customer id 
--b) Using the userviewcreated, retrieve the Average Amount of business that a northwind customer provides.  
The Average Business is total amount for each customer divided by the number of customer.
*/
--a)
create view CustomerOrderSum
as select o.customerid,sum(od.unitprice * od.quantity) as OrderSum
from orders o,[Order Details] od
where o.orderid=od.orderid
group by o.customerid

select * from CustomerOrderSum

--b)
select sum(OrderSum)/count(customerid)
from CustomerOrderSum


/*
Exercise Userview5
Create an Userviewto represent employee details with employee id, last name and title.
*/
create view EmployeeDetails
as select employeeid,lastname,title
from employees
group by employeeid,lastname,title

select * from EmployeeDetails




/* Procedure EX1 */
create procedure Myprocedure1 
as
begin
  select * from customers 
  where membercategory='A'
end

exec Myprocedure1


/* Procedure EX2 */
create procedure Myprocedure2(@var1 char(2))
as
begin
  select * from customers
  where membercategory=@var1
end

exec  Myprocedure2 @var1='B'
exec  Myprocedure2 @var1='Z'


/* Procedure EX3 
Write a stored procedure that update customer address based on the customer name.
Write statements to test this procedure.
*/


/* Procedure EX4 
Write stored procedure that insert customer record, with input parameters as 
  customer id, customer name, member category, address and postal code.
Write statements to test this procedure.
*/


/*Procedure EX5
Write a stored procedure that delete a customer record based on the customer id.
Write statements to test this procedure.
*/


/*Procedure EX6
Write a stored procedure to retrieve all video code rented by a customer, 
  with customer name as the input parameter. 
Write statements to test this procedure.
*/


