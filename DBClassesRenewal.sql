Use AdventureWorks2019
Go

Select Distinct PersonType, FirstName
From Person.Person

Select Top 20 * from Person.Person

Select Top 20 FirstName, MiddleName, LastName
From Person.Person
Order By FirstName Desc

Group By
Select Shelf, 
sum(Quantity) As Quantity, sum(Bin) as Bin
From Production.ProductInventory
Group By Shelf Order by Shelf

Having
Select Shelf, 
sum(Quantity) As Quantity, sum(Bin) as Bin
From Production.ProductInventory
Group By Shelf
Having Shelf = 'A'
Order by Shelf

Select Shelf, 
sum(Quantity) As Quantity, sum(Bin) as Bin
From Production.ProductInventory
Where Shelf = 'A'
Group By Shelf

Finds any values that have letter a in any position
Select * From Person.Person Where FirstName Like '%a%'

Finds any values that ends with a
Select * From Person.Person Where FirstName Like '%a'

Finds any values that start with a
Select * From Person.Person Where FirstName Like 'a%'

--Finds 5 letter name ending with 'inda'
Select * From Person.Person Where FirstName Like '_inda'

--Finds 5 which starts with D and have the 3rd letter v 
Select * From Person.Person Where FirstName Like 'D_v__'

Finds name starting with a/b/c letter
Select * from Person.Person Where FirstName  Like '[abc]%'
or like this one (sorting in alphabet way)
Select * from Person.Person Where FirstName  Like '[a-f]%'

Not like
Select * from Person.Person Where FirstName Not Like '[a-c]%'

Select DepID, DepartmentName,
	Case DepartmentName
		When 'IT' Then 'Information Technology'
		When 'Math' Then 'Mathematic'
		
	END As 'Department Long Name'

From Department


CASTING DATA
--convert
Select CONVERT(int, 5.45)

--cast
Select Cast(5.45 as int)

Select FirstName, LastName, ModifiedDate,
		Cast(ModifiedDate as varchar(7)) DateToText
from Person.Person

Select FirstName, LastName, ModifiedDate,
		Convert(varchar(7), ModifiedDate) DateToText
from Person.Person

-----------------------JOIN---------------------

Use Company
Go 
Select EmployeeID, EmployeeName, DepartmentName 
From tableEmployees
Join Department
On tableEmployees.DepID=Department.DepID

Select FirstName, LastName, EmailAddress from Person.Person
Join Person.EmailAddress
On Person.BusinessEntityID=EmailAddress.BusinessEntityID


Select [Name], SalesOrderDetailID
From Production.Product as P
Left Join Sales.SalesOrderDetail as S
On P.ProductID=S.ProductID

Select [Name], SalesOrderDetailID
From Production.Product as P
Right Join Sales.SalesOrderDetail as S
On P.ProductID=S.ProductID
Where [Name] Like '%red'

-----------------------UNION------------------------

Select CurrencyCode --109 rows
From Sales.CountryRegionCurrency
--Union 
Select * --105 rows
From Sales.Currency

Select CurrencyCode --109 rows
From Sales.CountryRegionCurrency
Union  --214 rows
Select CurrencyCode --105 rows
From Sales.Currency 


--------------SUBQUERIES----------------------------

How many Cable Lock has been sold

Select COUNT(*) 
From Sales.SalesOrderDetail
Where ProductID=(
Select ProductID 
From Production.Product
Where [Name] = 'Cable Lock')


Select * 
From Production.Product
Where ProductID IN (Select ProductID
					From Sales.SalesOrderDetail)


Select * 
From Production.Product as P
Where Exists(
				Select ProductID 
				From Sales.SalesOrderDetail as S
				Where P.ProductID = S.ProductID)

Insert Into Person.StateProvince
	Select StateProvinceName 
	From Person.vStateProvinceCountryRegion

Select * 
From Person.StateProvince

-----------------DATETIME FUNCTIONS --------------------------

Select GETDATE()

Select ISDATE('sql server')

Select Day('2020-01-20')-- Year() Month()

Select Day(GETDATE())

Select DatePart(YEAR, '2023-02-13 11:28:29') --Return Int

Intead of Year can be used  - Hour, minute, month, second

Select DateName(MONTH, '2023-05-25 11:55:35') --Return String (Nvarchar)

Select DateAdd(Day, 5, '2023-05-26') -- increase the count of days on N value

Select DateDiff(Year, '2003-01-01', GetDate()) --difference between two dates

Select Convert(varchar, GetDate(), 1) as 'Format-1',
	   Convert(varchar, GetDate(), 2) as 'Format-2',
	   Convert(varchar, GetDate(), 3) as 'Format-3',
	   Convert(varchar, GetDate(), 4) as 'Format-4',
	   Convert(varchar, GetDate(), 5) as 'Format-5',
	   Convert(varchar, GetDate(), 6) as 'Format-6',
	   Convert(varchar, GetDate(), 7) as 'Format-7',
	   Convert(varchar, GetDate(), 10) as 'Format-10'

Select DateDiff(Year, Convert(varchar,BirthDate,7), GetDate())
From HumanResources.Employee

-------------------STRING------------------------------

Select Len('Hello World 2023')

Select Left('Hello World 2023', 3)


Select Trim('Hello World          ')

Select Lower('Hello World 2023')

Select Upper('Hello World 2023')

Select Upper(FirstName), Upper(LastName) 
From Person.Person

Select REVERSE('Hello World 2023')

Select Replace('Hello World 2023', 'Hello', 'Bye')

Select Substring('Hello World 2023', 5, 5)

-------------MATH FUNCTIONS-------------------

Select ABS(-202)

Select Avg(ListPrice)
From Production.Product

Select CEILING(11.01) --12

Select Count(*)
From Production.Product

Select Floor(15.75) -- 15

Select Max(ListPrice)
From Production.Product

Select Min(ListPrice)
From Production.Product

Select Power(2,3)

Select Rand() --Returns a rand number 0-1 

Select Rand()*10 -- Returns a random number  0-10

Select Round(123.321,2) -- rounds the number for N number after dot

Select SQRT(9)

Select Square(5)

Select Sum(ListPrice)
From Production.Product

-------------Transactions---------------------------


Begin Tran
Update Person.Person
Set FirstName = 'Tom'
Where BusinessEntityID = 2

Rollback

Commit

Select *
From Person.Person


---------------SCHEMA----------------------------

Create Schema testSchema
Authorization dbo



Create Table testSchema.Departments(
	ID int Not Null,
	DepartmentName varchar Not Null
)


Create View
Create View VPersonWithEMailAddress As
Select FirstName, LastName, EmailAddress
From Person.Person As P
Join Person.EmailAddress As E
On P.BusinessEntityID = E.BusinessEntityID

Select * from VPersonWithEMailAddress


Create Sequence SequenceObj
Start With 1
Increment By 1


Select Next Value for SequenceObj

Select *
From sys.sequences
Where Name = 'SequenceObj'


Alter Sequence SequenceObj
Restart with 2

Insert Into HumanResources.Department
Values(
		Next Value for SequenceObj, 'K')



-----------------------LOGIN--------------------------------------------------


Create Login NewLogin With Password = '55555555'

Alter Login NewLogin with Name = NewLoginUPD

Alter Login NewLoginUPD With Password = '123456'

Drop Login NewLoginUPD



Create User Test_User For Login [admin]
