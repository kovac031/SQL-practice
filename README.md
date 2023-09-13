# SQL-practice
- SQL
- SQL Server Management Studio 19

> Practicing SQL statements
>   - creating database and tables
>   - table relations, 1 to m, many to many
>   - creating views
>       - using joins

## Tables:
```SQL
CREATE TABLE ThePeople (
Id uniqueidentifier not null PRIMARY KEY,
FirstName nvarchar(255) not null,
LastName nvarchar(255) not null,
DateOfBirth datetime not null,
EmailAddress varchar(255) not null,
RegisteredOn datetime not null
);
```
```SQL
CREATE TABLE TheOrders (
Id uniqueidentifier not null PRIMARY KEY,
OrderTime datetime not null,
OrderAmount int not null,
CustomerId uniqueidentifier not null,
CONSTRAINT FK_TheOrders_ThePeople_CustomerId FOREIGN KEY (CustomerId) REFERENCES ThePeople (Id) -- FK u tablici TheOrders koja referencira na tablicu ThePeople preko kljuca CustomerId
);
```
```SQL
CREATE TABLE TheProducts (
Id uniqueidentifier not null PRIMARY KEY,
ProductName nvarchar(50) not null,
ProductPrice decimal(10, 2) not null
);
```
```SQL
CREATE TABLE TheOrdersTheProducts (
OrderId uniqueidentifier not null,
ProductId uniqueidentifier not null,
CONSTRAINT FK_TheOrdersTheProducts_TheOrders_OrderId FOREIGN KEY (OrderId) REFERENCES TheOrders(Id),
CONSTRAINT FK_TheOrdersTheProducts_TheProducts_ProductId FOREIGN KEY (ProductId) REFERENCES TheProducts(Id),
PRIMARY KEY (OrderId, ProductId)
);
```

##  Tricky insert:
```SQL
INSERT INTO TheOrders VALUES (
newid(),
DATEADD(SECOND, CAST((RAND(CHECKSUM(NEWID())) * DATEDIFF(SECOND, (SELECT RegisteredOn FROM ThePeople WHERE Id = @RandomPersonId), GETDATE())) AS INT), (SELECT RegisteredOn FROM ThePeople WHERE Id = @RandomPersonId)), 
CAST((rand(CHECKSUM(NEWID())) * 17) + 1 AS INT),
@RandomPersonId
);
```
> goal for the random OrderTime was to respect the time a person registered (purchase time can't be earlier than registration time)

> goal for the random OrderAmount was to have it never be 0 but also be low enough to make sense in the context of grocery shopping

## Screenshots for Views:
![scr1](https://github.com/kovac031/SQL-practice/blob/main/purchaselog-view.jpg)
>
![scr2](https://github.com/kovac031/SQL-practice/blob/main/salesoverview-view.jpg)
>
![scr3](https://github.com/kovac031/SQL-practice/blob/main/customeroverview-view.jpg)
