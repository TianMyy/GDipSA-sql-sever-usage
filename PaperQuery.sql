/* SQL */

create table ArtPiece
	(ArtPieceId		varchar(6)		not null,
	 Description	varvhar(40)		not null,
	 Type			char(1),
	 Artist			varchar(35),
	 ContactEmail	varchar(35),
	 Primary key(ArtPieceId))

create table Exhibition
	(ExhibitionId	varchar(6)		not null,
	 Venue			varchar(20),
	 ArtPieceId		varchar(6)		not null,
	 DateForm		smalldatetime,
	 DateTo			smalldatetime,
	 Fees			int
	 Primary key(ExhibitionId),
	 Foreign key(ArtPieceId)	references
	 							ArtPiece(ArtPieceId))

select Artist
from ArtPiece
group by Artist
having count(*)>1
/*group by!!!*/

select Venue
from Exhibition
where ArtPieceId 
in (select ArtPieceId in ArtPiece where Artist='Susie Yuen')
/* or */
select e.Venue
from Exhibition e,ArtPiece a
where e.ArtPieceId=a.ArtPieceId
and a.Artist='Susie Yuen'

select a.Artist
from ArtPiece a,Exhibition e
where e.ArtPieceId=a.ArtPieceId
group by a.Artist,e.ArtPieceId
having count(*)>
(select count(*) 
	from Exhibition e,ArtPiece a 
	where e.ArtPieceId=a.ArtPieceId
	and Artist='Susie Yuen')

create procedure myProc(@artpieceid varchar(6))
as
begin
	select Artist
	from ArtPiece
	where ArtPieceId=@artpieceid
end

/*exec myProc @artpieceid='1'*/

create view ExhibitionView
	as 
	select Venue as ExhibitionVenu,ArtPieceId
	from Exhibition
/* create view之后要用view里面的表格和列的名字*/
select e.ExhibitionVenue
from ExhibitionView e,ArtPiece a
where e.ArtPieceId=a.ArtPieceId
and a.Artist='Mark'



/* paper */

--a)
create table Employer
	(EmployerId		varchar(6)		not null,
	 EmployerName	varvhar(40)		not null,
	 Address		varchar(35),
	 ContactEmail	varchar(35),
	 CompanySize	int,
	 primary key(EmployerId))

create table JobAdvert
	(JobAdvertId	varchar(6)		not null,
	 JobTitle		varchar(20),
	 EmployerId		varchar(6),
	 JobDesc		varchar(200),
	 DatePosted		datetime,
	 Qualification	varchar(20),
	 Salary			varchar(35),
	 primary key(JobAdvertId),
	 foreign key(EmployerId))	references
								Employer(EmployerId))

--b)
select JobTitle
from JobAdvert
where EmployerId in 
	(select EmployerId 
	 from Employer 
	 where EmployerName='4S Solution Ltd')
group by JobTitle
having count(*)>1

--c)
select distinct EmployerName
from Employer
where EmployerId in
	(select EmployerId
	 from JobAdvert
	 where JobTitle='UX Designer')

--d)
select e.EmployerName
from Employer e,JobAdvert j
where e.EmployerId=j.EmployerId
group by e.EmployerName,j.EmployerId
having count(*)>
	(select count(*)
	 from Employer e,JobAdvert j
	 where e.EmployerId=j.EmployerId
	 and e.EmployerName='IBMT')

--e)
create procedure myProc(@salary varchar(35),@givenid varchar(6),@giventitle varchar(20))
as
begin
	update JobAdvert
	set Salary=@salary
	where JobTitle=@giventitle
	and EmployerId=@givenid
end

--f)
create view CFOJobView
	as 
	select e.EmployerName as Employer Name,j.Salary as Salary
	from Employer e,JobAdvert j
	where e.EmployerId=j.EmployerId
	and j.JobTitle='CFO'

select count(*)
from CFOJobView