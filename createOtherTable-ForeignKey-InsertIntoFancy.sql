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
/*
DECLARE @RandomPersonId uniqueidentifier;
SELECT TOP 1 @RandomPersonId = Id FROM ThePeople ORDER BY NEWID();

INSERT INTO TheOrders VALUES (
newid(),
DATEADD(SECOND, CAST((RAND(CHECKSUM(NEWID())) * DATEDIFF(SECOND, (SELECT RegisteredOn FROM ThePeople WHERE Id = @RandomPersonId), GETDATE())) AS INT), (SELECT RegisteredOn FROM ThePeople WHERE Id = @RandomPersonId)), 
CAST(rand(CHECKSUM(NEWID())) * 1000 AS INT),
@RandomPersonId
);
*/

DELETE FROM TheOrders;

DECLARE @RandomPersonId uniqueidentifier;
SELECT TOP 1 @RandomPersonId = Id FROM ThePeople ORDER BY NEWID();

INSERT INTO TheOrders VALUES (
newid(),
DATEADD(SECOND, CAST((RAND(CHECKSUM(NEWID())) * DATEDIFF(SECOND, (SELECT RegisteredOn FROM ThePeople WHERE Id = @RandomPersonId), GETDATE())) AS INT), (SELECT RegisteredOn FROM ThePeople WHERE Id = @RandomPersonId)), 
CAST((rand(CHECKSUM(NEWID())) * 17) + 1 AS INT),
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

CREATE TABLE TheOrdersTheProducts (
OrderId uniqueidentifier not null,
ProductId uniqueidentifier not null,
CONSTRAINT FK_TheOrdersTheProducts_TheOrders_OrderId FOREIGN KEY (OrderId) REFERENCES TheOrders(Id),
CONSTRAINT FK_TheOrdersTheProducts_TheProducts_ProductId FOREIGN KEY (ProductId) REFERENCES TheProducts(Id),
PRIMARY KEY (OrderId, ProductId)
);

--------------------------------------------

INSERT INTO TheProducts VALUES (newid(), 'Popcorn 1kg',9.99);
INSERT INTO TheProducts VALUES (NEWID(), 'Organic Eggs 12-Pack', 5.50);
INSERT INTO TheProducts VALUES (NEWID(), 'Milk 1 Gallon', 3.00);
INSERT INTO TheProducts VALUES (NEWID(), 'White Bread Loaf', 2.50);
INSERT INTO TheProducts VALUES (NEWID(), 'Ground Beef 1lb', 4.00);
INSERT INTO TheProducts VALUES (NEWID(), 'Boneless Chicken Breast 1lb', 3.50);
INSERT INTO TheProducts VALUES (NEWID(), 'Apple Juice 64oz', 2.80);
INSERT INTO TheProducts VALUES (NEWID(), 'Olive Oil 500ml', 8.00);
INSERT INTO TheProducts VALUES (NEWID(), 'Almond Butter 16oz', 7.50);
INSERT INTO TheProducts VALUES (NEWID(), 'Organic Brown Rice 2lb', 3.60);
INSERT INTO TheProducts VALUES (NEWID(), 'Canned Tuna 5oz', 1.50);
INSERT INTO TheProducts VALUES (NEWID(), 'Granulated Sugar 5lb', 3.00);
INSERT INTO TheProducts VALUES (NEWID(), 'Coffee Grounds 12oz', 6.00);
INSERT INTO TheProducts VALUES (NEWID(), 'Frozen Peas 16oz', 1.50);
INSERT INTO TheProducts VALUES (NEWID(), 'Toilet Paper 6 Rolls', 5.00);
INSERT INTO TheProducts VALUES (NEWID(), 'Greek Yogurt 32oz', 5.50);
INSERT INTO TheProducts VALUES (NEWID(), 'Canned Tomatoes 14oz', 1.20);
INSERT INTO TheProducts VALUES (NEWID(), 'Baby Carrots 1lb', 1.30);
INSERT INTO TheProducts VALUES (NEWID(), 'Boxed Mac and Cheese', 2.00);
INSERT INTO TheProducts VALUES (NEWID(), 'Orange Juice 64oz', 3.00);
INSERT INTO TheProducts VALUES (NEWID(), 'Whole Wheat Pasta 16oz', 2.50);
INSERT INTO TheProducts VALUES (NEWID(), 'Jarred Pickles 16oz', 3.50);
INSERT INTO TheProducts VALUES (NEWID(), 'Instant Coffee 8oz', 4.50);
INSERT INTO TheProducts VALUES (NEWID(), 'Garlic Powder 3oz', 2.20);
INSERT INTO TheProducts VALUES (NEWID(), 'Laundry Detergent 50oz', 6.00);
INSERT INTO TheProducts VALUES (NEWID(), 'Chunky Peanut Butter 16oz', 2.80);
INSERT INTO TheProducts VALUES (NEWID(), 'Rice Cakes 14-Pack', 2.50);
INSERT INTO TheProducts VALUES (NEWID(), 'Aluminum Foil 30ft', 3.00);
INSERT INTO TheProducts VALUES (NEWID(), 'Vanilla Extract 2oz', 4.00);
INSERT INTO TheProducts VALUES (NEWID(), 'Paper Towels 2 Rolls', 3.50);
INSERT INTO TheProducts VALUES (NEWID(), 'Sparkling Water 12-Pack', 5.00);
INSERT INTO TheProducts VALUES (NEWID(), 'Olive Oil Spray 7oz', 3.50);
INSERT INTO TheProducts VALUES (NEWID(), 'Kosher Salt 1lb', 1.80);
INSERT INTO TheProducts VALUES (NEWID(), 'All-Purpose Flour 5lb', 2.50);
INSERT INTO TheProducts VALUES (NEWID(), 'White Sugar 4lb', 2.30);
INSERT INTO TheProducts VALUES (NEWID(), 'Cornstarch 16oz', 1.40);
INSERT INTO TheProducts VALUES (NEWID(), 'Unsalted Butter 1lb', 4.00);
INSERT INTO TheProducts VALUES (NEWID(), 'Black Peppercorns 4oz', 3.00);
INSERT INTO TheProducts VALUES (NEWID(), 'Baking Soda 16oz', 1.00);
INSERT INTO TheProducts VALUES (NEWID(), 'Vegetable Broth 32oz', 2.80);
INSERT INTO TheProducts VALUES (NEWID(), 'Soy Sauce 15oz', 2.50);
INSERT INTO TheProducts VALUES (NEWID(), 'Red Wine Vinegar 16oz', 3.00);
INSERT INTO TheProducts VALUES (NEWID(), 'Coconut Milk 13.5oz', 2.00);
INSERT INTO TheProducts VALUES (NEWID(), 'Ground Cinnamon 2.6oz', 1.50);
INSERT INTO TheProducts VALUES (NEWID(), 'Whole Nutmeg 1.5oz', 2.80);
INSERT INTO TheProducts VALUES (NEWID(), 'Paprika 2.1oz', 1.30);
INSERT INTO TheProducts VALUES (NEWID(), 'Canned Chickpeas 15.5oz', 0.90);
INSERT INTO TheProducts VALUES (NEWID(), 'Sesame Oil 5oz', 3.00);
INSERT INTO TheProducts VALUES (NEWID(), 'Oregano Leaves 0.75oz', 1.20);
INSERT INTO TheProducts VALUES (NEWID(), 'Honey 12oz', 4.00);
INSERT INTO TheProducts VALUES (NEWID(), 'Quinoa 16oz', 4.50);
INSERT INTO TheProducts VALUES (NEWID(), 'Pork Tenderloin 1lb', 4.50);
INSERT INTO TheProducts VALUES (NEWID(), 'Salmon Fillet 1lb', 8.00);
INSERT INTO TheProducts VALUES (NEWID(), 'Basmati Rice 2lb', 3.50);
INSERT INTO TheProducts VALUES (NEWID(), 'Sweet Potatoes 1lb', 1.20);
INSERT INTO TheProducts VALUES (NEWID(), 'Ground Turkey 1lb', 3.80);
INSERT INTO TheProducts VALUES (NEWID(), 'Whole-Wheat Spaghetti 16oz', 1.50);
INSERT INTO TheProducts VALUES (NEWID(), 'Frozen Mixed Vegetables 16oz', 1.40);
INSERT INTO TheProducts VALUES (NEWID(), 'Chicken Stock 32oz', 2.80);
INSERT INTO TheProducts VALUES (NEWID(), 'Dijon Mustard 8oz', 2.00);
INSERT INTO TheProducts VALUES (NEWID(), 'Shredded Mozzarella Cheese 8oz', 2.50);