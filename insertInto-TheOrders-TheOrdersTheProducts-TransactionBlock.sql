BEGIN TRANSACTION;

DECLARE @RandomPersonId uniqueidentifier; -- random kupac
SELECT TOP 1 @RandomPersonId = Id FROM ThePeople ORDER BY NEWID();

DECLARE @RandomProductId uniqueidentifier; -- random proizvod, koristimo u oba insert
SELECT TOP 1 @RandomProductId = Id FROM TheProducts ORDER BY NEWID();

DECLARE @NewOrderId uniqueidentifier; -- ovo treba da taj isti newid mozemo na vise mjesta ubaciti
SET @NewOrderId = NEWID();

INSERT INTO TheOrders VALUES ( -- isti insert kao i prije
@NewOrderId,
DATEADD(SECOND, CAST((RAND(CHECKSUM(NEWID())) * DATEDIFF(SECOND, (SELECT RegisteredOn FROM ThePeople WHERE Id = @RandomPersonId), GETDATE())) AS INT), (SELECT RegisteredOn FROM ThePeople WHERE Id = @RandomPersonId)), 
CAST((RAND(CHECKSUM(NEWID())) * 17) + 1 AS INT),
@RandomPersonId
);

INSERT INTO TheOrdersTheProducts VALUES (@NewOrderId, @RandomProductId); -- ovo je novo, i zbog ovog smo deklarirali

COMMIT;

------------------------- u petlji -------------------------------------

DECLARE @Count INT = 0;

WHILE @Count < 99 -- koliko novih?
BEGIN
--------------------

BEGIN TRANSACTION;

DECLARE @RandomPersonId uniqueidentifier; 
SELECT TOP 1 @RandomPersonId = Id FROM ThePeople ORDER BY NEWID();

DECLARE @RandomProductId uniqueidentifier; 
SELECT TOP 1 @RandomProductId = Id FROM TheProducts ORDER BY NEWID();

DECLARE @NewOrderId uniqueidentifier; 
SET @NewOrderId = NEWID();

INSERT INTO TheOrders VALUES ( 
@NewOrderId,
DATEADD(SECOND, CAST((RAND(CHECKSUM(NEWID())) * DATEDIFF(SECOND, (SELECT RegisteredOn FROM ThePeople WHERE Id = @RandomPersonId), GETDATE())) AS INT), (SELECT RegisteredOn FROM ThePeople WHERE Id = @RandomPersonId)), 
CAST((RAND(CHECKSUM(NEWID())) * 17) + 1 AS INT),
@RandomPersonId
);

INSERT INTO TheOrdersTheProducts VALUES (@NewOrderId, @RandomProductId); 

COMMIT;

--------------------
SET @Count = @Count + 1;
END;