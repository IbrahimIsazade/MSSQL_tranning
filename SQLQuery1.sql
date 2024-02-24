--use [master]

--create database [ShopDb]

create table [dbo].[Sizes] (
	[Id] int primary key identity(1,1),
	[Name] nvarchar(50) not null,
	[SmallName] varchar(10) not null,
	[CreatedAt] datetime default getdate() not null,
	[CreatedBy] int not null,
	[LastModifiedAt] datetime default getdate(),
	[LastModifiedBy] int,
	[DeletedAt] datetime default getdate(),
	[DeletedBy] int
)

create table [dbo].[Colors] (
	[Id] int primary key identity(1,1),
	[Name] nvarchar(50) not null,
	[HexCode] varchar(9),
	[CreatedAt] datetime default getdate() not null,
	[CreatedBy] int not null,
	[LastModifiedAt] datetime default getdate(),
	[LastModifiedBy] int,
	[DeletedAt] datetime default getdate(),
	[DeletedBy] int
)

create table [dbo].[Products] (
	[Id] int primary key identity(1,1),
	[Name] nvarchar(200) not null,
	[Slug] nvarchar(200),
	[StockKeepingUnit] nvarchar(10),
	[ShortDescription] nvarchar(100),
	[Description] nvarchar(250),
	[Rate] decimal, -- Burada double yerine decimal yazdim cun ki, SYNTAX: DOUBLE(SIZE, D) bele bir sey yazmishdilar. Men eledim alinmadi
	[CategoryId] int not null,
	[BrandId] int not null,
	[CreatedAt] datetime default getdate() not null,
	[CreatedBy] int not null,
	[LastModifiedAt] datetime default getdate(),
	[LastModifiedBy] int,
	[DeletedAt] datetime default getdate(),
	[DeletedBy] int
)

create table [dbo].[Brands] (
	[Id] int primary key identity(1,1),
	[Name] nvarchar(50) not null,
	[CreatedAt] datetime default getdate() not null,
	[CreatedBy] int not null,
	[LastModifiedAt] datetime default getdate(),
	[LastModifiedBy] int,
	[DeletedAt] datetime default getdate(),
	[DeletedBy] int
)

create table [dbo].[Categories] (
	[Id] int primary key identity(1,1),
	[ParentId] int not null,
	[Name] nvarchar(50) not null,
	[CreatedAt] datetime default getdate() not null,
	[CreatedBy] int not null,
	[LastModifiedAt] datetime default getdate(),
	[LastModifiedBy] int,
	[DeletedAt] datetime default getdate(),
	[DeletedBy] int

	CONSTRAINT FK_Categories_Categories FOREIGN KEY([ParentId]) REFERENCES [dbo].[Categories]([Id])
)

create table [dbo].[Specifications] (
	[Id] int primary key identity(1,1),
	[Name] nvarchar(50) not null,
	[CreatedAt] datetime default getdate() not null,
	[CreatedBy] int not null,
	[LastModifiedAt] datetime default getdate(),
	[LastModifiedBy] int,
	[DeletedAt] datetime default getdate(),
	[DeletedBy] int
)

create table [dbo].[BlogPosts] (
	[Id] int primary key identity(1,1),
	[Name] nvarchar(50) not null,
	[Title] nvarchar(50) not null,
	[Slug] nvarchar(50) not null,
	[Body] nvarchar(50) not null,
	[ImagePath] nvarchar(50) not null,
	[CategoryId] int not null,
	[PublishedAt] datetime default getdate() not null,
	[PublishedBy] int not null,
	[CreatedAt] datetime default getdate() not null,
	[CreatedBy] int not null,
	[LastModifiedAt] datetime default getdate(),
	[LastModifiedBy] int,
	[DeletedAt] datetime default getdate(),
	[DeletedBy] int
)

create table [dbo].[SpecificationValues] (
	[SpecificationId] int not null,
	[ProductId] int not null,
	[Value] varchar(50) not null

	CONSTRAINT PK_SpecificationValues PRIMARY KEY ([SpecificationId], [ProductId])
)

create table [dbo].[ProductImages] (
	[Id] int primary key identity(1,1),
	[Name] nvarchar(50) not null,
	[IsMain] bit not null, -- Burada bool ve ya boolean istifade etmek olmadi. Error verir. Evezinde baxdim, yaziblar ki, bit istifade etmek olar.
	[ProductId] int not null
)


--=[ FOREIGN KEYS ]=--

  --=[ Products ]=--
alter table [dbo].[Products]
add constraint FK_Products_Brands FOREIGN KEY ([BrandId]) REFERENCES [dbo].[Brands]([Id])

alter table [dbo].[Products]
add constraint FK_Products_Categories FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[Categories]([Id]) 

  --=[ Specification Values ]=--
alter table [dbo].[SpecificationValues]
add constraint FK_SpecificationValues_Products FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Products]([Id]) 

alter table [dbo].[SpecificationValues]
add constraint FK_SpecificationValues_Specifications FOREIGN KEY ([SpecificationId]) REFERENCES [dbo].[Specifications]([Id]) 

  --=[ Product Images ]=--
alter table [dbo].[ProductImages]
add constraint FK_ProductImages_Products FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Products]([Id]) 

  --=[ Blog Posts ]=--
alter table [dbo].[BlogPosts]
add constraint FK_BlogPosts_Categories FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[Categories]([Id]) 
