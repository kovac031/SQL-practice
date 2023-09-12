/*
CREATE TABLE TheOrders (
Id uniqueidentifier not null PRIMARY KEY,
CustomerId uniqueidentifier not null,
CONSTRAINT FK_TheOrders_ThePeople_CustomerId FOREIGN KEY (CustomerId) REFERENCES ThePeople (Id) -- FK u tablici TheOrders koja referencira na tablicu ThePeople preko kljuca CustomerId
);

-----------------------------------------

INSERT INTO TheOrders VALUES (
newid(),
(SELECT TOP 1 Id FROM ThePeople ORDER BY NEWID())
); -- nema order time i amount jer je potrebno CustomerId imati za to prvo

ALTER TABLE TheOrders ADD
OrderTime datetime null,
OrderAmount int null;

UPDATE TheOrders SET 
OrderTime = DATEADD(SECOND, CAST((RAND(CHECKSUM(NEWID())) * DATEDIFF(SECOND, (SELECT RegisteredOn FROM ThePeople WHERE Id = CustomerId), GETDATE())) AS INT), (SELECT RegisteredOn FROM ThePeople WHERE Id = CustomerId)), 
OrderAmount= CAST(rand(CHECKSUM(NEWID())) * 1000 AS INT)
;

--------------------------------------------

DECLARE @RandomPersonId uniqueidentifier;
SELECT TOP 1 @RandomPersonId = Id FROM ThePeople ORDER BY NEWID();

INSERT INTO TheOrders VALUES (
newid(),
@RandomPersonId,
DATEADD(SECOND, CAST((RAND(CHECKSUM(NEWID())) * DATEDIFF(SECOND, (SELECT RegisteredOn FROM ThePeople WHERE Id = @RandomPersonId), GETDATE())) AS INT), (SELECT RegisteredOn FROM ThePeople WHERE Id = @RandomPersonId)), 
CAST(rand(CHECKSUM(NEWID())) * 1000 AS INT)
);

------------------------------------------------ */

DROP TABLE TheOrders

CREATE TABLE TheOrders (
Id uniqueidentifier not null PRIMARY KEY,
OrderTime datetime not null,
OrderAmount int not null,
CustomerId uniqueidentifier not null,
CONSTRAINT FK_TheOrders_ThePeople_CustomerId FOREIGN KEY (CustomerId) REFERENCES ThePeople (Id) -- FK u tablici TheOrders koja referencira na tablicu ThePeople preko kljuca CustomerId
);

--------------------------------------------

DECLARE @RandomPersonId uniqueidentifier;
SELECT TOP 1 @RandomPersonId = Id FROM ThePeople ORDER BY NEWID();

INSERT INTO TheOrders VALUES (
newid(),
DATEADD(SECOND, CAST((RAND(CHECKSUM(NEWID())) * DATEDIFF(SECOND, (SELECT RegisteredOn FROM ThePeople WHERE Id = @RandomPersonId), GETDATE())) AS INT), (SELECT RegisteredOn FROM ThePeople WHERE Id = @RandomPersonId)), 
CAST(rand(CHECKSUM(NEWID())) * 1000 AS INT),
@RandomPersonId
);

/* breakdown

DATEADD(SECOND, expression, bazni datum) dodajemo sekunde na bazni datum datetime po expression logici
- kod mene je bazni datum (SELECT RegisteredOn FROM ThePeople WHERE Id = @RandomPersonId)
- kod mene je expression CAST((RAND(CHECKSUM(NEWID())) * DATEDIFF(SECOND, (SELECT RegisteredOn FROM ThePeople WHERE Id = @RandomPersonId), GETDATE())) AS INT)
	- CAST( nesto ) AS INT
		- "nesto" je (RAND(CHECKSUM(NEWID())) * DATEDIFF(SECOND, (SELECT RegisteredOn FROM ThePeople WHERE Id = @RandomPersonId), GETDATE())
			> RAND(CHECKSUM(NEWID()))
			- RAND() generira float izmedju 0 i 1
				- CHECKSUM() proizvede integer
					- NEWID() generira guid
						- dakle guid se pretvori u intiger, koji bude seed za proizvest random broj izmedju 0 i 1
			> DATEDIFF(SECOND, (SELECT RegisteredOn FROM ThePeople WHERE Id = @RandomPersonId), GETDATE())
			- DATEDIFF(SECOND, datetime, GETDATE())
				- razlika u sekundama između datetime datuma i GETDATE datuma (koji je sada)
	- dakle pomnozi nasumicni broj 0-1 sa brojem sekundi koja je razlika datuma, i pretvori u int tip
		- imamo int vrijednost koji je expression
	- dodamo expression int sekundi na bazni datum
		- novi datum koji je efektivno random
*/

--------------------------------------------

CREATE TABLE TheProducts (
Id uniqueidentifier not null PRIMARY KEY,
ProductName nvarchar(50) not null,
ProductPrice decimal(10, 2) not null
);