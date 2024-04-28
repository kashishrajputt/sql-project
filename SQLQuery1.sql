create table employeedemographics
(employeeID int,
firstname varchar(50),
latname varchar(50),
age int,
gender varchar(50)
)

create table employeesalary
(employeeID int,
jobtitle varchar(50),
salary int
)

insert into employeedemographics values
(1001,'jim','halpert',30,'male')
insert into employeedemographics values
(1002,'pam','beasley',28,'female'),
(1003,'stanley','hudson',52,'male'),
(1004,'meredith','palmer',35,'female'),
(1005,'dwight','schrute',32,'male'),
(1006,'kevin','malone',32,'male'),
(1007,'angela','martin',28,'female'),
(1008,'phyllis','swan',48,'female'),
(1009,'ryan','howard',28,'male')


insert into employeesalary values
(1001,'salesman',45000),
(1002,'receptionist',25000),
(1003,'salesman',45000),
(1004,'client relation',25000),
(1005,'salesman',45000),
(1006,'accountant',35000),
(1007,'accountant',35000),
(1008,'salesman',45000),
(1009,'temp',15000)

select *
from employeedemographics

select firstname from employeedemographics

select top 5 * from employeedemographics

select distinct(gender) from employeedemographics

select count(latname) from employeedemographics

select count(latname) as lastnamecount from employeedemographics

select * from employeesalary

select max(salary) from employeesalary
select min(salary) from employeesalary
select avg(salary) from employeesalary

select  *
from employeedemographics
where firstname = 'jim'

select  *
from employeedemographics
where firstname <> 'jim'

select  *
from employeedemographics
where age >= 30

/*wildcards*/

select *
from employeedemographics
where latname like 's%'

select *
from employeedemographics
where latname like '%s%'

select *
from employeedemographics
where latname like '%s'

select *
from employeedemographics
where latname like 's%e%'

select *
from employeedemographics
where firstname is NULL

select *
from employeedemographics
where firstname is NOT NULL

select *
from employeedemographics
where firstname IN ('jim','phyllis')

select gender, count(gender) as count
from employeedemographics
group by gender

select gender, age,count(gender) as count
from employeedemographics
group by gender,age

select gender, count(gender) as count
from employeedemographics
where age >30
group by gender

select gender, count(gender) as count
from employeedemographics
where age >30
group by gender
order by count desc

select gender, count(gender) as count
from employeedemographics
where age >30
group by gender
order by gender desc

select *
from employeedemographics
order by age

select *
from employeedemographics
order by age, gender

select *
from employeedemographics


select * from employeesalary

select * from employeedemographics
inner join employeesalary
	on employeedemographics.employeeID = employeesalary.employeeID


select * from employeedemographics
full outer join employeesalary
	on employeedemographics.employeeID = employeesalary.employeeID

select * from employeedemographics
left outer join employeesalary
	on employeedemographics.employeeID = employeesalary.employeeID

select  employeedemographics.employeeID, firstname,age,salary
from employeedemographics
left outer join employeesalary
	on employeedemographics.employeeID = employeesalary.employeeID

select  employeedemographics.employeeID, firstname,age,salary
from employeedemographics
inner join employeesalary
	on employeedemographics.employeeID = employeesalary.employeeID
	where firstname <> 'michael'
	order by salary desc

select firstname, latname, age,
CASE
	when age>30 then 'old'
	else 'young'
END
from employeedemographics
where age is NOT NULL
order by age 

select * from employeedemographics

/* ALIASING
*/

select firstname + '' + latname as  fullname
from employeedemographics

select avg(age) as avgage
from employeedemographics

select demo.employeeID
from employeedemographics as demo

select demo.employeeID, sal.salary
from employeedemographics as demo
join employeesalary as sal
on demo.employeeID=sal.employeeID

/*PARTION BY
*/
select firstname ,latname, gender, salary,
count(gender) over (partition by gender ) as totalgender
from employeedemographics as demo
join employeesalary as sal
on demo.employeeID = sal.employeeID


select firstname ,latname, gender, salary,
count(gender) 
from employeedemographics as demo
join employeesalary as sal
on demo.employeeID = sal.employeeID
group by firstname, latname,gender, salary

/* temp tables
*/

create table #temp_employee (
employeeID int,
jobtitle varchar(20),
salary int
)
select * from #temp_employee

insert into #temp_employee 
select * from employeesalary

drop table if exists #temp_employee2
create table #temp_employee2(
jobtitle varchar(50),
employeeperjob int,
avgage int,
avgsalary int)

insert into #temp_employee2
select jobtitle, count(jobtitle),avg(age), avg(salary)
from employeedemographics as demo
join employeesalary as sal
on demo.employeeID = sal.employeeID
group by jobtitle

select * from #temp_employee2

/*string function
*/

create table employeeerrors(
employeeID int,
firtname varchar(50),
lastname varchar(50)
)
select *  from employeeerrors

insert into employeeerrors values
('1001','jimbo','halpert'),
('   1002','pamela','beasley'),
('1003','toby','flenderon fired')

select employeeID, trim (employeeID) 
from employeeerrors

select lastname, replace(lastname, 'fired','') as lastnamefixed
from employeeerrors

select SUBSTRING(firtname, 3,3)
from employeeerrors

select err.firtname, demo.firstname
from employeeerrors as err
join employeedemographics as demo
on substring(err.firtname,1,3 ) = SUBSTRING(demo.firstname,1,3)

select firtname, lower(firtname)
from employeeerrors
select firtname, upper(firtname)
from employeeerrors

/*store procedure
*/

CREATE PROCEDURE
test as
select * from employeedemographics

execute test

create procedure temp_employee
as
create table #temp_employee(
jobtitle varchar(50),
employeeperjob int,
avgage int,
avgsalary int)

insert into #temp_employee
select jobtitle, count(jobtitle),avg(age), avg(salary)
from employeedemographics as demo
join employeesalary as sal
on demo.employeeID = sal.employeeID
group by jobtitle

select * from #temp_employee
execute temp_employee

/*sub query
*/