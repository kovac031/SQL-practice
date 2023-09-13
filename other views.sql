CREATE VIEW CustomerOverview AS
SELECT 
    ThePeople.Id, 
    ThePeople.FirstName, 
    ThePeople.LastName,
    COUNT(TheOrders.Id) AS OrderAmountTotal,
    SUM(TheOrders.OrderAmount) AS MoneySpentTotal
FROM 
    ThePeople
LEFT JOIN 
    TheOrders ON ThePeople.Id = TheOrders.CustomerId
GROUP BY 
    ThePeople.Id, ThePeople.FirstName, ThePeople.LastName;

SELECT * FROM CustomerOverview
ORDER BY MoneySpentTotal DESC;

------------------------------------------------------

CREATE VIEW ProductSalesOverview AS
SELECT 
	Prod.Id,
    Prod.ProductName, 
	Prod.ProductPrice,
    COUNT(OrdProd.OrderId) AS OrderQuantityTotal,
    SUM(Ord.OrderAmount * Prod.ProductPrice) AS RevenueGeneratedTotal
FROM 
    TheProducts Prod -- malo da vjezbam te skracenice
LEFT JOIN 
    TheOrdersTheProducts OrdProd ON Prod.Id = OrdProd.ProductId
LEFT JOIN
    TheOrders Ord ON OrdProd.OrderId = Ord.Id
GROUP BY 
    Prod.Id, Prod.ProductName, Prod.ProductPrice; -- mora imati sve sto je zajednicko, tj jedan proizvod ce imati sve ovo jedinstveno za svaki proizvod

SELECT * FROM ProductSalesOverview
ORDER BY RevenueGeneratedTotal DESC;

----------------------------------------------------

