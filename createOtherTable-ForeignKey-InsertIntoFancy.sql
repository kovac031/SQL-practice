CREATE TABLE TheOrders (
Id uniqueidentifier not null PRIMARY KEY,
CustomerId uniqueidentifier not null,
CONSTRAINT FK_TheOrders_ThePeople_CustomerId FOREIGN KEY (CustomerId) REFERENCES ThePeople (Id) -- FK u tablici TheOrders koja referencira na tablicu ThePeople preko kljuca CustomerId
);

INSERT INTO TheOrders VALUES (
newid(),
(SELECT TOP 1 Id FROM ThePeople ORDER BY NEWID())
); -- nema order time i amount jer je potrebno CustomerId imati za to prvo

ALTER TABLE TheOrders ADD
OrderTime datetime null,
OrderAmount int null;

UPDATE TheOrders SET 
OrderTime = DATEADD(SECOND, CAST((RAND(CHECKSUM(NEWID())) * DATEDIFF(SECOND, (SELECT RegisteredOn FROM ThePeople WHERE Id = CustomerId), GETDATE())) AS INT), (SELECT RegisteredOn FROM ThePeople WHERE Id = CustomerId)), 
OrderAmount= CAST(rand() * 1000 AS INT)
;
