create database [Library]
use [Library]

--=[ INIT ]=--
create table [dbo].[Books] (
	[Id] int identity(1, 1),
	[Name] nvarchar(80) not null,
	[Author] nvarchar(50) not null,
	[Genre] nvarchar(50) not null,
	[Price] decimal(18, 2) not null,
	[PageCount] int not null,
	[Published] Date default getdate() not null,
	[CreatedDate] Date default getdate() not null

	CONSTRAINT PK_Books PRIMARY KEY (Id)
)


--=[ Part 6 ]=--
INSERT INTO [dbo].[Books]
VALUES ('1984', 'George Orwell', 'Fiction', 3.5, 110, '1948-06-02', '2003-05-23')
		,('Oliver Twist', 'Charles Dickens', 'Adventure', 3.5, 134, '1878-03-14', '2000-02-01')
		,('Dağılma remzleri', 'Çingiz Abdullayev', 'Detective', 11.99, 496, '2004-06-02', '2005-05-23')
		,('Oliqarxın sehvi', 'Çingiz Abdullayev', 'Detective', 6.72, 110, '2005-06-02', '2006-05-23')
		,('The Da Vinci Code', ' Dan Brown', 'Mystery', 16.99, 	689, '2000-06-02', '2003-05-23')

--=[ Part 7 ]=--
select * 
from [dbo].[Books]
order by [Price] DESC

--=[ Part 8 ]=--
select top 3 * 
from [dbo].[Books]
order by [Price] ASC

--=[ Part 9 ]=--
select * 
from [dbo].[Books]
where [Author] = 'Çingiz Abdullayev'

--=[ Part 10 ]=--
update [dbo].[Books]
set [Price] = [Price] * 1.05
where [Author] = 'Çingiz Abdullayev'

--=[ Part 11 ]=--
delete from [dbo].[Books]
where [Price] > 90

--=[ Part 12 ]=--
truncate table [dbo].[Books]
