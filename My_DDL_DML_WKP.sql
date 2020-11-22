/*
1.Create a Table called MemberCategories with the following fields 
MemberCategory  nvarchar(2) 
MemberCatDescription nvarchar(200) 
None of the fields above can be null.  
Set the MemberCategory as the Primary key. 
*/
create table MemberCategories
(MemberCategory			nvarchar(2)		not null,
MemberCatDescription	nvarchar(200)	not null,
primary key(MemberCategory))

/*
2.Add the following data into the MemberCategories Table: 
MemberCategory  MemberCatDescription  
    A             Class A Members  
	B             Class B Members  
	C             Class C Members 
*/
select *  from MemberCategories

insert into MemberCategories
(MemberCategory,MemberCatDescription)
values('A','Class A Members'),
('B','Class B Members'),
('C','Class C Members')
/* 或者A B C分开三个insert和三个value来写 */

/*
3.Create a Table called GoodCustomers with the following fields: 
CustomerName  nvarchar(50)   
Address   nvarchar(65)   
PhoneNumber   nvarchar(9)   
MemberCategory  nvarchar(2)   
Only Customer Name and Phone Number is mandatory. 
Since there could be two customers having the same name, make CustomerName and Phone Number as a composite primary key. 
The MemberCategory should have a referential integrity to the MemberCategories Table so that only those categories that have been listed in MemberCategories Table could be entered.  
*/
create table GoodCustomers
(CustomerName	nvarchar(50)	not null,
Address			nvarchar(65),	
PhoneNumber		nvarchar(9)		not null,
MemberCategory	nvarchar(2),
primary key(CustomerName,PhoneNumber),
foreign key(MemberCategory)references
							MemberCategories(MemberCategory))

/*
4.Insert into GoodCustomer all records form Customer table with corresponding fields except Address, which is to be left Null. 
  Only Customers having Member Category ‘A’ or ‘B’ are good customers hence the table should be inserted only those records from the Customers table. 
*/
select * from GoodCustomers

insert into GoodCustomers
(CustomerName,Address,PhoneNumber,MemberCategory)
select CustomerName,Address,PhoneNumber,MemberCategory 
from Customers
where membercategory in ('A','B')

/*
5.Insert into GoodCustomers the following new customer. 
CustomerName = Tracy Tan PhoneNumber = 736572 MemberCategory = 'B' 
*/
insert into GoodCustomers
(CustomerName,PhoneNumber,MemberCategory)
VALUES('Tracy Tan',736572,'B')


/*
6. Insert into GoodCustomers table the following information for a new customer 
   Since all the columns are provided you may insert the record without specifying the column names. 
   CustomerName = Grace Leong 
   Address = 15 Bukit Purmei Road, Singapore 0904' 
   PhoneNumber = 278865 
   MemberCategory = 'A' 
*/
insert into GoodCustomers
values('Grace Leong','15 Bukit Purmei Road, Singapore 0904',278865,'A')

/*
7. Insert into GoodCustomers table the following information for a new customer Since all the columns are provided you may insert the record without specifying the column names. 
   CustomerName = Lynn Lim 
   Address = 15 Bukit Purmei Road, Singapore 0904' 
   PhoneNumber = 278865 
   MemberCategory = 'P' 
Does the command go through – It should not since member category ‘P’ is not defined in MemberCategories Table. (Violation of referential integrity) 
*/
insert into GoodCustomers
values('Lynn Lim ','15 Bukit Purmei Road, Singapore 0904',278865,'P')

/*
8. Change the Address of Grace Leong so that the new address is '22 Bukit Purmei Road, Singapore 0904' in GoodCustomers table. 
*/
update GoodCustomers
set Address='22 Bukit Purmei Road, Singapore 0904'
where CustomerName='Grace Leong'

/*
9. Change the Member Category to ‘B’ for customer whose Customer ID is 5108 in GoodCustomers table. 
*/
update GoodCustomers
set MemberCategory='B'
where CustomerName in
(select CustomerName from Customers where CustomerID=5108)
/*
-- alternate syntax for SQLServer database
 UPDATE GoodCustomers SET MemberCategory='B'
 FROM Customers c
 WHERE GoodCustomers.CustomerName = c.CustomerName AND c.CustomerID='5108' */

select * from goodcustomers
select * from customers
/*
10. Remove Grace Leong from GoodCustomers table. 
*/
delete from GoodCustomers
where CustomerName='Grace Leong'

/*
11. Remove customers with ‘B’ member category in GoodCustomers table. 
*/
delete from GoodCustomers
where MemberCategory='B'

/*
12. Add column FaxNumber (nvarchar(25)) to GoodCustomers table. 
*/
alter table GoodCustomers
add FaxNumber nvarchar(25)

/*
13. Alter the column Address to nvarchar(80) in GoodCustomers table. 
*/
alter table GoodCustomers
alter column Address nvarchar(80)

/*
14. Add column ICNumber (nvarchar(10)) to GoodCustomers table. 
*/
alter table goodcustomers
add ICNumber nvarchar(10) 

select * from goodcustomers
/*
15. Create a unique index ICIndex on table GoodCustomers bases on ICNumber. 
    Notice that the column ICNumber have no values.  
	Can you create the unique index successfully?  Why? 
*/
create unique index ICIndex_idx
on GoodCUstomers(ICNumber)
-- command failed as there are duplicate values in the column ICNumber (null value in all columns)

/*
16. Create an index on table GoodCustomers based on FaxNumber. 
*/
create index Fax_idx
on GoodCustomers(FaxNumber)

/*
17. Drop the index created on FaxNumber. 
*/
drop index Fax_idx on GoodCustomers
/* --  Alternate syntax for SQL Server
    DROP INDEX GoodCustomers.FaxNumber_idx */

/*
18. Remove the column FaxNumber from GoodCustomer table. 
*/
alter table GoodCustomer
drop column FaxNumber

select * from goodcustomers
/*
19. Delete all records from GoodCustomers. 
*/
delete from GoodCustomers

/*
20. Drop the table GoodCustomers.
*/
drop table GoodCustomers

 

